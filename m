From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/6] media: usb: hdpvr: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:45 +0100
Message-ID: <20200326210947.12747-6-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/hdpvr/hdpvr-core.c | 4 ++--
 drivers/media/usb/hdpvr/hdpvr-i2c.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index b75c18a012a7..52e05a69c46e 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -363,9 +363,9 @@ static int hdpvr_probe(struct usb_interface *interface,
 	}
 
 	client = hdpvr_register_ir_i2c(dev);
-	if (!client) {
+	if (IS_ERR(client)) {
 		v4l2_err(&dev->v4l2_dev, "i2c IR device register failed\n");
-		retval = -ENODEV;
+		retval = PTR_ERR(client);
 		goto reg_fail;
 	}
 #endif
diff --git a/drivers/media/usb/hdpvr/hdpvr-i2c.c b/drivers/media/usb/hdpvr/hdpvr-i2c.c
index 785c8508a46e..070559b01b01 100644
--- a/drivers/media/usb/hdpvr/hdpvr-i2c.c
+++ b/drivers/media/usb/hdpvr/hdpvr-i2c.c
@@ -44,7 +44,7 @@ struct i2c_client *hdpvr_register_ir_i2c(struct hdpvr_device *dev)
 	init_data->polling_interval = 405; /* ms, duplicated from Windows */
 	info.platform_data = init_data;
 
-	return i2c_new_device(&dev->i2c_adapter, &info);
+	return i2c_new_client_device(&dev->i2c_adapter, &info);
 }
 
 static int hdpvr_i2c_read(struct hdpvr_device *dev, int bus,
-- 
2.20.1
