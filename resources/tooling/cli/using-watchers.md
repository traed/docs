# Hot Module Reloading

## Using watchers

When developing with Shopware, you probably noticed that changes in JavaScript require commands to build the administration
or storefront, depending on your change using the following commands:

{% tabs %}
{% tab title="Administration (Composer)" %}

```bash
composer run build:js:storefront
```

{% endtab %}

{% tab title="Administration (Shell)" %}

```bash
./bin/build-administration.sh
```

{% endtab %}

{% tab title="Storefront (Composer)" %}

```bash
composer run build:js:admin
```

{% endtab %}

{% tab title="Storefront (Shell)" %}

```bash
./bin/build-storefront.sh
```

{% endtab %}
{% endtabs %}

This can be quite uncomfortable, since the building process always takes some time. To speed up the process, Shopware's
Production template offers composer commands to enable Hot Module Reloading / watchers to automatically reload and preview
your changes.

{% hint style="info" %}
This procedure does not replace a final build process, when you finished developing your feature.
{% endhint %}

To enable Hot Module Reloading, use the following composer commands:

{% tabs %}
{% tab title="Administration" %}

```bash
composer run watch:admin
```

{% endtab %}

{% tab title="Storefront" %}

```bash
composer run watch:storefront
```

{% endtab %}
{% endtabs %}

### Environment variables

Using environment variables can also affect Shopware and therefore its watchers. Like usual in Unix, prefixing command calls with
a variable set will run the command with the respective change. The following example will run the storefront watcher in production mode:

```bash
APP_ENV=prod composer run watch:storefront
```

#### APP_ENV

Using `APP_ENV=dev` Shopware runs in development mode and provides features for debugging, like for example the Symfony
Toolbar in the Storefront, while its counterpart `APP_ENV=prod` enables production mode and therefore disables such tools.

#### IPV4FIRST

Starting with Version NodeJS v17.0.0, it prefers IPv6 over IPv4. In some setups, this may cause problems when using watchers.
In case IPv6 causes problems, `IPV4FIRST=1` reverts this behaviour.
