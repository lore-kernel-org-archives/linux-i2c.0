From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/17] media: dvb-frontends: lgdt330x: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:04 +0100
Message-ID: <20191106212120.27983-5-wsa+renesas@sang-engineering.com>
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
 drivers/media/dvb-frontends/lgdt330x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/lgdt330x.c b/drivers/media/dvb-frontends/lgdt330x.c
index 651c8aa75e17..da3a8c5e18d8 100644
--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -922,8 +922,8 @@ struct dvb_frontend *lgdt330x_attach(const struct lgdt330x_config *_config,
 	strscpy(board_info.type, "lgdt330x", sizeof(board_info.type));
 	board_info.addr = demod_address;
 	board_info.platform_data = &config;
-	client = i2c_new_device(i2c, &board_info);
-	if (!client || !client->dev.driver)
+	client = i2c_new_client_device(i2c, &board_info);
+	if (!i2c_client_has_driver(client))
 		return NULL;
 
 	return lgdt330x_get_dvb_frontend(client);
-- 
2.20.1
