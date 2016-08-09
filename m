From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH 4/4] media: usb: dvb-usb-v2: dvb_usb_core: don't print error when adding adapter fails
Date: Tue,  9 Aug 2016 13:35:16 +0200
Message-ID: <1470742517-12774-5-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index 3fbb2cd19f5e2a..a8e6624fbe8347 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -82,8 +82,6 @@ static int dvb_usbv2_i2c_init(struct dvb_usb_device *d)
 	ret = i2c_add_adapter(&d->i2c_adap);
 	if (ret < 0) {
 		d->i2c_adap.algo = NULL;
-		dev_err(&d->udev->dev, "%s: i2c_add_adapter() failed=%d\n",
-				KBUILD_MODNAME, ret);
 		goto err;
 	}
 
-- 
2.8.1
