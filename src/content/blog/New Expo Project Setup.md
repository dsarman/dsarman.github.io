---
tags:
  - Expo
  - React Native
date: 2022-01-25
description: Setting up a new Expo project with absolute imports and Prettier.
post-slug: new-expo-project-setup
title: New Expo Project Setup
categories:
pubDatetime: 2022-01-25
lastMod: 2023-12-06
---

⬅️ For previous article in the series, see <a href="/posts/starting-new-side-project-for-a-few-times">Starting new side project ... for a few times</a>

---

You are starting a new project, and you know the drill. You usually have some basic template provided for you, in this case provided by the `[expo init my-app](https://docs.expo.dev/get-started/create-a-new-app/)` command. But how to structure your project files from there? I was just about to wing it and dive head first into creating code, but then a weak nagging feeling of “this is not the way” creeped up on me 😄. So I attempted to do a little research. The first few articles ([Best Folder Structure for React Native Project](https://medium.com/habilelabs/best-folder-structure-for-react-native-project-a46405bdba7), [An efficient way to structure React Native projects](https://cheesecakelabs.com/blog/efficient-way-structure-react-native-projects/)) talked about grouping components according to categories from [Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/). This seemed interesting, but then I stumbled upon an [article](https://www.freecodecamp.org/news/how-to-structure-your-project-and-manage-static-resources-in-react-native-6f4cfc947d92/) that seemed to go a little deeper.

# Grouping by type vs feature

I won’t rewrite everything here, but the premise is that grouping by feature is more natural, and it also offers benefits such as increasing co-location of code and making refactoring easier. This seemed to ring true to me, and it was also different from the grouping by type that I was used to from other projects.

## Handling common code

Of course, you will have some common code that will be used between more components. The solution to this is a separate `common` directory. For shared React components we can even use the previously mentioned [Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/) principles to flesh out important shared details with more structure.

Example of an project with this structure might look like this:

```tsx
src
├── common
│   ├── components
│   │   └── LoadingScreen.tsx
│   ├── constants.ts
│   ├── helpers.ts
│   ├── hooks
│   │   └── useIsMounted.tsx
│   ├── layout
│   │   └── SafeAreaLayout.tsx
│   ├── navigation
│   │   └── RootNavigator.tsx
│   ├── state
│   ├── theme.ts
│   └── types.ts
└── screens
  ├── settings
  │   ├── component
  │   │   └── SettingsComponent.tsx
  │   ├── SettingsScreen.tsx
  │   └── state
  │       └── settingsAtoms.ts
  ├── today
  │   ├── actions
  │   │   ├── completeTask.ts
  │   │   ├── createTask.ts
  │   │   └── planHabits.ts
  │   ├── components
  │   │   ├── NotionTaskCard.tsx
  │   │   └── TaskCard.tsx
  │   ├── constants
  │   │   └── taskContants.ts
  │   ├── state
  │   │   ├── habitsAtoms.ts
  │   │   ├── tasksAtoms.ts
  │   │   └── timeBlockAtoms.ts
  │   ├── TodayScreen.tsx
  │   └── todayTypes.ts
  └── wakeUp
      ├── actions
      │   └── createDailyQuest.ts
      ├── state
      │   └── dailyQuestAtoms.ts
      ├── svg
      │   └── SunriseSvg.tsx
      ├── WakeUpScreen.tsx
      └── wakeUpTypes.ts
```

# Bells & whistles

## Getting rid of relative paths

One of the other things mentioned more times was setting up your project so that import paths would not be relative, but absolute. The difference is:

```tsx
import { RootStackParams } from "../../library/navigation/RootNavigator";
import { SettingsComponent } from "./component/SettingsComponent";
```

vs this:

```tsx
import { RootStackParams } from "library/navigation/RootNavigator";
import { SettingsComponent } from "screens/settings/component/SettingsComponent";
```

At first I looked at this as a cosmetic issue, thinking “Who the hell writes imports by hand? You just press enter for automatic import in your IDE and you’re golden”. But after a few days it clicked, when I came upon a concrete example. Suppose you have the folder structure described above, with a `library` for common code, and a separate directory for each feature, and that your feature folder has a component name that overlaps with that of common component. Of course you should strive to name things uniquely to avoid this confusion, but it happens. With relative imports, you are faced with the question, “am I importing what I think I am?”

```tsx
import { SettingsComponent } from "./component/SettingsComponent";
import { SettingsComponent } from "../../component/SettingsComponent";
```

With absolute imports, you are sure from the first moment.

```tsx
import { SettingsComponent } from "library/component/SettingsComponent";
import { SettingsComponent } from "screens/settings/component/SettingsComponent";
```

With me it’s often these “little things” that can make a difference between an enjoyable programming experience, where you are in the flow, solving problems that are worth it, and an annoying chore where you feel like everything is fighting against you.

### The actual setup

So with motivation being clear, let’s get it set up. First, I tried the approach of using `package.json` to avoid relative path. This however did not work for me. So I set out Googling, and after a while came upon a setup that worked for me.

First, I had to set up my IDE. Due to coding Java & Kotlin for quite a few years I am a JetBrains customer, so for JavaScript I use WebStorm. To have absolute imports work there, you need to set up your `tsconfig.json` and set up the correct `baseUrl`, pointing to your typescript source directory.

```json
{
  "extends": "expo/tsconfig.base",
  "compilerOptions": {
    "strict": true,
    "baseUrl": "./src"
  }
}
```

Then you need to tell WebStorm to **not** use relative imports by going to Settings > Editor > Code Style > Typescript > Imports, and there you need to **check** the “Use paths relative to tsconfig.json” option. This should have you set up to use the correct absolute path when auto importing from the IDE.

But when I tried to run the project, the absolute imports could not be found. One solution to this is to use the `[babel-plugin-module-resolver](https://github.com/tleunen/babel-plugin-module-resolver)` plugin and configure the correct path aliases. An excerpt from `babel.config.js` below shows a possible configuration:

```jsx
...
plugins: [
	[
		'module-resolver',
    	{ alias: { common: './src/common', screens: './src/screens' } },
	],
],
...
```

## Prettier

Another thing that might seem cosmetic is setting up auto-formatting of code with something like [Prettier](https://prettier.io/). When I first set it up in my work project, I did not think much about it. It seemed like a good idea to standardize the code format, and this was an automatic way to do that.

But the benefit — which I only saw after going back to the project without auto-formatting, and arguably the bigger one for me — was the cognitive overhead it freed me from. I do not know about you, but I don’t enjoy formatting code, yet I do it as it improves readability. With Prettier, you do not have to do this by hand anymore. You just type your ugly stream of thought code, and upon saving it is auto-magically formatted. Just like that, you have one less thing to think about while trying to transform your thoughts into code.

➡️ For the next article in the series, see <a href="/posts/nobuddy-app-first-poc">NoBuddy app first POC</a>

---

🗄 Resources

- Expo create new app tutorial ⇒ [https://docs.expo.dev/get-started/create-a-new-app/](https://docs.expo.dev/get-started/create-a-new-app/)

- React native project structures with “atomic concept”:

  - [https://medium.com/habilelabs/best-folder-structure-for-react-native-project-a46405bdba7](https://medium.com/habilelabs/best-folder-structure-for-react-native-project-a46405bdba7)

  - [https://cheesecakelabs.com/blog/efficient-way-structure-react-native-projects/](https://cheesecakelabs.com/blog/efficient-way-structure-react-native-projects/)

- Atomic Design ⇒ [https://bradfrost.com/blog/post/atomic-web-design/](https://bradfrost.com/blog/post/atomic-web-design/)

- How to structure your project and manage static resources in React Native ⇒ [https://www.freecodecamp.org/news/how-to-structure-your-project-and-manage-static-resources-in-react-native-6f4cfc947d92/](https://www.freecodecamp.org/news/how-to-structure-your-project-and-manage-static-resources-in-react-native-6f4cfc947d92/)

- babel-plugin-module-resolver ⇒ [https://github.com/tleunen/babel-plugin-module-resolver](https://github.com/tleunen/babel-plugin-module-resolver)

- Prettier ⇒ [https://prettier.io/](https://prettier.io/)
