From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] i2c: i2c_del_adapter: Don't treat removing a non-registered adapter as error
Date: Sat,  9 Mar 2013 19:16:45 +0100
Message-ID: <1362853009-20789-3-git-send-email-lars@metafoo.de>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-i2c@vger.kernel.org

Currently i2c_del_adapter() returns -EINVAL when it gets an adapter which is not
registered. But none of the users of i2c_del_adapter() depend on this behavior,
so for the sake of being able to sanitize the return type of i2c_del_adapter
argue, that the purpose of i2c_del_adapter() is to remove an I2C adapter from
the system. If the adapter is not registered in the first place this becomes a
no-op. So we can return success without having to do anything.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a853cb3..7727d33 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1072,7 +1072,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 	if (found != adap) {
 		pr_debug("i2c-core: attempting to delete unregistered "
 			 "adapter [%s]\n", adap->name);
-		return -EINVAL;
+		return 0;
 	}
 
 	/* Tell drivers about this removal */
-- 
1.8.0
