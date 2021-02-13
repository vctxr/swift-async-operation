# Chained Async Operation ⛓

<p float="left">
  <img src="/Assets/preview-1.png" width="300" height="auto" hspace="50"/>
  <img src="/Assets/preview-2.png" width="300" height="auto" hspace="50"/>
</p>

Swift implementation of the `Operation` class with added asynchronous behavior and chainable input/output using Swift's `Result` type. 
This app demonstrates how we can easily chain the result of asynchronous operation by fetching random GIFs. I built this app inspired by Antoine van der Lee's video about operations in Swift ([link to his YouTube video](https://www.youtube.com/watch?v=T0wMEVBIZMg&t=1870s))

> **Note:** The implementation of these operations are based on my personal take and modifications on the topic 🌈. Oh and this app also fetches GIF from the Giphy API which requires an API key 🔑 which I kept secret, so please use your own API key instead WKWK.

# ⚡️ Demo

<p float="left">
  <img src="/Assets/demo.gif" width="300" height="auto" hspace="50"/>
</p>

# 🤝 Chained Operations
1. Fetch random word from [here](https://github.com/mcnaveen/Random-Words-API)
1. Search for matching GIF from [Giphy API](https://developers.giphy.com/docs/api#quick-start-guide) for the random word
1. Download the GIF from the URL

# 🚀 Highlights

- Chained asynchronous result based operations
- Cancellable operations
- No third-party dependencies/libraries
- MVVM
