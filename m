From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 180/262] i2c: of: Try to find an I2C adapter matching the parent
Date: Wed, 27 Mar 2019 14:00:35 -0400
Message-ID: <20190327180158.10245-180-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit e814e688413aabd7b0d75e2a8ed1caa472951dec ]

If an I2C adapter doesn't match the provided device tree node, also try
matching the parent's device tree node. This allows finding an adapter
based on the device node of the parent device that was used to register
it.

This fixes a regression on Tegra124-based Chromebooks (Nyan) where the
eDP controller registers an I2C adapter that is used to read to EDID.
After commit 993a815dcbb2 ("dt-bindings: panel: Add missing .txt
suffix") this stopped working because the I2C adapter could no longer
be found. The approach in this patch fixes the regression without
introducing the issues that the above commit solved.

Fixes: 17ab7806de0c ("drm: don't link DP aux i2c adapter to the hardware device node")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Tested-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-of.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6cb7ad608bcd..0f01cdba9d2c 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -121,6 +121,17 @@ static int of_dev_node_match(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static int of_dev_or_parent_node_match(struct device *dev, void *data)
+{
+	if (dev->of_node == data)
+		return 1;
+
+	if (dev->parent)
+		return dev->parent->of_node == data;
+
+	return 0;
+}
+
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
@@ -145,7 +156,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_adapter *adapter;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	dev = bus_find_device(&i2c_bus_type, NULL, node,
+			      of_dev_or_parent_node_match);
 	if (!dev)
 		return NULL;
 
-- 
2.19.1
