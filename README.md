# git-standup

> Recall what you did on the last working day ..or be nosy and find what some other guy did.

## Install

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


## License

MIT © [Kamran Ahmed](http://kamranahmed.info)
