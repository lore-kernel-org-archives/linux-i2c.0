From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Thu, 17 Jul 2014 10:57:49 -0700
Message-ID: <20140717175749.GA25303@roeck-us.net>
References: <20140713171717.25497712@endymion.delvare>
 <20140717172720.GE2901@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140717172720.GE2901@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 17, 2014 at 07:27:20PM +0200, Wolfram Sang wrote:
> On Sun, Jul 13, 2014 at 05:17:17PM +0200, Jean Delvare wrote:
> > I2C block transfers can have a size up to 32 bytes. If starting close
> 
> Shouldn't that be "256 bytes"? 32 is SMBUS transfer size? Otherwise I
> don't understand the patch.
> 
If I understand correctly, this is still an SMBus command, which is limited
to 32 bytes. Maybe the description should read "SMBus I2C block transfers ...".

Guenter


> > to the end of the address space, there may not be enough room to write
> > that many bytes (on I2C block writes) or not enough bytes to be read
> > (on I2C block reads.) In that case, we must shorten the transfer so
> > that it does not exceed the address space.
> > 
> > Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-stub.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- linux-3.16-rc4.orig/drivers/i2c/i2c-stub.c	2014-07-12 11:56:30.933096483 +0200
> > +++ linux-3.16-rc4/drivers/i2c/i2c-stub.c	2014-07-13 17:01:02.891235856 +0200
> > @@ -220,6 +220,8 @@ static s32 stub_xfer(struct i2c_adapter
> >  		 * We ignore banks here, because banked chips don't use I2C
> >  		 * block transfers
> >  		 */
> > +		if (data->block[0] > 256 - command)	/* Avoid overrun */
> > +			data->block[0] = 256 - command;
> >  		len = data->block[0];
> >  		if (read_write == I2C_SMBUS_WRITE) {
> >  			for (i = 0; i < len; i++) {
> > 
> > 
> > -- 
> > Jean Delvare
> > SUSE L3 Support
