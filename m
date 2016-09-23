From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] i2c-dev: Adjust checks for null pointers in three
 functions
Date: Fri, 23 Sep 2016 21:47:31 +0200
Message-ID: <7ba4f7a9-9af4-4a83-776c-930fb33f9e9e@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 23 Sep 2016 21:30:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" can point information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/i2c-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 7d3e3ca..8f7eddd 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -147,7 +147,7 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 		count = 8192;
 
 	tmp = kmalloc(count, GFP_KERNEL);
-	if (tmp == NULL)
+	if (!tmp)
 		return -ENOMEM;
 
 	pr_debug("i2c-dev: i2c-%d reading %zu bytes.\n",
@@ -263,7 +263,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 	data_ptrs = kmalloc_array(rdwr_arg.nmsgs,
 				  sizeof(*data_ptrs),
 				  GFP_KERNEL);
-	if (data_ptrs == NULL) {
+	if (!data_ptrs) {
 		kfree(rdwr_pa);
 		return -ENOMEM;
 	}
@@ -374,7 +374,7 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 				      client->flags, data_arg.read_write,
 				      data_arg.command, data_arg.size, NULL);
 
-	if (data_arg.data == NULL) {
+	if (!data_arg.data) {
 		dev_dbg(&client->adapter->dev,
 			"data is NULL pointer in ioctl I2C_SMBUS.\n");
 		return -EINVAL;
-- 
2.10.0

