From: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Subject: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Tue, 11 Oct 2016 14:52:28 +0200
Message-ID: <1476190348-37589-1-git-send-email-vlad@tsyrklevich.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36207 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbcJKMwf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 11 Oct 2016 08:52:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id z190so1320176qkc.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Oct 2016 05:52:34 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, Vlad Tsyrklevich <vlad@tsyrklevich.net>

i2c_smbus_xfer() does not always fill an entire block, allowing
kernel stack memory disclosure through the temp variable. Clear
it before it's read to.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>

---
 drivers/i2c/i2c-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 66f323f..62cb111 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -393,6 +393,8 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 	    (data_arg.read_write == I2C_SMBUS_WRITE)) {
 		if (copy_from_user(&temp, data_arg.data, datasize))
 			return -EFAULT;
+	} else {
+		memset(&temp, 0, datasize);
 	}
 	if (data_arg.size == I2C_SMBUS_I2C_BLOCK_BROKEN) {
 		/* Convert old I2C block commands to the new
-- 
2.7.0
