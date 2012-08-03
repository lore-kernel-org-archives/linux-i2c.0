From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/2] I2C: SIS964: Bus driver
Date: Fri, 3 Aug 2012 18:07:12 +0200
Message-ID: <20120803180712.1e768042@endymion.delvare>
References: <1344008145-14579-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344008145-14579-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?UTF-8?B?RGVjcsOqbWU=?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, jeffrey.t.kirsher-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Amaury,

On Fri,  3 Aug 2012 17:35:43 +0200, Amaury Decr=C3=AAme wrote:
> This series of patches are a I2C bus driver for the SIS964.
>=20
>=20
> The SIS964 is nearly the same as SIS630 for the SMBUS :
> 	- Most of the SMBus registers (Status, Enable, Control,
> 	  Host Control, etc.) are at the same adresses + 0x60
> 	- The register count is 21 instead of 20
>=20
> The SIS964 name is ambiguous as this chip isn't part of the SIS96X
> family and behaves differently.
>=20
> The datasheets have been used to develop the driver based on the
> exsiting driver for I2C SIS630 .=20

What is the rationale for not adding support for the new chip to
i2c-sis630 then? That would probably be a lot easier to review.

> Content of the patches:
> 	- 1/2 The driver itself
> 	- 2/2 Documentation, Kconfig, Makefile, Maintainers

This split makes little sense. Integration should come with the driver,
otherwise even build-testing is impossible.


--=20
Jean Delvare
