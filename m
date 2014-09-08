From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Diolan DLN-2 devices
Date: Mon, 8 Sep 2014 15:45:32 +0200
Message-ID: <20140908134532.GC9560@localhost>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
 <1409930279-1382-2-git-send-email-octavian.purdila@intel.com>
 <20140908113233.GA9560@localhost>
 <CAE1zotL3rKb3ayjgp0DbTr-a9xAhEJk6ybdqGEzg3UtuBUKWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotL3rKb3ayjgp0DbTr-a9xAhEJk6ybdqGEzg3UtuBUKWMw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 08, 2014 at 04:20:34PM +0300, Octavian Purdila wrote:
> On Mon, Sep 8, 2014 at 2:32 PM, Johan Hovold <johan@kernel.org> wrote:

> > > +static bool find_free_slot(struct dln2_mod_rx_slots *rxs, int *slot)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&rxs->lock, flags);
> > > +
> > > +     *slot = find_first_zero_bit(&rxs->bmap, DLN2_MAX_RX_SLOTS);
> > > +
> > > +     if (*slot < DLN2_MAX_RX_SLOTS) {
> > > +             struct dln2_rx_context *rxc = &rxs->slots[*slot];
> > > +
> > > +             init_completion(&rxc->done);
> >
> > Initialise the completions when you allocate them (and there's no need
> > to re-init here).
> 
> You are right, but I think we need a reinit_completion(). Technically
> we don't, as we don't use complete_all(), but I feel it is cleaner
> that way. I will move the initialization in probe and add the
> reinit_completion() in free_rx_slot. Is that OK with you?

Sure, that's fine. 

Johan
