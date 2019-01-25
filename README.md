Module One Final Project
========================

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, you'll be building a Command Line Application.

---

## Goals (Minimum Requirements)

You will be building a **Command Line CRUD App** that uses a database to persist information. The goal of which is to demonstrate all of the skills that you've learned in module one:

- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))

Your **minimum requirements** for this project are to build a Command Line App that:

1. Contains at least three models with corresponding tables, including a join table.
2. Accesses a Sqlite3 database using ActiveRecord.
3. Has a CLI that allows users to interact with your database as defined by your _user stories_ (minimum of four; one for each CRUD action).
4. Uses good OO design patterns. You should have separate models for your runner and CLI interface.

---

## Project Overview (Timeline)

Welcome to the Mood Quotes app! Sometimes we all need some inspiration to keep us going. Regardless of your current situation, things don't stay the same forever. We live in a world that has more than enough opportunities for redemption, growth and change.

## How to install this app:

1. First, fork it to your directory.
2. second, clone the repository
3. Git clone to your terminal
4. open
5. Enjoy!


## How to run this app:
 ruby  bin/run.rb

## How to use this app:
   1. This app will ask you to input your username and password. Please don't leave these fields blank.
   2. Then you will be asked how are you feeling. Pick from the three choices.
   3. You will be given a message and a quote.
   4. You will then have the option to pick a different feeling, see all your quotes so far, track your mood and change your
        user name.
   5. You can exit the app at any time from options menu.

What your program looks like (screenshots).
etc.
#### The Pitch

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above. When you are ready to pitch, be sure to bring the following with you when you sit down with your instructor(s):

* schema
* user stories

