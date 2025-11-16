# Dockerfile for Rails 6.0.6 / Ruby 3.1.4

FROM ruby:3.1.4-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler -v 2.3.26 --no-document

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install -j4

# Copy the application
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

# Create directory for uploads (even though using Cloudinary)
RUN mkdir -p /app/public/uploads

# Expose port
EXPOSE 8080

# Start the server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
