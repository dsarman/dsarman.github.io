---
date: 2022-06-01
slug: switching-from-notion-to-obsidian
description: Moving away from the cloud.
tags:
  - Obsidian
  - Personal Knowledge Management
title: Switching from Notion to Obsidian
categories:
pubDatetime: 2022-06-01
lastMod: 2023-12-07
---

## Motivation

Several previous articles here revolved around Notion and its API. This was to make planning my life in Notion easier. For this purpose I was using the [L-CTRL](https://toolbox.co-x3.com/product/l-ctrl) Notion template from the [co-x3](https://join.co-x3.com/) community. And while it was a tremendous starting point — and I will definitely keep many of the concepts it used close to heart — in the end it was just so huge. The breadth of the system (planning, gamification, review, content creation, etc.) was so big that even after using it for more than a year, I often felt lost. This led me to attempt a rewrite: keep only what I use, toss everything else.

So I started, and in the end, the result was pretty good! I simplified the system, even improved it in some regards. But the whole thing left me feeling like I was fighting Notion a little bit. Do not get me wrong, Notion is a great tool that I really liked, but the level of customisation that I wanted was really difficult to achieve. That is when I started to entertain the idea of leaving Notion, and since I knew about Obsidian from before, and was interested in it, it was the logical choice to try out.

## Comparison

### Features

Just to be safe, lets go over some of the high level pros of both programs:

- **Notion**

  - UX - Notion UI is beautiful, it allows page covers, icons, callouts, etc. and looks really streamlined.

  - Collaborative - You can share any page in the hierarchy, comment on pages or parts of text ...

- **Obsidian**

  - Open data format - Obsidian’s data format is Markdown, which means the content is viewable/editable and usable outside of Obsidian

  - Customisation - Due to being an Electron app with CodeMirror based editor with plugin architecture, the sky is the limit in terms of customisation.

### The feeling

While individual features are important, just enumerating them does not capture the whole experience of using the program. In this regard I can offer the take of an Obsidian novice. The experience is just "more basic". The reality of everything being a markdown file simplifies a lot of things, and while I expected to miss Notions sleek blocks and UI, this does not seem to be the case yet.

The topic of alternatives to Notion’s databases could take a whole chapter, but I will just touch on the subject briefly. To partially substitute Notion databases I am using the [obsidian-dataview](https://github.com/blacksmithgu/obsidian-dataview) plugin, which allows you to query all your notes. It has SQL-like API, but the star of the show is its JS API, which also exposes the Obsidian plugin API. This means that you can query your notes with the whole might of the JS ecosystem. You can even create your own UI (in React, Vue, Vanilla JS, ...), change the note content, etc. The sky is the limit here! And for me, this was immensely liberating. In Notion the Databases always felt a little rigid, not allowing me to structure my notes how I wanted, imposing its structure on me. This resulted in an ever present feeling of fighting the tool a bit. In Obsidian I feel none of this, and it is great!

This great freedom necessarily has its cost, and that is the amount of customisation. I have still not migrated all of my workflow over from Notion, and I already have several hundred lines of custom JS dataview code. The amount of customisation is a double edged sword. You can customise anything, but you need to have the time and motivation to actually do it.

Perhaps the best comparison is that of Linux (Obsidian) with its customizability to something like macOS (Notion) with its sleek polished UI.

## What's next ?

If anyone is reading this, I am aware that the system I am describing probably does not make any sense to you. I am planning to describe my Obsidian setup in more detail in later articles, which will hopefully shed more light on this abstract mess of ideas.
