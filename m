From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c-cht-wc: constify platform_device_id
Date: Tue, 28 Nov 2017 15:55:07 +0530
Message-ID: <bbbfa0879a3b9b778b11879fb6eb8150f4cb6838.1511864617.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 190bbbc..db56759 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -342,7 +342,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id cht_wc_i2c_adap_id_table[] = {
+static const struct platform_device_id cht_wc_i2c_adap_id_table[] = {
 	{ .name = "cht_wcove_ext_chgr" },
 	{},
 };
-- 
1.9.1
