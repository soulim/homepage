+++
title = "How to DRY Docker Compose files"
description = ""
# cover = ""
date = 2024-10-23
draft = false
+++

[`extends`][1] attribute in Docker Compose files allows to reuse existing service definitions for other services.
That makes it possible to [DRY][2] Compose files.

<!--more-->

{{< figure caption="compose.yml" >}}
  {{< highlight yaml >}}
  name: foo

  service:
    dev:
      image: ruby:3.3.5-alpine3.20
      environment:
        ENV: "development"
    test:
      extends:
        service: dev
      environment:
        ENV: "test"
  {{< /highlight >}}
{{< /figure >}}

In the definition above `test` service has exactly the same configuration `dev` and only redefines one environment variable.
According to [the documentation][3] it's also possible to include and reuse definitions from other files.

---

{{< til-rating text="good to know" >}}


[1]: https://docs.docker.com/reference/compose-file/services/#extends
[2]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
[3]: https://docs.docker.com/reference/compose-file/services/#finding-referenced-service
