From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/17] media: usb: dvb-usb-v2: af9035: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:11 +0100
Message-ID: <20191106212120.27983-12-wsa+renesas@sang-engineering.com>
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
 drivers/media/usb/dvb-usb-v2/af9035.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 792667ee5ebc..2db286d88fa5 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -208,8 +208,8 @@ static int af9035_add_i2c_dev(struct dvb_usb_device *d, const char *type,
 	request_module("%s", board_info.type);
 
 	/* register I2C device */
-	client = i2c_new_device(adapter, &board_info);
-	if (client == NULL || client->dev.driver == NULL) {
+	client = i2c_new_client_device(adapter, &board_info);
+	if (!i2c_client_has_driver(client)) {
 		ret = -ENODEV;
 		goto err;
 	}
-- 
2.20.1
