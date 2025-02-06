+++
title = "Why do I write tests?"
description = """\
  Recently I discovered additional reasons to write tests for my code! \
  Besides obvious and well-known ones described in books and many blog posts, I realized that the process of writing tests has also psychological effects for me. \
  These effects are especially helpful in cases of hotfixes that need to be deployed as soon as possible.\
  """
cover = "why-do-i-write-tests.cover.png"
date = 2021-09-25T06:46:53+02:00
draft = false
+++

Recently I had an interesting conversation with colleagues on the topic of writing tests for code.
In particular, it was about tests for hotfixes that need to be deployed as soon as possible.
In this post, I'll leave the results of that conversation aside and focus on what it inspired me to think about.
On the question "Why do I write tests for code?"

<!--more-->

The concept of writing tests was introduced to me when I started working with Ruby and Rails.
Before that, the only way to make sure everything works as expected was to manually test it.
The benefits of automated testing were totally clear, however, it was hard to accept it right away.
So I went through phases like:

  * being excited about the possibility to automate all the manual testing,
  * complaining about the necessity to write more code and writing tests just for the sake of having them,
  * discovering [TDD (test-driven development)][1], trying, struggling, denying, and accepting it,
  * discovering [BDD (behavior-driven development)][2] and going through similar stages as with TDD,
  * developing a sense of balance for the number and quality of tests,
  * reaching the state when delivering my code without tests fills like a poorly done job.

This recent discussion with colleagues, mentioned in the beginning, helped me to discover more. Writing tests has some psychological effects for me.

  * It raises my confidence level in understanding the problem at hand.
  * It helps me to calm down, clear my mind, and to easier get into the productivity zone.

So especially in cases of hotfixes when the production system is on fire, I would highly recommend not skipping tests.
Even if it's so tempting sometimes to deliver the fix as soon as possible :wink:

Keep writing good tests!


[1]: https://en.wikipedia.org/wiki/Test-driven_development
[2]: https://en.wikipedia.org/wiki/Behavior-driven_development
