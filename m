From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] [media] usb: make i2c_algorithm const
Date: Fri, 18 Aug 2017 21:36:58 +0530
Message-ID: <1503072418-6887-3-git-send-email-bhumirks@gmail.com>
References: <1503072418-6887-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503072418-6887-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, vz@mleia.com, slemieux.tyco@gmail.com, wsa@the-dreams.de, gxt@mprc.pku.edu.cn, mchehab@kernel.org, isely@pobox.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Make these const as they are only used in a copy operation or
are stored in the algo field of i2c_adapter structure, which is const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/usb/au0828/au0828-i2c.c        | 2 +-
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-i2c.c b/drivers/media/usb/au0828/au0828-i2c.c
index 42b352b..a028e36 100644
--- a/drivers/media/usb/au0828/au0828-i2c.c
+++ b/drivers/media/usb/au0828/au0828-i2c.c
@@ -329,7 +329,7 @@ static u32 au0828_functionality(struct i2c_adapter *adap)
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
 }
 
-static struct i2c_algorithm au0828_i2c_algo_template = {
+static const struct i2c_algorithm au0828_i2c_algo_template = {
 	.master_xfer	= i2c_xfer,
 	.functionality	= au0828_functionality,
 };
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
index 20a52b7..cfa8fbe 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
@@ -514,7 +514,7 @@ static u32 pvr2_i2c_functionality(struct i2c_adapter *adap)
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
 }
 
-static struct i2c_algorithm pvr2_i2c_algo_template = {
+static const struct i2c_algorithm pvr2_i2c_algo_template = {
 	.master_xfer   = pvr2_i2c_xfer,
 	.functionality = pvr2_i2c_functionality,
 };
-- 
1.9.1
