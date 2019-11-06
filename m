From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 16/17] media: usb: dvb-usb: dw2102: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:16 +0100
Message-ID: <20191106212120.27983-17-wsa+renesas@sang-engineering.com>
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
 drivers/media/usb/dvb-usb/dw2102.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index b960abd00d48..8b584507dd59 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -1590,8 +1590,8 @@ static int tt_s2_4600_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x68;
 	board_info.platform_data = &m88ds3103_pdata;
 	request_module("m88ds3103");
-	client = i2c_new_device(&d->i2c_adap, &board_info);
-	if (client == NULL || client->dev.driver == NULL)
+	client = i2c_new_client_device(&d->i2c_adap, &board_info);
+	if (!i2c_client_has_driver(client))
 		return -ENODEV;
 	if (!try_module_get(client->dev.driver->owner)) {
 		i2c_unregister_device(client);
@@ -1609,9 +1609,9 @@ static int tt_s2_4600_frontend_attach(struct dvb_usb_adapter *adap)
 	board_info.addr = 0x60;
 	board_info.platform_data = &ts2020_config;
 	request_module("ts2020");
-	client = i2c_new_device(i2c_adapter, &board_info);
+	client = i2c_new_client_device(i2c_adapter, &board_info);
 
-	if (client == NULL || client->dev.driver == NULL) {
+	if (!i2c_client_has_driver(client)) {
 		dvb_frontend_detach(adap->fe_adap[0].fe);
 		return -ENODEV;
 	}
-- 
2.20.1
