From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] Documentation: i2c: Use PM ops instead of legacy suspend/resume
Date: Sun, 30 Nov 2014 17:52:31 +0100
Message-ID: <1417366352-22356-1-git-send-email-lars@metafoo.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

New drivers should use PM ops instead of the legacy suspend/resume
callbacks. Update the I2C device driver guides to reflect this.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 Documentation/i2c/upgrading-clients | 6 ++----
 Documentation/i2c/writing-clients   | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/i2c/upgrading-clients b/Documentation/i2c/upgrading-clients
index 8e5fbd8..ccba3ff 100644
--- a/Documentation/i2c/upgrading-clients
+++ b/Documentation/i2c/upgrading-clients
@@ -79,11 +79,10 @@ static struct i2c_driver example_driver = {
  	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= "example",
+		.pm		= &example_pm_ops,
 	},
 	.attach_adapter = example_attach_adapter,
 	.detach_client	= example_detach,
-	.suspend	= example_suspend,
-	.resume		= example_resume,
 };
 
 
@@ -272,10 +271,9 @@ static struct i2c_driver example_driver = {
  	.driver		= {
 		.owner		= THIS_MODULE,
 		.name		= "example",
+		.pm		= &example_pm_ops,
 	},
 	.id_table	= example_idtable,
 	.probe		= example_probe,
 	.remove		= example_remove,
-	.suspend	= example_suspend,
-	.resume		= example_resume,
 };
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 6b344b5..a755b14 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -36,6 +36,7 @@ MODULE_DEVICE_TABLE(i2c, foo_idtable);
 static struct i2c_driver foo_driver = {
 	.driver = {
 		.name	= "foo",
+		.pm	= &foo_pm_ops,	/* optional */
 	},
 
 	.id_table	= foo_idtable,
@@ -47,8 +48,6 @@ static struct i2c_driver foo_driver = {
 	.address_list	= normal_i2c,
 
 	.shutdown	= foo_shutdown,	/* optional */
-	.suspend	= foo_suspend,	/* optional */
-	.resume		= foo_resume,	/* optional */
 	.command	= foo_command,	/* optional, deprecated */
 }
 
@@ -279,8 +278,9 @@ Power Management
 
 If your I2C device needs special handling when entering a system low
 power state -- like putting a transceiver into a low power mode, or
-activating a system wakeup mechanism -- do that in the suspend() method.
-The resume() method should reverse what the suspend() method does.
+activating a system wakeup mechanism -- do that by implementing the
+appropriate callbacks for the dev_pm_ops of the driver (like suspend
+and resume).
 
 These are standard driver model calls, and they work just like they
 would for any other driver stack.  The calls can sleep, and can use
-- 
1.8.0
