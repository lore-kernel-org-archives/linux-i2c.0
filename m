From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] Add device tree probe for i2c-imx driver
Date: Fri, 15 Jul 2011 00:03:43 +0800
Message-ID: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The first patch removes unused init/exit hooks from platform data,
and the second one actually adds the actual device tree probe support.

Shawn Guo (2):
      i2c/imx: remove init/exit hooks from platform data
      i2c/imx: add device tree probe support

 .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 +++++++++++
 arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
 drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
 3 files changed, 47 insertions(+), 28 deletions(-)
