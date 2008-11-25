From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Tue, 25 Nov 2008 12:54:07 +0100
Message-ID: <20081125125407.4d30cede@hyperion.delvare>
References: <200811201438.08788.david-b@pacbell.net>
	<200811250224.01610.david-b@pacbell.net>
	<20081125120100.6581f394@hyperion.delvare>
	<200811250327.08464.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811250327.08464.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 25 Nov 2008 03:27:08 -0800, David Brownell wrote:
> On Tuesday 25 November 2008, Jean Delvare wrote:
> >=20
> > > I did test this with the legacy "eeprom" and "i2c-stub" as you ha=
d
> > > suggested. =A0Worked fine ... this is different from previous pas=
ses,
> > > as it removes the lock instead of the list, and doesn't attempt t=
o
> > > change how the list is (mis/ab)used.
> >=20
> > Which kernel version? Since 2.6.27, the eeprom driver is no longer =
a
> > legacy driver. Instead it's a new-style driver with the
> > optional .detect() callback.
>=20
> 2.6.28-rc6 ... hmm, seeing the top of that driver with
>=20
>   /* Addresses to scan */
>   static const unsigned short normal_i2c[] =3D { 0x50, 0x51, 0x52, 0x=
53, 0x54,
>                                         0x55, 0x56, 0x57, I2C_CLIENT_=
END };
>=20
>   /* Insmod parameters */
>   I2C_CLIENT_INSMOD_1(eeprom);
>=20
> strongly implied that it's still a legacy driver.  But
> at the bottom, I see otherwise.

I voluntarily made the .detect() callback reuse the same data
structures, to make the transition easier. I still hope to be able to
kill the I2C_CLIENT_INSMOD*() macros someday though.

> (...) I suppose your "how to
> test such stuff" message predated 2.6.27 ... :)

Definitely.

--=20
Jean Delvare
