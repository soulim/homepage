+++
title = "How to use multiple arguments in shebang lines"
description = ""
# cover = ""
date = 2024-10-24
draft = false
+++

`env` command allows to find a script's interpreter when its location is a non-standard one.
In scripts it's recommended to use `env` in [shebang lines](https://en.wikipedia.org/wiki/Shebang_(Unix)) to find the executable and run it.

{{< figure caption="Ruby interpreter is used without any option." >}}
  {{< highlight ruby >}}
  #!/usr/bin/env ruby

  puts "Hello, world."
  {{< /highlight >}}
{{< /figure >}}

On GNU/Linux if it's necessary to run a script's interpreter with options, `env` has to be used with `-S` to pass options in shebang lines.

<!--more-->

{{< figure caption="Ruby interpreter is used with `-I` option to specify $LOAD_PATH directories. " >}}
  {{< highlight ruby >}}
  #!/usr/bin/env -S ruby -Ilib:test:.

  puts "Hello, world."
  {{< /highlight >}}
{{< /figure >}}

`env` could be also used with additional `-v` option.
It's usedful for debugging.

{{< figure >}}
  {{< highlight ruby >}}
  #!/usr/bin/env -vS ruby -Ilib:test:.

  puts "Hello, world."
  {{< /highlight >}}
{{< /figure >}}

When executed, the script from above would produce the following output:

{{< figure >}}
  {{< highlight console >}}
  #env executing: ruby
  #env    arg[0]= 'ruby'
  #env    arg[1]= '-Ilib:test:.'
  #env    arg[2]= 'bin/test.sh'
  Hello, world.
  {{< /highlight >}}
{{< /figure >}}