As you pitch, think about how you would explain your [Minimum Viable Product (MVP)](https://en.wikipedia.org/wiki/Minimum_viable_product). Which user stories are needed to give you a solid base to build off of? Which user stories can be left to later (stretch goals)? Think [skateboard instead of wheel](https://blog.crisp.se/2016/01/25/henrikkniberg/making-sense-of-mvp).

![mvp](https://blog.crisp.se/wp-content/uploads/2016/01/mvp.png)

_**You do not need to have your MVP figured out before your pitch.**_ We will help you scope your project idea before approving it. However, this is a very useful skill to begin building for the future.

**Get your data modeling approved by an instructor before moving on to the next step.**

#### Setup

Fork and clone this project repository. As you work, be sure to create a flow of:

* creating a branch to work on a new feature,
* committing and pushing to your branch,
* and merging it to `master` when finished.
* Then delete your old branch after successfully merging to `master`.
* Rinse and repeat.

Before you start building, take a look at the files you have available in this repo.

* In the main directory, you've got a `Gemfile` that gives you access to `activerecord`, `pry`, `rake`, and `sqlite3`.
  * Remember to `bundle install`!
* In the `bin` directory, you've got a `run.rb` file that you can run from the command line with `ruby bin/run.rb.`
* In `config`, you've got your database set up with Active Record, as well as all of your models from the `lib` folder made available to your database.
* In the `lib` directory, you'll be building all your models.

**Note:** There is no `spec` directory. Your goal is to use [Behavior Driven Development (BDD)](https://en.wikipedia.org/wiki/Behavior-driven_development) to confirm that your code is doing what it should. This means instead of running `rspec` or `learn`, you should frequently be opening up the `rake console` and confirming that your methods and associations work.

---

### Phase 2: Scaffolding

This should take approximately **3/4 of a day**.

#### Data Models

Make a new file for each model in your `lib` folder. What's the naming convention for a model filename? Check out previous labs for a reminder. Remember that `activerecord` gem from our `Gemfile`? Make sure that every model inherits from `ActiveRecord::Base`.

Be sure to include the relationships between your models. The [Rails Guides ActiveRecord Documentation](http://guides.rubyonrails.org/association_basics.html) is a great source if you get stuck! Check out the `has_many :through` section when setting up your many-to-many relationship.

#### Migrations

Create your database and migrations in the terminal (keeping in mind that you have Rake available to you! Run `rake -T` in your terminal for a refresher.) What are the naming conventions for migration files and table names?

Now is a great time to open up your console in the terminal and make sure everything's working properly. Your database is empty at this point, so start by creating a new row in your `users` table. For the Yelp example, we'd do something like this:

```ruby
mike = User.create(name: "Mike")
```

You should see the user inserted into your database. Cool! Now let's test our relationships:

```ruby
mings_garden = Restaurant.create(name: "Ming's Garden")
Review.create(user_id: mike.id, restaurant_id: mings_garden.id, content: "My favorite take out place!")

mike.reviews # What does this return?
mike.restaurants # What does this return?
```

Woah! What did we just do there?

The first part is simple: we added the a restaurant to our `restaurants` table. Then we created a new relationship between our user, _Mike_, and our new restaurant, _Ming's Garden_. What is this relationship? Why that relationship is _Mike_ reviewing _Ming's Garden_! Because we setup our relationships correctly in Active Record, _Mike_ can view both his reviews _and_ the restaurants that he reviewed! Amazing!! High fives all around.

![celebration](https://media.giphy.com/media/Is1O1TWV0LEJi/giphy.gif)

#### Seeding the Database

At this point, we could continue adding items to our database through the console, but let's be real. There are hundreds of thousands of restaurants, if not more. Entering them individually would take forever!! There must be a better way...

Enter the seeds file. What is a seed file? It's a file (`seeds.rb`), located in the `db` folder, where you create new instances of your classes and save them to your database. There are several ways this could happen. You could iterate over a csv file, for example, pulling out relevant data, and creating a new row in your database for every row in the file.

For now, let's just use the [`faker` gem](https://github.com/stympy/faker). Faker is a great library for generating fake data. For example:

```ruby
Faker::Name.name # returns a random name
Faker::Address.city # returns a random city
Faker::IDNumber.valid # returns a random valid Social Security Number
```

If you look in your `Gemfile`, you'll notice that it has already been included as a dependency for you and was installed when you ran `bundle install`. We can use `faker` to manually create seed data that is both random and makes sense for our domain models. For example:

```ruby
User.create(name: Faker::Name.name)
Restaurant.create(name: Faker::Company.name)
Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart)
```

This is great for randomly data and randomly associating it once, but that's still very limiting and manual. Now think about how you might automate creating _lots_ of objects using `faker` in your seed file _and_ set up the relationships between them. 🤔

**Your goal** is to make sure you have enough data to play around with once you get your command line interface up and running. Five to ten instances of each model, as well as the corresponding relationships should be enough. You can always add more later.

Once your file is ready, run `rake -T` to see which rake task you can use to seed your database.

---

### Phase 3: Execution

This should take approximately **one day**.

#### Welcome to the CLI

Okay, so we've got our databases; we've got our models; and we've got our relationships set up between them. Now, what do we do with all this stuff? We don't want our users to have to use the console every time they want to see restaurants, reviews, etc., so let's create a command line interface!

First things first, open up the run file and create a method that greets our app user. Then, let's call that method.

```ruby
def greet
  puts 'Welcome to Felp, the best resource for restaurant information in the world!'
end

greet
```

Now, let's run the file from the terminal with `ruby bin/run.rb`.

We should see our welcome message printed. Rad!! But wait--why are we defining this method in the run file? Isn't that going to get messy? Answer: yes.

Instead, let's put those OOP practices to use and create a command line interface (CLI) model in our `lib` directory. This model won't have a corresponding table; it's just going to be a place for us to write methods relating to the interface of our app. Now, let's move the `greet` method definition into the CLI model.

Now, our `bin/run.rb` should create a new instance of our CLI model and call the instance method, `greet`.

```ruby
cli = CommandLineInterface.new
cli.greet
```

Run `ruby bin/run.rb` to make sure everything works! Now that is some good abstraction and encapsulation!

#### Request - Input

Alright, we've greeted our user, but so far we haven't given them any of the information that we worked so hard to store in our database. Let's give them some of our valuable data! First things first: how should we decide what to show our users? It would probably be overwhelming if we printed out every review for every restaurant. Perhaps we should look to a user story that we've decided on beforehand that can help deliver a better user experience... 🤔

> As a user, I want to enter a restaurant and be given user reviews of that restaurant. (**Read**)

Perfect! Let's ask the user which restaurant they'd like to see reviews for instead of showing them everything.

```ruby
puts "Thinking of eating somewhere but not sure if it's good? We can help you with that decision!"
puts "Enter a restaurant name to get started:"
# What could we put here to allow a user to type a response?
```

Now let's test it by putting a `pry` there, running your app, and seeing if you can get that user input. Got it working? Awesome! Since we want to use that input, let's save it in a variable; maybe something like `restaurant_name`. Now we're ready to move on! 🎉

#### Response - Output

So, we've gotten an input (_request_) from our user, but what do we do with it? Give a _response_ of course!

First let's think big picture: our goal is to take the user's input--a string of a restaurant name--and use that restaurant name to find reviews in our database. Then we want to print out the content of those reviews. However, to give a really good user experience like on most review websites, we will also want to print out the names of the users who wrote those reviews. 🤔

Now let's think about how we'll code out this process: first, we want a method that uses the restaurant name to query our database, right? Know of any ActiveRecord methods we could use to find a restaurant by its name?

🤔

Think on it....

🤔

Keep thinking....

🤔

Alright, have you got an idea?

Is it this ActiveRecord method?

```ruby
Restaurant.find_by(name: restaurant_name)
```

_Nice!_

Okay, so now we can get user input and find our restaurant, but our code in our run file is starting to look at bit messy again...

```ruby
cli = CommandLineInterface.new
cli.greet
puts "Thinking of eating somewhere but not sure if it's good? We can help you with that decision!"
puts "Enter a restaurant name to get started:"
# What could we put here to allow a user to type a response?
Restaurant.find_by(name: restaurant_name)
```

_LET'S REFACTOR!_

Since all of this code is what _runs_ our application, one good spot for abstraction is to write a method to run our program. Let's move our code from the run file to a runner method in our CLI model.

```ruby
def run
  greet
  puts "Thinking of eating somewhere but not sure if it's good? We can help you with that decision!"
  puts "Enter a restaurant name to get started:"
  # What could we put here to allow a user to type a response?
  Restaurant.find_by(name: restaurant_name)
end
```

And let's change our run file to just call the run method. Nice use of OOP!

_**What other opportunities for abstraction can you find in this `run` method?**_ Take some time to think about it before moving forward as it will lead to cleaner code later on.

![thumbs_up](https://media.giphy.com/media/111ebonMs90YLu/giphy.gif)

So, we can greet our user, grab their input, and use that input to find a restaurant. We're on the home stretch, but there are a few things left to do before we can give them a proper _response_. First, we need to find the reviews associated with the restaurant, and then we need to output the content and usernames to the user. Phew! That still looks like a lot! But fear not! By tackling these in small steps one-by-one, we'll find that we can do this!

1. Get reviews.
2. Print out the content and usernames.

First, let's get those restaurant reviews. How can we access that data? Maybe we can loop through all the reviews and find the ones that `belongs_to` this restaurant?

```ruby
Review.all.select do |review|
  review.restaurant_id == restaurant.id
end
```

But wait, didn't we define our relationships already when we setup our models? Why did we even do that? 🤔

OH SNAP! It's because ActiveRecord writes that method for us already so long as we setup our schema and relationships correctly! We can just do this instead:

```ruby
restaurant.reviews
```

✨ ActiveRecord Magic! 💫

Now that we have the reviews, let's tackle the second step of printing out the content and usernames for the reviews. Before diving right into the code, let's think ahead a bit and put into practice those OOP principles and recall _Single Responsibility Principle_.

We can avoid our refactor step by realizing that we can create a reusable method that prints out reviews. This method will iterate over a given array of reviews and outputs the content and username to the console. OOP!

```ruby
def show_reviews(reviews)
  reviews.each do |review|
    # How could we output this review's content and the username associated with it?
  end
end
```

Now, add this method to the run method, and pass it the reviews we got through ActiveRecord. Finally, run `ruby bin/run.rb`. Woot, woot! We've got a working "skateboard" version of our app!!

![party](https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif)

#### CRUD IT UP!

Now that you've seen the basic flow of a command line application all the way from _request_ to _response_, **your next goal** is to finish building out your other user stories to hit your **MVP**.

_**Advice:** Tackle one user story at a time!_

Take your time to plan out your code, test each method, and make many commits. And don't forget to branch!!

---

### Phase 4: Project Review

When you are ready, schedule a project review with one of your instructors. The format of the review will roughly look like this:

* 3 minutes - Requirements Review
* 5 minutes - App Overview
* 6 minutes - Deep Dive
* 12 minutes - Pair Programming
* 4 minutes - Feedback

Once you pass the review, you will have free reign to take your command line application to new heights!

---

**All the phases after this are OPTIONAL!**

---

### Phase 5: Freedom

How can we improve on our command line app to have a motorcycle version and eventually a cadillac convertible version ? Lots of ways!

#### The Real World

One potential improvement would be to pull in data from the real world. So let's go back to our seed file and start seeding with real data!

You can either get data from a CSV file, an API, or a website by scraping. Use the power of the internet to search for where you can get this data. Some helpful starter resources:

* [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)
* [Public APIs](https://github.com/toddmotto/public-apis)

Now that you've found your data, how could you seed a database with rows from a CSV file or with JSON data from an API?

#### Stretch Goals

A basic CRUD app is good, but we can do better. Let's tackle other user stories. Don't have any others? Here are some suggestions:

* Format your output (_responses_) to look better.
* Add MORE CRUD functionality to more models.
* Allow the user to do multiple searches without having to run the app each time. What if they want to search fifty different restaurants and then exit the app midway through a search?
* Allow a user to open a webpage for a restaurant they want to visit.
* More interesting types of queries! Maybe some that aggregate and analyze data so users can dig deeper.
* Use a `gem` to jazz up the look of our app with [ASCII text](https://github.com/miketierney/artii) or [colors](https://rubygems.org/gems/colorize/versions/0.8.1).
