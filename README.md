# git-standup

> Recall what you did on the last working day ..or be nosy and find what someone else did.

## Install

You can install it  by cloning and manually installing it

```bash
$ git clone https://github.com/kamranahmedse/git-standup.git
$ cd git-standup
$ sudo make install
```

## Usage

All you have to do is run `git standup` in a repository or a folder containing multiple repositories

## Single Repository Usage

Head to the project repository and run

```bash
$ git standup
```

![git standup](http://i.imgur.com/wyo4s9E.gif)

## Multiple Repository Usage
Open a directory having multiple repositories and run

```bash
$ git standup
```

![git standup](http://i.imgur.com/RT25cT9.gif)

This will show you all your commits since the last working day in all the repositories inside. 


## Stand someone else up

If you want to find out someone else's commits do

```bash
# Considering their name on git is "John Doe"
$ git standup "John Doe"
```
![git standup](http://i.imgur.com/N6r3SXA.gif)


By default, it considers that the work week starts on Monday and ends on Friday. So if you are running this on any day between Tuesday and Friday, it will show you your commits from the last day. However, if you are running this on Monday, it will show you all your commits since Friday.

If you want to change this, like I want because here in Dubai working days are normally Sunday to Thursday, you will have to do the following

```bash
$ git standup "John Doe" SUN-THU
```

## Motivation

We have daily standups at our workplace and to check my deeds of the day, I was used to using git log or checking the heat map on my github profile and it seemed to be a bit cumbersome. To automate it, I searched and came across some of [the](http://code.joejag.com/2013/everyday-git-aliases.html) [aliases](https://coderwall.com/p/f4shwg/git-for-daily-standup) [and](https://gist.github.com/pathikrit/fb75ba009960c4ed9ddf) [snippets](https://github.com/stephenmathieson/git-standup) that people had been using but none of them directly served my purpose and so I spent a little time over the weekend to write this utility. Previously, I wrote it just for me but then I went ahead and made it a bit more generic and put it on github for others to use. And this is how git-standup was born.

## License

MIT © [Kamran Ahmed](http://kamranahmed.info)
