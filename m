From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/4] i2c: jz4780: Fix module autoload
Date: Tue, 18 Oct 2016 18:01:45 -0300
Message-ID: <1476824508-4679-2-git-send-email-javier@osg.samsung.com>
References: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/i2c/busses/i2c-jz4780.ko | grep alias
$

After this patch:

$ modinfo drivers/i2c/busses/i2c-jz4780.ko | grep alias
alias:          of:N*T*Cingenic,jz4780-i2cC*
alias:          of:N*T*Cingenic,jz4780-i2c

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/i2c/busses/i2c-jz4780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index b8ea62105f42..30132c3957cd 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -729,6 +729,7 @@ static const struct of_device_id jz4780_i2c_of_matches[] = {
 	{ .compatible = "ingenic,jz4780-i2c", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, jz4780_i2c_of_matches);
 
 static int jz4780_i2c_probe(struct platform_device *pdev)
 {
-- 
2.7.4
