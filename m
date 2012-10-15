From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/2] i2c: change id to let i2c-gpio work
Date: Mon, 15 Oct 2012 17:30:26 +0800
Message-ID: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c core driver will turn the platform device ID to busnum
When using platfrom device ID as -1, it means dynamically assigned
the busnum. When writing code, we need to make sure the busnum,
and call i2c_register_board_info(int busnum, ...) to register device
if using -1, we do not know the value of busnum
	
In order to solve this issue, set the platform device ID as a fix number
Here using 0 to match the busnum used in i2c_regsiter_board_info()

Bo Shen (2):
  i2c: change id to let i2c-gpio work
  i2c: change id to let i2c-at91 work

 arch/arm/mach-at91/at91rm9200.c          |    2 +-
 arch/arm/mach-at91/at91rm9200_devices.c  |    4 ++--
 arch/arm/mach-at91/at91sam9260.c         |    4 ++--
 arch/arm/mach-at91/at91sam9260_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9261.c         |    4 ++--
 arch/arm/mach-at91/at91sam9261_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9263.c         |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c  |    4 ++--
 9 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.7.9.5
