+++
title = "Running minitest without Rake"
description = ""
# cover = ""
date = 2024-11-11
draft = false
+++

When it's about writing tests for a Ruby project, I prefer [minitest][1] to anything else. It's fast and doesn't require to switch mental context to any domain-specific language (DSL). It's just Ruby.

Because minitest allows to express tests using plain Ruby, Ruby is the only necessary tool to run those tests.

{{< figure caption="Running minitest tests with Ruby." >}}
  {{< highlight shell >}}
  $ ruby -Ilib:test test/foo/test_foo_test.rb
  {{< /highlight >}}
{{< /figure >}}

That works fine for one file, but a bit tricky for multiple test files at once.

minitest comes with [a Rake task][2] to run all tests. However for small projects it might be to much to bring Rake just for that case.

So I wrote a script to run tests without anything but Ruby. It's basically a wrapper around a test runner that comes with minitest.

<!--more-->

{{< figure caption="${HOME}/.local/bin/minitest" >}}
  {{< highlight ruby >}}
  #!/usr/bin/env -S ruby -Ilib:test:.

  # Sets up the environment and runs minitest.
  #
  # Syntax
  #
  #   minitest [options] file [file ...]
  #
  # Examples
  #
  #   minitest test/**/*test.rb
  #
  #   minitest --help
  #
  #   minitest test/**/*test.rb --verbose
  #
  #   minitest test/**/*test.rb --seed 123

  files = []

  # Extract file paths from ARGV and keep only command-line options.
  # Minitest::autorun depends on values in ARGV, but expects only options there.
  ARGV.delete_if do |arg|
    keep = arg.end_with?(".rb")
    files.push(arg) if keep

    keep
  end

  # Require all test files because they will be later used by the minitest runner.
  files.each { |f| require(f) }

  # If no command-line arguments have been given, print help.
  ARGV.push("--help") if files.empty? && ARGV.empty?

  # Let minitest autorunner to do its job.
  # At this point the environment is setup and ready for tests to be executed.
  require "minitest/autorun"
  {{< /highlight >}}
{{< /figure >}}

The script sets up an environment and calls the minitest runner. No magic.

{{< figure caption="" >}}
  {{< highlight shell >}}
  $ minitest test/**/*_test.rb
  Run options: --seed 6995

  # Running:

  .....

  Finished in 0.001306s, 3829.5571 runs/s, 7659.1143 assertions/s.

  5 runs, 10 assertions, 0 failures, 0 errors, 0 skips
  {{< /highlight >}}
{{< /figure >}}

All command-line options of the minitest runner are available as well:

{{< figure caption="" >}}
  {{< highlight shell >}}
  $ minitest --help
  minitest options:
      -h, --help                       Display this help.
          --no-plugins                 Bypass minitest plugin auto-loading (or set $MT_NO_PLUGINS).
      -s, --seed SEED                  Sets random seed. Also via env. Eg: SEED=n rake
      -v, --verbose                    Verbose. Show progress processing files.
      -q, --quiet                      Quiet. Show no progress processing files.
          --show-skips                 Show skipped at the end of run.
      -n, --name PATTERN               Filter run on /regexp/ or string.
      -e, --exclude PATTERN            Exclude /regexp/ or string from run.
      -S, --skip CODES                 Skip reporting of certain types of results (eg E).
      -W[error]                        Turn Ruby warnings into errors

  Known extensions: pride
      -p, --pride                      Pride. Show your testing pride!
  {{< /highlight >}}
{{< /figure >}}

---

{{< til-rating text="good to know" >}}


[1]: https://github.com/minitest/minitest
[2]: https://github.com/minitest/minitest?tab=readme-ov-file#label-Rake+Tasks
