# NOTE

This is a fork of bakito/adguardhome-armv5. I created this fork to automate updates and maintain specific support for MikroTik armv5 devices. All credit for the original build logic goes to the original author.

# About

This project was created to provide a fully working **AdGuardHome container for legacy routers**, specifically **MikroTik hEX (ARMv5 / EN7562CT CPU)**.

According to MikroTik documentation, this device is limited to running **ARMv5 containers only**. Because of this, the official AdGuardHome images cannot run on hEX refresh.

This repository builds a **minimal, optimized ARMv5 AdGuardHome image** using a multi-stage Dockerfile. The AdGuardHome binary is pulled from the official GitHub releases, extracted in the builder stage, and packaged into a lightweight runtime image suitable for MikroTik devices.

---

# Registry Information

This image is published on **GitHub Container Registry (GHCR)**.

Set your MikroTik container registry to:

```
https://ghcr.io
```

Then pull the image from:

```
wout-io/adguardhome-armv5:latest
```

---

# Source Code Used

**AdGuardHome (latest stable ARMv5 release)**
  [https://github.com/AdguardTeam/AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)

  License:
  [https://github.com/AdguardTeam/AdGuardHome/blob/master/LICENSE.txt](https://github.com/AdguardTeam/AdGuardHome/blob/master/LICENSE.txt)

---

# Default Web Setup

After running the container, the AdGuardHome setup UI will be available at:

```
http://<container-ip>:3000
```

Follow the setup wizard to configure your instance.

---

# Exposed Ports

| Port  | Protocol | Description       |
| ----- | -------- | ----------------- |
| 53    | TCP/UDP  | DNS               |
| 67/68 | UDP      | DHCP              |
| 80    | TCP      | HTTP              |
| 443   | TCP      | HTTPS             |
| 853   | TCP/UDP  | DNS-over-TLS      |
| 784   | UDP      | DNS-over-QUIC     |
| 8853  | UDP      | DNS-over-QUIC Alt |
| 5443  | TCP/UDP  | DNSCrypt          |
| 3000  | TCP      | Setup UI          |

---

# Enjoy

If you find this useful or run AdGuardHome on low-end ARMv5 devices, enjoy this lightweight build!
