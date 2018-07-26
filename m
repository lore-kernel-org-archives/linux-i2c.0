From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Thu, 26 Jul 2018 15:55:08 -0700
Message-ID: <20180726225508.74612-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, dianders@chromium.org, dtor@chromium.org, venkateswarlu.v.vinjamuri@intel.corp-partner.google.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-i2c@vger.kernel.org

This enables the async suspend property for i2c devices. This reduces
the suspend/resume time considerably on platforms with multiple i2c
devices (such as a trackpad or touchscreen).

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb2b966..3382bb7e1dcc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -749,6 +749,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
-- 
2.18.0.345.g5c9ce644c3-goog
