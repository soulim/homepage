+++
title = "Getting a tool version from asdf"
description = ""
# cover = ""
date = 2024-12-04
draft = false
+++

{{< figure caption="Example: Print a version of Node.js managed by asdf." >}}
  {{< highlight shell >}}
  $ asdf current nodejs 2>&1 | sed -e "s/ \{2,\}/ /g" | cut -d" " -f2
  20.17.0
  {{< /highlight >}}
{{< /figure >}}

<!--more-->

## Context

The following command prints a tool version managed by [asdf][1]:

{{< figure caption="Print a version of Go managed by asdf." >}}
  {{< highlight shell >}}
  $ asdf current golang
  golang          1.23.3          /home/soulim/data/sources/github.com/soulim/q/.tool-versions
  {{< /highlight >}}
{{< /figure >}}

Unfortunately there's no way to get only the version. However that could be achieved with additional output manipulation.


Using [sed][2] and [cut][3] commands a version of given tool could be extracted using the following pipeline:

{{< figure caption="Print only a version of Go managed by asdf." >}}
  {{< highlight shell >}}
  asdf current golang | sed -e "s/ \{2,\}/ /g" | cut -d" " -f2
  {{< /highlight >}}
{{< /figure >}}

Explanation:

1. Print current tool version with `asdf current golang`.
2. In the output from asdf replace with one space character any sub-strings consisting of multiple space characters with `sed -e "s/ \{2,\}/ /g"`.
3. Split resulted output on columns separated by one space character and return the second column with `cut -d" " -f2`.

In this form the one-liner doesn't work well when given tool isn't installed yet.
In that case asdf doesn't print anything to the output stream, but instead sends an error message to the error stream.
Like in the following example with Node.js:

{{< figure caption="An attempt to print a version of Node.js that isn't installed yet." >}}
  {{< highlight shell >}}
  $ asdf current nodejs | sed -e "s/ \{2,\}/ /g" | cut -d" " -f2
  nodejs          20.17.0         Not installed. Run "asdf install nodejs 20.17.0"
  {{< /highlight >}}
{{< /figure >}}

To fix the issue error stream needs to be redirected to the output stream.
The final version of the one-liner looks like this:

{{< figure caption="A one-liner to print a tool version managed by asdf." >}}
  {{< highlight shell >}}
  asdf current nodejs 2>&1 | sed -e "s/ \{2,\}/ /g" | cut -d" " -f2
  {{< /highlight >}}
{{< /figure >}}

**UPDATE:** There's [a way]({{< relref "05-asdf-get-tool-version-improved.md" >}}) to replace _sed_ and _cut_ with _awk_ to simplify the solution.

---

{{< til-rating text="good to know" >}}


[1]: https://asdf-vm.com/
[2]: https://www.gnu.org/software/sed/
[3]: https://www.gnu.org/software/coreutils/manual/html_node/The-cut-command.html
