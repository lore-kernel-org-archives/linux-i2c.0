From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] ds2782 battery gas gauge driver
Date: Wed, 24 Jun 2009 18:18:34 +0400
Message-ID: <20090624141834.GA9035@oksana.dev.rtsoft.ru>
References: <4A371CDF.3070407@bluewatersys.com> <20090617110908.17b47a18@hyperion.delvare>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090617110908.17b47a18-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 17, 2009 at 11:09:08AM +0200, Jean Delvare wrote:
> Hi Ryan,
> 
> On Tue, 16 Jun 2009 16:17:35 +1200, Ryan Mallon wrote:
> > Add support for the the ds2782 standalone I2C gas-gauge.
> > 
> > Signed-off-by: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
> 
> I suggest you send this patch to the maintainers of the power supply
> subsystem for review: Anton Vorontsov and David Woodhouse (Cc'd.)

Thanks for Cc'ing and for the review, Jean.

[...]
> > +static int ds2782_get_temp(struct ds2782_info *info)
> > +{
> > +	u16 raw;
> > +	s16 temp;
> > +
> > +	/* Temperature is measured in units of 0.125 degrees celcius */
> > +	raw = ds2782_read_reg16(info, DS2782_REG_TEMP_MSB);
> > +	temp = (raw >> 5) & 0x7ff;
> > +	if (raw & (1 << 15))
> > +		temp |= 0xf800;
> > +	return (temp * 125) / 100;
> > +}
> 
> I don't know if the power supply class has a standard to reporting
> temperature values, but the hwmon class does, and it says that
> temperatures should be reported in millidegrees C. That's not what you
> do here AFAICS. It might be convenient to register a hwmon class device
> and export the temperature there, so that libsensors picks it.

Hwmon feels like a good idea. But no, drivers should not bother
with registering hwmon classes. Instead, some day we might want to
create power_supply_hwmon.c interface (like _sysfs.c that we have
already), the interface would register all needed stuff. And all
drivers will benefit right away without any modifications.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2
