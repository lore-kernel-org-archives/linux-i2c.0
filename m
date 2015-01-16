From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2] i2c: mv64xxx: enable acquisition of timeout value from Device Tree
Date: Fri, 16 Jan 2015 09:36:23 +0100
Message-ID: <1421397383-8222-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

This commit enables obtaining the transaction timeout value in
miliseconds using the timeout-ms property. If it doesn't succeed, the
default value of 1000ms is set.

The Device Tree binding documentation is updated accordingly.

[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: convert commit log to mainline
style]
[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: clarify which timeout is it]

Signed-off-by: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---

Changelog:

v1 -> v2:

- clarify which timeout is it in the Device Tree binding documentation
  and in the commit log.

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 5 +++++
 drivers/i2c/busses/i2c-mv64xxx.c                      | 9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 5c30026921ae..d02d0e5d202c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -25,12 +25,16 @@ default frequency is 100kHz
                      whenever you're using the "allwinner,sun6i-a31-i2c"
                      compatible.
 
+ - timeout-ms      : transaction timeout value in miliseconds. If not set the
+   		     default timeout is 1000ms
+
 Examples:
 
 	i2c@11000 {
 		compatible = "marvell,mv64xxx-i2c";
 		reg = <0x11000 0x20>;
 		interrupts = <29>;
+		timeout-ms = <1000>;
 		clock-frequency = <100000>;
 	};
 
@@ -40,5 +44,6 @@ For the Armada XP:
 		compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
 		reg = <0x11000 0x100>;
 		interrupts = <29>;
+		timeout-ms = <1000>;
 		clock-frequency = <100000>;
 	};
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 30059c1df2a3..a379a17c5c21 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -803,7 +803,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 #else
 	const struct of_device_id *device;
 	struct device_node *np = dev->of_node;
-	u32 bus_freq, tclk;
+	u32 bus_freq, tclk, timeout;
 	int rc = 0;
 
 	if (IS_ERR(drv_data->clk)) {
@@ -832,10 +832,9 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		reset_control_deassert(drv_data->rstc);
 	}
 
-	/* Its not yet defined how timeouts will be specified in device tree.
-	 * So hard code the value to 1 second.
-	 */
-	drv_data->adapter.timeout = HZ;
+	if (of_property_read_u32(np, "timeout-ms", &timeout))
+		timeout = 1000; /* 1000ms by default */
+	drv_data->adapter.timeout = msecs_to_jiffies(timeout);
 
 	device = of_match_device(mv64xxx_i2c_of_match_table, dev);
 	if (!device)
-- 
1.9.1
