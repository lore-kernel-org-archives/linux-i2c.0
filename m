From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c: change the id to let the i2c-gpio work
Date: Fri, 12 Oct 2012 17:42:51 +0800
Message-ID: <1350034971-1050-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-gpio driver will turn the platform device ID to busnum.
When using platfrom device ID as -1, it means dynamically assigned
the busnum. When writing code, we need to make sure the busnum,
and call i2c_register_board_info(int busnum, ...) to register device
if using -1, we do not know the value of busnum. 

In order to solve this issue, set the platform device ID as a fix number
Here using 0 to match the busnum used in i2c_regsiter_board_info().

Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
Change since v1
  Make the commit message more clear
---
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 0f24cfb..805ef95 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -389,7 +389,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9260_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
-- 
1.7.9.5
