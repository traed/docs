# HTML-Whitepaper
This document is designed to provide a brief and clear way of how the HTML structure of a shopware webpage should be written. Please take these rules and suggestions into account when writing code that will be presented to the storefront of a shopware6 instance either as a twig template for a plugin or a static HTML page.
The rules in this document are based on best-practice and reliability. In some cases we decided to be more strict to provide a clear rule for multiple possibilities. When in doubt choose the strict approach according to the living html standard on https://html.spec.whatwg.org/

## Validation
The first and most important step to have an HTML document, that works in every different environment, is that the document has to be valid due to w3c standards. To ensure this you should validate the rendered result of your templates with the w3c validator. This validation should result in no errors nor warnings.
https://validator.w3.org/

## Minimized HTML
The minimized result of the HTML should work and have no design differences with the original html.
https://www.willpeavy.com/tools/minifier/

## Base Structure
Every Page has the basic html structure.
The Basic Structure consists of the tags `doctype`, `html`, `head`, `title` and `body`

```html
<!doctype html>
<html>
    <head>
        <title>Page title</title>
    </head>
    <body>
        ...
    </body>
</html>
```

## Content Structure
Every full page (Every page which by design has a header, a navigation, content and a footer) has the following HTML5 Content structure.

```html
<body>
    <header>
        <h1>Page title</h1>
    </header>
    <nav>
        ...
    </nav>
    <main>
        <h1>Content Title</h1>
    </main>
    <footer>
        ...
    </footer>
</body>
```

## HTML5 Elements
* Every HTML Element has to be a valid HTML5 Tag.
* Every HTML Element consists of an open tag and a close tag or of one self closing tag (XHTML)
* Tag names are lowercase.
* Optional Tags are never omitted: https://html.spec.whatwg.org/multipage/syntax.html#optional-tags

### Open and closing tag
```html
<h1>Page title</h1>
<a href="/">Homepage</a>
```

### Self closing tag
```html<br />
<meta charset=utf-8" />
```

## Tag attributes
* Only allowed attributes are used (including aria-... and data-...).
* Attribute Values are enclosed in double quotes.
* Attribute names are lowercase.
* Attribute values consider their specific rules (numbers, dates, booleans) 
  * https://html.spec.whatwg.org/multipage/common-microsyntaxes.html
* Boolean attributes (`disabled`, `checked`) don’t have any value nor an equal sign. A boolean attribute absence is considered as this attribute to be false.
* Keyword and Enumerated attributes (e.g. the type attribute of the input tag or the method attribute of the form tag) only have values that are allowed.

See general attribute rules here: https://html.spec.whatwg.org/multipage/syntax.html#attributes-2

### Allowed attributes
#### Correct:
```html
<h1 id="title">Page title</h1>
<a href="/" class="link">Homepage</a>
<input id="search" type="text" aria-label="search" />
```
#### Incorrect:
```html
<h1 id='title'>Page title</h1>
<form method="mail" action="/"><input type="something" /><submit name='submit'></submit></form>
```

### Boolean attributes
#### Correct:
```html
<input id="search" type="text" aria-label="search" disabled />
<input id="fulltext" type="checkbox" aria-label="fulltext" checked />
```
#### Incorrect:
```html
<input id="search" type="text" aria-label="search" disabled="true" />
```

### Id attribute
* Ids have to be unique across the whole page.
* For templates that can be included in other templates consider a prefix to make sure the id will be unique in several mixups with other templates.
* For templates which are included multiple times into the same page add a unique identifier/counter to every id.

{% code title="image-template.html.twig" %}
```html
<img src="{{ image.src }}" id="image-{{ includeId }}" 
``` 

{% code title="gallery.html.twig" %}
```html
{% for user in users %}
    {% include 'image-template.html.twig' with {'image': image, 'includedId': 'uniqueIdentifierForThisInclude' ~ loop.index0} %}
{% endfor %}
``` 


## Content encoding
The Standard encoding is utf-8

```html
<meta charset="utf-8" />
```

## Forms
* Forms have to be well formed.
* A form should not contain another form.
* A form always has the method and an action attribute set.
* When in doubt, the POST method should be preferred.
https://html.spec.whatwg.org/multipage/forms.html


correct:
```html
<form method="post" action="/search"><input type="text" name="search" /> <input type="submit" value="search" /></form>
<form method="post" action="/login"><input type="text" name="username" /><input type="password" name="password" /><input type="submit" value="login" /></form>
```
Incorrect:
```html
<form><input type="text" name="search" /> <input type="submit" value="search" /><form><input type="text" name="username" /><input type="password" name="password" /><input type="submit" value="login" /></form></form>
```

## Content model
* The content model of each tag is considered and implemented correctly.
  * For example no div tag should be inside a span tag, no text node should be inside an &lt;input&gt;&lt;/input&gt; etc.
* https://html.spec.whatwg.org/multipage/dom.html#content-models

