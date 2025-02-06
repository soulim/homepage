+++
title = "Getting a tool version from asdf (improved)"
description = ""
# cover = ""
date = 2024-12-05
draft = false
+++

{{< figure caption="Example: Print a version of Node.js managed by asdf." >}}
  {{< highlight shell >}}
  $ asdf current nodejs 2>&1 | awk '{print $2}'
  22.11.0
  {{< /highlight >}}
{{< /figure >}}

<!--more-->

It's an improved version of [the previously mentioned solution]({{< relref "04-asdf-get-tool-version.md" >}}).

Kudos to [_André Wendt_][1] who showed me how to replace _sed_ and _cut_ with [_awk_][2].

---

{{< til-rating text="good to know" >}}


[1]: https://github.com/awendt
[2]: https://www.gnu.org/software/gawk/manual/gawk.html
