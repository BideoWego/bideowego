---
title: Genr8 Express App Generator
date: 2017-11-09 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/genr8.jpg
categories: [Bash, JavaScript]
tags: [express]
---


What's an app generator? What is [boilerplate code](https://en.wikipedia.org/wiki/Boilerplate_code)? How does a generator help and why is it so cool?

Well, if you've worked with frameworks like [Ruby on Rails](http://rubyonrails.org/), you've obviously been spoiled by commands like `rails new` that [generate all that boilerplate code](http://guides.rubyonrails.org/command_line.html#rails-new) to jump-start your project.

```
$ rails new commandsapp
     create
     create  README.md
     create  Rakefile
     create  config.ru
     create  .gitignore
     create  Gemfile
     create  app
     ...
     create  tmp/cache
     ...
        run  bundle install
```


When `rails new` is finished it's magic you have a rails app ready to be fired up and start coding! Awesome! This is not a concept that is only found in rails. Generators are also widely used in other frameworks. Having boilerplate created for you is a huge time saver. Here are a bunch of other solutions for code and application generation:

- [Initializr](http://www.initializr.com/)
- [Office Express Application Generator](https://expressjs.com/en/starter/generator.html)
- [HTML5 Boilerplate](https://html5boilerplate.com/)
- [Yeoman](http://yeoman.io/generators/)

So with all these solutions available, why introduce another?

Well, if you're like me, you want your files and folders setup to **your** needs from the beginning. You don't want to have to learn where the generator puts specific code, how, why and rearrange everything. It defeats the purpose of the generator in the first place! So what to do? Enter [genr8](https://github.com/BideoWego/genr8).


## Genr8

After pondering the issue of all the generators a bit, I began wishing it was just as simple as writing some [Bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-2.html#ss2.1). The bash script would just copy the boilerplate files and folders into my newly created project directory. So I came to the conclusion, "let's do that"!

[Genr8](https://github.com/BideoWego/genr8) is a [DIY](https://en.wikipedia.org/wiki/Do_it_yourself) generator written in bash. It comes with an Express.js generator that suits my usual needs in an Express application. However, the best part is, it's dirt simple! Just:

1. Create a folder in the main `genr8/` directory
1. Add an `index.sh` file to write the generator's bash script
1. Run `$ genr8 YOUR_GENERATOR_NAME` in the directory of your project
1. Done!

Benefits and advantages:

- It allows complete personalization
- It's quick and easy to update your boilerplate
- No running bash commands from within another programming language using `system`, `child_process` or whatever...
- No installing gems or packages to use the generator
- No studying complex documentation just to get a few files and folders created


### Genr8 and Node/Express

Node and Express applications tend to differ a lot in structure. Express is built to be minimalistic and integrate with **tons** of packages. Will your project use:

- Controllers?
- Routers?
- Models?
- SQL?
- MongoDB?
- Redis?
- Websockets?
- EJS?
- Handlebars?
- Jade?
- LESS?
- SASS?
- Plain CSS?
- Morgan logging?
- Winston logging?
- Some awkward combination of the above???!!!
- Ahhhh! The list is almost as long as the NPM package registry!!!!

The flexibility that `genr8` offers is perfect for this situation. Write your boilerplate plate the way **you** want it, **once** and then never have to write it again!


## Bash Tricks

Genr8 is largely just a few bash tricks I'll highlight here. First, it needs to be symlinked to provide the command to your `$PATH`:

```bash
ln -s /path/to/genr8/index.sh /usr/local/bin/genr8`
```

Once we have a `genr8` command symlinked, we'll need to get the directory of the original `genr8` repo because the command will be run from the symlink location. So...

```bash
# Get the path to the original genr8 repo directory
DIR=$(dirname $(readlink $(which genr8)))
```


Now, in order to make sure we have a subcommand with can run, we check to make sure there is a directory with the name of the given subcommand. That directory must have an `index.sh` file present.

```bash
# Do we have an argument?
# Do we have an subcommand/index.sh to run?
if [[ ! -z $1 ]] && [ -f $DIR/$1/index.sh ]; then

  # If so, let's go!
  bash $DIR/$1/index.sh

  # Exit the program because we don't want to run anything more
  exit 0
fi
```


Genr8 has dynamic subcommand detection by checking for the presence of directories. It lists the available directories/subcommands similarly. To get this list, we `cd` into the directory and list only the directories there, removing the trailing `/`.

```bash
echo "Please specify a generator from the list:"
cd $DIR

# This command lists only directories and has a few sed commands for formatting
ls -1d */ | sed 's#/##' | sed 's#^#  #'
exit 1
```


To copy all the contents of the [express boilerplate](https://github.com/BideoWego/genr8/tree/master/express/boilerplate) code we'll need to get a reference to the original `genr8` repo path and also use the `cp` command with the `-a` option. This will copy the contents of the directory but not the directory itself.

```bash
DIR=$(dirname $(readlink $(which genr8)))
DIR="$DIR/express/boilerplate"
cp -a $DIR/. .
```

From there it's smooth sailing! Just run `npm init` and install all the packages! Here's a neat little bit of bash to stick all your packages in an array and output them in the command:

```bash
PACKAGES=(
  body-parser
  cookie-session
  dotenv
  express
  express-flash-messages
  express-handlebars
  express-method-override-get-post-support
  load-helpers
  lodash
  method-override
  morgan
  morgan-toolkit
)
npm install --save ${PACKAGES[@]}
```


## Conclusion

I hope you enjoyed this bit of reading and I hope `genr8` helps you create some beautiful personalized boilerplate!






























