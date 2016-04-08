<div align="center"><img src="https://raw.githubusercontent.com/Radfordhound/love2d-game-maker/master/Project%20Resources/art/Project%20Logos/Love2d%20Game%20Maker%20General%20Maze.png" width="480" height="270" alt="LÖVE Game Maker logo" title="LÖVE Game Maker logo"></img></div>

A development tool designed for easy creation of games using the LÖVE open-source game framework based off of "[Game Maker](https://www.yoyogames.com/studio)" by Mark Overmans.

##Overview

- [What's LÖVE?!?](#whats-lÖve)
- [What's LÖVE Game Maker?](#whats-lÖve-game-maker)
- [But... why? :S](#but-why-s)
- [Wow! Sounds great! Is there any way I can help?](#wow-sounds-great-is-there-any-way-i-can-help)
- [What's the license for the project?](#whats-the-license-for-the-project)
- [This part of the ReadMe/Project is broken or unfinished!](#this-part-of-the-readmeproject-is-broken-or-unfinished)
- [I've got a question that wasn't answered in this readme or would like to contact you personally.](#ive-got-a-question-that-wasnt-answered-in-this-readme-or-would-like-to-contact-you-personally)

##What's LÖVE?!?

What's Love? You've never loved someone? You must have a sad life...

All goofiness aside, **[LÖVE](http://www.love2d.org) is a fabulous, free, and open-source game [framework](http://en.wikipedia.org/wiki/Software_framework) built off of several open-source [libraries](http://en.wikipedia.org/wiki/Library_%28computing%29).**

It allows for coding games easily and efficiently using Lua with next to no struggle!

For example, with [**MonoGame**](http://www.monogame.net/), writing a simple example to print "**Hello, world!**" to the screen looks something like this:

```C#
using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Storage;
using Microsoft.Xna.Framework.GamerServices;

namespace GameName1
{
    public class Game1 : Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;
        SpriteFont fnt;

        public Game1(): base()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
        }

        protected override void LoadContent()
        {
            spriteBatch = new SpriteBatch(GraphicsDevice);
            fnt = Content.Load<SpriteFont>("font");
        }

        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            spriteBatch.Begin();
            spriteBatch.DrawString(fnt,"Hello, world!", new Vector2(0,0),Color.White);
            spriteBatch.End();

            base.Draw(gameTime);
        }
    }
}
```

**And this is the minimum code with next to no un-needed functions!** This doesn't even include adding the **spritefont** used by this code to actually draw the text to the screen! You need to create one, as without it Monogame will simply error upon attempting to compile!

Now, comparing the above to other languages like C, you'd probably call me an insane man for even attempting to say MonoGame is difficult. Considering how much MonoGame handles for you, I'd be crazy to say it WASN'T easy. It's a marvelous project, and I definitely have nothing against them. I, actually, would recommend it as it allows you to code games in C#, which just-so-happens to be one of my favorite languages!

But **what about newbie coders?** People simply wanting to learn how to use the engine enough to make a simple game? **Having to tell them to type all of the above code may possibly** (and more than likely will) **scare them off!**

**This is where LÖVE comes into play.** As previously mentioned, **LÖVE games are written using Lua.** As a programmer who's used many different languages (VB.Net,C,C++,C#,Java,Lua,Batch, and *cough* GML *cough*), I can easily say that **Lua is the easiest programming language I've ever used** for many, many reasons. Such as the fact that **it's written in very clear english**, or that **semi-colons are not required at the end of each line**.

**This makes the framework a LOT easier for new programmers to use**, as well as speeding things up drastically for experienced programmers without limiting their potential!

How much easier is it, you ask? **Here's the above hello world example except in LÖVE instead of MonoGame**:

```lua
function love.draw()
  love.graphics.print("Hello, world!",0,0)
end
```

Yep. That's it. **It literally does the exact same thing**, and look how much shorter/easier this is!

You're probably thinking this is just an 'excerpt' of the complete code, or something along those lines. After all, 3 lines really isn't alot of code. We didn't even have to include the actual framework itself!

But this is where you'd, surprisingly, be wrong! See, **LÖVE uses a just-in-time compiler known as 'luajit', which, in many ways, is similar to Java** (such as the fact that it supports multiple platforms). **Unlike Java, however, is the fact that code runs surprisingly fast in LÖVE**, to the point where there's hardly even a noticeable difference in the speed at which your code runs in LÖVE vs. a compiled game engine!

One of the many great things about this is that it allows us to run code without including anything, as the framework itself is already running our code!

Best of all, though, is the fact that **it's multi-platform** and **has a great community,** with the current version supporting **Windows**, **Mac OSX 10.6+**, **Linux**, **Android**, and **iOS**; two of which (iOS and Android) were actually added in by the community!

##What's LÖVE Game Maker?

Love Game Maker is a program inspired by Mark Overman's "[Game Maker](https://www.yoyogames.com/studio)" which allows for easy drag-n-drop coding of games using the LÖVE as a background. It's basically the already-simple LÖVE, but with no actual coding involved!

##But... why? :S

At this point you may be asking youself "**If LÖVE is already so easy, why are you making an engine to make it even easier?**"

My official answer can be summed up with the following.

See, **as easy as LÖVE is, it still involves actual coding.** **This is something which**, unfortunately, **many people in today's world are scared of.** It's amazing. They'll gladly balance atop the grand canyon's edge, give large speeches in front of easily-offendable audiences, heck, probably even punch wolverines in the face for all I know. ..All without fear! And with a smile, too! But the minute you mention the word "code," they freak out like it's the end of the earth!

Because of this, **although the vast majority of people would *like* to make games/programs, they're scared to.** Because the second you mention there'll be coding involved they'll flee to the nearest avaliable dungeon to hide away for ages.

Who knows? They may even turn out to be a master programmer who loves making video games more than any thing else, but won't even try it out of fear of messing everything up!

**The best example of this is in children.** How many kids do you know who would love to make their own video game? Probably a lot! How many of them do you think would actually understand how to code one? Even in a easy-peasy engine such as LÖVE? Probably next-to-none.

I've been coding since I was 8. Do you think I started off with languages such as C++? Heck no! I started off with [Game Maker](https://www.yoyogames.com/studio)! And even that was complicated to my little 8-year-old mind!



The point I'm trying to make here is that, for whatever reason, **people seem to be scared of the word "code."**

**Programmers have always been portrayed in media as these nerdy geniuses who understand absolutely everything there is to know about the world.** Because of this, **many people think they can't code because they're "not a programmer,"** as in "not a genius," **and won't even give it a try**! What's silly about this is that TRYING IS HOW YOU LEARN!!!

So, then.. what's this got to do with the point of LÖVE Game Maker?

Quite simply, **LÖVE Game Maker is designed to teach the *principle* of coding to those afraid of the word.** To break past the complexity of programming preventing the average beginner from successfully completing what they're trying to do, and instead simply focus on the task at hand, with the only obstacle being your imagination. ..All whilst teaching how you how to do it on your own.

##Wow! Sounds great! Is there any way I can help?

Definitely! That's why this project's on GitHub! ..So those who want to help out can contribute their awesome talents to help create the most amazing piece of software that we can! :)

For specifics on what we need at the moment, check out the TODO.md file!
Thanks in advance for the support! We really appreciate it!!

##What's the license for the project?

The license is detailed in the ["LICENSE" file](https://github.com/Radfordhound/love2d-game-maker/blob/lua-recreation/LICENSE).

##This part of the ReadMe/Project is broken or unfinished!

Thanks for noticing! If you don't mind, [submitting an "issue"](https://help.github.com/articles/creating-an-issue/) to let us know what's wrong or needs to be fixed/improved would greatly help us out!** :D

##I've got a question that wasn't answered in this readme or would like to contact you personally.

Email me at **radfordhound@gmail.com**! While I may not respond instantaneously, **I'll almost always respond to you within a week** provided I'm in a state where I'm able to check my email in the first place (which is 99% of the time :P).
