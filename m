From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect
 function
Date: Mon, 13 May 2013 16:14:13 +0200
Message-ID: <20130513161413.58ebc9e8@endymion.delvare>
References: <20130212164811.GV8668@pengutronix.de>
	<3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com>
	<20130508175417.GB29689@roeck-us.net>
	<FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com>
	<20130509035313.GA26817@roeck-us.net>
	<3322BACE-9434-4249-8621-C1AD0D340A8A@gmail.com>
	<20130513101150.0c9e4d30@endymion.delvare>
	<E43DA0E6-A130-4837-8343-EEC182A12EE6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E43DA0E6-A130-4837-8343-EEC182A12EE6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?SmVhbi1GcmFuw6dvaXM=?= Dagenais <jeff.dagenais-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 May 2013 09:54:47 -0400, Jean-Fran=C3=A7ois Dagenais wrote:
> Salut Jean, merci de participer!
>=20
> On 2013-05-13, at 4:11 AM, Jean Delvare wrote:
>=20
> >=20
> > Guenter is right. You never have to disable auto-detection in the s=
lave
> > drivers (jc42 etc.) All these slave drivers do is claim "I _can_ do
> > auto-detection", not "I _will_ do auto-detection." It's always up t=
o the
> > I2C adapter driver, whether auto-detection will happen or not. And =
it
> > is disabled by default. So if you don't want it, just do not enable=
 it
> > in the bus driver. You can even set it per adapter, when the driver
> > controls more than one adapter, and per bus segment, when multiplex=
ing
> > is taking place.
>=20
> I am just wondering where the clean hook is for doing this. From what=
 I can
> gather, the master driver(s I've seen) declare ".class =3D I2C_CLASS_=
HWMON |
> I2C_CLASS_SPD," pretty statically. Is it just that they are missing t=
his
> flexibility? Something along the lines of patching the pdata of such =
a master
> driver to provide a 'class' variable in pdata?

Yes, exactly.

> If so, one would have to take
> into account the existing users of the master which expect the previo=
us class
> setting which may not be '0', thus requiring patching the existing up=
streamed
> users...  Suggestions?

Yes, you have to do something like that. The static class declarations
come from the PC world drivers where they (almost) never change.
Embedded systems definitely want a per-bus decision and should avoid
static declarations as much as possible. Especially when in most cases
they know exactly what slaves they are so they don't need
auto-detection. There's a reason why auto-detection is an optional
feature...

--=20
Jean Delvare
