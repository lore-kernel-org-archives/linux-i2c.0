From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Wed, 11 Mar 2009 11:40:50 +0100
Message-ID: <20090311104050.GA28547@buzzloop.caiaq.de>
References: <000001c9a0c6$bf92af80$b23e81a4@par.st.com> <20090310163044.571e4aff@hyperion.delvare> <fd6b62c10903102327u426a4262meeabe2c581d7107b@mail.gmail.com> <20090311101513.271f5464@hyperion.delvare> <20090311094752.GE25824@buzzloop.caiaq.de> <fd6b62c10903110319w1eebd2ebs4b83e7d1247f1678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd6b62c10903110319w1eebd2ebs4b83e7d1247f1678-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 11, 2009 at 06:19:18PM +0800, =E4=BC=8A=E6=B3=BD wrote:
> > Not true. You need to provide a firmware for that device and this
> > firmware selects the I2C slave address. Read the datasheet again.
>=20
>=20
> Thanks Jean, daniel,
>=20
> Yeah, the capsensor has the function to re-program its own slave addr=
ess ,we
> did try that already. If programmed with other address, only coming o=
ut data
> "0".
>=20
> The capsensor with 0x00 can also work with correct data,except the ph=
one
> hang problem.
>=20
> I really be confused, when i2c bus unit is blocked by some slave devi=
ce,  is
> it necessary to control the scl/sda by GPIO mode operation?

You need to have a master to the bus. Whether that is done by GPIO
bit-banging or with a real hardware module in some kind of processor or
peripheral device is up to you. You won't even see the difference from
the Linux API as long as your bus master is supported.

> >  "The I2C address is programmable during configuration. It can be l=
ocked
> >  to prevent accidental change by setting a flag in a config-uration
> >  register."
> >
> > > > We met much phone hang problem with i2c,errors such as "waiting=
 for bus
> > > > free" or "exhausted retries" are all with this sensor.
> >
> > Same reason. Without a firmware, the chips does not have its I2C co=
re
> > set up and hence it's blocking SDA and/or SCL.
>=20
> I think we have the firmware, and the chips have its i2c-core set up
> already,any other situation which the device block the SDA / SCL  ?

Every device connected to the bus can probably block it. If that
happens, you need to find out why (this implies at least using a
soldering iron and an oscilloscope). But as long as you're not sure
whether you have 'the firmware' or not, I'm confident nobody on this
list can help you with that.

Daniel
