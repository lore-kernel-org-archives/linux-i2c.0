From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 00/14] MIPS: Fixes and improvements for CI20 board (JZ4780)
Date: Tue, 11 Feb 2020 22:41:17 +0100
Message-ID: <cover.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>, Paul Boddie <paul-RlAhfoEKpGHe9xe1eoZjHA@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz-knWk7/PSn+s@public.gmane.org>, Richard Fontana <rfontana-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch set provides several improvements for the CI20 board:

* suppress warnings from i2c if device is not responding
* make ingenic-drm found through DT
* allow davicom dm9000 ethernet controller to use MAC address provided by U-Boot
* fix #include in jz4780.dtsi
* configure for loadable kernel modules
* add DTS for IR sensor and SW1 button
* configure so that LEDs, IR sensor, SW1 button have drivers
* fix DTS for ACT8600 PMU and configure driver
* fix interrupt of nxp,pcf8563

There is another patch set in our queue to add HDMI support on top of this work.

Signed-off-by: Paul Boddie <paul-RlAhfoEKpGHe9xe1eoZjHA@public.gmane.org>
Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>


Alex Smith (1):
  MIPS: DTS: CI20: add DT node for IR sensor

H. Nikolaus Schaller (13):
  i2c: jz4780: suppress txabrt reports for i2cdetect
  drm: ingenic-drm: add MODULE_DEVICE_TABLE
  net: davicom: dm9000: allow to pass MAC address through mac_addr
    module parameter
  MIPS: DTS: jz4780: fix #includes for irq.h and gpio.h
  MIPS: CI20: defconfig: configure for supporting modules
  MIPS: CI20: defconfig: compile leds-gpio driver into the kernel and
    configure for LED triggers
  MIPS: DTS: CI20: fix PMU definitions for ACT8600
  MIPS: CI20: defconfig: configure CONFIG_REGULATOR_ACT8865 for PMU
  MIPS: DTS: CI20: give eth0_power a defined voltage.
  MIPS: CI20: defconfig: compile gpio-ir driver
  MIPS: DTS: CI20: add DT node for SW1 as Enter button
  MIPS: CI20: defconfig: configure for CONFIG_KEYBOARD_GPIO=m
  MIPS: DTS: CI20: fix interrupt for pcf8563 RTC

 arch/mips/boot/dts/ingenic/ci20.dts    | 71 ++++++++++++++++++++------
 arch/mips/boot/dts/ingenic/jz4780.dtsi |  2 +
 arch/mips/configs/ci20_defconfig       | 21 ++++++++
 drivers/gpu/drm/ingenic/ingenic-drm.c  |  2 +
 drivers/i2c/busses/i2c-jz4780.c        |  3 ++
 drivers/net/ethernet/davicom/dm9000.c  | 42 +++++++++++++++
 6 files changed, 125 insertions(+), 16 deletions(-)

-- 
2.23.0
