From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 15/17] media: usb: dvb-usb: dib0700_devices: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:15 +0100
Message-ID: <20191106212120.27983-16-wsa+renesas@sang-engineering.com>
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
 drivers/media/usb/dvb-usb/dib0700_devices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index ab7a100ec84f..4ef3fa98d20f 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -3772,8 +3772,8 @@ static int xbox_one_attach(struct dvb_usb_adapter *adap)
 	info.addr = 0x18;
 	info.platform_data = &mn88472_config;
 	request_module(info.type);
-	client_demod = i2c_new_device(&d->i2c_adap, &info);
-	if (client_demod == NULL || client_demod->dev.driver == NULL)
+	client_demod = i2c_new_client_device(&d->i2c_adap, &info);
+	if (!i2c_client_has_driver(client_demod))
 		goto fail_demod_device;
 	if (!try_module_get(client_demod->dev.driver->owner))
 		goto fail_demod_module;
@@ -3800,8 +3800,8 @@ static int xbox_one_attach(struct dvb_usb_adapter *adap)
 	info.platform_data = &tda18250_config;
 
 	request_module(info.type);
-	client_tuner = i2c_new_device(&adap->dev->i2c_adap, &info);
-	if (client_tuner == NULL || client_tuner->dev.driver == NULL)
+	client_tuner = i2c_new_client_device(&adap->dev->i2c_adap, &info);
+	if (!i2c_client_has_driver(client_tuner))
 		goto fail_tuner_device;
 	if (!try_module_get(client_tuner->dev.driver->owner))
 		goto fail_tuner_module;
-- 
2.20.1
