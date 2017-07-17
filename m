From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] wire: export w1_touch_bit
Date: Mon, 17 Jul 2017 16:47:56 +0200
Message-ID: <20170717144756.GA22531@kroah.com>
References: <4aa9d196-1e31-de86-4ba7-752a0a04122c@gmx.de>
 <478401499958799@web19g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <478401499958799@web19g.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Jan Kandziora <jjj@gmx.de>, LKML <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 13, 2017 at 06:13:19PM +0300, Evgeniy Polyakov wrote:
> Hi Jan, Greg
> 
> 11.07.2017, 02:00, "Jan Kandziora" <jjj@gmx.de>:
> > Changes in v4 against v3 in this subpatch:
> >   - adapted to linux-4.12.0
> >
> > No changes in v3 against v2,v1 in this subpatch.
> >
> > The w1_ds28e17 driver from the next part of this patch needs to emit
> > single-bit read timeslots to the DS28E17. The w1 subsystem already
> > has this function but it is not exported outside drivers/w1/w1_io.c
> >
> > This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
> > same as the other exported symbols in drivers/w1/w1_io.c
> >
> > May be also useful later for writing drivers for other Onewire chips
> > which do single-bit communication.
> >
> > Signed-off-by: Jan Kandziora <jjj@gmx.de>
> 
> Greg, please pull this patchset into the tree, I missed it last time and it stuck in the queues for a too long.
> Thank you.
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

This is in no format that I can apply, sorry.

Jan, can you resend it in a correct format?

thanks,

greg k-h
