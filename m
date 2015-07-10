From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 14:52:31 +0900
Message-ID: <1436507551-1370-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/i2c/i2c-slave-eeprom.c      | 1 -
 drivers/i2c/muxes/i2c-mux-pca9541.c | 1 -
 drivers/i2c/muxes/i2c-mux-pca954x.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 822374654609..aed3298ad6aa 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -163,7 +163,6 @@ MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
 static struct i2c_driver i2c_slave_eeprom_driver = {
 	.driver = {
 		.name = "i2c-slave-eeprom",
-		.owner = THIS_MODULE,
 	},
 	.probe = i2c_slave_eeprom_probe,
 	.remove = i2c_slave_eeprom_remove,
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 0c8d4d2cbdaf..d0ba424adebc 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -386,7 +386,6 @@ static int pca9541_remove(struct i2c_client *client)
 static struct i2c_driver pca9541_driver = {
 	.driver = {
 		   .name = "pca9541",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = pca9541_probe,
 	.remove = pca9541_remove,
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ea4aa9dfcea9..acfcef3d4068 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -300,7 +300,6 @@ static struct i2c_driver pca954x_driver = {
 	.driver		= {
 		.name	= "pca954x",
 		.pm	= &pca954x_pm,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= pca954x_probe,
 	.remove		= pca954x_remove,
-- 
1.9.1
