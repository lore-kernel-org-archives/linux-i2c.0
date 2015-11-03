From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 3/3] at24: Support 16-bit devices on SMBus
Date: Tue, 3 Nov 2015 14:20:22 -0600 (CST)
Message-ID: <2035807412.321205.1446582022235.JavaMail.zimbra@xes-inc.com>
References: <1001500768.63909.1441302107931.JavaMail.zimbra@xes-inc.com> <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com> <20151103113353.0b62c5e1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:34002 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499AbbKCUV3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 3 Nov 2015 15:21:29 -0500
In-Reply-To: <20151103113353.0b62c5e1@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>

----- Original Message -----
> From: "Jean Delvare" <jdelvare@suse.de>
> Sent: Tuesday, November 3, 2015 4:33:53 AM
> 
> Hi Aaron,
> 
> On Thu, 3 Sep 2015 14:53:30 -0500 (CDT), Aaron Sierra wrote:
> > Previously, the at24 driver would bail out in the case of a 16-bit
> > addressable EEPROM attached to an SMBus controller. This is because
> > SMBus block reads and writes don't map to I2C multi-byte reads and
> > writes when the offset portion is 2 bytes.
> > 
> > Instead of bailing out, this patch settles for functioning with single
> > byte read SMBus cycles. Writes can be block or single-byte, depending on
> > SMBus controller features.
> > 
> > This patch introduces at24_smbus_read_byte_data to transparently handle
> > single-byte reads from 8-bit and 16-bit devices.
> > 
> > Functionality has been tested with the following devices:
> > 
> >     AT24CM01 attached to Intel ISCH SMBus (1.8 KB/s)
> >     AT24C512 attached to Intel I801 SMBus (1.4 KB/s)
> > 
> > Signed-off-by: Nate Case <ncase@xes-inc.com>
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> > ---
> >  drivers/misc/eeprom/Kconfig |  4 +++-
> >  drivers/misc/eeprom/at24.c  | 40 +++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 38 insertions(+), 6 deletions(-)

[ snip ]

> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index b92ee6e..457f49c 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -134,6 +134,32 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
> >  /*-------------------------------------------------------------------------*/
> >  
> >  /*
> > + * Read a byte from an AT24 device using SMBus cycles.
> > + */
> > +static inline s32 at24_smbus_read_byte_data(struct at24_data *at24,
> > +	struct i2c_client *client, u16 offset)
> > +{
> > +	s32 res;
> > +
> > +	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
> > +		return i2c_smbus_read_byte_data(client, offset);
> > +
> > +	/*
> > +	 * Emulate I2C multi-byte read by using SMBus "write byte" and
> > +	 * "receive byte".  This isn't optimal since there is an
> > +	 * unnecessary STOP involved, but it's the only way to
> 
> It's not just non-optimal, it's also slightly unsafe. You do not hold
> any lock on the I2C bus, so it is possible that another I2C transaction
> happens between setting the EEPROM internal pointer and reading the
> value from the register. I would hope that all AT24-compliant EEPROMs
> handle this case gracefully, but you would better check. Also, on
> multi-master I2C buses, it is possible that another master initiates a
> transaction in between, possibly to the same EEPROM, in which case you
> are screwed because the internal pointer will be changed by that
> third-party transaction.
> 
> This limitation is the key reason why I'm not thrilled by this patch
> set. If it is accepted then the risk above should be clearly documented.

Jean,
I looked up datasheets for AT24 compatible 512 Kb EEPROMs from several
manufacturers (Atmel, Freemont Micro Devices, Microchip Technology,
OnSemi, Renesas, Rohm, and STMicro) and they all support current
address read functionality, which makes the STOP only a concern for
busses with multiple masters. Our embedded x86 products are single
master.

I will expand this comment to address the safety issue.

> > +	 * work on many SMBus controllers when talking to EEPROMs
> 
> s/many SMBus/SMBus-only/
> 
> This is really a design limitation of SMBus itself.

OK, I'll clarify.

> > +	 * with multi-byte addresses.
> > +	 */
> > +	res = i2c_smbus_write_byte_data(client,
> > +		((offset >> 8) & 0xff), (offset & 0xff));
> 
> Useless masking.

OK

> > +	if (res)
> > +		return res;
> > +
> > +	return i2c_smbus_read_byte(client);
> 
> If you go that route then you may be able to get less slow reads by not
> issuing the SMBus "write byte" for every byte you want to read. All
> AT24-like EEPROMs I've seen so far implement internal pointer
> auto-increment, so consecutive SMBus "receive byte" will return the
> data bytes from the following offsets. This is i2cdump's "c" mode. As
> you are already on the unsafe side, it makes no difference on that
> front, but it should more than double your read rate.
> 
> I'm just not sure it this is part of the AT24 "specification" or if it
> works by accident.

That's a good point. I'll try this out. Based on the datasheets I
mentioned above, it appears to be a respected "standard".

-Aaron S.
