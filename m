From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] i2c: make sure i2c_master_send/recv return negative error
 codes
Date: Sat, 1 Apr 2017 10:54:35 -0700
Message-ID: <20170401175435.GA12354@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32864 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdDARyi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 1 Apr 2017 13:54:38 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

There is theoretical possibility that i2c_master_send() and
i2c_master_recv() may return non-negative result on error: we pass
return values from i2c_xfer() unmodified to the caller, unless we
transferred exactly 1 message. Let's ensure we always return negative on
error.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6efeba42d10b..34b0482333f4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2835,7 +2835,10 @@ int i2c_master_send(const struct i2c_client *client, const void *buf, int count)
 	 * If everything went ok (i.e. 1 msg transmitted), return #bytes
 	 * transmitted, else error code.
 	 */
-	return (ret == 1) ? count : ret;
+	if (likely(ret == 1))
+		return count;
+
+	return ret < 0 ? ret : -EIO;
 }
 EXPORT_SYMBOL(i2c_master_send);
 
@@ -2865,7 +2868,10 @@ int i2c_master_recv(const struct i2c_client *client, void *buf, int count)
 	 * If everything went ok (i.e. 1 msg received), return #bytes received,
 	 * else error code.
 	 */
-	return (ret == 1) ? count : ret;
+	if (likely(ret == 1))
+		return count;
+
+	return ret < 0 ? ret : -EIO;
 }
 EXPORT_SYMBOL(i2c_master_recv);
 
-- 
2.12.2.564.g063fe858b8-goog


-- 
Dmitry
