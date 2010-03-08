From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] i2c: Fix section mismatch errors in i2c-octeon.c
Date: Mon,  8 Mar 2010 11:04:21 -0800
Message-ID: <1268075061-31748-1-git-send-email-ddaney@caviumnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
---
 drivers/i2c/busses/i2c-octeon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 6037550..be88d5b 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -446,7 +446,7 @@ static struct i2c_adapter octeon_i2c_ops = {
 /**
  * octeon_i2c_setclock - Calculate and set clock divisors.
  */
-static int __init octeon_i2c_setclock(struct octeon_i2c *i2c)
+static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
 {
 	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
 	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
@@ -489,7 +489,7 @@ static int __init octeon_i2c_setclock(struct octeon_i2c *i2c)
 	return 0;
 }
 
-static int __init octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 {
 	u8 status;
 	int tries;
-- 
1.6.6.1
