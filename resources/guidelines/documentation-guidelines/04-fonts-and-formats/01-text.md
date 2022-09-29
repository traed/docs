# Fonts and Format for Text

## Text Format

Follow the below textual formats for good content visualization. 

{% hint style="info" %}
Do not override global styles.
{% endhint %}

### Bold

Use bold to signify UI elements, notices (warning, notice, important declaration), API response - status codes, and titles in descriptions lists.

Use double asterisk **bold** in Markdown to signify bold format.

### Italic

Use italics to draw attention to a specific word, phrase, parameter values, classes, methods, product versions and, key terms like SQL Database.

Use single asterisk *italic* in Markdown to signify italic format

### Underline

Do not underline any content.

## List

Use sentence cases for items in all types of lists as below:

* **Numbered list** - Use when you have a fixed number of entities or sequential steps to describe — for example, 3 varieties, 4 categories, 2 types, etc.

```markdown
Here is a sequence of steps to follow :

1. Create a docker-compose.yml file
2. Start the Docker
3. Prepare Development
...
```

* **Regular bulleted list** - Use this for general enlisting with an asterisk `*` in Markdown to signify bulleted lists.

```markdown
You can install Shopware on Mac with the help of other tools:

* Docker
* Vagrant
* MAMP
```

However, regular bulleted lists within tables can only be used using HTML tags.

```markdown
| Who is the audience? | What are their roles? |
| :--- | :--- |
| Fullstack Developer | <ul><li>Plugin Development</li><li>Templates</li><li>Routes/ Controllers</li></ul>|
```

* **Description list** - Use when you need to describe them along with their headings. In such a case, make the headings in bold followed by a hyphen or new line, followed by a detailed description. The description list can again be a numbered list or a bulleted list based on their sequence or fixed number of entities. For example,

```markdown
The Administrations components implement a number of cross-cutting concerns. The most important are:

* **Providing inheritance** - As Shopware 6 offers a flexible extension system to develop own Apps, Plugins or Themes.
* **Data management** - The Administration displays entities of the Core component.
* **State management** - Proper state management is key here.
```

## Date and Time

In general, use the following guidelines to format expressions of date and time:

* Use the 12-hour clock, except if required to use a 24-hour time, such as when documenting features that use 24-hour time

* Capitalize AM and PM, and leave one space between them and the time

* Avoid using time zones unless absolutely necessary. If using a specific time zone, spell out the region and include the *UTC or GMT* label

* Spell out the names of the months and days of the week. For example, `January 19, 2017`

* You can also use the numerical date format, `MM-DD-YYYY`, and separate the elements by hyphens.

## Numbers

Spell out all ordinal numbers in the text, such as first, fourth, twelfth, and twenty-third for 1st, 4th, 12th, and 23rd, respectively. However, there are exceptions like prices, weight, and quantity which can only be represented as numbers.

## Tables

* Do not embed a table in the middle of a sentence

* Use table headings for the first column and the first row only

* Use tables only when you have more than one row and column to represent

* Do not end sentences with punctuation, including a period, an ellipses, or a colon

* Use sentence case for all the elements in a table - contents, headings, labels, and captions

* Introduce a table using a complete sentence and try to refer to the table's position, using a phrase such as *the following table or the preceding table*

## Hyperlinks

* Use meaningful URL text links. Do not use *click here or read this document* phrases

* Write a complete sentence that refers the reader to another topic. Introduce the link with the phrase such as *For more information, see or For more information about..., see*

* Keep the link text short where possible. Do not write lengthy link text such as a sentence or short paragraph

* Place important words at the beginning of the link text

* Do not use the same link text in the same document for different target pages

* If the hyperlink text includes an abbreviation in parentheses, include the long form and the abbreviation in the link text

## Heading

* Use `#` to set the levels of heading

* Do not skip levels of the heading hierarchy. For example, an `<h3>` heading must fall under `<h2>`

* Follow camel case for all the `<H1>` heading types and sentence case for the rest of the sub-headings that follow

This section covers fonts and formats for text while the following section covers fonts and formats for code.