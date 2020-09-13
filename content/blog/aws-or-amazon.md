+++
title = "AWS Lambda or Amazon Lambda?"
description = "A tool to automatically check correctness of AWS service names in prose"
date = 2020-09-12
+++

As a cloud platform [Amazon Web Services][aws] (AWS) offers over 175 services. If you pay attention, you'll notice that people often do mistakes in the names of these services. For example they say *Amazon* Lambda instead of [*AWS* Lambda][lambda], or *AWS* DynamoDB instead of [*Amazon* DynamoDB][dynamodb].

While it's important to use correct names and terms, it's also hard or at least tricky sometimes. I've created a little tool to help with that and made it open source.

<!--more-->

The tool is an extension for prose linter called [Vale][vale]. If you work with text, this linter is *highly* recommended.

## Some details about Vale

Vale is a syntax-aware linter for prose built with speed and extensibility in mind.

Unlike most writing-related software, Vale's primary purpose isn't to provide its advice; it's designed to enforce an existing style guide through its YAML-based extension system.

Vale uses a plain-text (INI and YAML) configuration system that makes it possible to share configurations across platforms, applications, and users.

And the best of all Vale is open source. That means you have a chance not just to look into well-written code (Go), but also contribute :wink:

## A little challenge

To extend Vale it's necessary to craft a configuration file. A [`substitution` style][vale-substitution] helps to achieve this goal because then the linter *suggests* correct options and not just complains about mistakes.

Turns out it isn't easy to find a list of all AWS services in a machine-readable format. Also, it MUST include correct names. [@juanibiapina](https://github.com/juanibiapina) suggested a brilliant idea to use [the AWS status page][aws-status] :bulb:

## A small discovery

The phase of testing and polishing the substitution style revealed a fact, that the AWS status page uses the name "Auto Scaling" (without any prefix) which is incorrect as the service name is [*AWS Auto Scaling*][auto-scaling].

## Results

![AWS Vale demo output][screenshot-aws-vale-demo-output]

You can find [AWS style for Vale on GitHub][vale-aws]. Grab the latest release if you aren't interested in technical details.

## Bonus

If you use GitHub Actions, there is [an example][vale-aws-demo] of how AWS style for Vale helps to avoid mistakes in each commit.

[aws]: https://aws.amazon.com/what-is-aws/
[lambda]: https://aws.amazon.com/lambda/
[dynamodb]: https://aws.amazon.com/dynamodb/
[vale]: https://docs.errata.ai/vale/about
[microsoft-style]: https://docs.microsoft.com/en-us/style-guide/welcome/
[vale-substitution]: https://docs.errata.ai/vale/styles#substitution
[aws-status]: https://status.aws.amazon.com/
[list]: https://github.com/soulim/vale-aws/blob/f30baab722f0b059af4c77f0b606e0716f7d451f/bin/list
[gen]: https://github.com/soulim/vale-aws/blob/f30baab722f0b059af4c77f0b606e0716f7d451f/bin/gen
[auto-scaling]: https://aws.amazon.com/de/autoscaling/
[screenshot-aws-vale-demo-output]: /blog/images/screenshot-aws-vale-demo-output.png
[vale-aws]: https://github.com/soulim/vale-aws
[vale-aws-demo]: https://github.com/soulim/vale-aws-demo/pull/1/checks?check_run_id=1078148144
