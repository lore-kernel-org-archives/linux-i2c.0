From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 1/2] i2c: sh_mobile: List rmobile fallback compatibility last
Date: Wed,  7 Dec 2016 11:39:36 +0100
Message-ID: <1481107176-32409-1-git-send-email-horms+renesas@verge.net.au>
References: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Improve readability by listing the rmobile fallback compatibility string
after the more-specific compatibility strings they provide a fallback for.

This does not effect run-time behaviour as it is the order in the DTB that
determines which compatibility string is used.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 192f36f00e4d..6335ad35902d 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -827,7 +827,6 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 };
 
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
-	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &fast_clock_dt_config },
@@ -837,6 +836,7 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a7794", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7795", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
-- 
2.7.0.rc3.207.g0ac5344
