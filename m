From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: fix resume by always initializing registers before transfer
Date: Tue, 18 Apr 2017 20:38:35 +0200
Message-ID: <20170418183835.13836-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Resume failed because of uninitialized registers. Instead of adding a
resume callback, we simply initialize registers before every transfer.
This lightweight change is more robust and will keep us safe if we ever
need support for power domains or dynamic frequency changes.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Morimoto-san: you convinced me that putting all register settings to one place
is a nice thing to do. Here is the patch for that. However, having
pm_runtime_get/put in one place won't work, I am afraid. For I2C slave or
multi-master support, we need permanent-on handling. So, I think the current
pm_runtime handling is good in that regard. Can you agree?

 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 26f2ff22e97e55..66b84bf51bbfd0 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -700,6 +700,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_get_sync(dev);
 
+	rcar_i2c_init(priv);
+
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -860,8 +862,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_put;
 
-	rcar_i2c_init(priv);
-
 	/* Don't suspend when multi-master to keep arbitration working */
 	if (of_property_read_bool(dev->of_node, "multi-master"))
 		priv->flags |= ID_P_PM_BLOCKED;
-- 
2.11.0
