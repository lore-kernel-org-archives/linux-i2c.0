From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCHv2 0/6] Add I2C support for Allwinner SoCs
Date: Sun, 26 May 2013 12:20:36 +0200
Message-ID: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This patchset adds support for the I2C controller found on most of the
Allwinner SoCs, especially the already supported A10 and A13, and the
yet to come A31.

It has been tested on a A13-Olinuxino.

Thanks,
Maxime

Changes from v1:
  * Added comments to the switch statements to clarify when the fall th=
rough to
    the next case is made on purpose
  * Use devm_ioremap_resource instead of of_iomap
  * Moved the reset after enabling the clocks
  * Added Emilio Lopez' patch to add the available i2c controllers to t=
he
    cubieboard

Emilio L=C3=B3pez (1):
  ARM: sun4i: cubieboard: Enable the i2c controllers

Maxime Ripard (5):
  i2c: sunxi: Add Allwinner A1X i2c driver
  ARM: sunxi: dt: Add i2c controller nodes to the DTSI
  ARM: sun4i: dt: Add i2c muxing options
  ARM: sun5i: dt: Add i2c muxing options
  ARM: sun5i: olinuxino: Enable the i2c controllers

 .../devicetree/bindings/i2c/i2c-sunxi.txt          |  19 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  12 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  48 +++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  18 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  48 +++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sunxi.c                     | 455 +++++++++++++=
++++++++
 8 files changed, 611 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi.txt
 create mode 100644 drivers/i2c/busses/i2c-sunxi.c

--=20
1.8.2.3
