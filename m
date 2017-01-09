From: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Subject: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Mon,  9 Jan 2017 22:53:36 +0700
Message-ID: <1483977216-7623-1-git-send-email-vlad@tsyrklevich.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36843 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760669AbdAIPyB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Jan 2017 10:54:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so13799082pgf.3
        for <linux-i2c@vger.kernel.org>; Mon, 09 Jan 2017 07:54:01 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Vlad Tsyrklevich <vlad@tsyrklevich.net>

i2c_smbus_xfer() does not always fill an entire block, allowing
kernel stack memory disclosure through the temp variable. Clear
it before it's read to.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 66f323f..6f638bb 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -331,7 +331,7 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 		unsigned long arg)
 {
 	struct i2c_smbus_ioctl_data data_arg;
-	union i2c_smbus_data temp;
+	union i2c_smbus_data temp = {};
 	int datasize, res;
 
 	if (copy_from_user(&data_arg,
-- 
2.7.0
