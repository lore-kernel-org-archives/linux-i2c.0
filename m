From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] platform/chrome: chromeos_laptop: make I2C API conversion complete
Date: Thu, 26 Mar 2020 22:09:51 +0100
Message-ID: <20200326210952.12857-2-wsa+renesas@sang-engineering.com>
References: <20200326210952.12857-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54354 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCZVJz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:55 -0400
In-Reply-To: <20200326210952.12857-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org

When converting to i2c_new_scanned_device(), it was overlooked that a
conversion to i2c_new_client_device() was also needed. Fix it.

Fixes: c82ebf1bf738 ("platform/chrome: chromeos_laptop: Convert to i2c_new_scanned_device")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 4f3651fcd9fe..472a03daa869 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -103,7 +103,7 @@ chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
 			pr_debug("%d-%02x is probed at %02x\n",
 				 adapter->nr, info->addr, dummy->addr);
 			i2c_unregister_device(dummy);
-			client = i2c_new_device(adapter, info);
+			client = i2c_new_client_device(adapter, info);
 		}
 	}
 
-- 
2.20.1
