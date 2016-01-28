From: Stefan Wahren <info@lategoodbye.de>
Subject: i2c-bcm2835: Unable to read from i2c0
Date: Thu, 28 Jan 2016 22:43:17 +0100
Message-ID: <56AA8B75.9060801@lategoodbye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:40910 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbcA1Vni (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Jan 2016 16:43:38 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org

Hi,

i'm using a Raspberry Pi B (rev 1) and Linux kernel 4.5rc-1. I have 
connected a PiGlow (SN3218 at address 0x54) to the P1 Header. The I2C 
bus clock is set to 100 kHz.  Every time i want to read data from i2c0 
the following error appear:

[   94.343612] i2c-bcm2835 20205000.i2c: i2c transfer failed: 100

According to the BCM2835 datasheet this should be an ERR ACK (Slave has 
not acknowledged its address).

 > i2cdetect -y 0
0 1 2 3 4 5 6 7 8 9 a b c d e f
00: -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

 > i2cdetect -q -y 0
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- 54 -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Strangly writing data to the SN3218 works.

Does anyone have an explanation for this error?

Regards
Stefan
