From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 03/17] media: dvb-frontends: cxd2820r_core: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:03 +0100
Message-ID: <20191106212120.27983-4-wsa+renesas@sang-engineering.com>
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
 drivers/media/dvb-frontends/cxd2820r_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2820r_core.c b/drivers/media/dvb-frontends/cxd2820r_core.c
index d137199e13e6..b1618339eec0 100644
--- a/drivers/media/dvb-frontends/cxd2820r_core.c
+++ b/drivers/media/dvb-frontends/cxd2820r_core.c
@@ -530,8 +530,8 @@ struct dvb_frontend *cxd2820r_attach(const struct cxd2820r_config *config,
 	strscpy(board_info.type, "cxd2820r", I2C_NAME_SIZE);
 	board_info.addr = config->i2c_address;
 	board_info.platform_data = &pdata;
-	client = i2c_new_device(adapter, &board_info);
-	if (!client || !client->dev.driver)
+	client = i2c_new_client_device(adapter, &board_info);
+	if (!i2c_client_has_driver(client))
 		return NULL;
 
 	return pdata.get_dvb_frontend(client);
-- 
2.20.1
