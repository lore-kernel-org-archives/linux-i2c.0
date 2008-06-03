From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Tue, 3 Jun 2008 13:36:35 -0700
Message-ID: <200806031336.35678.david-b@pacbell.net>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<200806021233.46781.david-b@pacbell.net>
	<20080602214823.15ca190b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602214823.15ca190b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 02 June 2008, Jean Delvare wrote:
> > ISTR the point was safety: =A0letting other drivers potentially
> > access the device was a bad idea. =A0;)
> =

> I'm not even sure what problem it could cause in practice...

Who knows what protocol the "other drivers" expect to work.

It might happen to look like writing to arbitrary addresses.
Not unlike "read with 16-bit address" starts out with bytes
that look just like "write to 8-bit address"...


> > > Problem solved :)
> > =

> > Not really. =A0The "eeprom" driver, or various other legacy
> > drivers knowing about the 0x50..0x57 address range, could
> > bind to those addresses. =A0That problem would not be solved.
> =

> If you're using the at24 driver on that bus, you're most certainly
> using only new-style drivers and not even setting a "class" for legacy
> i2c drivers to probe the i2c adapter.

Not yet true.  There are systems that still need to use legacy
drivers.  In a few years, I hope you're correct about this.


> Yes, the eeprom driver currently doesn't check for i2c_adapter.class,
> and yes, it's a bug. We need to define a class flag for it
> (I2C_CLASS_SPD?), set it in all PC SMBus host drivers, and have the
> eeprom check for (I2C_CLASS_SPD | I2C_CLASS_DDC).
> =

> Once this is fixed, I really see zero benefit in requesting all the
> addresses the 24C00 replies to in the at24 driver.

I personally won't worry much about 24c00 chips; I have some for
testing, but haven't seen new systems using them for some time.
It was news for me that they exist on DDC links!


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
