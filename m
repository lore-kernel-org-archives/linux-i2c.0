From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] i2c: dev: use after free in detach
Date: Sat, 28 May 2016 08:01:46 +0300
Message-ID: <20160528050146.GC4107@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Erico Nunes <erico.nunes@datacom.ind.br>
Cc: linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The call to return_i2c_dev() frees "i2c_dev" so there is a use after
free when we call cdev_del(&i2c_dev->cdev).

Fixes: d6760b14d4a1 ('i2c: dev: switch from register_chrdev to cdev API')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 2562a45..3bf4f0d 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -592,9 +592,9 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
+	cdev_del(&i2c_dev->cdev);
 	return_i2c_dev(i2c_dev);
 	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
-	cdev_del(&i2c_dev->cdev);
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
