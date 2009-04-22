From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [Patch v2] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 09:19:38 +0200
Message-ID: <49EEC50A.4050707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For MPC adapter there is no class assigned as it is done in other
adapters. This way no new-style client will ever be instantiated, if not
noted in device tree or forced. With this patch class assignment is read
from device tree.
If class assignment is not set in device tree .class stays default (0)

Necessary device tree entry:
linux,i2c-class = <1>; /* I2C_CLASS_HWMON (iic.h) */

Based on kernel 2.6.29

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sang, Wolfram <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -318,7 +318,8 @@ static int __devinit fsl_i2c_probe(struct of_device
*op, const struct of_device_
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-
+	int *of_val;
+	
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -354,6 +355,10 @@ static int __devinit fsl_i2c_probe(struct of_device
*op, const struct of_device_
 	dev_set_drvdata(&op->dev, i2c);

 	i2c->adap = mpc_ops;
+	of_val = of_get_property(op->node, "linux,i2c-class", NULL);
+	if(of_val)
+		i2c->adap.class = *of_val;
+
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &op->dev;



-- 
Michael Lawnick
