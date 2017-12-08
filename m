From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] i2c: Include GPIO consumer header in main include
Date: Fri,  8 Dec 2017 14:39:34 +0100
Message-ID: <20171208133934.18038-1-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43162 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdLHNji (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 08:39:38 -0500
Received: by mail-lf0-f67.google.com with SMTP id 94so11914148lfy.10
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 05:39:37 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

It seems most users of <linux/i2c.h> pick up their
dependency of <linux/gpio/consumer.h> from other paths but
that is not a universal law, so include the header
explicitly so we have struct gpio_desc available.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5d7f3c1853ae..8b968c44ddfa 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,7 @@
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
+#include <linux/gpio/consumer.h>
 #include <uapi/linux/i2c.h>
 
 extern struct bus_type i2c_bus_type;
-- 
2.14.3
