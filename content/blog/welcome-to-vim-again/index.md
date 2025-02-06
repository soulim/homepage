+++
title = "Welcome to Vim... again"
description = """\
  Everyone has a unique story and relationships with Vim. \
  This is my story and a couple lessons learned after five failed attempts to tame the mighty editor.\
  """
cover = "welcome-to-vim-again.cover.png"
date = 2021-05-16
draft = false
+++

This post is written in Vim.
I use this editor for the last five months, but it's my sixth attempt to tame it.
Let me share a few lessons learned and reflect on the experience.

<!--more-->

For those who don't know, Vim is a text editor.
Unlike many other editors, it has a special aura around it.
Lots of people have "love or hate" relationships with this editor.
Why is it so?
It's because Vim allows you to be *incredibly* productive with text, but it asks something in return.
Vim asks you to invest time to learn and understand its philosophy.

One of the first and classic challenges that many people (everyone?..) have to solve on the way of mastering Vim is ["How do I exit the Vim editor?"][1].
As of today, this question on StackOverflow has 4252 upvotes and the answer is upvoted 5397 times!

{{< figure caption="StackOverflow: How do I exit the Vim editor?" >}}
  {{< img src="stackoverflow-how-to-exit-vim.png" alt="StackOverflow: How do I exit the Vim editor?" >}}
{{< /figure >}}

Does that mean Vim is hard to master? **Yes**, if you used any other editor before and try to apply the same approaches in Vim.
**No**, if you open to discover something different from what you are used to.

## Why I wanted to use Vim

Like many software engineers, I was excited to try Vim after seeing colleagues and other people on the internet being insanely productive with it.
They were able to write and navigate code with the speed and efficiency I've never had in any GUI editor and even powerful IDEs.
However the most intriguing was to see how proud and enthusiastic those people were.
Of course, I wanted to be like *that* as well!

So I went through lots of tutorials, asked many questions to colleagues... and failed to use Vim as my work tool.
Five times.

## Why my previous attempts failed

The internet is full of Vim tutorials.
There are countless videos on YouTube, blog posts, online classes, newsletters, Vim's built-in help, and still, I was consistently failing to work with text in Vim.
Of course, it wasn't terribly bad, but I wasn't even close to what all those people were able to do.

There was only one reason for all those failures.
I was trying to follow tutorials and do exactly what they suggest.
That was the main mistake.

For example, navigation.
The majority of Vim learning resources teach you how to navigate using {{< kbd "k" >}}, {{< kbd "j" >}}, {{< kbd "l" >}}, {{< kbd "h" >}} keys and suggest keystrokes like {{< kbd "10j" >}}.
For someone who was using a GUI editor for years, it's hard to understand and remember all of that.
Many tutorials suggest avoiding using a mouse to be faster and more productive with just a keyboard.
I wanted to be more productive, but it was almost impossible to stop using the mouse.

All that led to frustration, and I could understand why many people have "hate" relationships with Vim.

## What changed last time

After many years of using VSCode, I've noticed a need to disable some of its functionality that's enabled by default.
Also, it's never felt right that a text editor consumes more than a gigabyte of memory.
Vim, on the other hand, doesn't have much enabled by default besides core editing and navigation.
That gives a chance to gradually enable only what's necessary.
Speaking memory consumption, at the moment writing `nvim` process[^1] uses 11.5 MB of RAM!

This time I knew exactly what a text editor for *my* daily work should have:

  * core text editing and navigation functionality,
  * ability to be extended with plug-ins,
  * no smart features, but full-control instead,
  * speed and low memory footprint.

Vim fit these requirements, so it felt right to try it for the sixth time.
However, I set few rules for myself:

  1. Don't care about "recommended" ways, if ways you use for years work fine.
     That means, I'm fine with using arrow keys instead of {{< kbd "k" >}}, {{< kbd "j" >}}, {{< kbd "l" >}}, {{< kbd "l" >}} and not knowing many of fast navigation keystrokes.
  2. Learn and practice 1--2 new keystrokes at a time and only when you need them.
     So it's impossible to be overwhelmed with exotic (for a GUI user) keystrokes and to feel embarrassed due to the inability to remember many of them at once.
  3. Prefer single-purpose plug-ins over swiss-army knives ones.
     That helps to stay flexible, find your workflow, and use plug-ins 100%.
  4. Keep slowly understanding Vim.

## Lessons learned

When it's about a text editor, the list of possible options to choose from is huge ([VSCode][2], [Atom][3], [Sublime Text][4], [Vim][5] and [NeoVim][6], [Emacs][7], [Chocolat][8], [micro][9] and many others).
To pick one, it's better to know what you need from it.
That's a good exercise because it helps to reflect on your daily workflow.
Once the choice is made, it makes sense to understand the tool.
Yes, that requires time, but take small steps.

There is no wrong choice.
Be inspired by other people, but pick an editor that works for *you*.

Happy writing!

{{< kbd ":wq" >}}

[^1]: I use [NeoVim][6].


[1]: https://stackoverflow.com/questions/11828270/how-do-i-exit-the-vim-editor
[2]: https://code.visualstudio.com/
[3]: https://atom.io/
[4]: https://www.sublimetext.com/
[5]: https://www.vim.org/
[6]: https://neovim.io/
[7]: https://www.gnu.org/software/emacs/
[8]: https://chocolatapp.com/
[9]: https://micro-editor.github.io/
