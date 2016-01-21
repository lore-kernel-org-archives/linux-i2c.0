From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Thu, 21 Jan 2016 15:12:45 +0100
Message-ID: <20160121151245.6f072341@endymion.delvare>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
	<20151010074547.GD1619@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49119 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965265AbcAUOM5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Jan 2016 09:12:57 -0500
In-Reply-To: <20151010074547.GD1619@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com

Hi Wolfram, Christian,

On Sat, 10 Oct 2015 08:45:49 +0100, Wolfram Sang wrote:
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

Christian, is the problem still present with the latest version of the patches?

> > Please review and let me know required changes in order to get this upstream
> > finally.
> > 
> > Eddi, Thomas, it would be great if you could verify the changes on your
> > machines.
> > 
> > Regards,
> > Christian
> > 
> > Christian Fetzer (4):
> >   i2c-piix4: Optionally release smba in piix4_adap_remove
> >   i2c-piix4: Convert piix4_main_adapter to array
> >   i2c-piix4: Add support for multiplexed main adapter in SB800
> >   i2c-piix4: Add adapter port name support for SB800 chipset
> > 
> >  drivers/i2c/busses/i2c-piix4.c | 151 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 134 insertions(+), 17 deletions(-)
> 
> Jean, is that on your list?

Very sorry, I intended to reply to thins but let it slip through :(

Now I see the patches have been reviewed multiple times and merged for
kernel v4.5. I looked at the code and suspect there are issues which
need to be fixed. But I would like to read the previous reviews to make
sure I'm not missing something...

Wolfram, would you be kind enough to put all the previous versions of
the patch set and their reviews into a single mbox file and send that
to me? So I can understand the reasons behind the current code.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
