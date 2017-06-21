From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Wed, 21 Jun 2017 09:18:43 +0200
Message-ID: <20170621091843.657de813@endymion>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
 <20170619103002.5d502c92@endymion>
 <20170620172810.h2anac45n5u3oova@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170620172810.h2anac45n5u3oova@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 20 Jun 2017 19:28:10 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> > > +		bool did_stop = false;  
> > 
> > I'm pretty certain you want to declare and initialize this variable
> > outside the loop.  
> 
> Why? Well, it doesn't matter anymore but what is wrong with limiting the
> variable like this?

There's no problem with the scope. The problem is with the
initialization. The way you did, did_stop gets reset to false with
every iteration, which isn't what you want.

> > (...)
> > 1* Repeated start happens between messages of a same transaction, and
> > you handle that case above. However in the case of 10-bit address
> > clients, there is also a repeated start happening during the address
> > phase of the transaction, if the first message is a read. Did you check
> > what the SCCB protocol expects in that case?  
> 
> SCCB defines addresses to be 7 bit.

I looked at how 10-bit addressing works again and in fact it is simply
impossible to not use repeated start when reading from a 10-bit address
slave. Only the first 2 bits of the 10-bit address are repeated in the
read part of the transaction. If there was a stop between the two parts
then there would be no way to know which 10-bit slave should send the
data.

> > (...)
> > --- linux-4.11.orig/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 09:57:17.949074198 +0200
> > +++ linux-4.11/drivers/i2c/algos/i2c-algo-bit.c	2017-06-19 10:23:26.711088536 +0200
> > @@ -553,8 +553,17 @@ static int bit_xfer(struct i2c_adapter *
> >  		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
> >  		if (!(pmsg->flags & I2C_M_NOSTART)) {
> >  			if (i) {
> > -				bit_dbg(3, &i2c_adap->dev, "emitting "
> > -					"repeated start condition\n");
> > +				if (msgs[i - 1].flags & I2C_M_STOP) {
> > +					bit_dbg(3, &i2c_adap->dev,
> > +						"emitting enforced stop condition\n");
> > +					i2c_stop(adap);
> > +					bit_dbg(3, &i2c_adap->dev,
> > +						"emitting start condition\n");
> > +					i2c_start(adap);
> > +				}  
> 
> else

Oops. Right, fixed, thanks.

> 
> > +
> > +				bit_dbg(3, &i2c_adap->dev,
> > +					"emitting repeated start condition\n");
> >  				i2c_repstart(adap);
> >  			}
> >  			ret = bit_doAddress(i2c_adap, pmsg);  
> 
> A lot better! I like it very much. And also
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Do you want to cook up a patch or shall I? I'd just need a SoB then.

I'll send a proper patch shortly.

> Thanks for the improvement!

You're welcome.

-- 
Jean Delvare
SUSE L3 Support
