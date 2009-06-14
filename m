From: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
Subject: [PATCH] Make stu300 driver depend on MACH_U300
Date: Mon, 15 Jun 2009 00:30:18 +0200
Message-ID: <1245018618-19238-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This makes the stu300 driver for the ST Micro ST DDC I2C bus
driver depend on MACH_U300, new platforms reusing this I2C
driver will need to add in a similar dependency.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 739d5ff..f6c0234 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -515,6 +515,7 @@ config I2C_SIMTEC
 
 config I2C_STU300
 	tristate "ST Microelectronics DDC I2C interface"
+	depends on MACH_U300
 	default y if MACH_U300
 	help
 	  If you say yes to this option, support will be included for the
-- 
1.6.2.2
