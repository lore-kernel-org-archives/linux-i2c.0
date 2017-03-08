From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] i2c: do not leave semaphore armed when copying properties fails
Date: Wed,  8 Mar 2017 10:41:01 -0800
Message-ID: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We should not leave i2c_register_board_info() early, without unlocking the
__i2c_board_lock.

Fixes: b0c1e95ab44f ("i2c: copy device properties when using ...")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-boardinfo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index 5b8f6c3a6950..0e285c68b2ff 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -84,8 +84,10 @@ int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsig
 		if (info->properties) {
 			devinfo->board_info.properties =
 					property_entries_dup(info->properties);
-			if (IS_ERR(devinfo->board_info.properties))
-				return PTR_ERR(devinfo->board_info.properties);
+			if (IS_ERR(devinfo->board_info.properties)) {
+				status = PTR_ERR(devinfo->board_info.properties);
+				break;
+			}
 		}
 
 		list_add_tail(&devinfo->list, &__i2c_board_list);
-- 
2.12.0.246.ga2ecc84866-goog
