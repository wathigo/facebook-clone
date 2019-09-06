# Facebook-clone

A web application that is designed to implement the following functionalities similar to facebook.

## Function description

1. Sign up
   - after sign up, the status becomes signed in
2. Log In
   - log in status remains while
      * user moves page to page
      * without logout, user close browser and open it again
3. Log Out
   - deletes log in status
4. Create Posts
5. Comment to a Post
6. Like a post
7. Like a comment.

## Getting started

Clone the repository and cd into `fb` diretory

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

## Contributors

Project Owner: [Simon Wathigo](https://github.com/wathigo)


## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
