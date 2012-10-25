From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCHv7 0/2] ARM: I2C: Add device tree bindings to i2c-mux-gpio
Date: Thu, 25 Oct 2012 18:23:52 +0200
Message-ID: <1351182234-22971-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This patchset adds the device tree entry to the CFA-10049 board of its i2c
muxer. This muxer controls sub-buses that contains three Nuvoton NAU7802
ADCs and a NXP PCA955 GPIO expander. Support for these will be added
eventually.

Thanks,
Maxime

Changes from v6:
  - Changed the return value when neither platform data nor dt was available
  - Fix a sentence in the documentation

Maxime Ripard (2):
  i2c: mux: Add dt support to i2c-mux-gpio driver
  ARM: dts: cfa10049: Add the i2c muxer buses to the CFA-10049

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 +++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   24 ++++
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  146 +++++++++++++++-----
 3 files changed, 220 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

-- 
1.7.9.5
