From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 14 Apr 2008 09:22:27 +0200
Message-ID: <20080414072227.GU13814@pengutronix.de>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<ftnlao$o2r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ftnlao$o2r$1@ger.gmane.org>
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

On Fri, Apr 11, 2008 at 02:24:55PM +0200, Wolfram Sang wrote:
> I'll just review myself to ask for some comments where I think some
> more opinions would be good. I also tried to contact David Brownell as
> the original author directly last week, but all my mails got blocked;
> I hope we can negotiate through this list.

Hmm, usually, this should work.

> > + * at24.c - handle most I2C EEPROMs
> Maybe rename the driver? at24 is vendor-specific. 24xx? 24cxx?
> eeprom-ng? I'd go for 24xx.

Don't use to many "xx" characters. Last time someone did that, he was
blocked by rmk's spam filter :-) Maybe "i2c-eeprom"?

> > +	/* Lock protects against activities from other Linux tasks,
> > +	 * but not from changes by other I2C masters.
> > +	 */

Multi-line comments are usually written like

/*
 * foo
 */

> To support the X24645, it would be necessary to raise AT24_MAX_CLIENTS
> to 32 (what a beast!). Then again, most eeproms will just need one
> client, so this would cause quite some overhead in most use-cases.
> Maybe it pays off to hande this dynamically?

As eeproms are normally slow things anyway, would it be a big
performance impact?

> > +static struct i2c_client *at24_ee_address(
> > +	struct at24_data	*at24,
> > +	u16			*addr,
> > +	unsigned		*offset

Minor nit: the kernel usually doesn't aling the variables vertically; if
you add more and longer data types, it might be necessary to move around
all other lines, which clutters patches. So I'd write this as

	struct at24_data *at24,
	u16 *addr,
	unsigned *offset

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
