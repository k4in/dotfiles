# agents.md

## Mandatory Import & Router File Rules

These rules are strict and non-optional. They must be applied in all code changes.

### 1) `routeTree.gen.ts` is read-only when TanStack Router is installed
- If `tanstack-router` is a dependency, you MUST NEVER edit `routeTree.gen.ts` manually.
- This file is generated/updated automatically by TanStack Router.
- Any manual edits are invalid and will be overwritten.
- To change routing behavior, edit route source files only.

### 2) Basepath imports are required
- You MUST use basepath imports (`@/`) for internal project modules.
- Relative imports (`./`, `../`) are FORBIDDEN for internal modules.
- Example:
  - `import { type Post } from "@/types/post.ts"`
  - `import { type Post } from "./types/post.ts"` is not allowed.

### 3) Type import style is fixed and mandatory
- You MUST use inline `type` modifiers inside named imports for ALL type imports.
- `import type { ... }` is FORBIDDEN.
- This applies in every case (type-only imports and mixed imports).
- Required style:
  - `import { type Foo, type Bar } from "@/types/test.ts"`
  - `import { type Foo, object } from "@/types/test.ts"`
  - `import type { Foo, Bar } from "@/types/test.ts"` is not allowed.

### 4) Types
ALWAYS use type to declare types. never interface. (only in the very rare cases where an interface is necessary)

### 5) Import Order
- modules should always be important at the top of a file, in the following order: 
  - css-imports: index.css, etc..
  - react-imports: hooks, types, modules that come from react or react-dom.
  - types: any type imports
  - lib/utils: imports that come from the lib/ folder
  - shadcn-components: imports from components/shadcn
  - components: imports from components/
  - other: any other imports
- the import order has only to be applied in files that have >10 imports.

### 6) Project folder structure
- index.html
- package.json
- components.json
- vite.config.ts
- src/
  - index.css
  - routeTree.gen.ts
  - components/ #custom components
    - shadcn/ #shadcn components have their own subfolder
  - lib/
    - utils/
    - db/
    - types/
  - routes/ #follows tanstack-router file-routing naming convention
    - __root.tsx
    - index.tsx
  - hooks/
    - shadcn/ #shadcn hooks have their own subfolder

This structure is not strict. Meaning that all folders are optional. but if they are present, they need to follow the above structure. There can be more files and folders than shown in the structure above. It is only a template.


## Compliance
- Any change that violates these rules must be considered non-compliant and corrected before merge.
- These conventions take precedence over personal/editor defaults.
