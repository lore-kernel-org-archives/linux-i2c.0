From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/4] lockdep: make MAX_LOCKDEP_SUBCLASSES unconditionally visible
Date: Fri, 16 Sep 2016 18:02:43 +0200
Message-ID: <1474041765-17818-3-git-send-email-bgolaszewski@baylibre.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

This define is needed by i2c_adapter_depth() to detect if we don't
exceed the maximum number of lock subclasses. Make it visible even
if lockdep is disabled.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/lockdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index eabe013..c1458fe 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -16,6 +16,8 @@ struct lockdep_map;
 extern int prove_locking;
 extern int lock_stat;
 
+#define MAX_LOCKDEP_SUBCLASSES		8UL
+
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
@@ -29,8 +31,6 @@ extern int lock_stat;
  */
 #define XXX_LOCK_USAGE_STATES		(1+3*4)
 
-#define MAX_LOCKDEP_SUBCLASSES		8UL
-
 /*
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
  * cached in the instance of lockdep_map
-- 
2.7.4

