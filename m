From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/8] ARM: at91: do not configure at91sam9g10 twi pio as open-drain
Date: Fri, 31 Aug 2012 11:21:20 +0200
Message-ID: <1346404884-18451-5-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

As indicated in the datasheet, TWD and TWCK must not be programmed as
open-drain.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-at91/at91sam9261_devices.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index c94495d..405f603 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -324,20 +324,22 @@ static struct platform_device at91sam9261_twi_device = {
 
 void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
 {
-	/* IP version is not the same on 9261 and g10 */
+	/*
+	 * IP version is not the same on 9261 and g10 and only 9261 one
+	 * requires to configure PIO as open-drain.
+	 */
 	if (cpu_is_at91sam9g10()) {
 		at91sam9261_twi_device.name = "at91sam9g10_i2c";
+		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
+		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
 	} else {
 		at91sam9261_twi_device.name = "at91sam9261_i2c";
+		at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
+		at91_set_multi_drive(AT91_PIN_PA7, 1);
+		at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
+		at91_set_multi_drive(AT91_PIN_PA8, 1);
 	}
 
-	/* pins used for TWI interface */
-	at91_set_A_periph(AT91_PIN_PA7, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PA7, 1);
-
-	at91_set_A_periph(AT91_PIN_PA8, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PA8, 1);
-
 	i2c_register_board_info(0, devices, nr_devices);
 	platform_device_register(&at91sam9261_twi_device);
 }
-- 
1.7.11.3
