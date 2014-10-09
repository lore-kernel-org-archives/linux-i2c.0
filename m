From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/4] mfd: add support for Diolan DLN-2 devices
Date: Thu, 9 Oct 2014 15:16:36 +0200
Message-ID: <20141009131636.GO1990@localhost>
References: <1411661254-5204-1-git-send-email-octavian.purdila@intel.com>
 <1411661254-5204-2-git-send-email-octavian.purdila@intel.com>
 <20141008092347.GB1990@localhost>
 <CAE1zotKHq1Fj_AqKzfnBHoypetb6Yz3OsHnqfeHN5PrVJtuHVw@mail.gmail.com>
 <20141008120410.GE1990@localhost>
 <CAE1zot+muJn5ngxpq8LeF9J+7kZqCiStzvcxLLP0wf08TjWG4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zot+muJn5ngxpq8LeF9J+7kZqCiStzvcxLLP0wf08TjWG4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 08, 2014 at 03:33:28PM +0300, Octavian Purdila wrote:
> On Wed, Oct 8, 2014 at 3:04 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, Oct 08, 2014 at 01:54:07PM +0300, Octavian Purdila wrote:
> >> On Wed, Oct 8, 2014 at 12:23 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> > On Thu, Sep 25, 2014 at 07:07:31PM +0300, Octavian Purdila wrote:
> >> >
> >> >> +static void dln2_rx_transfer(struct dln2_dev *dln2, struct urb *urb,
> >> >> +                          u16 handle, u16 rx_slot)
> >> >> +{
> >> >> +     struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
> >> >> +     struct dln2_rx_context *rxc;
> >> >> +     struct device *dev = &dln2->interface->dev;
> >> >> +
> >> >> +     spin_lock(&rxs->lock);
> >> >
> >> > You must use spin_lock_irqsave here as you call it from the completion
> >> > handler.
> >>
> >> Why? AFAICS the completion handler gets called from the HCD irq handler:
> >
> > The completion handler is currently called with local interrupts
> > disabled but that is about to change once all drivers have been updated:
> >
> >         http://marc.info/?l=linux-usb&m=137353360511003&w=2
> >
> > In this case you could probably get away with not disabling interrupts
> > anyway, but using the irqsave versions would make it obvious.
> >
> 
> I was not assuming that interrupts are disabled while running the
> completion handler. Since that spinlock is not touched by any other
> interrupt context code I don't think irqsave is necessary.

No, it isn't necessary so leave it as it is.

But you are exporting interfaces to other drivers and it may appear to
someone that those could possibly end up indirectly calling a function
taking that lock in IRQ context. We know that isn't the case now, but I
bet someone will post conversion patch for that spinlock at some point.
;)

Johan
