From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] i2c-piix4: Support alternative port selection
 register
Date: Mon, 15 Feb 2016 18:30:14 +0100
Message-ID: <20160215183014.15fd063e@endymion>
References: <20160129104146.50f06562@endymion.delvare>
	<20160129104452.05e94c08@endymion.delvare>
	<20160212192720.GQ1520@katana>
	<20160213225147.26c64bbf@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34516 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbcBORaR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 15 Feb 2016 12:30:17 -0500
In-Reply-To: <20160213225147.26c64bbf@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>

On Sat, 13 Feb 2016 22:51:47 +0100, Jean Delvare wrote:
> Hi Wolfram,
> 
> On Fri, 12 Feb 2016 20:27:20 +0100, Wolfram Sang wrote:
> > On Fri, Jan 29, 2016 at 10:44:52AM +0100, Jean Delvare wrote:
> > > The SB800 register reference guide says that the SMBus port selection
> > > bits may not always be in register Smbus0En (0x2c) but could
> > > alternatively be found in register Smbus0Sel (0x2e) depending on the
> > > settings in register Smbus0SelEn (0x2f.) Add support for this
> > > configuration.
> > 
> > Were you able to test both cases?
> 
> I don't have the hardware myself so I was not able to test any case.
> I was hoping Christian would test. This is the reason why I am logging
> which register is used, so that we know if the alternative setting is
> ever used. I found the potential problem by looking at the datasheet,
> it's not something that has been reported (yet.)
> 
> Meanwhile I have found a datasheet for device 780Bh (named Bolton FCH
> on AMD's web site, but Hudson2 in our driver) which suggest that the
> "alternative" setting is the only possible one on this chipset. The
> register used to figure out the setting is marked as reserved. If the
> register exists still and the relevant bit is set, then my patch should
> work. If not then a better patch will be needed.
> 
> I'll try to gain access to a system with a Bolton FCH and experiment
> with it.

I have access to a Bolton FCH system for one week. I tested the port
selection and as the datasheet suggested, the "alternative" register is
always used on this chipset. Register Smbus0SelEn (0x2f) doesn't exist
so the code I submitted doesn't work for this chipset. After
unconditionally using 0x2e for port selection, the driver seems to work
fine, except that sensors-detect just hung the machine when probing
SMBus port 2 address 0x2f (and it's 1200 km away from me and I can't
reboot it, yay.) That could be a driver issue or (more likely) just
another case of I2C/SMBus device that hates being probed and hangs the
system for reprisal.

> Then there's the most recent device, codenamed "CZ", for which I have
> no information at all.

Still looking into that as well, trying to get my hands on both the
documentation and the hardware. I would bet that it works the same as
the Hudson2/Bolton, but if I can verify that it would be safer.

-- 
Jean Delvare
SUSE L3 Support
