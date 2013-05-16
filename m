From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 5/9] I2C: mv64xxx: use devm_kzalloc()
Date: Thu, 16 May 2013 21:35:10 +0100
Message-ID: <E1Ud4tK-0004Jo-Ik@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, "Mark A. Greer" <mgreer@animalcreek.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

As we're changing to using devm_* APIs to fix various problems
in this driver, lets also do devm_kzalloc() while we're here too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 0b4da77..841792f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -580,16 +580,15 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	if ((!pdata && !pd->dev.of_node))
 		return -ENODEV;
 
-	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
+	drv_data = devm_kzalloc(&pd->dev, sizeof(struct mv64xxx_i2c_data),
+				GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
 	r = platform_get_resource(pd, IORESOURCE_MEM, 0);
 	drv_data->reg_base = devm_ioremap_resource(&pd->dev, r);
-	if (IS_ERR(drv_data->reg_base)) {
-		rc = PTR_ERR(drv_data->reg_base);
-		goto exit_kfree;
-	}
+	if (IS_ERR(drv_data->reg_base))
+		return PTR_ERR(drv_data->reg_base);
 
 	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
 		sizeof(drv_data->adapter.name));
@@ -613,11 +612,11 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	} else if (pd->dev.of_node) {
 		rc = mv64xxx_of_config(drv_data, pd->dev.of_node);
 		if (rc)
-			goto exit_unmap_regs;
+			goto exit_clk;
 	}
 	if (drv_data->irq < 0) {
 		rc = -ENXIO;
-		goto exit_unmap_regs;
+		goto exit_clk;
 	}
 
 	drv_data->adapter.dev.parent = &pd->dev;
@@ -637,7 +636,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 			"mv64xxx: Can't register intr handler irq: %d\n",
 			drv_data->irq);
 		rc = -EINVAL;
-		goto exit_unmap_regs;
+		goto exit_clk;
 	} else if ((rc = i2c_add_numbered_adapter(&drv_data->adapter)) != 0) {
 		dev_err(&drv_data->adapter.dev,
 			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
@@ -648,9 +647,9 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 	return 0;
 
-	exit_free_irq:
-		free_irq(drv_data->irq, drv_data);
-	exit_unmap_regs:
+exit_free_irq:
+	free_irq(drv_data->irq, drv_data);
+exit_clk:
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
 	if (!IS_ERR(drv_data->clk)) {
@@ -658,8 +657,6 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		clk_unprepare(drv_data->clk);
 	}
 #endif
-	exit_kfree:
-		kfree(drv_data);
 	return rc;
 }
 
@@ -678,7 +675,6 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 		clk_unprepare(drv_data->clk);
 	}
 #endif
-	kfree(drv_data);
 
 	return rc;
 }
-- 
1.7.4.4
