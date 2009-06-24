From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Looking for help writing an i2c client for i2c-core
Date: Wed, 24 Jun 2009 10:54:11 +0200
Message-ID: <20090624105411.64a22474@hyperion.delvare>
References: <7BD054A954B148E7B69442B1AC498484@footfall>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7BD054A954B148E7B69442B1AC498484@footfall>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Tompson <brian.tompson-4c4C/Gi1/tVWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 22 Jun 2009 21:02:40 -0700, Brian Tompson wrote:
> In my i2c searches I stumbled upon this list.=A0 I hope this message =
is
> appropriate here.
>=20
> I am trying to write an i2c client driver for the i2c core, using the=
 Linux
> Driver Model (new style driver).
> I am looking for a list of steps I need to take to accomplish this.
>=20
> I have been looking for a list something like this:
>=20
> Load this i2c-core structure with this information.
> Call this i2c-core function to register your driver.
> Call this i2c-core function to connect to the adapter or bus or algor=
ithm
> (don't know which)
> Write a probe function that does this.
> Write a remove function that does this.
> Call this i2c-core function to write raw i2c data (not SMBus) to your=
 device
> Call this i2c-core function to read raw i2c data from your device.
> Call this i2c-core function to disconnect from the adapter or bus or
> algorithm
>=20
> Or whatever the actual steps should be.
>=20
> I have started writing a driver and have used i2c_add_driver() to reg=
ister
> my driver with i2c_core.
> Now what?=A0 Probe, attach, send, remove, ...?=A0 Is there a resource=
 available
> that simply lays out these facts?=A0 I think a resource like that wou=
ld be
> very useful to someone trying to develop a client driver for the i2c-=
core
> using the Linux Driver Model.

Have you read Documentation/i2c/writing-clients already? That would be
a very good start. Or more generally, the developer's documentation
section on http://i2c.wiki.kernel.org/

--=20
Jean Delvare
