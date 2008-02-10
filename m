From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] [arch/arm/mach-pnx4008/gpio.c] duplication in if ... else
 if branches
Date: Sun, 10 Feb 2008 16:11:14 +0100
Message-ID: <47AF1412.4090908@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752892AbYBJPL1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vitalywool@gmail.com
Cc: i2c@lm-sensors.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

There is a duplication of code in the following section. Possibly it was
copy-pasted and it was forgotten to edit these lines? otherwise consider
removing the duplicate lines with the patch below.
---
Different if ... else if branches do the same, remove duplication

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/arm/mach-pnx4008/gpio.c b/arch/arm/mach-pnx4008/gpio.c
index 1ab84ce..7a3b190 100644
--- a/arch/arm/mach-pnx4008/gpio.c
+++ b/arch/arm/mach-pnx4008/gpio.c
@@ -122,16 +122,11 @@ int pnx4008_gpio_register_pin(unsigned short pin)
 	unsigned long bit = GPIO_BIT(pin);
 	int ret = -EBUSY;	/* Already in use */
 
 	gpio_lock();
 
-	if (GPIO_ISBID(pin)) {
-		if (access_map[GPIO_INDEX] & bit)
-			goto out;
-		access_map[GPIO_INDEX] |= bit;
-
-	} else if (GPIO_ISRAM(pin)) {
+	if (GPIO_ISBID(pin) || GPIO_ISRAM(pin)) {
 		if (access_map[GPIO_INDEX] & bit)
 			goto out;
 		access_map[GPIO_INDEX] |= bit;
 
 	} else if (GPIO_ISMUX(pin)) {
