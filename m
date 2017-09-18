From: GregKH <greg@kroah.com>
Subject: Re: [PATCH v4 1/2] wire: export w1_touch_bit
Date: Mon, 18 Sep 2017 21:37:45 +0200
Message-ID: <20170918193745.GA22439@kroah.com>
References: <20170918130346.3886-1-jjj@gmx.de>
 <20170918141929.GA10178@kroah.com>
 <642d1ff1-57ff-71ee-a516-c6028dd1d1c2@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51193 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbdIRThe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Sep 2017 15:37:34 -0400
Content-Disposition: inline
In-Reply-To: <642d1ff1-57ff-71ee-a516-c6028dd1d1c2@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, Linux-I2C <linux-i2c@vger.kernel.org>

On Mon, Sep 18, 2017 at 09:34:27PM +0200, Jan Kandziora wrote:
> Am 18.09.2017 um 16:19 schrieb GregKH:
> > On Mon, Sep 18, 2017 at 03:03:45PM +0200, Jan Kandziora wrote:
> >> The w1_ds28e17 driver from the next part of this patch needs to emit
> >> single-bit read timeslots to the DS28E17. The w1 subsystem already
> >> has this function but it is not exported outside drivers/w1/w1_io.c
> >>
> >> This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
> >> same as the other exported symbols in drivers/w1/w1_io.c
> >>
> >> May be also useful later for writing drivers for other Onewire chips
> >> which do single-bit communication.
> >>
> >> Signed-off-by: Jan Kandziora <jjj@gmx.de>
> >> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> >> ---
> >> Changes in v4 against v3 in this subpatch:
> >>   - adapted to linux-4.12.0
> >>
> >> No changes in v3 against v2,v1 in this subpatch.
> > 
> > You should change it as it does not apply to 4.14-rc1 :(
> > 
> Okay, I will review them again.
> 
> 
> > Please rebase your patches and resend them, with Evgeniy's acks added to
> > them.
> > 
> Now you caught me. I don't know how to do that. What's required? The
> Acked-by: line? Am I allowed to simply add these lines to my patches or
> is there a procedure to follow?

Just add the acked-by line, like I did above, and all should be fine.

thanks,

greg k-h
