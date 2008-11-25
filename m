From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Tue, 25 Nov 2008 03:27:08 -0800
Message-ID: <200811250327.08464.david-b@pacbell.net>
References: <200811201438.08788.david-b@pacbell.net> <200811250224.01610.david-b@pacbell.net> <20081125120100.6581f394@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081125120100.6581f394-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 25 November 2008, Jean Delvare wrote:
>=20
> > I did test this with the legacy "eeprom" and "i2c-stub" as you had
> > suggested. =A0Worked fine ... this is different from previous passe=
s,
> > as it removes the lock instead of the list, and doesn't attempt to
> > change how the list is (mis/ab)used.
>=20
> Which kernel version? Since 2.6.27, the eeprom driver is no longer a
> legacy driver. Instead it's a new-style driver with the
> optional .detect() callback.

2.6.28-rc6 ... hmm, seeing the top of that driver with

  /* Addresses to scan */
  static const unsigned short normal_i2c[] =3D { 0x50, 0x51, 0x52, 0x53=
, 0x54,
                                        0x55, 0x56, 0x57, I2C_CLIENT_EN=
D };

  /* Insmod parameters */
  I2C_CLIENT_INSMOD_1(eeprom);

strongly implied that it's still a legacy driver.  But
at the bottom, I see otherwise.  I suppose your "how to
test such stuff" message predated 2.6.27 ... :)
