From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH v3 0/5] i2c: img-scb: enchancements to support i2c on pistachio
Date: Thu, 19 Nov 2015 09:35:12 +0000
Message-ID: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:30497 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbKSJfU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 04:35:20 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>

The following patches are required to enchance the existing driver to
support i2c on pistachio.

This patch series depends on the series of fixes posted earlier[1].
The features added in this series were tested with the earlier fixes
in place.

Tested on Pistachio bub and on tz1090 using an Adafruit I2C
Non-Volatile FRAM Breakout (256Kbit / 32KByte) eeprom.

Used i2c buildroot tools to test the eeprom and the other i2c blocks.
Also used dd commands to copy data to and then to dump data from the
eeprom. i2ctransfer was used to test repeated starts and verified
using a scope.

[1]:
http://marc.info/?l=linux-i2c&m=144189643306030&w=2

Changes from v1:
	removed v1 3/7: "mark transaction as complete when all data is read"
	removed v1 4/7: "mark transaction as complete when no more data to write"
	1/5: Acked-by added.
	2/5 reworked with J Hogan suggestions.
	3/5 reworked with J Hogan suggestions.
	4/5 reworked with J Hogan suggestions.
	5/5 moved v1 2/7: "support repeated starts on IP v3.3 to" the end

Sifan Naeem (5):
  i2c: img-scb: support I2C_M_IGNORE_NAK
  i2c: img-scb: remove fifo EMPTYING interrupts handle
  i2c: img-scb: add handle for stop detected interrupt
  i2c: img-scb: add handle for Master halt interrupt
  i2c: img-scb: support repeated starts on IP v3.3

 drivers/i2c/busses/i2c-img-scb.c |   92 +++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 25 deletions(-)

-- 
1.7.9.5
