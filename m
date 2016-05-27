From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: dev: don't start function name with 'return'
Date: Fri, 27 May 2016 13:18:11 +0200
Message-ID: <1464347891-4236-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47365 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbcE0LSU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 27 May 2016 07:18:20 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Erico Nunes <erico.nunes@datacom.ind.br>, Wolfram Sang <wsa@the-dreams.de>

I stumbled multiple times over 'return_i2c_dev', especially before the
actual 'return res'. It makes the code hard to read, so reanme the
function to 'put_i2c_dev' which also better matches 'get_free_i2c_dev'.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 2562a45ff152e5..89593dcb79f032 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -91,7 +91,7 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 	return i2c_dev;
 }
 
-static void return_i2c_dev(struct i2c_dev *i2c_dev)
+static void put_i2c_dev(struct i2c_dev *i2c_dev)
 {
 	spin_lock(&i2c_dev_list_lock);
 	list_del(&i2c_dev->list);
@@ -575,7 +575,7 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 error:
 	cdev_del(&i2c_dev->cdev);
 error_cdev:
-	return_i2c_dev(i2c_dev);
+	put_i2c_dev(i2c_dev);
 	return res;
 }
 
@@ -592,7 +592,7 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
-	return_i2c_dev(i2c_dev);
+	put_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	cdev_del(&i2c_dev->cdev);
 
-- 
2.8.1
