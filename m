From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 2/3] i2c: mv64xxx: Fix clock resource by adding an optional bus clock
Date: Tue, 16 Jan 2018 17:35:39 +0100
Message-ID: <20180116163540.1092-3-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57614 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeAPQfz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 11:35:55 -0500
In-Reply-To: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
is optional because not all the SoCs need them but at least for Armada
7K/8K it is actually mandatory.

The binding documentation is updating accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 5c30026921ae..0ffe65a316ae 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -25,6 +25,15 @@ default frequency is 100kHz
                      whenever you're using the "allwinner,sun6i-a31-i2c"
                      compatible.
 
+ - clocks:	   : pointers to the reference clocks for this device, the
+		     first one is the one used for the clock on the i2c bus,
+		     the second one is the clock used to acces the registers
+		     of the controller
+
+ - clock-names	   : names of used clocks, mandatory if the second clock is
+		     used, the name must be "core", and "reg" (the latter is
+		     only for Armada 7K/8K).
+
 Examples:
 
 	i2c@11000 {
@@ -42,3 +51,14 @@ For the Armada XP:
 		interrupts = <29>;
 		clock-frequency = <100000>;
 	};
+
+For the Armada 7040:
+
+	i2c@701000 {
+		compatible = "marvell,mv78230-i2c";
+		reg = <0x701000 0x20>;
+		interrupts = <29>;
+		clock-frequency = <100000>;
+		clock-names = "core", "reg";
+		clocks = <&core_clock>, <&reg_clock>;
+	};
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index f69066266faa..440fe4a96e68 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -135,6 +135,7 @@ struct mv64xxx_i2c_data {
 	u32			freq_m;
 	u32			freq_n;
 	struct clk              *clk;
+	struct clk              *reg_clk;
 	wait_queue_head_t	waitq;
 	spinlock_t		lock;
 	struct i2c_msg		*msg;
@@ -894,13 +895,20 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	init_waitqueue_head(&drv_data->waitq);
 	spin_lock_init(&drv_data->lock);
 
-	/* Not all platforms have a clk */
+	/* Not all platforms have clocks */
 	drv_data->clk = devm_clk_get(&pd->dev, NULL);
 	if (IS_ERR(drv_data->clk) && PTR_ERR(drv_data->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (!IS_ERR(drv_data->clk))
 		clk_prepare_enable(drv_data->clk);
 
+	drv_data->reg_clk = devm_clk_get(&pd->dev, "reg");
+	if (IS_ERR(drv_data->reg_clk) &&
+	    PTR_ERR(drv_data->reg_clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR(drv_data->reg_clk))
+		clk_prepare_enable(drv_data->reg_clk);
+
 	drv_data->irq = platform_get_irq(pd, 0);
 
 	if (pdata) {
@@ -950,6 +958,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_reset:
 	reset_control_assert(drv_data->rstc);
 exit_clk:
+	clk_disable_unprepare(drv_data->reg_clk);
 	clk_disable_unprepare(drv_data->clk);
 
 	return rc;
@@ -963,6 +972,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
 	reset_control_assert(drv_data->rstc);
+	clk_disable_unprepare(drv_data->reg_clk);
 	clk_disable_unprepare(drv_data->clk);
 
 	return 0;
-- 
2.15.1
