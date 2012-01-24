From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 10:51:27 +0100
Message-ID: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I've an external i2c attached EEPROM, where I hold the MAC addresses
for 3 interfaces including WLAN. My SoC is am3517 from TI. I found
EEPROM driver under drivers/misc/eeprom/at24.c I can access EEPROM via
sysfs from userland. What were the appropriate method of accessing
EEPROM from a network driver? AFAIK no functions were exported from
eeprom.c.

Regards,
Yegor
