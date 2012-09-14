From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH] i2c: at91: add dma support
Date: Fri, 14 Sep 2012 17:43:32 +0200
Message-ID: <1347637413-1257-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, pko-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Hi,

This patch provides DMA support for Atmel TWI. Only sam9x5 and sam9n12 devices
are concerned.
One part is missing since the generic device tree DMA helpers have not been
adopted yet, it has been tested with home-made ones.

It has been tested with an eeprom. Do you see potential issues with this device
or with other ones.

If you have suggestions about sg part and twi_irq_save/restore, don't hesitate.
I am not really pleased with it, I think something better could be done.

Thanks

Regards

Ludovic

Ludovic Desroches (1):
  i2c: at91: add dma support

 drivers/i2c/busses/i2c-at91.c | 323 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 311 insertions(+), 12 deletions(-)

-- 
1.7.11.3
