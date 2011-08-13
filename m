From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] i2c-dev: Use memdup_user
Date: Sat, 13 Aug 2011 10:17:06 +0200
Message-ID: <1313223430.16820.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

 Use kmemdup_user rather than duplicating its implementation
 This is a little bit restricted to reduce false positives

 The semantic patch that makes this output is available
 in scripts/coccinelle/api/memdup_user.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c 2011-04-14 10:34:17.670994023 +0200
+++ b/drivers/i2c/i2c-dev.c 2011-08-01 22:08:25.888046385 +0200
@@ -251,15 +251,10 @@ static noinline int i2cdev_ioctl_rdrw(st
 	if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
-	rdwr_pa = kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), GFP_KERNEL);
-	if (!rdwr_pa)
-		return -ENOMEM;
-
-	if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
-			   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
-		kfree(rdwr_pa);
-		return -EFAULT;
-	}
+	rdwr_pa = memdup_user(rdwr_arg.msgs,
+			      rdwr_arg.nmsgs * sizeof(struct i2c_msg));
+	if (IS_ERR(rdwr_pa))
+		return PTR_ERR(rdwr_pa);
 
 	data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);
 	if (data_ptrs == NULL) {
