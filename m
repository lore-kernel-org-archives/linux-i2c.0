From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: [PATCH] Define a NO_GPIO macro to compare against and to use as an
 invalid GPIO
Date: Thu, 31 Jan 2008 16:26:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762688AbYAaP0i@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

As discussed on i2c mailing list with David Brownell, and number
outside of the 0...MAX_INT range is invalid as a GPIO number.
Define a macro, similar to NO_IRQ, to be used as a deliberate
invalid GPIO, rather than defining a is_valid_gpio() macro.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>

---

As gpiolib doesn't seem to have an own mailing list, sending it directly 
to LKML.

 include/asm-generic/gpio.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index f29a502..806b86c 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -16,6 +16,10 @@
 #define ARCH_NR_GPIOS		256
 #endif
 
+#ifndef NO_GPIO
+#define NO_GPIO			((unsigned int)-1)
+#endif
+
 struct seq_file;
 
 /**
-- 
1.5.3.4
