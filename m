From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/3] of: unittest: simplify getting the adapter of a client
Date: Mon, 10 Jun 2019 11:51:56 +0200
Message-ID: <20190610095157.11814-4-wsa+renesas@sang-engineering.com>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Reported-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 3832a5de4602..e6b175370f2e 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1946,7 +1946,7 @@ static int unittest_i2c_mux_probe(struct i2c_client *client,
 {
 	int i, nchans;
 	struct device *dev = &client->dev;
-	struct i2c_adapter *adap = to_i2c_adapter(dev->parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct device_node *np = client->dev.of_node, *child;
 	struct i2c_mux_core *muxc;
 	u32 reg, max_reg;
-- 
2.19.1
