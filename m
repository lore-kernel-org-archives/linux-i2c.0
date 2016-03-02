From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: RE: [PATCH v3 0/8] i2c mux cleanup and locking update
Date: Wed, 2 Mar 2016 22:55:10 +0000
Message-ID: <d0164db34a634171afa631a3167269b8@EMAIL.axentia.se>
References: <1452265496-22475-1-git-send-email-peda@lysator.liu.se>
 <20160302172904.GC5439@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160302172904.GC5439@katana>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Olli Salonen <olli.salonen-X3B1VOXEql0@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-media@vger.k
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> On Fri, Jan 08, 2016 at 04:04:48PM +0100, Peter Rosin wrote:
> > 
> > Hi!
> > 
> > [doing a v3 even if there is no "big picture" feedback yet, but
> >  previous versions has bugs that make them harder to test than
> >  needed, and testing is very much desired]
> > 
> > I have a pair of boards with this i2c topology:
> > 
> >                        GPIO ---|  ------ BAT1
> >                         |      v /
> >    I2C  -----+------B---+---- MUX
> >              |                   \
> >            EEPROM                 ------ BAT2
> > 
> > 	(B denotes the boundary between the boards)
> > 
> > The problem with this is that the GPIO controller sits on the same i2c bus
> > that it MUXes. For pca954x devices this is worked around by using unlocked
> > transfers when updating the MUX. I have no such luck as the GPIO is a general
> > purpose IO expander and the MUX is just a random bidirectional MUX, unaware
> > of the fact that it is muxing an i2c bus, and extending unlocked transfers
> > into the GPIO subsystem is too ugly to even think about. But the general hw
> > approach is sane in my opinion, with the number of connections between the
> > two boards minimized. To put is plainly, I need support for it.
> > 
> > So, I observe that while it is needed to have the i2c bus locked during the
> > actual MUX update in order to avoid random garbage on the slave side, it
> > is not strictly a must to have it locked over the whole sequence of a full
> > select-transfer-deselect operation. The MUX itself needs to be locked, so
> > transfers to clients behind the mux are serialized, and the MUX needs to be
> > stable during all i2c traffic (otherwise individual mux slave segments
> > might see garbage).
> > 
> > This series accomplishes this by adding code to i2c-mux-gpio and
> > i2c-mux-pinctrl that determines if all involved devices used to update the
> > mux are controlled by the same root i2c adapter that is muxed. When this
> > is the case, the select-transfer-deselect operations should be locked
> > individually to avoid the deadlock. The i2c bus *is* still locked
> > during muxing, since the muxing happens as part of i2c transfers. This
> > is true even if the MUX is updated with several transfers to the GPIO (at
> > least as long as *all* MUX changes are using the i2s master bus). A lock
> > is added to the mux so that transfers through the mux are serialized.
> > 
> > Concerns:
> > - The locking is perhaps too complex?
> > - I worry about the priority inheritance aspect of the adapter lock. When
> >   the transfers behind the mux are divided into select-transfer-deselect all
> >   locked individually, low priority transfers get more chances to interfere
> >   with high priority transfers.
> > - When doing an i2c_transfer() in_atomic() context or with irqs_disabled(),
> >   there is a higher possibility that the mux is not returned to its idle
> >   state after a failed (-EAGAIN) transfer due to trylock.
> > - Is the detection of i2c-controlled gpios and pinctrls sane (i.e. the
> >   usage of the new i2c_root_adapter() function in 8/8)?
> > 
> > To summarize the series, there's some i2c-mux infrastructure cleanup work
> > first (I think that part stands by itself as desireable regardless), the
> > locking changes are in the last three patches of the series, with the real
> > meat in 8/8.
> > 
> > PS. needs a bunch of testing, I do not have access to all the involved hw
> 
> I want to let you know that I am currently thinking about this series.

Glad to hear it!

> There seems to be a second occasion where it could have helped AFAICT.
> http://patchwork.ozlabs.org/patch/584776/ (check my comments there from
> yesterday and today)

The mpu6050 driver has to set muxc->i2c_controlled before adding
any child adapters for anything to behave differently, and it also
has to make sure that all accesses in select/deselect are normal
i2c accesses (i.e. not unlocked accesses). When doing so,
unreleated i2c traffic might interleave with the muxing. So, if
the chip is auto-deselecting on the first i2c transfer after select
it will never work properly.

> First of all, really thank you that you tried to find the proper
> solution and went all the way for it. It is easy to do a fire&forget
> hack here, but you didn't.

Fire&forget often turns out to be just the fire. If you do it properly
there is a better chance that you really can forget it...

> I hope you understand, though, that I need to make a balance between
> features and complexity in my subsystem to have maintainable and stable
> code.
> 
> As I wrote in the mentioned thread already: "However, I am still
> undecided if that series should go upstream because it makes the mux
> code another magnitude more complex. And while this seems to be the
> second issue which could be fixed by that series, both issues seem to
> be corner cases, so I am not sure it is worth the complexity."
> 
> And for the cleanup series using struct mux_core. It is quite an
> intrusive change and, frankly, the savings look surprisingly low. I
> would have expected more, but you never find out until you do it. So, I
> am unsure here as well.

Yes, that part of the series went ballistic when the half-dozen mux
users outside of drivers/i2c was added to the mix (I was originally
not aware of them). The savings looked better when only the i2c-internal
muxes was considered, mainly because the external muxes are often not
real muxes and only have one child adapter. Creating the mux-core for
that one adapter then swallows the savings.

Funnily enough, I was just the other day looking at the series again and
decided to redo those 5 patches so that I first add the new mux core
and implement the old interface in terms of the new interface, then
convert all the mux users one patch at a time, then remove the glue.
That means 15 patches instead of 5, but each patch only touches one
subsystem, which should ease the transition. The end result is
equivalent, I only had to change a few names to make it possible to
have both the old and the new interfaces active at the same time.

In doing so, I realized that what might be good for the non-generic
one-child-only "muxes" is perhaps an interface that creates a mux core
and registers one child adapter with one call?

One other thing that could help the +- statistics is to maybe add more
parameters to i2c_mux_alloc, such as parent adapter and select/deselect
ops. But that is fairly cosmetic...

> I am not decided and open for discussion. This is just where we are
> currently. All interested parties, I am looking forward to more
> thoughts.

Cheers,
Peter
