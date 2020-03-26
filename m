From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/6] media: usb: cx231xx: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:44 +0100
Message-ID: <20200326210947.12747-5-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and make use of the fact that
unregistering devices is NULL- and ERR_PTR-safe.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/cx231xx/cx231xx-input.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-input.c b/drivers/media/usb/cx231xx/cx231xx-input.c
index 9f88c640ec2b..8149702bcf89 100644
--- a/drivers/media/usb/cx231xx/cx231xx-input.c
+++ b/drivers/media/usb/cx231xx/cx231xx-input.c
@@ -88,7 +88,7 @@ int cx231xx_ir_init(struct cx231xx *dev)
 	ir_i2c_bus = cx231xx_boards[dev->model].ir_i2c_master;
 	dev_dbg(dev->dev, "Trying to bind ir at bus %d, addr 0x%02x\n",
 		ir_i2c_bus, info.addr);
-	dev->ir_i2c_client = i2c_new_device(
+	dev->ir_i2c_client = i2c_new_client_device(
 		cx231xx_get_i2c_adap(dev, ir_i2c_bus), &info);
 
 	return 0;
@@ -96,7 +96,6 @@ int cx231xx_ir_init(struct cx231xx *dev)
 
 void cx231xx_ir_exit(struct cx231xx *dev)
 {
-	if (dev->ir_i2c_client)
-		i2c_unregister_device(dev->ir_i2c_client);
+	i2c_unregister_device(dev->ir_i2c_client);
 	dev->ir_i2c_client = NULL;
 }
-- 
2.20.1
