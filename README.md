# Checklist

1. Setup SSH Keys
2. Install Git
3. Bootstrap

   ```
   $ ./bootstrap.sh
   ```

4. Install Tmux Plugins

   ```
   $ tmux
   Ctrl-b I
   ```

5. Set Git Config

   ```
   $ git config --global user.email jteppinette@jteppinette.com
   $ git config --global user.name "Joshua Taylor Eppinette"
   ```

# FAQ

I am getting an error from compinit on each new terminal window. What should I do?

First, determine the list of directories that need to have their security level increased:

```sh
$ compaudit
```

Second, recursively update the permissions of those directories:

```sh
$ sudo chmod -R 755 <eg:/usr/local/share>
```
