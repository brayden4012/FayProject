# FayProject
A short take-home project to replicate the overview screen of the Fay nutrition app

## Overview
I previously wrote up a simple networking library (called [CoreNetworking](https://github.com/brayden4012/CoreNetworking)), and thought this would be a great opportunity to refine and extend the functionality of that library to streamline the setup of future projects. The `CoreNetworking` package enforces the stance that all network models must be decoupled from the domain layer of the app, and not following this standard will trigger errors.

In addition to enhancing the `CoreNetworking` library, I placed a huge focus on extensibility with this project by implementing the following:
- A cohesive design system that utilizes intuitive color and image asset names. Doing this raises less questions about what colors should be used for common elements like primary text, secondary text, and backgrounds. Dark mode support was also baked into the design system
- Rudimentary routing pattern with support for global navigation to any view in the app, as well as support for tab bar navigation. This service can be extended to support future needs such as deeplinking
- `CoreNetworkingService`: The single source of truth for making network requests. This service hooks into my `CoreNetworking` library to perform network requests.

## Time Breakdown
- Login screen: 1 hour
- Appointments screen: 3 hours
- Nice-to-haves: 1.5 hours (Custom Loading animation, design system, tab switching) 
- Any additional time spent: 2 hours - `CoreNetworking` enhancements
