From: Colin King <colin.king@canonical.com>
Subject: [PATCH] i2c: i2c-boardinfo: fix memory leaks on devinfo
Date: Wed, 22 Nov 2017 17:52:24 +0000
Message-ID: <20171122175224.2982-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when an error occurs devinfo is still allocated but is
unused when the error exit paths break out of the for-loop. Fix
this by kfree'ing devinfo to avoid the leak.

Detected by CoverityScan, CID#1416590 ("Resource Leak")

Fixes: 4124c4eba402 ("i2c: allow attaching IRQ resources to i2c_board_info")
Fixes: 0daaf99d8424 ("i2c: copy device properties when using i2c_register_board_info()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/i2c-boardinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index 31186ead5a40..509a6007cdf6 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -86,6 +86,7 @@ int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsig
 					property_entries_dup(info->properties);
 			if (IS_ERR(devinfo->board_info.properties)) {
 				status = PTR_ERR(devinfo->board_info.properties);
+				kfree(devinfo);
 				break;
 			}
 		}
@@ -98,6 +99,7 @@ int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsig
 					GFP_KERNEL);
 			if (!devinfo->board_info.resources) {
 				status = -ENOMEM;
+				kfree(devinfo);
 				break;
 			}
 		}
-- 
2.14.1
