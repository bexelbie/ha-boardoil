# Updating for a new upstream BoardOil release

Maintainer checklist for bumping this wrapper when
[dozigden/boardoil](https://github.com/dozigden/boardoil) cuts a new release.
Nothing here runs automatically — a human has to notice the release and work
this list.

## 1. Read the release

- `gh release view vX.Y.Z --repo dozigden/boardoil`
- Note the exact image tag under "Container Images" (e.g. `1.5.1`, no `v`
  prefix) — that's what goes in `Dockerfile`/`config.yaml`, not the git tag.

## 2. Diff the upstream Dockerfile for container-surface changes

```
git -C <path-to-boardoil-checkout> diff v<old>..v<new> -- Dockerfile
```

Look for anything that changes what this wrapper has to expose or translate:

- New/changed `EXPOSE` or `ENV ASPNETCORE_URLS` → port changes in
  `boardoil/config.yaml` (`ports`, `ports_description`, `webui`).
- New required `ENV` vars → may need a new option in `config.yaml`
  (`options`/`schema`) and a translation line in `boardoil/run.sh`.
- Changed health-check path → update `watchdog` in `config.yaml`.
- Changed `/data` layout (db path, images dir, signing key name, backup dir)
  → update `boardoil/DOCS.md`.

If nothing changed here, this is a pure version bump (the common case).

## 3. Diff the upstream LICENSE

```
diff <path-to-boardoil-checkout>/LICENSE boardoil/BOARD_OIL_LICENSE
```

If it differs (copyright year, license type, added notices), copy the new
text over `boardoil/BOARD_OIL_LICENSE` verbatim. This file must stay
byte-identical to whatever upstream ships at the pinned version — it's the
legally required copy of the license for the binary this image redistributes,
not a paraphrase.

## 4. Bump versions (keep these two in lockstep)

- `boardoil/Dockerfile`: `FROM ghcr.io/dozigden/boardoil:X.Y.Z`
- `boardoil/config.yaml`: `version: "X.Y.Z"`

They're both hand-maintained today — nothing errors if they drift, but the
app's displayed version will lie about what image it's actually running.

## 5. Push and confirm the build

Push to `main` → `.github/workflows/publish.yaml` builds `amd64`, `aarch64`,
and the multi-arch manifest. Confirm all three jobs go green before telling
anyone to update.

## 6. Smoke test on a live Home Assistant instance

Don't consider the bump validated from a green CI run alone:

1. Install/update the app on a real HA instance.
2. Confirm the watchdog (`/api/health`) reports healthy.
3. Restart the app, confirm board data survives (`/data` volume intact).
4. If step 2 touched auth/cookie behavior, exercise both the direct-HTTP
   (`allow_insecure_cookies` on) and reverse-proxy (off) paths — `run.sh`
   branches on this option.
