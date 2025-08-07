---
title: Testing and Linting
description: A guide on how testing and linting is performed in the application
---

This project currently uses basic testing and code formatting tools. Additional automated tests will be added during development.

## Linting

Both the frontend and backend use ESLint, although they have seperate configuration files to allow us to tailor the rules that we want enforce separability. To run this with a standard React config. Run:

```bash
npm run lint
```

## Testing

Automated testing will be added in later sprints, potentially using:

    Jest (unit tests for frontend components) or

    Firebase Test SDK (for backend function testing)

Notes
All new features should be tested manually before merging

Future CI integration will enforce linting and tests on pull requests
