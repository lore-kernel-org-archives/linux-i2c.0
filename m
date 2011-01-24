From: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Subject: [PATCH] i2c: octeon: Make the timeout 1*HZ instead of 1 jiffy
Date: Mon, 24 Jan 2011 13:05:41 +0100
Message-ID: <1295870741-19970-1-git-send-email-walle@corscience.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Since the timeout in the struct i2c_adapter use jiffies as unit and a
timeout should be independent of CONFIG_HZ and most drivers that specify
a timeout here use just HZ, change the i2c-octeon driver to use 1*HZ
(which is a second), too.

Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
---
 drivers/i2c/busses/i2c-octeon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 0fe1102..537a4ee 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -460,7 +460,7 @@ static struct i2c_adapter octeon_i2c_ops = {
 	.owner = THIS_MODULE,
 	.name = "OCTEON adapter",
 	.algo = &octeon_i2c_algo,
-	.timeout = 2,
+	.timeout = HZ,
 };
 
 /**
-- 
1.7.1
