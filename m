From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
 naming
Date: Mon, 18 Nov 2013 09:14:23 -0800
Message-ID: <20131118171423.GA16823@roeck-us.net>
References: <5287B9E4.1020107@roeck-us.net>
 <20131116214116.3d035b76@endymion.delvare>
 <20131116214318.1d101d35@endymion.delvare>
 <20131117185624.GA23639@roeck-us.net>
 <20131117214102.236ae09a@endymion.delvare>
 <52893187.3000600@roeck-us.net>
 <20131118151441.0ad2b5d8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131118151441.0ad2b5d8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 18, 2013 at 03:14:41PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 17 Nov 2013 13:13:43 -0800, Guenter Roeck wrote:
> > On 11/17/2013 12:41 PM, Jean Delvare wrote:
> > > On Sun, 17 Nov 2013 10:56:24 -0800, Guenter Roeck wrote:
> > >> This retains the old mux name if the mux is not an i2c device, and adds
> > >> the i2c device address if it is. This solves the problem for me.
> > >>
> > >> Comments ?
> > >
> > > This "for me" worries me a bit. You basically restored the uniqueness
> > > for the multiple I2C-based multiplexer case. But for multiple
> > > GPIO-based multiplexers, for example, the name confusion still exists.
> > 
> > Only if some genius connects multiple separate gpio based multiplexers
> > to the same bus.
> 
> This is totally possible, for a variety of reasons, including physical
> location of the GPIO pins and bus segment ends, but also economical
> (using the same chips on several boards.)
> 
Ok.

> > In practice, though, that can be modeled as single
> > gpio mux with more pins, so I didn't think that is that much of a problem.
> 
> I admit I had not considered this. But would it work if the different
> GPIO pins are on different chips (say south bridge and Super-I/O for
> example)? The i2c-mux-gpio driver assumes a single chip, at least when
> passed by name.
> 
... so you could or should not pass a name if that is the case.

> > > If we are going to address this problem, I believe we should do so in a
> > > way which doesn't need revisiting in a couple months. You are changing
> > > adapter names people or tools may be relying on, we really don't want
> > > to do this too often.
> >
> > Good point. One possible solution might be to add the mux type into the name.
> > 	i2c-2-mux-i2c-76 (chan_id 0)
> > 	i2c-2-mux-gpio-77 (chan_id 0)
> 
> Yes, that's pretty much what I had in mind.
> 
> > We could add an additional parameter to the API, such as
> > 	const char *qualifier
> > to provide the "i2c-76" or "gpio-77" string. If the qualifier is NULL,
> > the name would revert to the old naming scheme. Would that make sense ?
> 
> Yes, although your first draft gave me some hope that i2c-mux could do
> some magic to guess the type and identifier automatically. But maybe
> it's not that clean to have to touch i2c-mux for every new i2c-mux-*
> driver. Not that I expect too many of them... so it's mostly a matter
> of principle. An explicit qualifier as you suggest above might be
> cleaner.
> 
Another option would be to use the patch I provided, except to create
names such as i2c-2-mux-i2c-76. The API change could then be added later
if/as needed.

But, yes, an API change would be cleaner. Before I submit a "final" patch,
it would be great to get feedback and direcetion from Wolfram ... after all,
he'll have to approve it at the end.

Thanks,
Guenter
