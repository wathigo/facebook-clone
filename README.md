# Facebook-clone

A web application that is designed to implement the following functionalities similar to facebook.

## Function description

1. Sign up
   - after sign up, the status becomes signed in
2. Log In
   - Remembers a user if remember me box is checked
3. Log Out
   - deletes log in status
   - Does not remember a user after the log out.
4. Create Posts
5. Comment to a Post
6. Like a post
7. Like a comment.

## Getting started

Clone the repository and cd into `fb` diretory

```
$ git clone https://github.com/wathigo/facebook-clone/edit/comment-like-models.git
```
Cd into `fb` directory
```
$ cd fb
```
Install the gems using bundler
```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```


Seed some data into the database

```
$ rails db:seed
```

Run test

```
$ rspec --format documentation spec/
```

Start the development server

```
$ rails server
```

## Contributor(s)

Project Creator: [Simon Wathigo](https://github.com/wathigo)

