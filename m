From: Michael Berger <mikeaberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unable to access I2C device behind two muxes configured to deselect.
Date: Wed, 17 Jun 2015 14:04:36 -0400
Message-ID: <CAArnDZnbqsFpa-1-OmnbhykFP9rc-P8oq8uOHSn82EAtwx4org@mail.gmail.com>
References: <CAArnDZ=WNAOHzxxPPfW+=OLgE6oSifsjWo9qu++Jo+5T4CA_xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAArnDZ=WNAOHzxxPPfW+=OLgE6oSifsjWo9qu++Jo+5T4CA_xw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 17, 2015 at 8:23 AM, Michael Berger <mikeaberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I cannot access an I2C device located behind two or more nested
> PCA9545 muxes if the muxes are configured to use a deselect function.
> ...
> Address 0x50 --- At this point I see an error/NACK with the SDA
> floating high and the SCLK staying low.  I would have thought that the
> second write of 0x08 to address 0x71 would (re-)select the correct
> path through the top mux, but that isn't happening and I don't have a
> good explanation for it.  This behaviour is 100% reproducible on my
> system.

I removed all other I2C devices from the bus in question - I also had
several SMBUS devices and several GPIO I/O expanders on the same bus
running through the same top two muxes.  I did not think they were
relevant to the problem, so I did not mention them in my OP.

After removing all the other devices, leaving only the four PCA9545
muxes and eight at24 EEPROMS running in isolation, the mux
selects/deselects are performing correctly.  The method for
deselecting the muxes was not immediately obvious to me since it was
my bus that was misbehaving.  But now that I can see an entire
operation from start to finish, I now understand how the deselecting
of nested muxes works and see that it is correct.  It does not matter
what order the muxes are deselected since all muxes above the mux
being deselected are explicitly selected/deselected to establish the
path to the mux to be deselected.  It's much easier to understand when
you watch it on an analyzer.

So, I must look further into the interactions with the other devices
on the bus to determine why my bus misbehaves shortly after boot - the
SCLK is being held low by something beyond the top mux.

Regards, Mike
