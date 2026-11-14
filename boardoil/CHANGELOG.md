## 1.9.0

- Add full-editor card creation and more consistent form validation.
- Expand MCP support with diagnostics, bulk delete/archive, and board reordering.
- Fix Safari tab restoration and large slicks, and improve archived slick restoration.
- Repair tag normalization and enforce unique user email addresses.

This update migrates the database and can merge duplicate tags or rename duplicate
email addresses. Back up the complete app data before upgrading. To roll back,
restore that backup together with the previous app version.

[Upstream release notes](https://github.com/dozigden/boardoil/releases/tag/v1.9.0)

## 1.8.0

- Add checklist progress, comment editing, and clearer feedback for remote updates.
- Add scheduled database maintenance and a server timezone setting.
- Expand MCP support for boards, columns, and card types.
- Improve attachment downloads, keyboard navigation, and reconnecting after sleep.
- Update dependencies and container bases; revise authentication and anti-forgery handling.

This update migrates the database. Back up the complete app data before upgrading;
restore that backup together with the previous app version if rollback is needed.

[Upstream release notes](https://github.com/dozigden/boardoil/releases/tag/v1.8.0)

## 1.7.0

- Update BoardOil to 1.7.0.

[Upstream release notes](https://github.com/dozigden/boardoil/releases/tag/v1.7.0)
