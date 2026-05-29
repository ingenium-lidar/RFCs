# How to install: Automatic RPi Clock Sync

## Ubuntu Linux installation

  1. First, starting in the right Ubuntu distro (this process will work for both Ubuntu 20.04 and 24.04), you will have to decide where you want this file to be created. I did it in my ~/bin which adds it to my $PATH, which is mostly useful in that you don't need to be in a particular file to run it.
  - If you are using ~/bin to add to PATH, first check if you have it set up with: 
```bash
echo $PATH
```
  - If it doesn't appear, then create it:
```bash
mkdir -p ~/bin #mkdir = make directory, -p = plan for errors
```
  - Then check again with:
```bash
echo $PATH
```
  2. From here, if you chose to add to $PATH, then use the following syntax to create a file in your $PATH, otherwise use the directory you chose in place here:
```bash
touch ~/bin/ussh
```
  3. Next, make the file executable with:
```bash
chmod +x ~/bin/ussh
```
  4. From here, we can create the contents of the file by first opening an editor. I will show a couple of ways to do it within the editor, but also know you can use VS Code (which would use code ~/bin/ussh) or any other editor.
    - So the first way is to use the nano command:
```bash
nano ~/bin/ussh
```
  5. Now you can work in this editor and write in the new ussh script:
```bash
#!/bin/bash #This is a shebang. Present in every bash script.
current_host_datetime=$(date "+%Y-%m-%d %H:%M:%S") #This creates a variable "current_host_datetime" which reads the datetime of the computer and puts it in the format Year-month-day Hour:Minute:Second
ssh ubuntu@10.42.0.1 "sudo date -s \"$current_host_datetime\"" #This command in an ssh into the RPi (at ubuntu@10.42.0.1) using the admin (sudo) command, which updates the RPi's time to the variable we just created in the last line.
ssh ubuntu@10.42.0.1 #This is a second ssh to actually get into the RPi and allow further access to it.
```
  - Save with Ctrl "O" and close the nano terminal with Ctrl "X".
  5. (Alternate) Another method to do this is to use no terminal at all using a heredoc. To do this, simply paste the following into the terminal:
```bash
cat > ~/bin/ussh << 'EOF' #"cat" stands for "concatenate" and doesn't do much, but it allows us to write this heredoc (short for "here document") into a file. "<<EOF" bookends with the final "EOF" to define this heredoc.
#!/bin/bash
current_host_datetime=$(date "+%Y-%m-%d %H:%M:%S")
ssh ubuntu@10.42.0.1 "sudo date -s \"$current_host_datetime\""
ssh ubuntu@10.42.0.1
EOF #Bookends with "<< EOF" to define the heredoc.
```
  6. Congratulations! You have successfully installed an SSH script that syncs your RPi clock on first connection.
# Optional: Use Key and Passphrase to streamline connection.
  1. You now have a working ssh, however you will have to enter the RPi password for each ssh request in the ussh script (there are two). You can do this no problem, but if you want to streamline this to only one, then you will want to create a key and passphrase.
      - To begin, write the following in the terminal:
```bash
ssh-keygen -t ed25519 #"ssh-keygen" generates a new key, "-t" specifies the type of key to be generated which is "ed25519".
```
  - For the key, "ed25519" is most recommended, but here are some other common encription options:
    
<img width="1231" height="286" alt="image" src="https://github.com/user-attachments/assets/3097b199-0f93-410e-b48b-139eb6b1e4f9" />
    
  - You will be automatically prompted a couple of times. First to confirm location, confirm location at "~/.ssh/id_ed25519", which should be listed and you just hit enter. Second, to enter a passphrase (save in a safe place) which can probably be the usual one :).
  2. You can check that it worked by writing this:
```bash
ls -la ~/.ssh/ # ls (list) -la (lists all files (-a) in a long format (-l))
```
  - If you see "id_ed25519" and "id_ed25519.pub" (the first being a private and teh second a public key) then you are all set!
  3. You now have a key and passphrase! Now to connect it to the RPi, you write the following when it boots:
```bash
ssh-copy-id ubuntu@10.42.0.1
```
# To use on Ubuntu Linux
  1. This should fully set up the RPi Clock Sync on a Ubuntu Linux System (20.04 or 24.04) and should run automatically upon first ssh connection. To run, type the command:
```bash
ussh
```
  - When you run the ssh in the terminal. You will be prompted for your password (or passwords if you didn't create a key and passphrase).
  2. If you did everything right, you should have a synced clock on the RPi!
