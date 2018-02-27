+++
title = "Passwordless authentication: one step further"
description = "How to authenticate a user without keeping the email address in the database."
date = 2016-11-16
+++

Today it is hard to image an app or a website on the internet that does not require authentication. Usually a sign-up form have at least two fields — email and password. That immediately brings two problems:

1. The password should be strong enough otherwise it does not make sense to have it at all.
2. The email address must be kept secure because it is user’s private information.

<!--more-->

The first problem is easy to fix. There are many password managers that help generate strong passwords and keep them safe.

Another solution for the password problem is [the passwordless authentication](https://medium.com/@ninjudd/passwords-are-obsolete-9ed56d483eb). What could solve the issue better than absence of the password? Medium and Slack’s magic links are good examples.

> "The basic idea is that instead of using a password to authenticate each user, a temporary secret code is sent to them over a secure channel. Email or SMS is that (mostly) secure channel. It’s almost as if the backend server makes up a temporary, one-use password each time a user wants to log in and whispers it in their ear."
>
> _-- ["Passwords are Obsolete"](https://medium.com/@ninjudd/passwords-are-obsolete-9ed56d483eb), Justin Balthrop_

However the email address is still there and needs to be treated well. Of course many services uses these addresses not just for authentication, but anyway there is a huge number of cases when the email is just a convenient replacement for a unique username and nothing more than that.

So if you are a developer of an app or a website that uses email addresses just for authentication and you care about privacy, ask yourself: _"Do I **really** need to keep the email address to authenticate the user?"_

## Implementation

That exact question I asked myself of few days ago and realised I could answer _"No."_ on it. Let me explain the idea of "emailless authentication" :)

In cases of password and passwordless authentications the email address is used as an easy to remember and unique string. It is also used to send a password recovery link or an authentication link (aka "magic links").

The emailless authentication is a possible implementation of the passwordless authentication for cases when the email address is used just for user lookup. Here is how it works in details:

1. The app or website asks users for an email address.
2. A unique string based on the given email is generated and used to find the user. (If the used is not found, then she is treated as a new one. It is up to you how to deal with these new users.)
3. A temporary authentication code is stored on the found user’s account.
4. An email is sent to the address given on the step 1. This email contains an authentication link.
5. The users clicks on the link and follows general passwordless authentication procedure.

As you could see it is totally possible to implement authentication that requires neither an email address nor a password in the database of the app or website.

## Summary

As a software engineer I like to challenge myself with questions like "Do I **really** need this field/attribute/method/etc?" or "Is that really simple enough?". The idea of the emailless authentication is an answer to one of these questions. At the moment it exists only on paper, but I am definitely going to try it for a real app soon.

---

Originally posted on [Medium](https://medium.com/@soulim/passwordless-authentication-one-step-further-fd06833e785f).
