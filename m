From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/5] media: pci: bt8xx: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:43 +0100
Message-ID: <20191216122946.3495-4-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/bt8xx/bttv-input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-input.c b/drivers/media/pci/bt8xx/bttv-input.c
index 492bc85c2700..41226f1d0e5b 100644
--- a/drivers/media/pci/bt8xx/bttv-input.c
+++ b/drivers/media/pci/bt8xx/bttv-input.c
@@ -386,7 +386,7 @@ void init_bttv_i2c_ir(struct bttv *btv)
 
 	if (btv->init_data.name) {
 		info.platform_data = &btv->init_data;
-		i2c_dev = i2c_new_device(&btv->c.i2c_adap, &info);
+		i2c_dev = i2c_new_client_device(&btv->c.i2c_adap, &info);
 	} else {
 		/*
 		 * The external IR receiver is at i2c address 0x34 (0x35 for
@@ -396,9 +396,9 @@ void init_bttv_i2c_ir(struct bttv *btv)
 		 * internal.
 		 * That's why we probe 0x1a (~0x34) first. CB
 		 */
-		i2c_dev = i2c_new_probed_device(&btv->c.i2c_adap, &info, addr_list, NULL);
+		i2c_dev = i2c_new_scanned_device(&btv->c.i2c_adap, &info, addr_list, NULL);
 	}
-	if (NULL == i2c_dev)
+	if (IS_ERR(i2c_dev))
 		return;
 
 #if defined(CONFIG_MODULES) && defined(MODULE)
-- 
2.20.1
