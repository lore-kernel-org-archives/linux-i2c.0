From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/7] i2c: img-scb: enchancements to support i2c on pistachio
Date: Mon, 27 Jul 2015 12:55:55 +0100
Message-ID: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Following patches are required to enchance the existing driver to
support i2c on pistachio.

This patch series depends on the series of fixes posted earlier[1].
The features added in this series were tested with the earlier fixes
series.

Tested on Pistachio bub and on tz1090 using an Adafruit I2C
Non-Volatile FRAM Breakout (256Kbit / 32KByte) eeprom.

Used i2c buildroot tools to test the eeprom and the other i2c blocks.
Also used dd commands to copy data to and then to dump data from the
eeprom. i2ctransfer was used to test repeated starts and verified
using a scope.

[1]:
http://marc.info/?l=linux-i2c&m=143799753022541&w=2

Sifan Naeem (7):
  i2c: img-scb: support I2C_M_IGNORE_NAK
  i2c: img-scb: support repeated starts on IP v3.3
  i2c: img-scb: mark transaction as complete when all data is read
  i2c: img-scb: mark transaction as complete when no more data to write
  i2c: img-scb: remove fifo EMPTYING interrupts handle
  i2c: img-scb: add handle for stop detected interrupt
  i2c: img-scb: add handle for Master halt interrupt

 drivers/i2c/busses/i2c-img-scb.c |  129 ++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 25 deletions(-)

-- 
1.7.9.5
