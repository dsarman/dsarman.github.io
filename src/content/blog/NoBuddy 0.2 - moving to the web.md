---
date: 2022-04-12
post-slug: nobuddy-moving-to-the-web
description: Moving from a mobile only solution to a web one.
tags:
  - Expo
  - FaaS
  - NoBuddy
  - React Native
title: NoBuddy 0.2 - moving to the web
categories:
pubDatetime: 2022-04-12
lastMod: 2023-12-07
---

⬅️ For previous article in the series, see <a href="/posts/nobuddy-app-first-poc">NoBuddy app first POC</a>

First, lets do a little recap to jog our memory:

- I have POC of a mobile only Expo app, which I found out does not really suit my needs.

- I think that by moving away from the mobile only solution I could get rid of these pain points:

  - [Unreliable background task execution](https://www.notion.so/NoBuddy-app-first-POC-bf5ffc74b73449a58864906f00a3f37a?pvs=21)

  - Missing web app form factor

# 💡The Idea

After thinking through the mentioned changes in requirements, I thought of the following ideas:

- Do the repeated task scheduling on a server instead of fully in the mobile app.

- Implement my own API covering the Notion one. This is mainly because of [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) constraints that are not present on a fully mobile solution.

- Create a web widget that could be embedded into a Notion page, and that would act as a “completed basket”. Upon dragging your task and dropping it onto the widget, it would be automatically marked as completed, and all the necessary Notion DB connections would be made.

# 🏗Execution

## Creating backend for Notion API management

Before implementing the backend, I had to make several decisions about technologies that I would use to achieve these requirements:

- Method of storing and accessing the Notion API key securely.

  - You could use any DB here, but I have long wanted to try [Fauna](https://fauna.com/), and although this simple use case will definitely not test it as I would like, at least I will get my feet wet.

- API to use the stored token to access Notion API and relay the results back.

  - This is the most “boilerplaty” part of the app, since we need to use authentication. I have many times started and abandoned my side-projects at this stage, so I am looking into the easiest-to-set up solution.

### The [Netlify](https://www.netlify.com/) debacle

For the API part I decided on using [Netlify](https://www.netlify.com/) functions. I did not do in-depth research into alternative providers, but I heard good things about the service and wanted to try it out.

It was nice to work with, and I liked the authentication offering in the form of [Netlify Identity](https://docs.netlify.com/visitor-access/identity/). The major gripe I had with it was _very_ little documentation. As a beginner in this area it took me a while before figuring out how to integrate it.

However, this phase of everything going pretty smoothly was about to end. I was almost halfway done with moving the Notion integration to Netlify functions when I hit a roadblock.

I implemented the function that stores the Notion api key in [Fauna](https://fauna.com/). This is used when first setting up the app, where upon entering the API key, the app checks if all needed Notion databases can be found. To do this it makes 4 calls to Notion, and since the API (and, frankly Notion as a whole) is not very fast, I ran into the [10 second Netlify function time limit](https://docs.netlify.com/functions/overview/#default-deployment-options) almost immediately. This gave me huge pause as there were definitely functions that were even more “Notion heavy” than this one, and this was almost unusable. I could of course try to split the functions into separate ones that would probably be faster, but the hanging sword of the 10 second time limit would always be above my head, ready to fall without any notice. This was the reason I began looking for an alternative [FaaS](https://en.wikipedia.org/wiki/Function_as_a_service) platform.

### Looking for alternatives

One of the other [FaaS](https://en.wikipedia.org/wiki/Function_as_a_service) providers I know of is [Vercel](https://vercel.com), which I actually use to serve this blog. But it has the same [execution time limitation](https://vercel.com) as [Netlify](https://www.netlify.com/), at least for free accounts. And even with paid plans that have this limit expanded to 60 seconds and more, I feared what the costs would be if I started adding more Notion interaction.

The next provider I know of is [Cloudflare Workers](https://workers.cloudflare.com/), and while looking at their price model, I started to get excited. The way they compute execution time is **CPU** execution time. This is important because as I said before the reason for my functions exceeding the limit is interaction with Notion API, which is mostly IO. This means I should not be billed for all the waiting around for Notion API **at all**. And the difference was really huge, what was 10s or more when timing the whole execution, became around 24ms of CPU execution time!

Ok, so I was sold 😀, now I need to take everything I just implemented with [Netlify](https://www.netlify.com/), and move it over to [Cloudflare Workers](https://workers.cloudflare.com/), yay ... And that is what the next post is going to be about.
