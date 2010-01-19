From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
Date: Tue, 19 Jan 2010 21:24:06 +0100
Message-ID: <1263932653-3634-5-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263932653-3634-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: dzu-ynQEQJNshbs@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

    - Update Kconfig for i2c-mpc driver.
    - Enable I2C interrupts on MPC5121.

Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Signed-off-by: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/Kconfig   |    9 +++++----
 drivers/i2c/busses/i2c-mpc.c |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..f481f30 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -418,13 +418,14 @@ config I2C_IXP2000
 	  instead.
 
 config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx/86xx"
+	tristate "MPC107/824x/85xx/512x/52xx/86xx"
 	depends on PPC32
 	help
 	  If you say yes to this option, support will be included for the
-	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
-	  family processors, though interrupts are known not to work.
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245,
+	  MPC85xx/MPC8641 and MPC512x family processors. The driver may
+	  also work on 52xx family processors, though interrupts are known
+	  not to work.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f627001..84eeb25 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		}
 	}
 
+	if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c")) {
+		struct device_node *np;
+		void __iomem *i2cctl;
+
+		/* Enable I2C interrupts */
+		np = of_find_compatible_node(NULL, NULL,
+					     "fsl,mpc5121-i2c-ctrl");
+		if (np) {
+			i2cctl = of_iomap(np, 0);
+			if (i2cctl) {
+				/*
+				 * Set interrupt enable bits:
+				 *  - I2C-0: bit 24,
+				 *  - I2C-1: bit 26,
+				 *  - I2C-2: bit 28.
+				 */
+				out_be32(i2cctl, 0x15000000);
+				iounmap(i2cctl);
+			}
+			of_node_put(np);
+		}
+	}
+
 	dev_set_drvdata(&op->dev, i2c);
 
 	i2c->adap = mpc_ops;
-- 
1.5.6.3
