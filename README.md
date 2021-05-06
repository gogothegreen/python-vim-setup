# Setting up Vim for Python editing
I wanted to use Vim for writing Python code. The top hit on Google search is [this page](https://realpython.com/vim-and-python-a-match-made-in-heaven/). This is however a few years old and buggy. It took me some time to fix the issues. So, here is my **.vimrc** file for python and explanations for some difficult parts. I am working on MacOS Catalina.

## YouCompleteMe Setup
This took the most time to get working. I got the following error *YouCompleteMe unavailable: requires Vim compiled with Python (3.6.0+) support*. Basically, Vim has to be compiled with Python3 support, which is the default when done using homebrew. However, if you have Anaconda Python, then YCM does not work. The trick is to first remove it from your $PATH and compile YCM using non-Anaconda python3, after which it can be put back into your $PATH. So the steps were

1. Following the solution [here](https://www.reddit.com/r/vim/comments/5m7snu/i_installed_anaconda_and_it_broke_my_vim_i_think/dc351ur/) and add the given code to the .zshrc (or .bashrc) file.

```
anaconda_bin_dir="$HOME/opt/anaconda3/bin"
add_anaconda() {
    if [[ "$PATH" != *"${anaconda_bin_dir}"* ]]; then
        export PATH="${anaconda_bin_dir}:$PATH"
    fi
}
 
rm_anaconda() {
    export PATH=$(echo $PATH | sed 's|'"${anaconda_bin_dir}:"'||g')
}
```

3. In the terminal run, `rm_anaconda`, then `cd` into the YCM directory and do the following.

```
cd .vim/bundle/YouCompleteMe
/usr/bin/python3 install.py
add_anaconda
```

4. Fire up Vim and `:InstallPlugin`

## Virtual environment support
A [plugin](https://dev.to/sansyrox/vim-python-virtualenv-a-plugin-to-manage-virtual-environments-in-python-54c) exists for this. However you can just add the following Python code to your .vimrc file.

```
python3 << EOF
 import os
 import subprocess

if "VIRTUAL_ENV" in os.environ:
    project_base_dir = os.environ["VIRTUAL_ENV"]
    script = os.path.join(project_base_dir, "bin/activate")
    pipe = subprocess.Popen(". %s; env" % script, stdout=subprocess.PIPE, shell=True)
    output = pipe.communicate()[0].decode('utf8').splitlines()
    env = dict((line.split("=", 1) for line in output))
    os.environ.update(env)
 EOF
 ```

## Powerline setup
Following instructions [here](https://medium.com/@ITZDERR/how-to-install-powerline-to-pimp-your-bash-prompt-for-mac-9b82b03b1c02), install powerline globally using pip `pip install powerline-status`. Then add the following code to the .vimrc file

```
set rtp+=$HOME/opt/anaconda3/lib/python3.8/site-packages/powerline/bindings/vim
set laststatus=2  
set t_Co=256
```

