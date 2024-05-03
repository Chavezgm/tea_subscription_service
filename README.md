# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Tea Subscription Service API

## Overview
This Rails API provides endpoints to manage a Tea Subscription Service. It allows users to subscribe to tea plans, cancel subscriptions, and view their subscription history.

## Requirements
To run this API, ensure you have Ruby on Rails installed.

## Installation
1. Clone this repository.
2. Run `bundle install` to install dependencies.
3. Run `rails db:create` to create the database.
4. Run `rails db:migrate` to run migrations.
5. (Optional) Seed the database with `rails db:seed` for sample data.

## Endpoints

### Subscribe a Customer to a Tea Subscription
- **Endpoint:** `/api/v1/customers/:customer_id/subscriptions`
- **Method:** POST
- **Parameters:** 
  - `customer_id`: The ID of the customer subscribing.
  - Request body should include subscription details.

### Cancel a Customer’s Tea Subscription
- **Endpoint:** `/api/v1/customers/:customer_id/subscriptions/:id`
- **Method:** PATCH
- **Parameters:** 
  - `customer_id`: The ID of the customer canceling the subscription.
  - `id`: The ID of the subscription to cancel.

### View all of a Customer’s Subscriptions
- **Endpoint:** `/api/v1/customers/:customer_id/subscriptions`
- **Method:** GET
- **Parameters:** 
  - `customer_id`: The ID of the customer.

## Data Models
- **Tea:**
  - Title
  - Description
  - Temperature
  - Brew Time
- **Customer:**
  - First Name
  - Last Name
  - Email
  - Address
- **Subscription:**
  - Title
  - Price
  - Status
  - Frequency

## Testing
This project follows Test Driven Development (TDD). Run tests with `bundle exec rspec` command.

