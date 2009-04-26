From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Warn when adapters have no parent
Date: Sun, 26 Apr 2009 10:30:25 +0200
Message-ID: <20090426103025.4525edd3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Warn more loudly when an i2c-adapter is registered without a parent.
There should be almost no driver left in this case, and it's about
time to fix these.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.30-rc3.orig/drivers/i2c/i2c-core.c	2009-04-25 08:46:12.000000000 +0200
+++ linux-2.6.30-rc3/drivers/i2c/i2c-core.c	2009-04-26 10:10:40.000000000 +0200
@@ -457,8 +457,9 @@ static int i2c_register_adapter(struct i
 	 */
 	if (adap->dev.parent == NULL) {
 		adap->dev.parent = &platform_bus;
-		pr_debug("I2C adapter driver [%s] forgot to specify "
-			 "physical device\n", adap->name);
+		pr_warning("I2C adapter driver [%s] forgot to specify "
+			   "physical device\n", adap->name);
+		pr_warning("Fix it now, it will soon break!\n");
 	}
 
 	/* Set default timeout to 1 second if not already set */


-- 
Jean Delvare
