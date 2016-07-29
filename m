From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] i2c: add i2c_trylock_bus wrapper, use it
Date: Fri, 29 Jul 2016 10:17:56 +0200
Message-ID: <1469780277-31085-2-git-send-email-peda@axentia.se>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:55568
	"EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750752AbcG2Ju7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 05:50:59 -0400
In-Reply-To: <1469780277-31085-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

This unifies usage with i2c_lock_bus and i2c_unlock_bus, and paves the
way for the next patch which looks a bit saner with this preparatory
work taken care of beforehand.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core.c |  2 +-
 drivers/i2c/i2c-mux.c  |  4 ++--
 include/linux/i2c.h    | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index af11b658984d..2c9135ffdf10 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2311,7 +2311,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 #endif
 
 		if (in_atomic() || irqs_disabled()) {
-			ret = adap->trylock_bus(adap, I2C_LOCK_SEGMENT);
+			ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
 			if (!ret)
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 8eee98634cda..764f195795e4 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -159,7 +159,7 @@ static int i2c_mux_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
 		return 0;	/* mux_lock not locked, failure */
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return 1;	/* we only want mux_lock, success */
-	if (parent->trylock_bus(parent, flags))
+	if (i2c_trylock_bus(parent, flags))
 		return 1;	/* parent locked too, success */
 	rt_mutex_unlock(&parent->mux_lock);
 	return 0;		/* parent not locked, failure */
@@ -193,7 +193,7 @@ static int i2c_parent_trylock_bus(struct i2c_adapter *adapter,
 
 	if (!rt_mutex_trylock(&parent->mux_lock))
 		return 0;	/* mux_lock not locked, failure */
-	if (parent->trylock_bus(parent, flags))
+	if (i2c_trylock_bus(parent, flags))
 		return 1;	/* parent locked too, success */
 	rt_mutex_unlock(&parent->mux_lock);
 	return 0;		/* parent not locked, failure */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 96a25ae14494..e1a8d72ebccb 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -588,6 +588,20 @@ i2c_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 }
 
 /**
+ * i2c_trylock_bus - Try to get exclusive access to an I2C bus segment
+ * @adapter: Target I2C bus segment
+ * @flags: I2C_LOCK_ROOT_ADAPTER tries to locks the root i2c adapter,
+ *	I2C_LOCK_SEGMENT tries to lock only this branch in the adapter tree
+ *
+ * Return: true if the I2C bus segment is locked, false otherwise
+ */
+static inline int
+i2c_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
+{
+	return adapter->trylock_bus(adapter, flags);
+}
+
+/**
  * i2c_unlock_bus - Release exclusive access to an I2C bus segment
  * @adapter: Target I2C bus segment
  * @flags: I2C_LOCK_ROOT_ADAPTER unlocks the root i2c adapter, I2C_LOCK_SEGMENT
-- 
2.1.4
