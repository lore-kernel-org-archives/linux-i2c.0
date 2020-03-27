From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Subject: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Fri, 27 Mar 2020 16:19:51 +0100
Message-ID: <20200327151951.18111-1-ricardo.canuelo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0PUO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 11:20:14 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>, Derek Basehore <dbasehore@chromium.org>, Guenter Roeck <groeck@chromium.org>

This enables the async suspend property for i2c devices. This reduces
the suspend/resume time considerably on platforms with multiple i2c
devices (such as a trackpad or touchscreen).

(am from https://patchwork.ozlabs.org/patch/949922/)

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Reviewed-on: https://chromium-review.googlesource.com/1152411
Tested-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@intel.com>
Reviewed-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@intel.com>
Reviewed-by: Justin TerAvest <teravest@chromium.org>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
This patch was originally created for chromeos some time ago and I'm
evaluating if it's a good candidate for upstreaming.

By the looks of it I think it was done with chromebooks in mind, but
AFAICT this would impact every i2c client in every platform, so I'd like
to know your opinion about it.

As far as I know there was no further investigation or testing on it, so
I don't know if it was tested on any other hardware.

Best,
Ricardo

 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad0881942..643bc0fe0281 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -769,6 +769,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	client->dev.of_node = of_node_get(info->of_node);
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
-- 
2.18.0
