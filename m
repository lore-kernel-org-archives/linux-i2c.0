From: Jochen Friedrich <jochen@scram.de>
Subject: [PATCH] [POWERPC] Fix of_i2c include for module compilation
Date: Sat, 03 May 2008 14:42:56 +0200
Message-ID: <481C5DD0.5090503@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Now that of_i2c may be compiled as module, the header must be
exported for module compilation, as well.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 include/linux/of_i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 2e5a967..dca6013 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -14,7 +14,7 @@
 
 #include <linux/i2c.h>
 
-#ifdef CONFIG_OF_I2C
+#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
 
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
-- 
1.5.5.1
