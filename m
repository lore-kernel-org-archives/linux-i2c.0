From: "Brian Tompson" <brian.tompson-4c4C/Gi1/tVWk0Htik3J/w@public.gmane.org>
Subject: RE: Looking for help writing an i2c client for i2c-core
Date: Thu, 25 Jun 2009 08:48:21 -0700
Message-ID: <061243056589422B81DCA99818292EA3@footfall>
References: <7BD054A954B148E7B69442B1AC498484@footfall> <20090624105411.64a22474@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090624105411.64a22474-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thank you both for your responses.  The link to the kernel wiki was als=
o
worthwhile.

In my all too quick research into writing a Linux Driver Model driver,
somehow I missed the step of calling i2c_register_board_info() in the k=
ernel
startup code.  I could register my driver with the i2c_core, but since =
there
was not i2c_board_info entry nothing else happened in my driver.  No th=
at I
have added the i2c_register_board_info call, my driver callbacks are ca=
lled
and I can get back to writing device driver code again.

When my schedule frees up some, I hope I can write up description of th=
e
steps I took to get a new Linux Driver Model I2C device driver written.

Thank you for your help,
Brian



-----Original Message-----
=46rom: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]=20
Sent: Wednesday, June 24, 2009 1:54 AM
To: Brian Tompson
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Looking for help writing an i2c client for i2c-core

On Mon, 22 Jun 2009 21:02:40 -0700, Brian Tompson wrote:
> In my i2c searches I stumbled upon this list.=A0 I hope this message =
is
> appropriate here.
>=20
> I am trying to write an i2c client driver for the i2c core, using the
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
> Call this i2c-core function to write raw i2c data (not SMBus) to your
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
> Now what?=A0 Probe, attach, send, remove, ...?=A0 Is there a resource
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
