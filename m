From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH 0/8] i2c: img-scb: fixes to support i2c on pistachio
Date: Mon, 27 Jul 2015 12:47:13 +0100
Message-ID: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <james.hogan@imgtec.com>, linux-i2c@vger.kernel.org
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Following patches are required to fix the existing driver to
support i2c on pistachio.

Tested on Pistachio bub using an Adafruit I2C Non-Volatile FRAM Breakout
(256Kbit / 32KByte) eeprom.

Used i2c buildroot tools to test the eeprom and the other i2c blocks.
Also used dd commands to copy data to and then to dump data from the
eeprom. i2ctransfer was used to test repeated starts and verified
using a scope.

Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>

Sifan Naeem (8):
  i2c: img-scb: enable fencing for all versions of the ip
  i2c: img-scb: do dummy writes before fifo access
  i2c: img-scb: use DIV_ROUND_UP to round divisor values
  i2c: img-scb: fix LOW and HIGH period values for the SCL clock
  i2c: img-scb: reset interrupts in img_i2c_soft_reset
  i2c: img-scb: remove start bit detected status after handling
  i2c: img-scb: improve transaction complete handle
  i2c: img-scb: verify support for requested bit rate

 drivers/i2c/busses/i2c-img-scb.c |  101 ++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 43 deletions(-)

-- 
1.7.9.5
