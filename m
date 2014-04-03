From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: I2C adapters protocol deviation
Date: Thu, 3 Apr 2014 16:55:28 +0200
Message-ID: <20140403145528.GA6199@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On the Allwinner A31, the PMIC communicates with the SoC through a bus
looking quite similar to I2C, while being pretty different.

The communication starts with the PMIC through the regular I2C
protocol, but it's only used to initialize the PMIC, and switch to a
mode called "Push/Pull 2 Wire Interface".

That bus is using SDA and SCL, with the start and stop conditions
exactly like I2C does, but:
  - Once the start condition has been issued, the address isn't sent,
    only a direction bit. Hence, it does not support multiple devices
    anymore.
  - Once that direction bit has been sent, the master sends the
    register it wants to read from/write to, over 8 bits, followed by
    one parity bit.
  - Whenever you're writing, the master then sends the data over 8
    bits, followed once again by a parity bit. Then, and only then, an
    ACK is issued by the slave.
  - Whenever you're reading, the master then clocks SDL and the slave
    drives SDA for 8 bits plus 1 parity bit. If there was some kind of
    error, the slave will pull SDA up for 9 cycles, resulting in a
    parity error. Like with I2C though, since it is the only and last
    byte it's receiving, the master won't issue an ACK.

Obviously, to go ahead with the PMIC support, we need to support this
controller and bus first. I can't really decide whether it's within
the scope of the allowed protocol deviations of I2C or if we should
create a whole new bus for it.

Since it's quite similar to and starts as an I2C bus, I'd go for the
former, but I'm really not definitive about it, and wanted to have
your feedback.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTPXZgAAoJEBx+YmzsjxAgSXsP/j3RfuaQu7bt62c2LTKWFVOm
YJM6SzWqoNotn7PJrveVKXLNwzwZ1ojD0cdAVroXV7voHcWjHX6JOMDt0D7ZGtHq
MCQR5H4/i5XkGdSDx0gHLhF6iL0fvufsUlaMzWopZevWeeAXDw50RRSb5EKV1wZc
8wSw5pHblb4Q0kMH6bvF8rVxeRdEgrERogK6FP5PL+IaTDnoM3+qucUd1Y3Dd3QV
ZDUxfPZkTIQt7KRJF55UPURAMtCVQjXfKoUKkByapvHBrHo3ZL0+kS1P1SFcm12I
05IdtqOnlZTeR9QbESgZ3Yi7H9wROwGGunPT/sFm04vlL7N4MQ8uuSlwVYOPNVvw
Kxb7ZC0HjnGCMnClp3M+JPx5MHjfeUk6VRUuiRZ9Pj9IKkHaOYp7bSjQ7XD+55VR
nf24lI8FZfDOeSAsjPeWtCZSrRHG/kfF62FJEH9W7XOq4xex6Ic/kG5sPEvhDiaJ
W5k+kdMT4Q9+MyTCZTDIaYZNUeM9YodO6qMxV4Q5p6GSyIUTVdHs5PN7wcOTFAMD
yA2lAzGACxBDKHJDlRxHpgTtyvRW+oxE83vrT6/TbDtIG79QiyQCdlrIeD+ZtcoB
IzdS4iMfuyNAdpvrR0o7gKJq5BQ4us+ZJPbBuY2rMzSBywG4uAFI6oPRRWzT745B
tDnQWUWb1Q58Y768HEKD
=TZqb
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
