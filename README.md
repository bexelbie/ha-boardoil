# BoardOil

BoardOil is a self-hosted Kanban board targeting home lab environments.
Try the [live demo](https://demo.boardoil.dozigden.com).

Key features:
- Multiple boards with basic RBAC.
- REST API and MCP server.
- Cards can be tagged, assigned, and grouped together into Slicks (similar to swim lanes).

See more at [https://boardoil.dozigden.com](https://boardoil.dozigden.com).

An [integration](https://github.com/andrew-codechimp/HA-BoardOil) is also available to work with cards within Home Assistant.


## Install

Add `https://github.com/bexelbie/ha-boardoil` as a custom Home Assistant app
repository, then install BoardOil from the app store.

[![Open your Home Assistant instance and show the dashboard of an app.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=2d69bcb5_boardoil&repository_url=https%3A%2F%2Fgithub.com%2Fbexelbie%2Fha-boardoil)

Home Assistant pulls the wrapper image from
`ghcr.io/bexelbie/ha-boardoil`. The wrapper uses the matching upstream BoardOil
image and only translates the Home Assistant cookie-security option into
BoardOil's runtime configuration.

See the app documentation for direct HTTP, TLS reverse proxy, MCP, and backup
configuration.
