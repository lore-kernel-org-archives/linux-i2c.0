From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] i2c: correct struct i2c_driver doc about detection
Date: Wed,  3 Oct 2012 16:17:24 -0400
Message-ID: <1349295444-18645-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

s/address_data/address_list/ in addition to c3813d6.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 include/linux/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8e25a91..8d87329 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -140,7 +140,7 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
  * The driver.owner field should be set to the module owner of this driver.
  * The driver.name field should be set to the name of this driver.
  *
- * For automatic device detection, both @detect and @address_data must
+ * For automatic device detection, both @detect and @address_list must
  * be defined. @class should also be set, otherwise only devices forced
  * with module parameters will be created. The detect function must
  * fill at least the name field of the i2c_board_info structure it is
-- 
1.7.11.4
