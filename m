From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/4] mfd: add support for Diolan DLN-2 devices
Date: Fri, 10 Oct 2014 11:14:34 +0200
Message-ID: <20141010091434.GB12494@localhost>
References: <1412882541-10934-1-git-send-email-octavian.purdila@intel.com>
 <1412882541-10934-2-git-send-email-octavian.purdila@intel.com>
 <1412883877.2975.26.camel@joe-AO725>
 <CAE1zotJTQATJkTQinnWOg=NJbG+SWzNNdgB2uVEJgubnhtyXbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotJTQATJkTQinnWOg=NJbG+SWzNNdgB2uVEJgubnhtyXbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 09, 2014 at 11:27:12PM +0300, Octavian Purdila wrote:
> On Thu, Oct 9, 2014 at 10:44 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> > On Thu, 2014-10-09 at 22:22 +0300, Octavian Purdila wrote:

> >> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > []
> > +struct dln2_mod_rx_slots {
> > +       /* RX slots bitmap */
> > +       unsigned long bmap;
> >
> > Probably better as:
> >         DECLARE_BITMAP(bmap, DLN2_MAX_RX_SLOTS);
> >
> > Then a lot of &ptr->bmap uses can be ptr->bmap
> >
> 
> Originally I was using DECLARE_BITMAP, but during the review process
> Johan suggested to use unsigned long. Now that I think about it, it
> sounds better to use DECLARE_BITMAP and of couse keep using
> find_first_bit, set_bit, etc. Johan do you see any issue with that?

No, that's fine as long as you keep the bitops.

> >> +struct dln2_dev {
> >> +     struct usb_device *usb_dev;
> >> +     struct usb_interface *interface;
> >> +     u8 ep_in;
> >> +     u8 ep_out;
> >> +
> >> +     struct urb *rx_urb[DLN2_MAX_URBS];
> >> +     void *rx_buf[DLN2_MAX_URBS];
> >> +
> >> +     struct dln2_mod_rx_slots mod_rx_slots[DLN2_HANDLES];
> >> +
> >> +     struct list_head event_cb_list;
> >> +     spinlock_t event_cb_lock;
> >> +
> >> +     bool disconnect;
> >> +     int active_transfers;
> >> +     wait_queue_head_t disconnect_wq;
> >> +     spinlock_t disconnect_lock;
> >> +};
> >
> > Maybe reorder the bools and u8s to pack this a bit better?
> 
> I prefer to keep it this way, it's not wasting a lot since you will
> only have a handful of these devices, and it keeps the related data
> together.

I agree.

Johan
