From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v4 03/14] i2c-octeon: Change adapter timeout and retry default values
Date: Fri, 18 Mar 2016 09:46:28 +0100
Message-ID: <dd3af500365eeeac662a097441259e90a0d3e303.1458289385.git.jglauber@cavium.com>
References: <cover.1458289385.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36485 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbcCRIqz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2016 04:46:55 -0400
In-Reply-To: <cover.1458289385.git.jglauber@cavium.com>
In-Reply-To: <cover.1458289385.git.jglauber@cavium.com>
References: <cover.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Convert the adapter timeout to 2 ms instead of a fixed number of
jiffies and set retries to 10.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 9240037..e616e4c 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -414,7 +414,6 @@ static struct i2c_adapter octeon_i2c_ops = {
 	.owner = THIS_MODULE,
 	.name = "OCTEON adapter",
 	.algo = &octeon_i2c_algo,
-	.timeout = HZ / 50,
 };
 
 /* calculate and set clock divisors */
@@ -541,6 +540,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	octeon_i2c_set_clock(i2c);
 
 	i2c->adap = octeon_i2c_ops;
+	i2c->adap.timeout = msecs_to_jiffies(2);
+	i2c->adap.retries = 10;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
 	i2c_set_adapdata(&i2c->adap, i2c);
-- 
1.9.1
