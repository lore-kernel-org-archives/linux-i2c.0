From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable on Keystone SOCs
Date: Wed, 24 Jul 2013 20:28:17 -0400
Message-ID: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Keystone SOCs uses the same I2C IP as available on DaVinci SOCs. These
couple of patches makes it possible to select the I2C_DAVINCI on
Keystone SOCs.

Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Santosh Shilimkar (2):
  i2c: davinci: remove useless mach/hardware include
  i2c: davinci: Allow i2c driver available for keystone platforms

 drivers/i2c/busses/Kconfig       |    2 +-
 drivers/i2c/busses/i2c-davinci.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
1.7.9.5
