From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH 4/4] i2c: stu300: Fix module autoload for OF platform driver
Date: Tue, 20 Oct 2015 15:16:30 +0100
Message-ID: <1445350590-25911-5-git-send-email-luisbg@osg.samsung.com>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, heiko@sntech.de, b.galvani@gmail.com, Luis de Bethencourt <luis@debethencourt.com>, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: linux-i2c@vger.kernel.org

From: Luis de Bethencourt <luis@debethencourt.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
2.5.3
