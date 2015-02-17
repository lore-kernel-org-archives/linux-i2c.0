From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/8] Add proper support for Compulab CM-A510/SBC-A510
Date: Tue, 17 Feb 2015 19:52:01 +0100
Message-ID: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch set improves current mainline support for the Compulab
CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
base board. Thanks to Gabriel Dobato who agreed to remote debug and
test the provided DT changes.

On the way to proper support, we
- Rework i2c-mux-pinctrl to honor disabled sub-bus nodes
- Add missing "compulab" vendor prefix
- Fix broken uart[23] reg properties
- Beautify Dove's dtsi files by adding gpio/irq includes, node
  labels for pcie, and some additional pinctrl settings
- Add a node for the internal i2c mux mechanism on Dove SoCs

And finally add a DT include for the Compulab CM-A510 SoM and a DT
board file for the SBC-A510 base board.

Patches are based on stable v3.19 and are indended for the next
merge window (either v3.21 or v4.1). Compulab related changes have
been tested by Gabriel Dobato, I tested on SolidRun CuBox that it
does not break existing Dove boards.

For the i2c-mux-pinctrl, a Tested-by from any user of Tegra20
Seaboard, Tamonten, or Ventana would be nice to see if it is fully
compatible.

I have added MVEBU maintainers to all patches, Wolfram for i2c and
Stephen as the i2c-mux-pinctrl author i2c-mux-pinctrl related patches,
and corresponding lists. As there is no important DT work in here,
I decided to not explicitly add each of the DT maintainers except for
the vendor prefix patch.

Sebastian Hesselbarth (8):
  i2c: mux-pinctrl: Rework to honor disabled child nodes
  devicetree: vendor-prefixes: Add CompuLab to known vendors
  ARM: dts: dove: Fix uart[23] reg property
  ARM: dts: dove: Always include gpio and interrupt-controller headers
  ARM: dts: dove: Add node labels for PCIe ports 0 and 1
  ARM: dts: dove: Add some more common pinctrl settings
  ARM: dts: dove: Add internal i2c multiplexer node
  ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510

 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  28 +--
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/dove-cm-a510.dts                 |  38 ----
 arch/arm/boot/dts/dove-cm-a510.dtsi                | 195 +++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts                | 182 +++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                        | 103 ++++++++++-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  70 +++++---
 8 files changed, 537 insertions(+), 85 deletions(-)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
