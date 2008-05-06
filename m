From: Jochen Friedrich <jochen@scram.de>
Subject: [PATCHv2 2.6.26-rc1] [POWERPC] Fix of_i2c include for module compilation
Date: Tue, 06 May 2008 20:40:01 +0200
Message-ID: <4820A601.2020801@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764843AbYEFSlG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>, "Kernel, Linux" <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>, Jon Smirl <jonsmirl@gmail.com>, Laurent Pinchart <laurentp@cse-semaphore.com>, David Miller <davem@davemloft.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-i2c@vger.kernel.org

Remove #ifdef CONFIG_OF_I2C as this breaks module compilation.
Drivers using this header should depend on OF_I2C anyways, so
there's no need to make this conditional

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 include/linux/of_i2c.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 2e5a967..bd2a870 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -14,11 +14,7 @@
 
 #include <linux/i2c.h>
 
-#ifdef CONFIG_OF_I2C
-
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
 
-#endif /* CONFIG_OF_I2C */
-
 #endif /* __LINUX_OF_I2C_H */
-- 
1.5.5.1
