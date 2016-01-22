From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Fri, 22 Jan 2016 13:07:58 +0100
Message-ID: <20160122130758.420ba5d2@endymion.delvare>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
	<20151020151935.GH5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40585 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbcAVMIB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jan 2016 07:08:01 -0500
In-Reply-To: <20151020151935.GH5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 20 Oct 2015 17:19:35 +0200, Wolfram Sang wrote:
> On Tue, Aug 25, 2015 at 01:05:01PM +0200, Christian Fetzer wrote:
> > This is an attempt to upstream the patches created by Thomas Brandon and
> > Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
> > chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757.html)
> > 
> > I have mainly rebased the latest patch version and tested the driver on a
> > HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor data
> > from a w83795adg).
> > 
> > The patched driver is running stable on the machine, given that ic2_piix4 is
> > loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
> > sensors triggers some errors:
> >     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> > 
> > While the kernel log shows:
> >     i2c i2c-1: Transaction (pre): CNT=0c, CMD=05, ADD=31, DAT0=03, DAT1=c0
> >     i2c i2c-1: Error: no response!
> >     i2c i2c-1: Transaction (post): CNT=0c, CMD=05, ADD=31, DAT0=ff, DAT1=ff
> > Unfortunately I don't know how to tackle this specific issue.
> > 
> > Please review and let me know required changes in order to get this upstream
> > finally.
> > 
> > Eddi, Thomas, it would be great if you could verify the changes on your
> > machines.
> 
> Yes, additional tests are always good for a patch series
> 
> Asking the Intel guys for help, I have not much expierence with x86
> platforms... Mika, Jarkko, Andy any chance to help?

JFYI... The i2c-piix4 driver was originally for Intel hardware, however
for many many years now Intel has moved to i2c-i801 and the only recent
hardware supported by the i2c-piix4 driver is from AMD. So if you want
to bother a hardware vendor with this driver, that should be AMD, not
Intel.

-- 
Jean Delvare
SUSE L3 Support
