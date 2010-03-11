From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 11:54:26 +0100
Message-ID: <20100311115426.6440837c@hyperion.delvare>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de>
	<20100311085835.34c6cd51@hyperion.delvare>
	<20100311080347.GB16219@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311080347.GB16219-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?UTF-8?B?RHJlw58=?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 11 Mar 2010 09:03:47 +0100, Wolfram Sang wrote:
> Hi Jean,
> 
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 88c20da..d2deea4 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -541,6 +541,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > >  	at24->bin.attr.mode = chip.flags & AT24_FLAG_IRUGO ? S_IRUGO : S_IRUSR;
> > >  	at24->bin.read = at24_bin_read;
> > >  	at24->bin.size = chip.byte_len;
> > > +	sysfs_bin_attr_init(&at24->bin);
> > 
> > I think it would make more sense to move the initialization _before_
> > manually setting other struct members. You don't know what
> > sysfs_bin_attr_init does or will do in the future.
> 
> Okay.

OK, patch applied with this change, thanks.

> > I presume the at25 driver needs the same fix?
> 
> Yes, sent it to the SPI-list sperately. I wasn't sure if a patch series would
> ease or complicate things.

Fine with me, as long as it get fixed.

-- 
Jean Delvare
