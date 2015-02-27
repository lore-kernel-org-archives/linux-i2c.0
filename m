From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] Add proper support for Compulab CM-A510/SBC-A510
Date: Fri, 27 Feb 2015 13:24:41 +0100
Message-ID: <1425039885-5137-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424199129-22099-1-git-send-email-sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is v2 of the patch set to improve current mainline support for the
Compulab CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
base board. 

Compared to v1 there have been the following changes:
- removed preparing Dove patches that already have been taken by MVEBU
  maintainers.
- added a Tested-by for i2c-mux-pinctrl changes from Stepen Warren.
- reworded i2c-mux-pinctrl devicetree doc changes
  (Suggested by Stephen Warren).
- Added an Acked-by for the vendor-prefix patch from Rob Herring.
- Added an Acked-by for the addition of i2c mux node to dove.dtsi from
  Gregory Clement.
- Rebased on top of v4.0-rc1 with preparing patches applied.

Patches are based on v4.0-rc1 with preparing patches for Dove applied
and are intended for v4.1.

Sebastian Hesselbarth (4):
  i2c: mux-pinctrl: Rework to honor disabled child nodes
  devicetree: vendor-prefixes: Add CompuLab to known vendors
  ARM: dts: dove: Add internal i2c multiplexer node
  ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510

 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  25 +--
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/dove-cm-a510.dts                 |  38 ----
 arch/arm/boot/dts/dove-cm-a510.dtsi                | 195 +++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts                | 182 +++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                        |  40 ++++-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  70 +++++---
 8 files changed, 477 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts

---
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
2.1.0
