From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] i2c-dev: Use kmalloc_array() in i2cdev_ioctl_rdwr()
Date: Fri, 23 Sep 2016 21:44:32 +0200
Message-ID: <be56c41b-0b29-de40-0bce-700de64b7d92@users.sourceforge.net>
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
Date: Fri, 23 Sep 2016 20:30:07 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/i2c-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 66f323f..6d8226d 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -260,7 +260,9 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 	if (IS_ERR(rdwr_pa))
 		return PTR_ERR(rdwr_pa);
 
-	data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
+	data_ptrs = kmalloc_array(rdwr_arg.nmsgs,
+				  sizeof(*data_ptrs),
+				  GFP_KERNEL);
 	if (data_ptrs == NULL) {
 		kfree(rdwr_pa);
 		return -ENOMEM;
-- 
2.10.0
