From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect
 function
Date: Mon, 13 May 2013 10:11:50 +0200
Message-ID: <20130513101150.0c9e4d30@endymion.delvare>
References: <20130212164811.GV8668@pengutronix.de>
	<3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
	<20130508175417.GB29689@roeck-us.net>
	<FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
	<20130509035313.GA26817@roeck-us.net>
	<3322BACE-9434-4249-8621-C1AD0D340A8A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3322BACE-9434-4249-8621-C1AD0D340A8A-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?SmVhbi1GcmFuw6dvaXM=?= Dagenais <jeff.dagenais-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Salut Jean-Fran=C3=A7ois, hi Guenter,

Sorry for jumping in a little late, I am just back from vacation.

On Thu, 9 May 2013 08:38:28 -0400, Jean-Fran=C3=A7ois Dagenais wrote:
> On 2013-05-08, at 11:53 PM, Guenter Roeck wrote:
> > Is one of the I2C adapter drivers your own ? If so, you can disable=
 auto-detection
> > in the adapter code by setting the adapter class to 0 (specifically=
, don't set it
> > to I2C_CLASS_HWMON). You can do the same in the Kontron driver if y=
ou have the
> > source (it is GPL so you should be able to find it). While not perf=
ect, that should
> > be better than disabling auto-detection in the affected chip driver=
s.
>=20
> That's great advice!! I will look into this, thanks!

Guenter is right. You never have to disable auto-detection in the slave
drivers (jc42 etc.) All these slave drivers do is claim "I _can_ do
auto-detection", not "I _will_ do auto-detection." It's always up to th=
e
I2C adapter driver, whether auto-detection will happen or not. And it
is disabled by default. So if you don't want it, just do not enable it
in the bus driver. You can even set it per adapter, when the driver
controls more than one adapter, and per bus segment, when multiplexing
is taking place.

Please also note: the jc42 driver now uses I2C_CLASS_SPD not
I2C_CLASS_HWMON, because memory modules typically use a single chip for
SPD EEPROM and JEDEC JC42.2 temperature sensor. Think of I2C_CLASS_SPD
as "I2C class for memory modules."

> > Note that the Kontron driver also sets I2C_CLASS_SPD, which means E=
EPROMs are
> > auto-detected on address 0x50.
>=20
> Funny, I had to explicitly inject "I2C_BOARD_INFO("24c32", 0x50)" to =
see
> Kontron's JIDA chip.

The only EEPROMs which are auto-detected are SPD and EDID EEPROMs. The
legacy eeprom driver is used for these. The 24C32 is a larger EEPROM,
you must use the at24 driver for it and it doesn't support
auto-detection (this is simply not possible.)

In the long run, the legacy eeprom driver could be killed, but not
before someone verifies that the at24 driver can take over completely,
including the auto-detection feature, performance optimizations and
corner case coverage.

> > (...)
> > Sure, it does work, I am just not sure what the benefits are of hav=
ing two
> > masters in this scenario.
>=20
> My thoughts exactly. I would have avoided it. Right now I am trying t=
o improve
> and existing design.

It might be a little late now, but you may want to look into the
PCA9541, for which Guenter has written a driver.

--=20
Jean Delvare
