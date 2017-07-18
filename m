From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] wire: export w1_touch_bit (RESEND: line breaks
 fixed, I hope.)
Date: Tue, 18 Jul 2017 07:00:26 +0200
Message-ID: <20170718050026.GB6176@kroah.com>
References: <b68811cc-58f3-d217-642d-2ddb16154910@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b68811cc-58f3-d217-642d-2ddb16154910@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 18, 2017 at 12:53:14AM +0200, Jan Kandziora wrote:
> Changes in v4 against v3 in this subpatch:
>   - adapted to linux-4.12.0
> 
> No changes in v3 against v2,v1 in this subpatch.

All of that needs to go below the --- line.

And your subject needs to be fixed.  I should not have to edit anything
in a patch by hand in order to apply it.

> 
> The w1_ds28e17 driver from the next part of this patch needs to emit
> single-bit read timeslots to the DS28E17. The w1 subsystem already
> has this function but it is not exported outside drivers/w1/w1_io.c
> 
> This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
> same as the other exported symbols in drivers/w1/w1_io.c
> 
> May be also useful later for writing drivers for other Onewire chips
> which do single-bit communication.
> 
> 
> Signed-off-by: Jan Kandziora <jjj@gmx.de>
> ---
> >From 6aedd1b890bd77bfe788f6af7a38724c16934ab0 Mon Sep 17 00:00:00 2001
> From: Jan Kandziora <jjj@gmx.de>
> Date: Sat, 8 Jul 2017 21:14:27 +0200
> Subject: [PATCH 1/2] wire: export w1_touch_bit


Why is this all here?

And where is patch 2/2?

Please fix and resend the whole series.

thanks,

greg k-h