## Meta tags
The following `meta` tags should be provided on every single webpage.
* `viewport`, `author`, `robots`, `keywords`, `description`, `itemprop="isFamilyFriendly"`

The following `link` tags should be provided on every single webpage.
* `shortcut icon`, `apple-touch-icon`, `canonical`
```html
<link rel="shortcut icon" href="http://localhost/media/8b/13/45/1643295399/favicon.png">
<link rel="apple-touch-icon" sizes="180x180" href="http://localhost/media/8b/13/45/1643295399/favicon_touch.png">
<link rel="canonical" href="http://localhost/" />
```

The following meta tags should be provided to provide opengraph information for the page.
* `og:type`, `og:site_name`, `og:title`, `og:description`, `og:image` 

The following meta tags should be provided to provide twitter special card information for the page.
* `twitter:card`, `twitter:site`, `twitter:title`, `twitter:description`, `twitter:iamge`
```html
<meta name="twitter:card" content="summary" />
<meta name="twitter:site" content="Demostore" />
<meta name="twitter:title" content="Home" />
<meta name="twitter:description" content="Short description for twitter cards" />
<meta name="twitter:image" content="http://localhost/media/6d/g0/25/1643295399/twitter-logo.png" />
```

## Images
Images should be provided responsive for different viewports according to these guidelines: https://developers.google.com/web/fundamentals/design-and-ux/responsive/images

The standard viewports are 1920, 800 and 400.

Fortunately, you do not need to define these attributes on your own - For that, Shopware introduced the `sw_thumbnails` Twig function: sw_thumbnails automatically generates the img and srcset code.
See https://developer.shopware.com/docs/guides/plugins/plugins/storefront/use-media-thumbnails#working-with-sw_thumbnail for details.

```html
<img src="http://localhost/media/be/08/3e/1643295419/e55d00fb72001c275848fa10c42c6efa.jpg"
     srcset="
     http://localhost/thumbnail/be/08/3e/1643295419/e55d00fb72001c275848fa10c42c6efa_1920x1920.jpg 1920w, 
     http://localhost:8000/thumbnail/be/08/3e/1643295419/e55d00fb72001c275848fa10c42c6efa_800x800.jpg 800w, 
     http://localhost:8000/thumbnail/be/08/3e/1643295419/e55d00fb72001c275848fa10c42c6efa_400x400.jpg 400w
     " 
     sizes="310px" 
     class="teaser-image" 
     title="snow covered mountain" 
     data-object-fit="cover"
/>

```

## Urls
Urls to the same site should always be relative.

Correct:
```html
<a href="/impress">Impress</a>
```

Incorrect:
```html
<a href="https://localhost/impress">Impress</a>
```

## Comments
Comments should not be rendered in the resulting html as far as they are not explicit wanted for the public to be seen.

Correct for comments you explicitly want to appear in the html:
```html
<html>
    <head>
        <!-- If you read this comment, maybe you want to join our dev-team https://localhost/jobs -->
    </head>
    <body>
        ...
    </body>
</html>
```

Correct for developer comments:
```html
<html>
    <head>
      {# @todo add a title #}
    </head>
    <body>
        ...
    </body>
</html>
```

Incorrect:
```html
<html>
    <head>
        <!-- @todo remove old classed from image tags -->
    </head>
    <body>
        ...
    </body>
</html>
```

## Script tag
The type attribute for a script tag has to be set if it is other than `text/javascript` or it has it's `src` attribute set.

```html
<script>windows.someVar = true;</script>
<script type="text/css">
    html {
        margin: 1px;
    }
</script>
```

## Javascript
JS is always provided in an external javascript-file and should not be provided inline. Rare exception should be code that only works inline e.g. code that decides which javascript extensions have to be loaded or code that needs to be present immediately on render start. 

```html
<script src="http://localhost/functions.js"></script>
<script>
    window.breakpoints = {"xs":0,"sm":576,"md":768,"lg":992,"xl":1200};
</script>
```

## CSS
CSS is always provided in an external css-file and should not be provided inline. Rare exceptions are toggles which are set and unset by js-code (e.g. bootstrap toggles).

```html
<link href="style.css" media="all" rel="stylesheet" type="text/css" />
```
```html
<div name="toggledMessage" style="display: none">A hidden message</div>
```

The CSS syntax should comply the CSS specifications on: https://www.w3.org/Style/CSS/specs.html

## Performance
The site performance should always result in a good/green result for the `Speed-Index`, `Time to interactive` and `Largest contentful paint` according to https://web.dev/
The current good/green standards are:

* Speed-Index (https://web.dev/speed-index/): < 2 seconds
* Time to interactive (https://web.dev/interactive/): < 2.2 seconds
* Largest contentful paint (https://web.dev/lcp/): < 2.2 seconds

Consider this Scopes as a maximum and always try to be as performant as possible while keep the standards. 