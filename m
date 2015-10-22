From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Thu, 22 Oct 2015 11:27:55 +0300
Message-ID: <20151022082755.GK1526@lahna.fi.intel.com>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
 <20151020151935.GH5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30803 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbbJVI17 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 04:27:59 -0400
Content-Disposition: inline
In-Reply-To: <20151020151935.GH5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com

On Tue, Oct 20, 2015 at 05:19:35PM +0200, Wolfram Sang wrote:
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

Unfortunately I don't have hardware this old to test on :-/
