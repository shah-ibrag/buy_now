pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@rails/ujs", to: "rails-ujs.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"