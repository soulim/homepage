+++
title = "How to list Ruby gems in the bundle"
description = ""
# cover = "blog/images/social-media/lgtm.cover.png"
date = 2024-10-22
draft = false
+++

Bundler, a Ruby package manager, provides two options to list gems in the bundle.

<!--more-->

- [`bundle show`](https://bundler.io/v2.5/man/bundle-show.1.html)
- [`bundle list`](https://bundler.io/v2.5/man/bundle-list.1.html)

If no options provided, both commands print a list of gems and their versions.
As well as they output the list of paths of all gems, when executed with the `--paths` option.

The difference between two commands becomes visible when other options are provided.

- `bundle list` can print the list with additional group fileters applied.
- `bundle show` is suitable to get the path of only one gem in the bundle.

## Interesting story

Wondering why two different commands would print very similar output, I decided to look into their source code.
That lead to a [an interesting discovery](https://github.com/rubygems/rubygems/issues/3243#issuecomment-780379254).

There was some sort of "competition" between `bundle list` and `bundle show`.
One command was supposed to be depricated in favour of another.
Then due to a mistake that another command was marked for deprication.
After an attempt to "fix" the deprecation confusion, it was decided to keep both commands.

{{< figure caption="A short competition story." >}}
  {{< img src="til/images/screenshot.png" >}}
{{< /figure >}}

Lesson: if two commands produce similar output, it would be confusing not just when you use these commands, but also when you maintain them as an author.

## Credits

Thank you [Pablo Vicente](https://pvcarrera.github.io/) for showing me `bundle show`.
