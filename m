From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH resend 0/2] I2C: sis630: add sis964 support
Date: Tue, 18 Dec 2012 12:51:05 +0100
Message-ID: <20121218125105.25c2cbb6@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346204115-30293-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Amaury,

On Wed, 29 Aug 2012 03:35:13 +0200, Amaury Decr=EAme wrote:
> This serie of patches brings SIS964 support to i2c-sis630.
>=20
> The SiS datasheets have been used.
>=20
> The SIS964 isn't part of the SIS96X family and behaves differently.
> For i2c, this array show the differences between sis630 and sis964.
> 	+------------------------+--------------------+-------------------+
> 	|                        |     SIS630/730     |      SIS964       |
> 	+------------------------+--------------------+-------------------+
> 	| Clock                  | 14kHz/56kHz        | 55.56kHz/27.78kHz |
> 	| SMBus registers offset | 0x80               | 0xE0              |
> 	| SMB_CNT                | Bit 1 =3D Slave Busy | Bit 1 =3D Bus prob=
e |
> 	| SMB_COUNT              | 4:0 bits           | 5:0 bits          |
> 	+------------------------+--------------------+-------------------+
>=20
> The other differences doesn't affect the functions provided by the or=
iginal
> i2c-sis630 driver.
>=20
> The first patch is mandatory as it adds supports for SIS964 bus.
> The second patch is optional. It depends on the first patch.
>=20
> Amaury Decr=EAme (2):
>   I2C: sis630: sis964 bus
>   I2C: sis630: Cleaning and cosmetics
>=20
>  Documentation/i2c/busses/i2c-sis630 |   17 +-
>  drivers/i2c/busses/Kconfig          |    4 +-
>  drivers/i2c/busses/i2c-sis630.c     |  445 +++++++++++++++++++++----=
----------
>  3 files changed, 278 insertions(+), 188 deletions(-)

I reviewed these two patches 2 months ago, but did not hear back from
you since then. Do you plan to resubmit these patches with the
improvements I suggested? I would hate to see your work time and mine
wasted.

Thanks,
--=20
Jean Delvare
