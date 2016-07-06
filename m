From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] i2c-dev: don't get i2c adapter via i2c_dev
Date: Tue,  5 Jul 2016 19:57:06 -0700
Message-ID: <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34849 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcGFC5O (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 22:57:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id c2so75744449pfa.2
        for <linux-i2c@vger.kernel.org>; Tue, 05 Jul 2016 19:57:13 -0700 (PDT)
In-Reply-To: <cover.1467772840.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1467772840.git.viresh.kumar@linaro.org>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

There is no code protecting i2c_dev to be freed after it is returned
from i2c_dev_get_by_minor() and using it to access the value which we
already have (minor) isn't safe really.

Avoid using it and get the adapter directly from 'minor'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/i2c/i2c-dev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 6ecfd76270f2..66f323fd3982 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -485,13 +485,8 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	unsigned int minor = iminor(inode);
 	struct i2c_client *client;
 	struct i2c_adapter *adap;
-	struct i2c_dev *i2c_dev;
-
-	i2c_dev = i2c_dev_get_by_minor(minor);
-	if (!i2c_dev)
-		return -ENODEV;
 
-	adap = i2c_get_adapter(i2c_dev->adap->nr);
+	adap = i2c_get_adapter(minor);
 	if (!adap)
 		return -ENODEV;
 
-- 
2.7.4
