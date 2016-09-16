From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/4] i2c: add a warning to i2c_adapter_depth()
Date: Fri, 16 Sep 2016 18:02:44 +0200
Message-ID: <1474041765-17818-4-git-send-email-bgolaszewski@baylibre.com>
References: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36900 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964957AbcIPQDK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Sep 2016 12:03:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id k186so49853884wmd.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Sep 2016 09:03:09 -0700 (PDT)
In-Reply-To: <1474041765-17818-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Yong Li <yong.b.li@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This routine is only used together with lockdep for nested locking.
The number of lock subclasses is limited to 8 as defined in lockdep.h

Emit a warning if the adapter depth exceeds the maximum number of
lockdep subclasses.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/i2c/i2c-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c9b8df8..75cefa8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1342,6 +1342,9 @@ unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
 	while ((adapter = i2c_parent_is_i2c_adapter(adapter)))
 		depth++;
 
+	WARN_ONCE(depth >= MAX_LOCKDEP_SUBCLASSES,
+		  "adapter depth exceeds lockdep subclass limit\n");
+
 	return depth;
 }
 EXPORT_SYMBOL_GPL(i2c_adapter_depth);
-- 
2.7.4
