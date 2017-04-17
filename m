From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC] i2c: rcar: reinit hardware on resume
Date: Mon, 17 Apr 2017 20:32:49 +0200
Message-ID: <20170417183249.19128-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On resume, reinit hardware to ensure state machine and clock settings
are proper. This code assumes:

* bus clock is a fixed value, so no need to recalculate timings after probe
* handling RuntimePM is not needed, because register content is kept
  when disabling the IP core clock

Tested with r8a7796 (M3-W) and r8a7790 (H2).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

@Geert: do you agree to my assumptions?

 drivers/i2c/busses/i2c-rcar.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 26f2ff22e97e55..7010c77df11daa 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -907,10 +907,27 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rcar_i2c_resume(struct device *dev)
+{
+	struct rcar_i2c_priv *priv = dev_get_drvdata(dev);
+
+	rcar_i2c_init(priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rcar_i2c_pm, NULL, rcar_i2c_resume);
+#define RCAR_I2C_PM	(&rcar_i2c_pm)
+#else
+#define RCAR_I2C_PM	NULL
+#endif
+
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
 		.of_match_table = rcar_i2c_dt_ids,
+		.pm	= RCAR_I2C_PM,
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
-- 
2.11.0
