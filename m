From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/17] media: dvb-core: dvbdev: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:02 +0100
Message-ID: <20191106212120.27983-3-wsa+renesas@sang-engineering.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the newer API returning an ERRPTR and use the new helper to bail
out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/dvb-core/dvbdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 917fe034af37..80b6a71aa33e 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -983,8 +983,8 @@ struct i2c_client *dvb_module_probe(const char *module_name,
 	board_info->addr = addr;
 	board_info->platform_data = platform_data;
 	request_module(module_name);
-	client = i2c_new_device(adap, board_info);
-	if (client == NULL || client->dev.driver == NULL) {
+	client = i2c_new_client_device(adap, board_info);
+	if (!i2c_client_has_driver(client)) {
 		kfree(board_info);
 		return NULL;
 	}
-- 
2.20.1
