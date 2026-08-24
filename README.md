# BoardOil

BoardOil is a self-hosted Kanban board targeting home lab environments.
Try the [live demo](https://demo.boardoil.dozigden.com).

Key features:
- Multiple boards with basic RBAC.
- REST API and MCP server.
- Cards can be tagged, assigned, and grouped together into Slicks (similar to swim lanes).

See more at [https://boardoil.dozigden.com](https://boardoil.dozigden.com).

## Install

Add `https://github.com/bexelbie/ha-boardoil` as a custom Home Assistant app
repository, then install BoardOil from the app store.

Home Assistant pulls the wrapper image from
`ghcr.io/bexelbie/ha-boardoil`. The wrapper uses the matching upstream BoardOil
image and only translates the Home Assistant cookie-security option into
BoardOil's runtime configuration.

See the app documentation for direct HTTP, TLS reverse proxy, MCP, and backup
configuration.
