From: Rob Herring <robh@kernel.org>
Subject: [PATCH] i2c: powermac: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:24 -0600
Message-ID: <20181205195050.4759-8-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/i2c/busses/i2c-powermac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f6f4ed8afc93..281113c28314 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -229,9 +229,9 @@ static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 		return (be32_to_cpup(prop) & 0xff) >> 1;
 
 	/* Now handle some devices with missing "reg" properties */
-	if (!strcmp(node->name, "cereal"))
+	if (of_node_name_eq(node, "cereal"))
 		return 0x60;
-	else if (!strcmp(node->name, "deq"))
+	else if (of_node_name_eq(node, "deq"))
 		return 0x34;
 
 	dev_warn(&adap->dev, "No i2c address for %pOF\n", node);
@@ -304,7 +304,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 	}
 
 	/* Now look for known workarounds */
-	if (!strcmp(node->name, "deq")) {
+	if (of_node_name_eq(node, "deq")) {
 		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */
 		if (addr == 0x34) {
 			snprintf(type, type_size, "MAC,tas3001");
@@ -331,7 +331,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 	 * case we skip this function completely as the device-tree will
 	 * not contain anything useful.
 	 */
-	if (!strcmp(adap->dev.of_node->name, "via-pmu"))
+	if (of_node_name_eq(adap->dev.of_node, "via-pmu"))
 		return;
 
 	for_each_child_of_node(adap->dev.of_node, node) {
-- 
2.19.1
