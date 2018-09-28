From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2] i2c: Convert to using %pOFn instead of device_node.name
Date: Fri, 28 Sep 2018 17:49:47 -0500
Message-ID: <20180928224947.19058-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Remove initialization of parent

 drivers/i2c/busses/i2c-powermac.c | 17 +++++++++--------
 drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f2a2067525ef..f6f4ed8afc93 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -388,9 +388,8 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 static int i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
-	struct device_node *parent = NULL;
+	struct device_node *parent;
 	struct i2c_adapter *adapter;
-	const char *basename;
 	int rc;
 
 	if (bus == NULL)
@@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
 		parent = of_get_parent(pmac_i2c_get_controller(bus));
 		if (parent == NULL)
 			return -EINVAL;
-		basename = parent->name;
+		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d",
+			 parent,
+			 pmac_i2c_get_channel(bus));
+		of_node_put(parent);
 		break;
 	case pmac_i2c_bus_pmu:
-		basename = "pmu";
+		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	case pmac_i2c_bus_smu:
 		/* This is not what we used to do but I'm fixing drivers at
 		 * the same time as this change
 		 */
-		basename = "smu";
+		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	default:
 		return -EINVAL;
 	}
-	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
-		 pmac_i2c_get_channel(bus));
-	of_node_put(parent);
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 92cf5f48afe6..f60b670deff7 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(child, "reg", &chan);
 		if (ret < 0) {
-			dev_err(dev, "no reg property for node '%s'\n",
-				child->name);
+			dev_err(dev, "no reg property for node '%pOFn'\n",
+				child);
 			goto err_children;
 		}
 
-- 
2.17.1
