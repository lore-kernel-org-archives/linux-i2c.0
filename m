From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: muxes: fix leaked i2c adapter device node references
Date: Wed, 26 Aug 2015 23:59:33 +0300
Message-ID: <1440622773-20913-1-git-send-email-vz@mleia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Every call of of_parse_phandle() increments user count of found device
node, if OF_DYNAMIC is enabled.

The change fixes all similar addressed cases in drivers/i2c.

Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 1 +
 drivers/i2c/muxes/i2c-mux-gpio.c           | 1 +
 drivers/i2c/muxes/i2c-mux-pinctrl.c        | 1 +
 drivers/i2c/muxes/i2c-mux-reg.c            | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 71aac09..402e3a6 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -197,6 +197,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	arb->parent = of_get_i2c_adapter_by_node(parent_np);
+	of_node_put(parent_np);
 	if (!arb->parent) {
 		dev_err(dev, "Cannot find parent bus\n");
 		return -EPROBE_DEFER;
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 70db992..b8e11c1 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -76,6 +76,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 		return -ENODEV;
 	}
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
+	of_node_put(adapter_np);
 	if (!adapter)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index b48378c..b5a982b 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -111,6 +111,7 @@ static int i2c_mux_pinctrl_parse_dt(struct i2c_mux_pinctrl *mux,
 		return -ENODEV;
 	}
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
+	of_node_put(adapter_np);
 	if (!adapter) {
 		dev_err(mux->dev, "Cannot find parent bus\n");
 		return -EPROBE_DEFER;
diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 86d41d36..57ec57e 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -106,6 +106,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 		return -ENODEV;
 	}
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
+	of_node_put(adapter_np);
 	if (!adapter)
 		return -EPROBE_DEFER;
 
-- 
2.1.4
