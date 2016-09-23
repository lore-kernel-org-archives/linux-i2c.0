From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] i2c-dev: Rename jump labels in i2cdev_attach_adapter()
Date: Fri, 23 Sep 2016 21:46:27 +0200
Message-ID: <735c3aa5-0402-0e2b-1c6c-a5bfc17c9afd@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 23 Sep 2016 21:21:39 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/i2c-dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index a6e35ce..7d3e3ca 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -555,7 +555,7 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	i2c_dev->cdev.owner = THIS_MODULE;
 	res = cdev_add(&i2c_dev->cdev, MKDEV(I2C_MAJOR, adap->nr), 1);
 	if (res)
-		goto error_cdev;
+		goto put_i2c;
 
 	/* register this i2c device with the driver core */
 	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
@@ -563,15 +563,15 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 				     "i2c-%d", adap->nr);
 	if (IS_ERR(i2c_dev->dev)) {
 		res = PTR_ERR(i2c_dev->dev);
-		goto error;
+		goto delete_cdev;
 	}
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
 		 adap->name, adap->nr);
 	return 0;
-error:
+delete_cdev:
 	cdev_del(&i2c_dev->cdev);
-error_cdev:
+put_i2c:
 	put_i2c_dev(i2c_dev);
 	return res;
 }
-- 
2.10.0
