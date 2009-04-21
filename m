From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 08:42:27 +0200
Message-ID: <49ED6AD3.2060808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For MPC adapter there is no class assigned as it is done in other
adapters. This way no new-style client will ever be instantiated. With
this patch class assignment is read from device tree.
Necessary entry:
class = <1>; /* I2C_CLASS_HWMON (iic.h) */

Based on 2.6.29

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sang, Wolfram <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -318,6 +318,7 @@ static int __devinit fsl_i2c_probe(struct of_device
*op, const struct of_device_
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
+	int *of_val;

 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -354,6 +355,10 @@ static int __devinit fsl_i2c_probe(struct of_device
*op, const struct of_device_
 	dev_set_drvdata(&op->dev, i2c);

 	i2c->adap = mpc_ops;
+	of_val = of_get_property(op->node, "class", NULL);
+	if(of_val)
+		i2c->adap.class = *of_val;
+
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &op->dev;

-- 
Michael Lawnick
