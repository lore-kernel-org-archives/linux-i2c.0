From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RESEND] i2c: eg20t: include slab.h for memory allocations
Date: Wed, 23 Feb 2011 11:11:35 +0100
Message-ID: <1298455895-5778-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fixes (with v2.6.38-rc3/parisc/parisc-allmodconfig):
  src/drivers/i2c/busses/i2c-eg20t.c:720: error: implicit declaration of function 'kzalloc'
  src/drivers/i2c/busses/i2c-eg20t.c:790: error: implicit declaration of function 'kfree'

Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 2e067dd..50ea1f4 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/ktime.h>
+#include <linux/slab.h>
 
 #define PCH_EVENT_SET	0	/* I2C Interrupt Event Set Status */
 #define PCH_EVENT_NONE	1	/* I2C Interrupt Event Clear Status */
-- 
1.7.2.3
