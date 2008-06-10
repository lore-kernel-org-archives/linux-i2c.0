From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Tue, 10 Jun 2008 18:54:43 +0200
Message-ID: <20080610185443.14a4516e@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
	<20080608115033.5dd91786@hyperion.delvare>
	<20080610134347.GA4210@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080610134347.GA4210-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Tue, 10 Jun 2008 15:43:47 +0200, Wolfram Sang wrote:
> > The Atmel 24C01 datasheet says page size is 4 bytes, and the Microchip
> > 24C01A datasheet says 2 bytes. So defaulting to 8 doesn't look safe.
> 
> Will go back to 2 because of Microchip. But 24C01 seems to have lots of
> variants, which makes a generic entry difficult. Some would need

Feel free to not make a generic entry at all if you think it's not
worth it.

> AT24_FLAG_24C00 (doesn't really matter), and AT24C01 needs 128
> addresses?? (please, someone, prove me wrong)

Why do you think so? My personal guess is that they simply forgot to
mention the address in the datasheet. A chip responding to all
addresses would prevent any other chip from being connected to the bus,
that's impractical enough to be reasonably certain that no manufacturer
did this.

> > In the end, the only things that must go in at24.h are the definition
> > of struct at24_platform_data and its flags. All the rest is internal to
> > the driver and should go in at24.c.
> 
> I wanted to have the AT24_SIZE_* flags next to the struct, so I won't
> forget to change their size if anything inside the struct will change.
> Then again, I might work with sizeof here; the result will probably look
> a bit nasty, too...

I see, it makes some sense to keep these flags around then. But then
please add a warning that these are for the driver internal use only
and shouldn't be considered stable.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
