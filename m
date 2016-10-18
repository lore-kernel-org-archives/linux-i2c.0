From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/4] i2c: xlr: Fix module autoload for OF registration
Date: Tue, 18 Oct 2016 18:01:47 -0300
Message-ID: <1476824508-4679-4-git-send-email-javier@osg.samsung.com>
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

$ modinfo drivers/i2c/busses/i2c-xlr.ko | grep alias
alias:          platform:xlr-i2cbus

After this patch:

$ modinfo drivers/i2c/busses/i2c-xlr.ko | grep alias
alias:          platform:xlr-i2cbus
alias:          of:N*T*Csigma,smp8642-i2cC*
alias:          of:N*T*Csigma,smp8642-i2c

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/i2c/busses/i2c-xlr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 0968f59b6df5..ad17d88d8573 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -358,6 +358,7 @@ static const struct of_device_id xlr_i2c_dt_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, xlr_i2c_dt_ids);
 
 static int xlr_i2c_probe(struct platform_device *pdev)
 {
-- 
2.7.4
