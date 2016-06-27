From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Sensor with 7 bit address above 0x77
Date: Mon, 27 Jun 2016 13:39:45 +0200
Message-ID: <17002e23-eaf4-125c-9402-4def2bf13e51@sigma-star.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbcF0LkJ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jun 2016 07:40:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sigma-star.at (Postfix) with ESMTP id 716C416B4335
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jun 2016 13:40:06 +0200 (CEST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Richard Weinberger <richard@sigma-star.at>

Hi!


I have an issue with a recently purchased I2C sensor that (according to the manufacturer) responds
to bus address 0x78.

The i2c-tools program i2cdetect only displays addresses in the range 0x03 to 0x77 and i2cdump
complains that the address is out of range.

Since 0x77 seems pretty arbitrary and strange for a hardware limit (0 bit right in the center),
I assumed that the remaining 8 addresses above 0x77 might be reserved for some special use and
started digging around in the documentation.


Both programs mention the limitations in their manpages but give *no explanation* on why they
exist or where those special values came from. i2cdetect seems to have a switch to override
this behaviour, but i2cdump doesn't.

I found no mentioning of the magic limits in the uapi headers. In fact, a quick git grep revealed
that the i2c-tools are sprinkled with *hard-coded* address range checks.


I found no mentioning in the kernel documentation either. A quick git grep in the kernel source
lead me to i2c-core.c:897 (i2c_check_7bit_addr_validity_strict) where yet another hard-coded
address check is performed.

The comment above the line states that addresses 0x78-0x7b are used for 10-bit slave
addressing. The documentation on 10-bit slave addressing (Documentation/i2c/ten-bit-addresses)
says "...The leading 0xa (= 10) represents the 10 bit mode...". Wouldn't such an address
on the bus be quite problematic as 0xA has a leading 1 bit (read/write select?).

After a quick search on the mailing list, I found a number of messages regarding 10 bit addresses,
mentioning _completely_ different address ranges for mapping 10 bit addresses.


Since I don't have 10 bit addressed devices on the bus anyway (or anywhere else in the entire
building), is there some magic ioctl that I can use to access them? According to the docs,
I2C_TENBIT is already off by default?

Is there a specific reason I can override i2cdetect but not i2cdump?


Thanks,

David
