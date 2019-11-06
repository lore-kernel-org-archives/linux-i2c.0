From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 05/17] media: dvb-frontends: m88ds3103: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:05 +0100
Message-ID: <20191106212120.27983-6-wsa+renesas@sang-engineering.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the newer API returning an ERRPTR and use the new helper to bail
out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/dvb-frontends/m88ds3103.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index 3a367a585084..c96f05ff5f2f 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1277,8 +1277,8 @@ struct dvb_frontend *m88ds3103_attach(const struct m88ds3103_config *cfg,
 	strscpy(board_info.type, "m88ds3103", I2C_NAME_SIZE);
 	board_info.addr = cfg->i2c_addr;
 	board_info.platform_data = &pdata;
-	client = i2c_new_device(i2c, &board_info);
-	if (!client || !client->dev.driver)
+	client = i2c_new_client_device(i2c, &board_info);
+	if (!i2c_client_has_driver(client))
 		return NULL;
 
 	*tuner_i2c_adapter = pdata.get_i2c_adapter(client);
-- 
2.20.1
