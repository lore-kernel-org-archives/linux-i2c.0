From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 05/12] i2c: powermac: convert to use i2c_new_client_device()
Date: Tue,  7 Jan 2020 18:47:39 +0100
Message-ID: <20200107174748.9616-6-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/busses/i2c-powermac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 504f5bf0e625..973e5339033c 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -240,8 +240,8 @@ static void i2c_powermac_create_one(struct i2c_adapter *adap,
 
 	strncpy(info.type, type, sizeof(info.type));
 	info.addr = addr;
-	newdev = i2c_new_device(adap, &info);
-	if (!newdev)
+	newdev = i2c_new_client_device(adap, &info);
+	if (IS_ERR(newdev))
 		dev_err(&adap->dev,
 			"i2c-powermac: Failure to register missing %s\n",
 			type);
@@ -359,8 +359,8 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
 
-		newdev = i2c_new_device(adap, &info);
-		if (!newdev) {
+		newdev = i2c_new_client_device(adap, &info);
+		if (IS_ERR(newdev)) {
 			dev_err(&adap->dev, "i2c-powermac: Failure to register"
 				" %pOF\n", node);
 			of_node_put(node);
-- 
2.20.1
