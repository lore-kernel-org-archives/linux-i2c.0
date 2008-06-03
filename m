From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Tue, 3 Jun 2008 23:19:27 +0200
Message-ID: <20080603231927.61f9eb61@hyperion.delvare>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<200806021233.46781.david-b@pacbell.net>
	<20080602214823.15ca190b@hyperion.delvare>
	<200806031336.35678.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806031336.35678.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 3 Jun 2008 13:36:35 -0700, David Brownell wrote:
> On Monday 02 June 2008, Jean Delvare wrote:
> > > ISTR the point was safety: =A0letting other drivers potentially
> > > access the device was a bad idea. =A0;)
> > =

> > I'm not even sure what problem it could cause in practice...
> =

> Who knows what protocol the "other drivers" expect to work.
> =

> It might happen to look like writing to arbitrary addresses.
> Not unlike "read with 16-bit address" starts out with bytes
> that look just like "write to 8-bit address"...

That's correct but irrelevant here. You can't rely on driver A picking
addresses it doesn't even use before legacy driver B has a chance to
probe them because that probing could do something wrong. B could
"load" before A, or the kernel could have driver B but not driver A.
The only safe approach is to only use "safe" transactions (basically:
SMBus read byte transactions) during probing in legacy drivers, and
that's what we actually do.

> > > > Problem solved :)
> > > =

> > > Not really. =A0The "eeprom" driver, or various other legacy
> > > drivers knowing about the 0x50..0x57 address range, could
> > > bind to those addresses. =A0That problem would not be solved.
> > =

> > If you're using the at24 driver on that bus, you're most certainly
> > using only new-style drivers and not even setting a "class" for legacy
> > i2c drivers to probe the i2c adapter.
> =

> Not yet true.  There are systems that still need to use legacy
> drivers.  In a few years, I hope you're correct about this.

But then they tell which type of legacy drivers can probe them. I
pretty much doubt that you'll allow the legacy eeprom driver to probe
your bus if you are also using the at24 driver. And the eeprom driver
is possibly the only legacy driver which probes addresses 0x51-0x57.

I agree that in theory something wrong could happen in the current
state of things if the extra addresses of the 24C00 chip are not
"protected" by the at24 driver, but in practice I very much doubt that
it'll happen, and if it does, it would be easy to fix. So I reiterate
that the at24 driver doesn't need to handle this.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
