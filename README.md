# Setup

This is the tooling I use to build my ideal development environment. The goal
here is to have all of my favorite tooling, aliases, scripts, and console tweaks
easily applied across new environments. 

We're currently configured to deploy the following: 

- **Homebrew** for package management in Linux
- **Zsh** as the shell with Oh-My-Zsh and Powerlevel10k
- **ASDF** for version management of languages and tools
  - Bun
  - Node
  - Python
  - Golang
  - Terraform
    - Terraspace
    - Terrascan
    - Infracost
    - TF-Summarize
  - Rust
  - Serverless Framework
  - AWS CLI
  - Docker
- Custom Laravel Setup Container (PHP, Composer, Artisan) 

## Prerequisites

- **~/.ssh** in place with valid keys and a config with AT LEAST:
  - gh: a pointer to GitHub using your SSH key.

- **~/.aws/config** in place with a set of profiles to access various roles
  - We make use of AWS-SSO and avoid IAM users wherever possible. 
  - We want short-lived access tokens. 
  - We don't want to copy/paste tokens from AWS Console or SSO user page. 

- **Docker** must be available to the command-line.
  - In WSL, I use Docker Desktop and its WSL2 integration.
  - In other environments, just ensure that docker is available.

- **NerdFonts** should be installed on the host system. If using WSL2, this
  means installing the fonts in Windows and setting the console appearance
  to use the MesloLGS NF font. If using another system, install the fonts
  in the usual manner for that OS. 
  
  See the https://github.com/romkatv/powerlevel10k repo for instructions.

      MesloLGS NF Regular.ttf
      MesloLGS NF Bold.ttf
      MesloLGS NF Italic.ttf
      MesloLGS NF Bold Italic.ttf

## Stages

The configuration process must be completed in multiple steps, since some
steps will require a reset of the environment before they can be completed.

### Start

`just start` or `make start` - copies the variables.example.yml file to variables.yml.
You will then need to fill out desired values accordingly.

### Build

`just build` or `make build` - runs the build script to install all configured
tooling. It's going to power through everything, so it will take a bit.

### Finish

Once the build is completed, restart your shell and finish the setup by following the
powerlevel10k configuration prompts. You'll be asked a series of questions about
your preferences for the shell prompt and its behavior. Once you're done with that,
you should be all set up and ready to go.
