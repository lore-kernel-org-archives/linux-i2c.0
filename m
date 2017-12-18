From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/7] i2c: sh_mobile: move type detection upwards
Date: Mon, 18 Dec 2017 22:57:56 +0100
Message-ID: <20171218215802.28591-2-wsa+renesas@sang-engineering.com>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

For refactoring reasons, we will need this information before the setup
callback. Also, simplify the comment to a oneliner.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index b01607b4fce2b8..1ac896e46b390c 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -873,6 +873,10 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
 	pd->clks_per_count = 1;
 
+	/* Newer variants come with two new bits in ICIC */
+	if (resource_size(res) > 0x17)
+		pd->flags |= IIC_FLAG_HAS_ICIC67;
+
 	config = of_device_get_match_data(&dev->dev);
 	if (config) {
 		pd->clks_per_count = config->clks_per_count;
@@ -881,12 +885,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 			config->setup(pd);
 	}
 
-	/* The IIC blocks on SH-Mobile ARM processors
-	 * come with two new bits in ICIC.
-	 */
-	if (resource_size(res) > 0x17)
-		pd->flags |= IIC_FLAG_HAS_ICIC67;
-
 	ret = sh_mobile_i2c_init(pd);
 	if (ret)
 		return ret;
-- 
2.11.0
