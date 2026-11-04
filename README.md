# Whatnot Dart Monorepo

Monorepo containing official Dart SDKs for the **Whatnot Platform**, managed with [Melos](https://melos.invertase.io/) and Dart Pub Workspaces.

---

## Packages

| Package | Description | Version |
| :--- | :--- | :--- |
| [`whatnot_seller_api`](packages/whatnot_seller_api) | Client for Whatnot Seller REST v2 API & HMAC-SHA256 Webhook Engine | `0.1.0` |
| [`whatnot_product_taxonomy`](packages/whatnot_product_taxonomy) | Whatnot marketplace category tree & attribute validator | `1.2.0` |

---

## Workspace Architecture

* **Dart 3.13+ Primary Constructors**: Modern syntax across models and clients.
* **OpenAPI 3.1.0 & Taxonomy Code Generation**: Uses `analyzer_buffer` to compile models, REST operations, and lookup tables.
* **Independent Versioning**: `whatnot_product_taxonomy` updates independently as Whatnot publishes new categories and attributes on GitHub, without forcing version bumps on `whatnot_seller_api`.

---

## Melos Commands

```bash
# Run tests across all workspace packages
puro dart run melos run test

# Run static analysis with fatal infos
puro dart run melos run analyze

# Check formatting
puro dart run melos run format
puro dart run melos run format:fix

# Check if upstream OpenAPI spec or Taxonomy have changed (without updating)
puro dart run melos run check:upstreams

# Download latest specs and regenerate SDK code
puro dart run melos run update:spec
puro dart run melos run update:taxonomy
puro dart run melos run update:all
```

---

## Continuous Integration (GitHub Actions)

* **[`.github/workflows/ci.yml`](.github/workflows/ci.yml)**: Triggers on pushes and pull requests to `main`. Installs Puro, validates code formatting, runs static analysis (`--fatal-infos`), and executes the complete unit test suite across both packages.
* **[`.github/workflows/check_upstreams.yml`](.github/workflows/check_upstreams.yml)**: Runs on a scheduled weekly cron (every Monday at 08:00 UTC) and on manual dispatch. Uses `puro dart run melos run check:upstreams` to verify if Whatnot has published an updated OpenAPI spec or category taxonomy, failing the step with an automated alert if upstream changes are detected.

---

## License

MIT

