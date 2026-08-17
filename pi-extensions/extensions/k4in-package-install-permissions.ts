/**
 * Package Install / Runner Permission Extension
 *
 * Prompts for confirmation before the agent runs:
 * - project package-manager install/mutate commands (npm, yarn, pnpm, bun, pip, cargo, …)
 * - package runners / one-shot executors (npx, pnpx, pnpm dlx, yarn dlx, bunx, uvx, …)
 *
 * Choices:
 * - Deny
 * - Accept once
 * - Accept for this task (current agent run, until settled)
 * - Accept for this session
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";

/** Detect common project-local package install / mutate commands. */
const PACKAGE_INSTALL_PATTERNS: RegExp[] = [
	// JavaScript / TypeScript
	/\b(?:npm|pnpm|yarn|bun)\s+(?:install|i|add|ci|update|upgrade|remove|rm|uninstall)\b/i,
	/\bnpm\s+i\b/i,
	// Python
	/\b(?:pip|pip3)\s+install\b/i,
	/\bpython[0-9.]*\s+-m\s+pip\s+install\b/i,
	/\b(?:poetry|uv)\s+(?:add|install|sync|remove)\b/i,
	/\buv\s+pip\s+install\b/i,
	// Rust
	/\bcargo\s+(?:add|install|remove)\b/i,
	// Go
	/\bgo\s+(?:get|install)\b/i,
	// Ruby
	/\bgem\s+install\b/i,
	/\bbundle\s+(?:install|add|update)\b/i,
	// PHP
	/\bcomposer\s+(?:require|install|update|remove)\b/i,
	// Deno
	/\bdeno\s+(?:add|install)\b/i,
	// Dart / Flutter
	/\b(?:dart|flutter)\s+pub\s+(?:add|get|upgrade|remove)\b/i,
	// Elixir
	/\bmix\s+deps\.(?:get|update)\b/i,
	// .NET
	/\bdotnet\s+(?:add|install|restore)\b/i,
];

/**
 * Detect package runners / one-shot package executors that may download
 * and run untrusted code without a prior install prompt.
 */
const PACKAGE_RUNNER_PATTERNS: RegExp[] = [
	// Node ecosystem
	/\bnpx\b/i,
	/\bpnpx\b/i,
	/\bbunx\b/i,
	/\bbun\s+x\b/i,
	/\b(?:npm|pnpm|yarn|bun)\s+(?:exec|dlx|create)\b/i,
	/\byarn\s+pkg\b/i,
	// Python
	/\buvx\b/i,
	/\buv\s+tool\s+run\b/i,
	/\bpipx\s+(?:run|install)\b/i,
	// Deno (remote module execution)
	/\bdeno\s+run\b/i,
];

type PermissionScope = "prompt" | "task" | "session";

const CHOICE_DENY = "Deny";
const CHOICE_ONCE = "Accept once";
const CHOICE_TASK = "Accept for this task";
const CHOICE_SESSION = "Accept for this session";

function normalizeCommand(command: string): string {
	return command.replace(/\\\n/g, " ").replace(/\s+/g, " ").trim();
}

function isPackageInstallCommand(command: string): boolean {
	const normalized = normalizeCommand(command);
	return PACKAGE_INSTALL_PATTERNS.some((pattern) => pattern.test(normalized));
}

function isPackageRunnerCommand(command: string): boolean {
	const normalized = normalizeCommand(command);
	return PACKAGE_RUNNER_PATTERNS.some((pattern) => pattern.test(normalized));
}

function isGuardedCommand(command: string): boolean {
	return isPackageInstallCommand(command) || isPackageRunnerCommand(command);
}

function describeCommandKind(command: string): string {
	const install = isPackageInstallCommand(command);
	const runner = isPackageRunnerCommand(command);
	if (install && runner) return "Package install / runner";
	if (runner) return "Package runner";
	return "Package install";
}

function summarizeCommand(command: string, maxLen = 240): string {
	const oneLine = command.replace(/\s*\n\s*/g, " ").trim();
	if (oneLine.length <= maxLen) return oneLine;
	return `${oneLine.slice(0, maxLen - 1)}…`;
}

function scopeLabel(scope: PermissionScope): string {
	switch (scope) {
		case "session":
			return "allowed for this session";
		case "task":
			return "allowed for this task";
		default:
			return "prompt on each matching command";
	}
}

export default function (pi: ExtensionAPI) {
	/** Highest granted allow scope for matching bash commands. */
	let allowScope: PermissionScope = "prompt";

	const resetTaskAllow = () => {
		if (allowScope === "task") {
			allowScope = "prompt";
		}
	};

	const resetAllAllows = () => {
		allowScope = "prompt";
	};

	pi.on("session_start", () => {
		// Fresh policy each session (including /new, /resume, /fork, /reload)
		resetAllAllows();
	});

	// "This task" ends when the agent fully settles (includes retries / follow-ups).
	pi.on("agent_settled", () => {
		resetTaskAllow();
	});

	pi.on("tool_call", async (event, ctx) => {
		if (!isToolCallEventType("bash", event)) return;

		const command = event.input.command ?? "";
		if (!isGuardedCommand(command)) return;

		if (allowScope === "session" || allowScope === "task") return;

		if (!ctx.hasUI) {
			return {
				block: true,
				reason:
					"Package install/runner blocked: no UI available for confirmation. Re-run interactively or allow via /package-install-permission allow-session.",
			};
		}

		const kind = describeCommandKind(command);
		const summary = summarizeCommand(command);
		const choice = await ctx.ui.select(
			`📦 ${kind} requested:\n\n  ${summary}\n\nAllow this command?`,
			[CHOICE_ONCE, CHOICE_TASK, CHOICE_SESSION, CHOICE_DENY],
		);

		if (choice === CHOICE_SESSION) {
			allowScope = "session";
			ctx.ui.notify("Package installs/runners allowed for this session", "info");
			return;
		}

		if (choice === CHOICE_TASK) {
			allowScope = "task";
			ctx.ui.notify("Package installs/runners allowed for this task", "info");
			return;
		}

		if (choice === CHOICE_ONCE) {
			return;
		}

		// Cancelled dialog, Deny, or undefined
		return {
			block: true,
			reason: "Package install/runner blocked by user",
		};
	});

	pi.registerCommand("package-install-permission", {
		description:
			"Show or set package install/runner permission (once/task/session)",
		handler: async (args, ctx) => {
			const action = (args ?? "").trim().toLowerCase();

			if (
				action === "reset" ||
				action === "deny" ||
				action === "off" ||
				action === "prompt"
			) {
				resetAllAllows();
				ctx.ui.notify("Package install/runner permission reset to prompt", "info");
				return;
			}

			if (
				action === "allow" ||
				action === "allow-session" ||
				action === "session" ||
				action === "on"
			) {
				allowScope = "session";
				ctx.ui.notify("Package installs/runners allowed for this session", "info");
				return;
			}

			if (action === "allow-task" || action === "task") {
				allowScope = "task";
				ctx.ui.notify("Package installs/runners allowed for this task", "info");
				return;
			}

			if (action === "help" || action === "?") {
				ctx.ui.notify(
					[
						"/package-install-permission — show current policy",
						"/package-install-permission allow-session — allow all matching cmds this session",
						"/package-install-permission allow-task — allow until agent settles",
						"/package-install-permission reset — prompt again",
					].join("\n"),
					"info",
				);
				return;
			}

			ctx.ui.notify(
				`Package installs/runners: ${scopeLabel(allowScope)} (use /package-install-permission help)`,
				"info",
			);
		},
	});
}
