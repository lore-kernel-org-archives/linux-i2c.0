From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-algo-bit: Complain about masters which can't
	read SCL
Date: Wed, 8 Dec 2010 04:01:46 +0000
Message-ID: <20101208040146.GP20097@trinity.fluff.org>
References: <20101207110705.69792a1a@endymion.delvare> <20101207115325.GN20097@trinity.fluff.org> <20101207160739.0d7141f3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101207160739.0d7141f3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 07, 2010 at 04:07:39PM +0100, Jean Delvare wrote:
> Hi Ben,
> 
> On Tue, 7 Dec 2010 11:53:25 +0000, Ben Dooks wrote:
> > On Tue, Dec 07, 2010 at 11:07:05AM +0100, Jean Delvare wrote:
> > > The I2C specification explicitly describes both SDA and SCL as
> > > bidirectional lines. An I2C master with a read-only SCL is thus not
> > > compliant. If a slow slave stretches the clock, errors will happen,
> > > so the bus can't be considered as reliable.

> > > +	if (bit_adap->getscl == NULL) {
> > > +		dev_warn(&adap->dev, "Not I2C compliant: can't read SCL\n");
> > 
> > I'll have a think about wording. I might be able to improve it.
> > 
> > As a note, I always prefer cannot to can't. 
> 
> And I thought you were a busy developer ;)

I've my reasons for this, blame my parents.
 
> There is no trend one way or another, neither in the kernel tree nor
> even in drivers/i2c specifically.

no, just my preference.
 
> > > +		dev_warn(&adap->dev, "Bus may be unreliable\n");
> > 
> > if there are any other warnings, should we print just one unreliable warning
> > at the end of the scan?
> 
> I'm not sure what "scan" you refer to, and in all honesty I'm not sure
> I get your point at all.

ok, looking at the code it isn't important.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
