From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on SB800
Date: Sun, 24 Jan 2016 13:07:03 +0100
Message-ID: <56A4BE67.2090308@assembler.cz>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
 <20160122135040.6db7b66b@endymion.delvare> <56A3846F.9000908@googlemail.com>
 <20160124101657.7aa42eb9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ms.trustica.cz ([82.208.32.68]:51481 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbcAXMNo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 24 Jan 2016 07:13:44 -0500
In-Reply-To: <20160124101657.7aa42eb9@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, fetzerch <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

Hi Jean,

> One thing that bothers me is that pins for SMBus ports may be shared
> with other functions. The "AMD SB810/850 Southbridge Databook" document
> shows that all SMBus ports are shared with at least GPIOs and port 4
> also with PS/2 function. Unfortunately I can't find any document
> explaining how to check which function is assigned to each pin.

Well it is quite easy, you need to check IOMUX register for specific pin.

The base address "AcpiMMioAddr" is defined in PM_reg x24, with the default base
address at "FED8_0000"

See 2.3.7 IoMux Registers

PS2_CLK/SCL4/ GPIO188

The function 0 is PS2_CLIK function1 is SCL4 and GPIO188 is fun2, so all you
need is to check it at "AcpiMMioAddr" + 0xd00 + 188 (8 bit register)
bits 1:0 encode it. 00 - function 0 etc...

Btw similar functionality is also on later SBs of AMD, I have an hudson system,
so we can add the support for it later, when SB800 is done. I think it follows
same patern, maybe the GPIOs will be different.

Thanks
Rudolf
