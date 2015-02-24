From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 0/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Date: Tue, 24 Feb 2015 18:29:00 +0800
Message-ID: <1424773744-15106-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB75EWGTQKGQEJGR25KI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This series adds support for the Reduced Serial Bus (RSB)
controller found on newer Allwinner SoCs, such as the A23
or A80. The RSB is used to communicate with companion ICs,
notably the bundled PMIC.

RSB is an improvement over P2WI that was found on the A31
SoC. The main new feature is support for multiple slave
devices on the same bus, using addresses that are configured
at runtime. The slave devices also have a hardware address,
which is only used when setting the runtime address.

Like the P2WI, the RSB is an SMBus like interface, supporting
byte, word and double-word transfers only. However, the wire
protocol is different so only RSB compatible devices can be
used. This class currently consists of the AXP223, AXP806,
AXP809 PMICs, and the AC100 audio codec, all from X-Powers.

Following the P2WI driver, we hope this driver can be integrated
into the I2C subsystem as well.


Patch 1 adds the driver supporting RSB.

Patch 2 documents the device tree bindings for the driver.

Patch 3 adds a device node for RSB to the A23 dtsi.

Patch 4 enables the RSB for the only supported A23 device.

Only the A23 is enabled at the moment. The A80 uses the same
IP block with no differences, but the related clock/reset/pinctrl
drivers are still WIP.


Regards,
ChenYu

Chen-Yu Tsai (4):
  i2c: sunxi: Add Reduced Serial Bus (RSB) support
  i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings documentation
  ARM: dts: sun8i: Add Reduced Serial Bus controller device node to A23
    dtsi
  ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial Bus controller

 .../devicetree/bindings/i2c/i2c-sunxi-rsb.txt      |  50 +++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |   4 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  21 +
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sunxi-rsb.c                 | 458 +++++++++++++++++++++
 6 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
 create mode 100644 drivers/i2c/busses/i2c-sunxi-rsb.c

-- 
2.1.4
