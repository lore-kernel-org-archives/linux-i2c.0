From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7] gpio: i2c expanders use subsys_init
Date: Wed, 24 Sep 2008 10:40:43 -0700
Message-ID: <200809241040.43943.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754643AbYIXRk4@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: lkml <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make the I2C external GPIO expander drivers register themselves
at subsys_initcall() time when they're statically linked.

SOC-integrated GPIOs are available starting very early -- early
in arch_initcall() at latest, but often even before initcalls
start to run -- so this improves consistency, so more subsystems
can rely on GPIOs in their own subsys_initcall() code.

(This isn't a theoretical problem.  This is one of several patches
needed to resolve oopsing observed when statically linking kernels
on a DaVinci EVM.  Its pcf857x GPIOs needed to be available well
before some other drivers initialized.)

This depends on a patch moving I2C's driver model init earlier
in the boot sequence; otherwise this change would cause oopsing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
For the 2.6.28-rc0 merge window.  Jean, can you include this
in your I2C tree, so it only merges after the I2C init patch
on which it depends?  We want "git bisect" to work.  ;)

 drivers/gpio/max732x.c |    5 ++++-
 drivers/gpio/pca953x.c |    5 ++++-
 drivers/gpio/pcf857x.c |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/gpio/max732x.c
+++ b/drivers/gpio/max732x.c
@@ -372,7 +372,10 @@ static int __init max732x_init(void)
 {
 	return i2c_add_driver(&max732x_driver);
 }
-module_init(max732x_init);
+/* register after i2c postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(max732x_init);
 
 static void __exit max732x_exit(void)
 {
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -289,7 +289,10 @@ static int __init pca953x_init(void)
 {
 	return i2c_add_driver(&pca953x_driver);
 }
-module_init(pca953x_init);
+/* register after i2c postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(pca953x_init);
 
 static void __exit pca953x_exit(void)
 {
--- a/drivers/gpio/pcf857x.c
+++ b/drivers/gpio/pcf857x.c
@@ -351,7 +351,10 @@ static int __init pcf857x_init(void)
 {
 	return i2c_add_driver(&pcf857x_driver);
 }
-module_init(pcf857x_init);
+/* register after i2c postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(pcf857x_init);
 
 static void __exit pcf857x_exit(void)
 {
