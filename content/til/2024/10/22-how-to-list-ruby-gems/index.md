+++
title = "How to list Ruby gems in the bundle"
description = ""
# cover = ""
date = 2024-10-22
draft = false
+++

Bundler, a Ruby package manager, provides two options to list gems in the bundle.

<!--more-->

- [`bundle show`][1]
- [`bundle list`][2]

If no options provided, both commands print a list of gems and their versions.
As well as they output the list of paths of all gems, when executed with the `--paths` option.

The difference between two commands becomes visible when other options are provided.

- `bundle list` can print the list with additional group filters applied.
- `bundle show` is suitable to get the path of only one gem in the bundle.

## Interesting story

Wondering why two different commands would print very similar output, I decided to look into their source code.
That lead to a [an interesting discovery][3].

There was some sort of "competition" between `bundle list` and `bundle show`.
One command was supposed to be deprecated in favor of another.
Then due to a mistake that another command was marked for deprecation.
After an attempt to "fix" the deprecation confusion, it was decided to keep both commands.

{{< figure caption="A short competition story." >}}
  {{< img src="screenshot.png" >}}
{{< /figure >}}

Lesson: if two commands produce similar output, it would be confusing not just when you use these commands, but also when you maintain them as an author.

## Credits

Thank you [Pablo Vicente][4] for showing me `bundle show`.

---

{{< til-rating text="good to know" >}}


[1]: https://bundler.io/v2.5/man/bundle-show.1.html
[2]: https://bundler.io/v2.5/man/bundle-list.1.html
[3]: https://github.com/rubygems/rubygems/issues/3243#issuecomment-780379254
[4]: https://pvcarrera.github.io/
