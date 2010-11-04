From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC/PATCH] i2c/busses: Add support for Diolan U2C-12 USB/I2C
 adapter
Date: Thu, 4 Nov 2010 21:18:07 +0100
Message-ID: <20101104211807.07a55104@endymion.delvare>
References: <1288830389-13873-1-git-send-email-guenter.roeck@ericsson.com>
	<20101104134314.7928cd85@endymion.delvare>
	<1288888902.22931.165.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288888902.22931.165.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Thu, 4 Nov 2010 09:41:42 -0700, Guenter Roeck wrote:
> On Thu, 2010-11-04 at 08:43 -0400, Jean Delvare wrote:
> > I'm also unsure what is the point of having such a large buffer when
> > the largest block you ever transfer in practice is 5 bytes?
>
> I took that from the Diolan code. They always use a 257 byte temp
> buffer, since that is the maximum data size sent by the adapter. 
> You are right, I should not really need that since I don't send any long
> commands. Ultimate reason is to account for possible adapter errors, if
> it replies (or tries to reply) with more bytes than expected. Pretty
> much just playing safe.

Which commands are they using, which require such a large buffer? In
your driver, bytes are all processed one by one, which is certainly not
good performance-wise. If there is a way to read or write mode than one
byte at a time, this would be worth a try.

> > (...)
> > BTW, I'm not sure why you don't use the original buffer directly?
> > memcpy is bad performance-wise.
>
> To account for the possibility that the adapter returns more bytes than
> I am expecting. Sure, that would be a bug, but I wanted to play safe.

Hmm, OK, that makes sense.

> > (...)
> > Should be -EPROTO according to Documentation/i2c/fault-codes.
>
> Ok. Note that I got that from i2c-algo-bit.c.

I would welcome a patch fixing this.

> > > (...)
> > > +static u32 usb_func(struct i2c_adapter *a)
> > > +{
> > > +     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> > > +         I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> > 
> > Odd indentation/alignment.
>
> Seems to be exactly what other drivers do, so I am a bit at loss here.

Really? Using 4 spaces for indentation is wrong. Either use a tab, or
align using 7 spaces.

> > (...)
> > You are abusing algo_data here. You are supposed to use
> > i2c_get/set_adapdata() instead. algo_data is only there for providing
> > platform specific implementation details to generic i2c algorithms such
> > as i2c-algo-bit.
>
> Copied from i2c-tiny-usb.c. I didn't really think about it. Fixed.

I take patches ;)

-- 
Jean Delvare
