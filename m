From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/5] media: pci: ivtv: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:45 +0100
Message-ID: <20191216122946.3495-6-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Sean Young <sean@mess.org>, Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable. Change
the legacy function to simply return void because the retval was never
used anywhere.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/ivtv/ivtv-i2c.c | 6 +++---
 drivers/media/pci/ivtv/ivtv-i2c.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-i2c.c b/drivers/media/pci/ivtv/ivtv-i2c.c
index 0772d757a389..982045c4eea8 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.c
+++ b/drivers/media/pci/ivtv/ivtv-i2c.c
@@ -208,12 +208,12 @@ static int ivtv_i2c_new_ir(struct ivtv *itv, u32 hw, const char *type, u8 addr)
 	info.platform_data = init_data;
 	strscpy(info.type, type, I2C_NAME_SIZE);
 
-	return i2c_new_probed_device(adap, &info, addr_list, NULL) == NULL ?
+	return IS_ERR(i2c_new_scanned_device(adap, &info, addr_list, NULL)) ?
 	       -1 : 0;
 }
 
 /* Instantiate the IR receiver device using probing -- undesirable */
-struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv)
+void ivtv_i2c_new_ir_legacy(struct ivtv *itv)
 {
 	struct i2c_board_info info;
 	/*
@@ -235,7 +235,7 @@ struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv)
 
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strscpy(info.type, "ir_video", I2C_NAME_SIZE);
-	return i2c_new_probed_device(&itv->i2c_adap, &info, addr_list, NULL);
+	i2c_new_scanned_device(&itv->i2c_adap, &info, addr_list, NULL);
 }
 
 int ivtv_i2c_register(struct ivtv *itv, unsigned idx)
diff --git a/drivers/media/pci/ivtv/ivtv-i2c.h b/drivers/media/pci/ivtv/ivtv-i2c.h
index 462f73449a6e..2d9cdaa682c5 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.h
+++ b/drivers/media/pci/ivtv/ivtv-i2c.h
@@ -9,7 +9,7 @@
 #ifndef IVTV_I2C_H
 #define IVTV_I2C_H
 
-struct i2c_client *ivtv_i2c_new_ir_legacy(struct ivtv *itv);
+void ivtv_i2c_new_ir_legacy(struct ivtv *itv);
 int ivtv_i2c_register(struct ivtv *itv, unsigned idx);
 struct v4l2_subdev *ivtv_find_hw(struct ivtv *itv, u32 hw);
 
-- 
2.20.1
