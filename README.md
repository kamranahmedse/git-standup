# git-standup

> Recall what you did on the last working day... or be nosy and find what someone else did.

This is a little tool that I have always wanted for myself. I work on several repositories on a daily basis and it is very difficult to remember where I left off in each one of them. I used to check the heat map on my Github profile or run *git log* on each project to remember what I did and it seemed to be a bit cumbersome that's when I came up with the idea of making `git-standup`.

By default, it shows commits of the current directory and the directories below it since the last working day, and it also comes with several options to modify how it behaves.

The only requirement is to have good commit messages :)

![](https://i.imgur.com/yL03GkB.png)

## Install

You can install `git-standup` using one of the options listed below

| Source | Command |
| --- | --- |
| curl | `curl -L https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh \| sudo sh` |
| npm | `npm install -g git-standup` |
| brew | `brew update && brew install git-standup` |
| aur | `pacaur -S git-standup-git` |
| manual | Clone and run `make install` |  

## Usage

Simply run it in your project directory and it will give you the output from the last working day

```shell
git standup
```

If you run it in a folder containing multiple git repositories, it will go through all of your projects and then it will give you the standup report for each one of them.

## Options 

You can pass several options to modify how `git-standup` behaves

```shell
git standup [-a <author name>] 
            [-w <weekstart-weekend>]
            [-m <max-dir-depth>]
            [-d <since-days-ago>] 
            [-u <until-days-ago>]
            [-D <date-format>]
            [-L]
            [-g] 
            [-h] 
            [-f]
            [-s]
            [-r]
```

Here is the detail for each of the options 

| Option | Description |
| --- | --- |
| a | Specify author to restrict search to e.g. `-a "Kamran Ahmed"` or `-a "all"` |
| w | Specify the first and the last days of the workweek e.g. in UAE workweeks are from Sunday to Thursday, so you can do `-w SUN-THU`|
| m | Specify the depth of recursive directory search e.g. `-m 3` defaults to two |
| d | Specify the number of days back to include e.g. `-d 30` to get for a month |
| u | Specify the number of days back till which standup should run e.g. `-u 3` |
| L | Toggle inclusion of symbolic links in recursive directory search |
| D | Specify the date format for "git log" (default: relative) [possible values](https://git-scm.com/docs/git-log#git-log---dateltformatgt) |
| h | Display the help screen |
| g | Show if commit is GPG signed (G) or not (N) |
| f | Fetch the latest commits beforehand |
| s | Silences the no activity message (useful when running inside a directory that has multiple repositories) |
| r | Generates the standup report file `git-standup-report.txt` in the current directory |

For the basic usage, all you have to do is to run `git standup` in a repository or a folder containing multiple repositories

## Single Repository Usage

To check all your personal commits from the last working day, head to the project repository and run

```shell
$ git standup
```

![git standup](http://i.imgur.com/wyo4s9E.gif)

## Multiple Repository Usage
Open a directory having multiple repositories and run

```shell
$ git standup
```

![git standup](http://i.imgur.com/4xmkA49.gif)

This will show you all your commits since the last working day in all the repositories inside. 

## Directory depth

By default the script searches only in the current directory or one
level deep. If you want to increase that, use the `-m` switch.

```shell
$ git standup -m 3
```

### Directory whitelisting

If you want to restrict the standup to some paths, you can whitelist them by adding them to a `.git-standup-whitelist` file. For example, if you have the directory structure below:

    ├── Workspace              # All your projects are here
    │   ├── project-a          # A git repository called project-a
    │   ├── project-b          # A git repository called project-b
    │   ├── sketch-files       # Some sketch files
    │   ├── mockups            # Some balsamiq mockups
    │   └── ...                # etc.
    └── ...

And you want the `git-standup` to show logs for only `project-a` and `project-b`, you can do that by creating a `.git-standup-whitelist` file under the `Workspace` directory with the contents below and it will only consider those directories for the standup

```
project-a
project-b
```

## Checking someone else's commits

If you want to find out someone else's commits, do

```shell
# Considering their name on git is "John Doe"
$ git standup -a "John Doe"
```
![git standup](http://i.imgur.com/sYICxW8.gif)

## Check what every contributor did

If you want to find out someone else's commits, do

```shell
$ git standup -a "all"
```

## Commits from `n` days ago

If you would like to show all your/someone else's commits from n days ago, you can do

```shell
# Show all my commits from 4 days ago
$ git standup -d 4

# Show all John Doe's commits from 5 days ago
$ git standup -a "John Doe" -d 5
```

![git standup -d 5](http://i.imgur.com/j7Ma760.gif)

## [Identifying Signed Commits](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)

Add `-g` flag to check the GPG info

```shell
$ git standup -g
```

![GPG Info](http://i.imgur.com/bwJzPft.gif)

## Specifying the date format

Add `-D` flag to specify the date format. Default is `relative`

Please note that it accepts the same format that you could pass while doing *git log*. For example

```shell
$ git standup -D relative
# Or instead of relative, it could be local|default|iso|iso-strict|rfc|short|raw etc
```

## Changing the Weekdays

By default, it considers that the workweek starts on Monday and ends on Friday. So if you are running this on any day between Tuesday and Friday, it will show your commits from the last day. However, if you are running this on a Monday, it will show all your commits since Friday.

If you want to change this like I did (because here in Dubai working days are normally Sunday to Thursday), you will have to do the following

```shell
$ git standup -w "SUN-THU"
```

## Fetch commits before showing standup

If you have many repositories that you want to generate a standup for, it may be useful to automatically run `git fetch` before viewing the standup.

If you would like to automatically run `git fetch --all` before printing the standup, you can add the `-f` flag, as show below

```shell
$ git standup -f
```

## Mixing options

Of course you can mix the options together but, please keep in mind that if you provide the number of days, it will override the weekdays configuration (`MON-FRI`) and it will show you the commits specifically from `n` days ago.

```shell
# Show all the John Doe's commits from 5 days ago
$ git standup -a "John Doe" -d 5
```

## License

MIT © [Kamran Ahmed](http://kamranahmed.info)
