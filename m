From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c-bfin-twi: pull in io.h for ioremap()
Date: Sun, 14 Jun 2009 01:55:37 -0400
Message-ID: <1244958937-11106-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Rather than relying on some of the headers implicitly pulling in io.h,
pull it in explicitly our self for ioremap() and friends.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
Ben: can you push this for 2.6.31 ?  it blocks Blackfin header conversion
to asm-generic as this driver relies on implicit includes.  or i can just
push it through my tree to keep things from breaking (since it's a simple
change).

 drivers/i2c/busses/i2c-bfin-twi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 26d8987..9fb114c 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
-- 
1.6.3.1
