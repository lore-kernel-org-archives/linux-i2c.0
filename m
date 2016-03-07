From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 05/14] i2c-octeon: Make adapter timeout tunable
Date: Mon,  7 Mar 2016 16:10:48 +0100
Message-ID: <00a182c50af211e409f128630ba6ba5359da6198.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33630 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbcCGPLU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 10:11:20 -0500
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>

From: Peter Swain <pswain@cavium.com>

Make the i2c adapter timeout a module parameter to allow upper-level
target device drivers to retry with their own logic before their own
timeouts abort operations.

For example, at24 eeprom driver retries for 25ms when -EAGAIN
indicates that an eeprom has gone unresponsive while committing
a newly written page (5ms on typical devices).

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 6041cd7..ef1720f 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -72,6 +72,10 @@ struct octeon_i2c {
 	struct device *dev;
 };
 
+static int timeout = 2;
+module_param(timeout, int, 0444);
+MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
+
 /**
  * octeon_i2c_write_sw - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -425,7 +429,6 @@ static struct i2c_adapter octeon_i2c_ops = {
 	.owner = THIS_MODULE,
 	.name = "OCTEON adapter",
 	.algo = &octeon_i2c_algo,
-	.timeout = HZ / 50,
 };
 
 /* calculate and set clock divisors */
@@ -561,6 +564,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	octeon_i2c_setclock(i2c);
 
 	i2c->adap = octeon_i2c_ops;
+	i2c->adap.timeout = msecs_to_jiffies(timeout);
+	i2c->adap.retries = 10;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
 	i2c_set_adapdata(&i2c->adap, i2c);
-- 
1.9.1
