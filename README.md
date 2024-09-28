<p align="center">
  <a href="https://github.com/swiftly-solution/connection-filters">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[Swiftly] Connection Filters</h3>

  <p align="center">
    A simple plugin for Swiftly that filters the connection based on some settings.
    <br/>
  </p>
</p>


<p align="center">
  <img src="https://img.shields.io/github/downloads/swiftly-solution/connection-filters/total" alt="Downloads"> 
  <img src="https://img.shields.io/github/contributors/swiftly-solution/connection-filters?color=dark-green" alt="Contributors">
  <img src="https://img.shields.io/github/issues/swiftly-solution/connection-filters" alt="Issues">
  <img src="https://img.shields.io/github/license/swiftly-solution/connection-filters" alt="License">
</p>

---

### Installation 👀

1. Download the newest [release](https://github.com/swiftly-solution/antiflash/releases).
2. Everything is drag & drop, so I think you can do it!

### Configuring the plugin 🧐

* After installing the plugin, you can change the configuration from `addons/swiftly/configs/plugins`.

### Explaining each key from config

* Each key offers two modes: `blacklist` and `whitelist`, with only one option available at a time.
* The **VPN Filter** blocks any user whose IP is detected as using a VPN or identified by an ASN (fetched from a public GitHub repository).
* The **Ping Threshold** acts as a "ping limiter," ensuring smoother gameplay by setting a cap on ping values.
* The **GameEvents filter** monitors in-game events on the client side. If a player listens to events that should be inaccessible without cheats, they will receive a warning or ban. This feature has been rigorously tested against GameSense and a few other cheats, instantly flagging cheaters.


### Have ideas/Found bugs? 💡
Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎plugins-sharing` of this plugin!

---
