From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] Documentation: i2c: drop unnecessary .owner field in examples
Date: Mon, 15 Jan 2018 12:08:46 +0000
Message-ID: <1516018126-16119-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.at>
List-Id: linux-i2c@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.at>

 Currently there are a few drivers that still set the .owner
 in the i2c_driver structure - all of which are reported by
 coccinelle (scripts/coccinelle/api/platform_no_drv_owner.cocci)
 and there are no cases that set the .onwer and do not call any
 of the functions that set the .owner field anyway in any of the
 drivers (checked by a modified coccinelle script based on the
 above) so it seems that the examples are no longer valid and
 .owner = THIS_MODULE, can be removed here.

 While at it an obvious typo (new new) was also fixed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.at>
---

Patch is against 4.15-rc7 (localversion-next is -next-20180112)

 Documentation/i2c/upgrading-clients | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/i2c/upgrading-clients b/Documentation/i2c/upgrading-clients
index ccba3ff..d5e51ae 100644
--- a/Documentation/i2c/upgrading-clients
+++ b/Documentation/i2c/upgrading-clients
@@ -7,7 +7,7 @@ Introduction
 ------------
 
 This guide outlines how to alter existing Linux 2.6 client drivers from
-the old to the new new binding methods.
+the old to the new binding methods.
 
 
 Example old-style driver
@@ -77,7 +77,6 @@ static int example_attach_adapter(struct i2c_adapter *adap)
 
 static struct i2c_driver example_driver = {
  	.driver		= {
-		.owner		= THIS_MODULE,
 		.name		= "example",
 		.pm		= &example_pm_ops,
 	},
@@ -217,7 +216,6 @@ and other utilities:
 
 static struct i2c_driver example_driver = {
  	.driver		= {
-		.owner		= THIS_MODULE,
 		.name		= "example",
 	},
 +	.id_table	= example_ids,
@@ -269,7 +267,6 @@ MODULE_DEVICE_TABLE(i2c, example_idtable);
 
 static struct i2c_driver example_driver = {
  	.driver		= {
-		.owner		= THIS_MODULE,
 		.name		= "example",
 		.pm		= &example_pm_ops,
 	},
-- 
2.1.4
