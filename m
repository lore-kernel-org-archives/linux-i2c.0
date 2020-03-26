From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/6] media: marvell-ccic: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:43 +0100
Message-ID: <20200326210947.12747-4-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/platform/marvell-ccic/cafe-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 37fdcc53a1c4..9a09a10a3631 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -556,7 +556,7 @@ static int cafe_pci_probe(struct pci_dev *pdev,
 	clkdev_create(mcam->mclk, "xclk", "%d-%04x",
 		i2c_adapter_id(cam->i2c_adapter), ov7670_info.addr);
 
-	if (i2c_new_device(cam->i2c_adapter, &ov7670_info)) {
+	if (!IS_ERR(i2c_new_client_device(cam->i2c_adapter, &ov7670_info))) {
 		cam->registered = 1;
 		return 0;
 	}
-- 
2.20.1
