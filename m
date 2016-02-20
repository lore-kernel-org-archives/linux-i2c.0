From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5/6] i2c: i2c-smbus: sort includes
Date: Sat, 20 Feb 2016 23:38:50 +0100
Message-ID: <1456007931-4595-6-git-send-email-wsa@the-dreams.de>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55910 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992832AbcBTWjF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:05 -0500
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I request this for drivers, so the core should adhere to sorted includes as
well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-smbus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 94765a81970d8c..abb55d3e76f33a 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -15,14 +15,14 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 struct i2c_smbus_alert {
 	unsigned int		alert_edge_triggered:1;
-- 
2.7.0
