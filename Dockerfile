# Use the official Ubuntu 21.04 LTS image as the base
FROM ubuntu:21.04

# Create a new user with sudo permissions
RUN useradd -m rails && \
    echo "rails:rails" | chpasswd && \
    adduser rails sudo

# Switch to the new user
USER rails

# Install dependencies
RUN sudo apt-get update && sudo apt-get install -y \
  curl \
  git \
  build-essential \
  postgresql-12 \
  redis-server

# Install RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable

# Add the RVM path to the environment variables
ENV PATH /usr/local/rvm/bin:$PATH

# Load RVM into the shell
RUN ["/bin/bash", "-c", "source /etc/profile.d/rvm.sh"]

# Install Ruby 3.0.2
RUN rvm install ruby-3.0.2

# Set the default Ruby version to 3.0.2
RUN rvm use ruby-3.0.2 --default

# Install Bundle
RUN gem install bundler

# Set the working directory
WORKDIR /home/rails/environment

# Copy the Gemfile and Gemfile.lock
# COPY Gemfile* ./

# Install the gems
# RUN bundle install

# Command to run the app
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
CMD ["/bin/bash"]
