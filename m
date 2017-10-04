From: Ferry Toth <ftoth@telfort.nl>
Subject: Re: [PATCH v3 0/4] i2c: designware: add i2c gpio recovery option
Date: Wed, 04 Oct 2017 11:41:38 +0200
Message-ID: <1507110098.6358.1.camel@telfort.nl>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
         <1b54a382-c447-2f42-fd00-6a033449d394@electromag.com.au>
         <1506596114.16112.148.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:33216 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdJDJpU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Oct 2017 05:45:20 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gldi-i2c-1@m.gmane.org>)
        id 1dzgEi-0008IJ-Ct
        for linux-i2c@vger.kernel.org; Wed, 04 Oct 2017 11:45:04 +0200
In-Reply-To: <1506596114.16112.148.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org



Andy Shevchenko schreef op do 28-09-2017 om 13:55 [+0300]:
> On Thu, 2017-09-28 at 15:37 +0800, Phil Reid wrote:
> > On 30/08/2017 14:17, Phil Reid wrote:
> > > Changes from V1:
> > > - In review Andy suggested change the i2c core to use the gpiod
> > >    I've added a patch that allows the gradual switching of
> > > drivers
> > >    to using gpiod interface. The old interface is preserved so
> > >    that changes can be made incrementally.
> > > - I've update Tim's patch for the designware driver to use the
> > > new
> > >    interface. Tweaked a couple of things to his patch and fixed
> > >    up things Andy id in last review.
> > >    The core changes in p1 don't require the get/set scl/sda
> > > functions.
> > >    Hopefully I've done the right thing with preserving authorship
> > > and
> > >    signoff.
> 
> +Cc: Ferry.
> 
> Ferry, I think you might be interested in this series.
> If so, perhaps Phil can include you in Cc for v4 of it.

Thanks. I am interested in this, though I may be experiencing a
somewhat different issue.

I my case (Intel Edison on Arduino expansion board) there are 4 MUX
attached to the same i2c bus. On warm boot sometimes the first device
is not detected (as shown by i2c-detect). The 2nd - 4th devices are
detected fine.

It would seem that initially the bus is stuck accessing the first
device and recovers after this. But this is probably not the case, as
on successive warm reboots, the same first device remains undetected.

A cold boot fixes this.

To me that looks like the bus is not stuck, but the particular slave is
in the wrong state. 

I have not yet been able to figure out if this patch series only resets
a device when it holds the bus, or if it also resets a device that
doesn't respond or responds with garbled data, but I will look into it.

Up to now I have not found a reliable way to trigger the situation,
other than noting it seems to happen mostly after a kernel or u-boot
reflash. 

> > > 
> > > Changes from V2:
> > > - Rebase on https://git.kernel.org/pub/scm/linux/kernel/git/wsa/l
> > > inu
> > > x.git/
> > >    i2c/for-next
> > >    No intentional changes, but needed to move
> > > i2c_dw_plat_prepare_clk to common
> > >    for the master recovery functions to use. which is included as
> > > two additional
> > >    patches.
> > > 
> > > 
> > > Phil Reid (4):
> > >    i2c: Switch to using gpiod interface for gpio bus recovery
> > >    i2c: designware: move i2c_dw_plat_prepare_clk to common
> > >    i2c: designware: rename i2c_dw_plat_prepare_clk to
> > > i2c_dw_prepare_clk
> > > 
> > > Tim Sander (1):
> > >    i2c: designware: add i2c gpio recovery option
> > > 
> > >   drivers/i2c/busses/i2c-designware-common.c  | 24 ++++++++++--
> > >   drivers/i2c/busses/i2c-designware-core.h    |  2 +
> > >   drivers/i2c/busses/i2c-designware-master.c  | 57
> > > +++++++++++++++++++++++++++++
> > >   drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++-------
> > >   drivers/i2c/i2c-core-base.c                 | 22 +++++++++--
> > >   include/linux/i2c.h                         |  2 +
> > >   6 files changed, 103 insertions(+), 22 deletions(-)
> > > 
> > 
> > Any comments on this series?
> > 
> 
> 
