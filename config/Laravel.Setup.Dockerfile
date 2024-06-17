# Stage 1: Build
FROM php:8.2-fpm-alpine as build

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    bash \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    oniguruma-dev \
    autoconf \
    g++ \
    make \
    curl \
    git

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install exif \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install intl \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install zip

# Install Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Stage 2: Final image
FROM php:8.2-fpm-alpine

WORKDIR /app

# Copy PHP extensions and Composer from build stage
COPY --from=build /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=build /usr/local/bin/composer /usr/local/bin/composer

# Install runtime dependencies including autoconf for Redis extension
RUN apk add --no-cache \
    libzip \
    libpng \
    libjpeg-turbo \
    freetype \
    nodejs \
    npm \
    icu \
    oniguruma \
    bash \
    autoconf \
    g++ \
    make

# Reinstall Redis extension (requires autoconf)
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install Bun
RUN curl -fsSL https://bun.sh/install -o /tmp/bun_install.sh && bash /tmp/bun_install.sh

# Clean up build dependencies
RUN apk del autoconf g++ make

CMD ["php-fpm"]
