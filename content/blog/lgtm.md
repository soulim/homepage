+++
title = "LGTM: a Chrome extension"
description = "LGTM extension prints review statuses as stamp labels on the GitHub pull request overview page."
images = [
  "blog/images/social-media/lgtm.cover.png"
]
date = 2018-05-15
draft = false
+++

If you don't know *LGTM* is an initialism of "looks good to me".

A few days ago, while going through my Twitter timeline, I spotted one tweet that turned on the bulb above my head. I was instantly inspired! :bulb:

<!--more-->

There is the tweet, btw:

{{< tweet 992146407128686592 >}}

I was inspired to create [a Chrome extension that prints stamps on GitHub pull request overview pages](https://chrome.google.com/webstore/detail/lgtm-looks-good-to-me/mbiaidjlljbijjfbeekcocinpfamgkcl). The problem didn't look very complex even if I had no idea how to write an extension.

## The making of LGTM

I didn't have much time and didn't want to turn this tiny little project into something big. The main goal was (and still is) to some experience of making an extension by doing something small, but useful.

Google provides [nice documentation](https://developer.chrome.com/extensions), so it doesn't take much time to understand the basics.

The biggest challenge and the most interesting part was to decide how exactly these stamps should look on the page. These are options I was experimenting with:

1. Put stamps on above the reviewers block in the sidebar.
2. Replace existing review statuses with stamps.
3. Do not modify anything existing on the page and put stamps on top.

After few experiments, I decided to go with the third option because it was the easiest one to implement and actually the closest one to the idea from the tweet.

Intentionally I didn't want to give the extension to much power and ask the user for too many permissions. That would be silly for such a tiny extension. So after about half an hour, the first draft was ready to roll. The extension used information already available on the page (existing review statuses in the sidebar) and printed stamps based on that information.

Results looked great, but then I discovered that the extension does print stamps in some cases. GitHub doesn't reload pages when one navigates through the website. It uses [pjax](https://github.com/defunkt/jquery-pjax) to load page parts, put them on the page, and modify URL in the address bar of the browser. That does not play nicely with Chrome extension because they are activated when a page is actually (re)loaded.

After some research and experimentation, I've ended up with a hack - a proxy function for `History#replaceState` method.

{{< highlight js >}}
// The extension is activated and this script is executed
// when the page is reloaded. However GitHub uses PJAX to
// load and replace just part of the page, so there is no
// actual page reload happening.
//
// Because PJAX is using `History.replaceState` and
// `History.popState` to manipulate URL and update
// the page parts, this scripts acts as a proxy
// for `History.replaceState`. It might look a a hack, but
// it is the best solution I have found so far.
var addHistoryStateProxy = function () {
    var replaceState = history.replaceState;

    history.replaceState = function () {
        window.postMessage('lgtm:pageUpdated', '*');
        return replaceState.apply(this, arguments);
    };
};
{{< /highlight >}}

The next tricky step was to figure out where and when to add the hack. There is what I decided to do:

{{< highlight js >}}
// The extention is running in a sandbox, so
// the `History.replaceState` proxy script must be
// injected on the page.
var script = document.createElement('script');
var parent = document.documentElement;
script.textContent = '('+ addHistoryStateProxy +')();';
parent.appendChild(script);
{{< /highlight >}}

Once I was happy with the extension running in the local browser, it was time to release it. You should [give it a try too](https://chrome.google.com/webstore/detail/lgtm-looks-good-to-me/mbiaidjlljbijjfbeekcocinpfamgkcl).

## Summary

It was a nice weekend project. The source code is open and you could find on GitHub - <https://github.com/soulim/lgtm>. Feel free to [rate or leave a review of the extension on the Chrome Web Store](https://chrome.google.com/webstore/detail/lgtm-looks-good-to-me/mbiaidjlljbijjfbeekcocinpfamgkcl/reviews), report an issue or open a pull request on GitHub.

Also, I would like to say one more time "Thank you!" to [David Jones](https://twitter.com/d_jones) for the inspiration :smile:
