# BoardOil

BoardOil stores its database, uploaded images, authentication signing key, and
automatic pre-migration database backups in `/data`. Home Assistant preserves
this directory across restarts and includes all of it in add-on backups.

## HTTPS through another add-on

This is the default and recommended setup.

1. Leave port `5000` disabled on the **Network** tab.
2. Leave `allow_insecure_cookies` disabled on the **Configuration** tab.
3. In your TLS reverse proxy, forward the public BoardOil hostname to:

   ```text
   http://<boardoil hostname>:5000
   ```

   Replace <boardoil hostname> with the hostname listed on the app info screen. Enable
   WebSocket support and preserve the original host and protocol headers.
4. Open the public HTTPS URL and complete BoardOil's initial administrator
   setup.
5. In BoardOil's **System admin > Configuration**, set **MCP public base URL** to the
   public HTTPS origin, for example `https://boardoil.example.com`.

Only the reverse proxy needs a host port. BoardOil port `5000` remains confined
to the Supervisor network.

## Direct HTTP access

Use direct HTTP only on a trusted network.

1. Assign a host port to container port `5000` on the **Network** tab.
2. Enable `allow_insecure_cookies` on the **Configuration** tab.
3. Restart the add-on.
4. Open `http://<home-assistant-host>:<assigned-port>`.

Do not enable `allow_insecure_cookies` when BoardOil is available exclusively
through HTTPS.

## Backups

Home Assistant stops BoardOil while backing it up so its SQLite database is
quiescent. The backup includes the complete `/data` directory:

- `boardoil.db`
- `images/`
- `boardoil-auth-signing-key`
- `backups/`

The `backups/` directory contains BoardOil's automatic database copies made
before schema migrations. Including these internal pre-migration backups is
deliberate: a Home Assistant backup therefore retains both the current
installation and BoardOil's migration recovery points. This uses additional
backup space, but avoids silently discarding BoardOil's built-in recovery
mechanism.

Restore the Home Assistant backup containing BoardOil's add-on data, then start
BoardOil. Keep the database, images, and signing key together; restoring only
the database is not a complete installation restore.
