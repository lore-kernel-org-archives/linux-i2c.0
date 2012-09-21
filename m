From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/3] ARM: I2C: Add device tree bindings to i2c-mux-gpio
Date: Fri, 21 Sep 2012 17:32:11 +0200
Message-ID: <1348241535-27754-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This patchset adds the device tree entry to the CFA-10049 board of its i2c
muxer. This muxer controls sub-buses that contains three Nuvoton NAU7802
ADCs and a NXP PCA955 GPIO expander. Support for these will be added
eventually.

Thanks,
Maxime

Maxime Ripard (3):
  i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
  i2c: mux: Add dt support to i2c-mux-gpio driver
  ARM: dts: cfa10049: Add the i2c muxer buses to the CFA-10049

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   86 ++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   33 ++++
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  168 +++++++++++++++-----
 3 files changed, 244 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

-- 
1.7.9.5
