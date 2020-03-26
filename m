From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/6] media: pci: saa7134: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:42 +0100
Message-ID: <20200326210947.12747-3-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/pci/saa7134/saa7134-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7134/saa7134-input.c b/drivers/media/pci/saa7134/saa7134-input.c
index 9aea7c30380b..8610eb473b39 100644
--- a/drivers/media/pci/saa7134/saa7134-input.c
+++ b/drivers/media/pci/saa7134/saa7134-input.c
@@ -982,7 +982,7 @@ void saa7134_probe_i2c_ir(struct saa7134_dev *dev)
 
 	if (dev->init_data.name)
 		info.platform_data = &dev->init_data;
-	i2c_new_device(&dev->i2c_adap, &info);
+	i2c_new_client_device(&dev->i2c_adap, &info);
 }
 
 static int saa7134_raw_decode_irq(struct saa7134_dev *dev)
-- 
2.20.1
