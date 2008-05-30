From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 30 May 2008 11:51:31 +0200
Message-ID: <20080530115131.0e111fdb@hyperion.delvare>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
	<20080530091534.GB727@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080530091534.GB727-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 30 May 2008 11:15:34 +0200, Wolfram Sang wrote:
> thanks for your review! Just a few comments from me, otherwise I'll
> change the things as suggested by you or David.
> 
> > > As we now support device_ids, probably most of the chip data will
> > > come back into the driver. This is yet to be done. Tested on two
> > > platforms by me and another one by David. Builds also on x86.
> > We have to make a decision about the strategy now, and stick to it.
> > Changing it after the driver is upstream will cause a lot of
> > confusion.
> ACK. I was thinking about the following way to support the standard
> eeprom sizes without bloating the driver too much with chip data: In a
> MODULE_DEVICE_TABLE, we have a kernel_ulong_t available for each entry
> of a supported device. All parameters of the standard eeprom chips are
> powers of 2. If we use log2 of these parameters, they will easily fit
> into a kernel_ulong_t. We'd need one macro to create these magic numbers
> from the provided chip data (AT24_DATA_*) and just a tiny bit of code to
> create a proper platform_data struct from it.
> A general "at24" entry will expect the platform data to be provided, of
> course.

That's fine with me.

> > > +	at24->bin.attr.name = "eeprom";
> > > +	at24->bin.attr.mode = S_IRUSR;
> > This makes the data only readable by root, as the comment says. The
> > eeprom driver makes (most of) the data world-readable. I think it would
> > be good to at least have the option to make the data world-readable,
> > for example for SPD or EDID data. Otherwise we will never be able to
> > drop the eeprom driver.
> I'd go for David's solution here to introduce another flag for this
> purpose.

OK.

> > > +	u8		i2c_addr_mask;		/* for multi-addr chips */
> > This notion of i2c_addr_mask seems more restrictive and easy to get
> > wrong than it needs to be. What you really have is a number of slave
> > I2C addresses, that's more intuitive IMHO, and using this would save a
> > couple "+ 1" in the code. As a matter of fact, that's what you
> > described in the comment above.
> > Oh, BTW, can't you compute this value yourself from byte_len and (flags
> > & AT24_EE_ADDR2)? I think so...
> I was about to address this issue in the next version. Still need to
> think about side-effects and corner-cases in a quiet minute.

I'd rather see this addressed now rather than later, as struct
at24_platform_data is public, changing it later would be non-trivial.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
