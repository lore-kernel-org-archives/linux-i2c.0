From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/7] i2c: img-scb: fixes to support i2c on pistachio
Date: Fri, 14 Aug 2015 16:50:17 +0100
Message-ID: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The following patches are required to fix the existing driver to
support i2c on pistachio.

Tested on Pistachio bub using an Adafruit I2C Non-Volatile FRAM Breakout
(256Kbit / 32KByte) eeprom.

Used i2c buildroot tools to test the eeprom and the other i2c blocks.
Also used dd commands to copy data to and then to dump data from the
eeprom. i2ctransfer was used to test repeated starts and verified
using a scope.

Changes from v1:
	removed v1 5/8: i2c-img-scb-reset-interrupts-in-img_i2c_soft_reset
	removed v1 7/8: i2c-img-scb-improve-transaction-complete-handle
	4/7: extra space removed
	5/7: line_status used instead of i2c->line_status
	6/7: reworked v1 7/8 and added as new patch
	7/7: reworked, limit bitrate to maximum supported
	12 digit hash id used.

Sifan Naeem (7):
  i2c: img-scb: enable fencing for all versions of the ip
  i2c: img-scb: do dummy writes before fifo access
  i2c: img-scb: use DIV_ROUND_UP to round divisor values
  i2c: img-scb: fix LOW and HIGH period values for the SCL clock
  i2c: img-scb: remove start bit detected status after handling
  i2c: img-scb: Clear line and interrupt status before starting a
    transfer
  i2c: img-scb: verify support for requested bit rate

 drivers/i2c/busses/i2c-img-scb.c |   87 +++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 33 deletions(-)

-- 
1.7.9.5
