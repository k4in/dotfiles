# [agents.md](http://agents.md)

## Mandatory Import & Router File Rules

These rules are absolute constraints. Every code change MUST comply. No exceptions.

---

### 1) `routeTree.gen.ts` is auto-generated (DO NOT EDIT)

* If `tanstack-router` exists in the project's dependencies: `routeTree.gen.ts` is **read-only**.
* This file is generated and maintained by TanStack Router automatically.
* **Never** add, remove, or modify any line in this file.
* To alter routing behavior, edit the route source files inside `src/routes/`.

### 2) Basepath imports only

* All imports of internal project modules **must** use the `@/` basepath alias.
* **Never** use relative paths (`./`, `../`) for internal modules.
* Correct: `import { type Post } from "@/types/post.ts"`
* Wrong: `import { type Post } from "./types/post.ts"`

### 3) Inline `type` modifier on imports

* When importing types, the `type` keyword **must** appear inline inside the named import braces.
* The top-level `import type { ... }` syntax is **forbidden**.
* This applies to both pure-type imports and mixed imports.
* Correct:
  * `import { type Foo, type Bar } from "@/types/test.ts"`
  * `import { type Foo, someObject } from "@/types/test.ts"`
* Wrong:
  * `import type { Foo, Bar } from "@/types/test.ts"`

### 4) `type` over `interface`

* **Always** use `type` to declare types. Never use `interface` unless it is technically required (extremely rare).

### 5) Import ordering

* Apply this ordering rule **only** when a file contains more than 10 imports.
* When it applies, group and order imports top-to-bottom as follows:

  1. **CSS** — stylesheets (`index.css`, etc.)
  2. **React** — hooks, types, and modules from `react` or `react-dom`
  3. **Types** — any type-only imports
  4. **Lib/Utils** — imports from `lib/`
  5. **Shadcn components** — imports from `components/shadcn/`
  6. **Components** — imports from `components/`
  7. **Other** — everything else

### 6) Project folder structure

The canonical layout is shown below. All folders are **optional**, but any folder that exists **must** match this structure. Additional files and folders beyond what is listed are allowed.

```
index.html
package.json
components.json
vite.config.ts
src/
  index.css
  routeTree.gen.ts
  components/          # custom components
    shadcn/            # shadcn components (dedicated subfolder)
  lib/
    utils/
    db/
    types/
  routes/              # TanStack Router file-based routing
    __root.tsx
    index.tsx
  hooks/
    shadcn/            # shadcn hooks (dedicated subfolder)
```

---

## Compliance

* Any change that violates these rules is **non-compliant** and must be corrected before merge.
* These rules override personal preferences and editor defaults.
