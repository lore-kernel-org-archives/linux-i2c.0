From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/34] gpu: drm: bridge: sii9234: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:55:41 +0200
Message-ID: <20190608105619.593-3-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/gpu/drm/bridge/sii9234.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index b36bbafb0e43..25d4ad8c7ad6 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -815,7 +815,7 @@ static irqreturn_t sii9234_irq_thread(int irq, void *data)
 static int sii9234_init_resources(struct sii9234 *ctx,
 				  struct i2c_client *client)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	int ret;
 
 	if (!ctx->dev->of_node) {
@@ -897,7 +897,7 @@ static const struct drm_bridge_funcs sii9234_bridge_funcs = {
 static int sii9234_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct sii9234 *ctx;
 	struct device *dev = &client->dev;
 	int ret;
-- 
2.19.1
