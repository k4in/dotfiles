# [agents.md](http://agents.md)

## Mandatory Import & Router File Rules

These rules are absolute constraints. Every code change MUST comply. No exceptions.

---

### 1) `routeTree.gen.ts` is auto-generated (DO NOT EDIT)

- If `tanstack-router` exists in the project's dependencies: `routeTree.gen.ts` is **read-only**.
- This file is generated and maintained by TanStack Router automatically.
- **Never** add, remove, or modify any line in this file.
- To alter routing behavior, edit the route source files inside `src/routes/`.

### 2) Basepath imports only

- All imports of internal project modules **must** use the `@/` basepath alias.
- **Never** use relative paths (`./`, `../`) for internal modules.
- Correct: `import { type Post } from "@/types/post.ts"`
- Wrong: `import { type Post } from "./types/post.ts"`

### 3) Inline `type` modifier on imports

- When importing types, the `type` keyword **must** appear inline inside the named import braces.
- The top-level `import type { ... }` syntax is **forbidden**.
- This applies to both pure-type imports and mixed imports.
- Correct:
  - `import { type Foo, type Bar } from "@/types/test.ts"`
  - `import { type Foo, someObject } from "@/types/test.ts"`
- Wrong:
  - `import type { Foo, Bar } from "@/types/test.ts"`

### 4) `type` over `interface`

- **Always** use `type` to declare types. Never use `interface` unless it is technically required (extremely rare).

### 5) Import ordering

- Apply this ordering rule **only** when a file contains more than 10 imports.
- When it applies, group and order imports top-to-bottom as follows:
  1. **CSS** — stylesheets (`index.css`, etc.)
  2. **React** — hooks, types, and modules from `react` or `react-dom`
  3. **Types** — any type-only imports
  4. **Lib/Utils** — imports from `lib/`
  5. **Shadcn components** — imports from `components/shadcn/`
  6. **Components** — imports from `components/`
  7. **Other** — everything else

### 6) Format everything

After every finished change, the format command needs to be run to ensure proper formatting.

### 7) Folder structure

- This tree is a **template** describing where things belong, not a list of things that must exist.
- **Almost everything is optional.** A folder or file only needs to exist if the project actually uses it (e.g. no `schemas/` without zod, no `components/shadcn/` without shadcn).
- **But if it exists, it must be at exactly this path.** Example: if the project has hooks, they live in `src/hooks/` — never in `src/utils/hooks/`, `src/components/hooks/` or similar.
- Entries marked **(required)** must always exist. Entries marked **(required if …)** must exist as soon as the condition is met.
- Do **not** create parallel/duplicate locations for the same concern (e.g. a second `utils/` or `constants/` folder somewhere else).
- `...` means further files or subfolders are allowed at that level, as long as they fit the purpose of the parent folder.
- New top-level folders in `src/` are only allowed if the file genuinely does not fit into any existing folder.
- Only **global** types belong in `src/types/`. Component-specific types — including ones re-used by a handful of sub-components — **must** be defined in the component file itself. If such a type is shared by sub-components in other files, define and export it in the parent component's file and import it from there.

```
root/
├── src/
│   ├── main.tsx                 # (required) App entry point, mounts the app / router
│   ├── index.css                # Global styles (Tailwind entry, theme variables)
│   ├── routeTree.gen.ts         # (required if TanStack Router) Auto-generated, DO NOT EDIT (see rule 1)
│   ├── App.tsx                  # (required if NO TanStack Router) App root component; with TanStack Router `routes/__root.tsx` takes this role
│   ├── components/              # React components
│   │   ├── shadcn/              # shadcn/ui primitives, managed via the shadcn CLI (see components.json)
│   │   └── ...                  # Other components, may be grouped in thematic subfolders (e.g. form/, table/, ui/)
│   ├── context/                 # React contexts & providers (e.g. useSocket/), rarely used — prefer hooks/stores
│   ├── hooks/                   # Custom hooks, one hook per file, named use<Name>.tsx
│   │   ├── useHook.tsx
│   │   ├── shadcn/              # Hooks installed via the shadcn CLI (see components.json), exempt from the naming rule above
│   │   └── ...                  # May be grouped in thematic subfolders (e.g. forms/)
│   ├── lib/                     # Non-React logic
│   │   ├── env.ts               # Typed access to .env variables, validated with zod
│   │   ├── constants/           # Constants (regex, breakpoints, ...)
│   │   ├── data/                # Data fetchers (get<Name>.ts), usually generic getData / mutateData functions
│   │   ├── utils/               # Pure helper functions, no side effects, no React
│   │   │   ├── cn.ts            # (required if shadcn) shadcn's `cn` class-merge helper
│   │   │   └── ...
│   │   └── ...                  # Further logic folders (e.g. features/, stores)
│   ├── routes/                  # (required if TanStack Router) File-based routes
│   │   ├── __root.tsx           # (required if TanStack Router) Root layout
│   │   └── ...                  # Files and folders following TanStack Router naming conventions
│   ├── schemas/                 # Zod schemas (<entity>.ts), may be grouped in subfolders; in a monorepo schemas live in a shared package instead
│   ├── types/                   # Global type definitions only, component-specific types stay in the component file
│   └── ...                      # Other folders/files only if absolutely necessary and nothing above fits
├── index.html                   # (required) Vite HTML entry
├── package.json                 # (required)
├── vite.config.ts               # Vite config (incl. `@/` alias, see rule 2)
├── tsconfig*.json               # TypeScript config (incl. `@/` path alias)
├── components.json              # (required if shadcn) shadcn config
├── .prettierrc, .prettierignore # Prettier config (see rule 6)
├── pnpm-workspace.yaml          # pnpm workspace / settings
├── .gitignore
└── ...
```

#### `components.json` must match the folder structure

- This folder structure deviates from the shadcn defaults. The `aliases` (and `tailwind.css`) in `components.json` therefore **must** point to the paths defined above, otherwise the shadcn CLI installs components and helpers into the wrong locations.
- Expected values:

  | Key            | Expected value        |
  | -------------- | --------------------- |
  | `tailwind.css` | `src/index.css`       |
  | `components`   | `@/components`        |
  | `ui`           | `@/components/shadcn` |
  | `utils`        | `@/lib/utils/cn`      |
  | `lib`          | `@/lib`               |
  | `hooks`        | `@/hooks/shadcn`      |

- If a mismatch is detected, the agent **must only output a WARNING** naming the key, the current value and the expected value, e.g.:
  `⚠️ WARNING: components.json → aliases.ui is "@/components/ui", expected "@/components/shadcn".`
- The agent **must NOT** modify `components.json` on its own. Changing it is the user's decision.
- The agent must also not move or re-create files to work around the mismatch (e.g. installing shadcn components into the wrong folder and then moving them).

---

## Compliance

- Any change that violates these rules is **non-compliant** and must be corrected before merge.
- These rules override personal preferences and editor defaults.
