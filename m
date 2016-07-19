From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH]  i2c: i2c-smbus: drop useless stubs
Date: Tue, 19 Jul 2016 13:15:49 +0200
Message-ID: <20160719131549.3eb23323@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcGSLPw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jul 2016 07:15:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

Drivers which use the SMBus extensions select I2C_SMBUS, so the
stubs are not needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/i2c-smbus.h |   15 ---------------
 1 file changed, 15 deletions(-)

--- linux-4.7-rc7.orig/include/linux/i2c-smbus.h	2016-07-19 13:06:08.873469372 +0200
+++ linux-4.7-rc7/include/linux/i2c-smbus.h	2016-07-19 13:11:46.265359168 +0200
@@ -73,23 +73,8 @@ struct smbus_host_notify {
 	u8			addr;
 };
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS)
 struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
 int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
 				 unsigned short addr, unsigned int data);
-#else
-static inline struct smbus_host_notify *
-i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
-{
-	return NULL;
-}
-
-static inline int
-i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
-			     unsigned short addr, unsigned int data)
-{
-	return 0;
-}
-#endif /* I2C_SMBUS */
 
 #endif /* _LINUX_I2C_SMBUS_H */


-- 
Jean Delvare
SUSE L3 Support
