From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 01/19] i2c: octeon: Increase retry default and use fixed timeout value
Date: Mon, 11 Apr 2016 17:28:32 +0200
Message-ID: <912e7b105708740802cd6fc944d4d041a4939a35.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

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
