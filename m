From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: [PATCH 1/3] Prepare to extend pca9539 to support more chips - rename
 files
Date: Thu, 31 Jan 2008 15:04:04 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: video4linux-list@redhat.com, i2c@lm-sensors.org
Cc: David Brownell <david-b@pacbell.net>, Jean Delvare <khali@linux-fr.org>
List-Id: linux-i2c@vger.kernel.org

First stage of the extension, letting pca9539 also support
pca9536, pca9537, and pca9538. Split to make review easier.
Here only rename the files and modify the Makefile.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>

---

This is a git-style rename patch. If desired, I can produce a complete GNU 
patch instead.

 drivers/gpio/Makefile                      |    2 +-
 drivers/gpio/{pca9539.c => pca953x.c}      |    2 +-
 include/linux/i2c/{pca9539.h => pca953x.h} |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpio/{pca9539.c => pca953x.c} (99%)
 rename include/linux/i2c/{pca9539.h => pca953x.h} (100%)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 470ecd6..16dda77 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,5 +5,5 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
-obj-$(CONFIG_GPIO_PCA9539)	+= pca9539.o
+obj-$(CONFIG_GPIO_PCA9539)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
diff --git a/drivers/gpio/pca9539.c b/drivers/gpio/pca953x.c
similarity index 99%
rename from drivers/gpio/pca9539.c
rename to drivers/gpio/pca953x.c
index 3e85c92..7fae4e5 100644
--- a/drivers/gpio/pca9539.c
+++ b/drivers/gpio/pca953x.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pca9539.h>
+#include <linux/i2c/pca953x.h>
 
 #include <asm/gpio.h>
 
diff --git a/include/linux/i2c/pca9539.h b/include/linux/i2c/pca953x.h
similarity index 100%
rename from include/linux/i2c/pca9539.h
rename to include/linux/i2c/pca953x.h
-- 
1.5.3.4

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
