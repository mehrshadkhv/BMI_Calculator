# README documentation references

- GitHub Linguist overrides: https://github.com/github-linguist/linguist/blob/main/docs/overrides.md
  `linguist-vendored=true` excludes platform boilerplate from language statistics. `linguist-generated=true` excludes generated files and suppresses them in diffs. Root `.gitattributes` patterns are relative to the repository root; `folder/**` applies recursively. GitHub sees these changes after they are committed and pushed.
- GitHub Markdown syntax: https://docs.github.com/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax
  Repository-relative image paths and document links work across branches. Screenshot filenames containing spaces will be percent-encoded in README image paths.
- Shields static badges: https://shields.io/badges
  Static badge URLs encode a label, message, and color separated by hyphens. Flutter, Dart SDK constraint, and MIT license badges will reflect this project's own metadata rather than an assumed Flutter release.

The application description, dependencies, SDK constraint, architecture, BMI thresholds, input handling, platforms, and test caveat are grounded in the local project files, not external claims.
