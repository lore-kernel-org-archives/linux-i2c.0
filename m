From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v5 01/14] i2c: octeon: Increase retry default and use fixed timeout value
Date: Thu, 31 Mar 2016 12:28:14 +0200
Message-ID: <7e4c8b3007137d9cf9d5b8ab5d4c4c326dc2f1e0.1459352583.git.jglauber@cavium.com>
References: <cover.1459327368.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36633 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbcCaK2m (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Mar 2016 06:28:42 -0400
In-Reply-To: <cover.1459327368.git.jglauber@cavium.com>
In-Reply-To: <cover.1459352583.git.jglauber@cavium.com>
References: <cover.1459352583.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Convert the adapter timeout to 2 ms independently of depending on CONFIG_HZ.
CONFIG_HZ is 100 for MIPS Cavium-Octeon so the timeout value is not changed.

Also set retries to 5 to improve robustness.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 46fb6c4..c4abf16 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -426,7 +426,6 @@ static struct i2c_adapter octeon_i2c_ops = {
 	.owner = THIS_MODULE,
 	.name = "OCTEON adapter",
 	.algo = &octeon_i2c_algo,
-	.timeout = HZ / 50,
 };
 
 /* calculate and set clock divisors */
@@ -553,6 +552,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	octeon_i2c_set_clock(i2c);
 
 	i2c->adap = octeon_i2c_ops;
+	i2c->adap.timeout = msecs_to_jiffies(2);
+	i2c->adap.retries = 5;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
 	i2c_set_adapdata(&i2c->adap, i2c);
-- 
1.9.1
