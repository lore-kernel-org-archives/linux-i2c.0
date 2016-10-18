From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/4] i2c: xlp9xx: Fix module autoload
Date: Tue, 18 Oct 2016 18:01:46 -0300
Message-ID: <1476824508-4679-3-git-send-email-javier@osg.samsung.com>
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

$ modinfo drivers/i2c/busses/i2c-xlp9xx.ko | grep alias
$

After this patch:

$ modinfo drivers/i2c/busses/i2c-xlp9xx.ko | grep alias
alias:          of:N*T*Cnetlogic,xlp980-i2cC*
alias:          of:N*T*Cnetlogic,xlp980-i2c

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/i2c/busses/i2c-xlp9xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 2a972ed7aa0d..e29ff37a43bd 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -426,6 +426,7 @@ static const struct of_device_id xlp9xx_i2c_of_match[] = {
 	{ .compatible = "netlogic,xlp980-i2c", },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, xlp9xx_i2c_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xlp9xx_i2c_acpi_ids[] = {
-- 
2.7.4
