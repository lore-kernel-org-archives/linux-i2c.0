From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 4/4] i2c: stu300: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 18:36:47 +0200
Message-ID: <20150917163647.GA26265@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/i2c/busses/i2c-stu300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 4885da9..460c134 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -977,6 +977,7 @@ static const struct of_device_id stu300_dt_match[] = {
 	{ .compatible = "st,ddci2c" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, stu300_dt_match);
 
 static struct platform_driver stu300_i2c_driver = {
 	.driver = {
-- 
2.4.6
