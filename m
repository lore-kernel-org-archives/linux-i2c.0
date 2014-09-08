From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Diolan DLN-2 devices
Date: Mon, 8 Sep 2014 16:20:34 +0300
Message-ID: <CAE1zotL3rKb3ayjgp0DbTr-a9xAhEJk6ybdqGEzg3UtuBUKWMw@mail.gmail.com>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
	<1409930279-1382-2-git-send-email-octavian.purdila@intel.com>
	<20140908113233.GA9560@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140908113233.GA9560@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 8, 2014 at 2:32 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Fri, Sep 05, 2014 at 06:17:57PM +0300, Octavian Purdila wrote:
> > This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
> > Master Adapter DLN-2. Details about the device can be found here:
> >
<snip>
>
> First of all, this is much cleaner than the first non-MFD version. I'll
> have a look at the subdrivers shortly as well.
>

Hi Johan,

I have addressed all you comments except one, please see bellow. I
will wait for the review on the subdrivers before submitting a new
version of the patch set. Thanks for for review !

<snip>
> > +static bool find_free_slot(struct dln2_mod_rx_slots *rxs, int *slot)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&rxs->lock, flags);
> > +
> > +     *slot = find_first_zero_bit(&rxs->bmap, DLN2_MAX_RX_SLOTS);
> > +
> > +     if (*slot < DLN2_MAX_RX_SLOTS) {
> > +             struct dln2_rx_context *rxc = &rxs->slots[*slot];
> > +
> > +             init_completion(&rxc->done);
>
> Initialise the completions when you allocate them (and there's no need
> to re-init here).
>

You are right, but I think we need a reinit_completion(). Technically
we don't, as we don't use complete_all(), but I feel it is cleaner
that way. I will move the initialization in probe and add the
reinit_completion() in free_rx_slot. Is that OK with you?
