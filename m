From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c: i2c-smbus: fix i2c_handle_smbus_host_notify
 documentation
Date: Sat, 16 Jul 2016 15:45:23 +0200
Message-ID: <1468676723.17822.3.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45581 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcGPNp0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Jul 2016 09:45:26 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

The parameter description is from a previous implementation, update
it to describe the actual implementation.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-smbus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -302,8 +302,8 @@ EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_n
  * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
  * I2C client.
  * @host_notify: the struct host_notify attached to the relevant adapter
- * @data: the Host Notify data which contains the payload and address of the
- * client
+ * @addr: the I2C address of the notifying device
+ * @data: the payload of the notification
  * Context: can't sleep
  *
  * Helper function to be called from an I2C bus driver's interrupt

-- 
Jean Delvare
SUSE L3 Support
