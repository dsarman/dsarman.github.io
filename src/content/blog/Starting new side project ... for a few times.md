---
tags:
  - Android
  - Expo
  - React Native
date: 2021-12-21
description: From React Native to native Android app, and back to React Native again.
slug: starting-new-side-project-for-a-few-times
title: Starting new side project ... for a few times
categories:
pubDatetime: 2021-12-21
lastMod: 2023-12-06
---

For some time, I have wanted to create a Notion companion mobile app to streamline some of my Notion workflows. At first I was waiting for the public API. That was finally released a few months ago in May 2021, and has been [acquiring features at a steady pace](https://developers.notion.com/changelog?page=1) ever since. So now the only problem is me procrastinating.

# 🖥 Technologies

For every side project I start, I always try to choose the most exciting technologies. In work, you are often limited by legacy libraries, years of technological debt, and outdated coding practices set in stone. When I am coding outside of work I want to forget all this "inconvenient" reality, and just enjoy the best libraries & APIs I can.

Of course, this has its downside. New technologies are fun, and some of them might be paradigm-altering enough to warrant the investment you have to put into learning them, but beware of excessive tinkering. It can lead you down an unproductive rabbit hole, instead of creating actual output and working code. The following paragraphs are a testimony to that.

## 1️⃣ React Native first try

Since I have been working on a React Native (RN) project for a year at the time, I wanted to hone my skills further, and decided to use it for this side project too. Besides the proximity to my work life, RN offers several opportunities that I wanted to take advantage of:

- Multiplatform development (the obvious one ...) → I have Android, my wife has iOS, but I do not have want to invest time into to developing 2 native apps as a side project.

- Reacts declarative UI paradigm (the main one)→I have experience with creating Android native UIs — and I must say — that the top down reactive paradigm is much nicer to use than the Java/Kotlin + XML way of Android (no longer true with [Jetpack Compose](https://developer.android.com/jetpack/compose), see below)

In the spirit of trying new stuff out and saving time, I decided try using the [Ignite](https://github.com/infinitered/ignite) boilerplate project. It was nice at first, I got to try out [MST](https://mobx-state-tree.js.org/intro/welcome), which was interesting, I liked the cli tool for generating boilerplate code for stuff like components, MST state, UI screens. The nice thing about this cli for templating common code is it takes away a few “insignificant” choices you would otherwise have to make: where should I put this code? what is the common way to define this kind of component in this project? etc. . It also automatically enforces code style and guidelines you might want to follow.

But as it often goes with boilerplate projects, as I wanted to customise more stuff, I felt more and more "crowded". I was unsure if my changes will fit into the broader architecture of the boilerplate without investing significant amount of time to understand the inner workings of the existing code. Add in a few bugs and complex update process, and I was frustrated enough that I stopped working on the project for a while.

## 2️⃣ Pivoting to native Android

For a few months, I was inactive, slowly accumulating motivation until it finally reached a threshold where I had to act 😁. Right around that time, I bought the Galaxy Watch4 smartwatch, and thought "wouldn't it be nice if I could use the app directly from smartwatches". I looked around and found out that React Native by itself does not support Wear OS. There is the [Renative](https://github.com/pavjacko/renative) project, which should support this use-case, but I did not feel comfortable adding yet another layer of abstraction to an already very abstraction heavy RN solution.

As I started to look into making a native Android app, I came across the new [Jetpack Compose](https://developer.android.com/jetpack/compose). With this new library, you can write declarative native Android UIs without touching XML. The whole time I was going through the tutorial and documentation, I was thinking: "this feels **_really_** familiar, this is like **_React in Kotlin_**!". You have composable functions (components in RN), you have state hoisting, you have coroutines (`async` functions), you have `CompositionLocal` (`React.Context`). These are of course just summaries that I deduced after a quick read through the basic documentation, but the similarity is indisputable.

This was great, another nice new API to learn, brand new rabbit holes to go down into ... And round and round it goes ♾️.

## 3️⃣ Back to React Native

I kept learning the Compose libraries, and it was fun, but it was really slow too, and then fatigue set in. Also, the multiplatform angle kept bugging me. So in another scrape and pivot to different technology, I am going back to React Native 🙊.

The main reasons for this are:

- I need 🍏 iOS version of the app

- I can use the [Notion JavaScript SDK](https://github.com/makenotion/notion-sdk-js)

  - This was quite a pain point in Kotlin, since I had to roll my own client. I ended up trying to reimplement the types 1:1 against the API and JS SDK, and it was quite verbose.

- React Native makes more sense for a solo developer

  - I can appreciate the native experience as much as the next guy, and feel that RN stability could be improved **_a lot_**. Nevertheless there are only 24 hours in a single day, and I get way more done in RN, than I would in two native projects.

On my second RN run, I wanted to go the "clean slate" route and opted for clean Expo with no boilerplate. I think this will bring me closer to basics, as well as give me some insight into the choices that boilerplates make for you: what are the pros/cons of the libraries and how well do they interact with others around them, and your general app architecture.

So, this ended up being something different than what I set out to write. I wanted to give a simple walkthrough of setting up the very beginning of an Expo project, but went off course into the past. Nevertheless it helped me reflect on my choices and reassured me of my direction. See you next time for a more practical tutorial 👋.

➡️ For the next article in the series, see <a href="/posts/new-expo-project-setup">New Expo Project Setup</a>

---

🗃 Resources

- Jetpack Compose - [https://developer.android.com/jetpack/compose](https://developer.android.com/jetpack/compose)

- Ignite - [https://github.com/infinitered/ignite](https://github.com/infinitered/ignite)

- MobX-State-Tree - [https://mobx-state-tree.js.org/intro/welcome](https://mobx-state-tree.js.org/intro/welcome)

- Notion JavaScript SDK - [https://github.com/makenotion/notion-sdk-js](https://github.com/makenotion/notion-sdk-js)
