From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 0/2] i2c: sunxi: Change compatibles pattern
Date: Thu, 13 Mar 2014 12:37:21 +0100
Message-ID: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This is the third version of the i2c compatible changes.

Changes from v2:
  - rebased on top of current i2c/for-next

Maxime Ripard (2):
  i2c: sunxi: Change i2c compatibles
  ARM: sunxi: dt: Convert to the new i2c compatibles

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |  2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  6 +++---
 arch/arm/boot/dts/sun5i-a10s.dtsi                     |  6 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi                      |  6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi                      | 10 +++++-----
 drivers/i2c/busses/i2c-mv64xxx.c                      |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.9.0
