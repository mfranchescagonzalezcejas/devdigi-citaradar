# Create the public repository (run on the Victus)

Create a **new empty public** GitHub repository named `devdigi-citaradar` under `mfranchescagonzalezcejas` (do not add README/licence from the GitHub UI: the starter already provides those). Then use the commands below in the extracted starter directory:

```bash
git init -b main
git add .
git commit -m 'chore: bootstrap CitaRadar project and QA planning'
git remote add origin https://github.com/mfranchescagonzalezcejas/devdigi-citaradar.git
git push -u origin main
git switch -c develop
git push -u origin develop
```

Alternative if `gh` is available and authenticated: run `gh repo create mfranchescagonzalezcejas/devdigi-citaradar --public --source=. --remote=origin --push` after the first commit, and then create/push develop.

Afterwards configure branch rules for `main` and `develop`, require PR + Jenkins, disable squash and rebase merges, leave merge commits enabled. Do not claim rules are enabled until manually verified.

No GitHub public repository has been created by generating this starter. Do not paste passwords or tokens into shell scripts.
