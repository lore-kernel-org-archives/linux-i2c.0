From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 09:37:25 +0200
Message-ID: <20171018073725.6qtglbpquyqx5xyq@ninjato>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i62rotqdkjmkzspe"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56170 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762374AbdJRHh1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Oct 2017 03:37:27 -0400
Content-Disposition: inline
In-Reply-To: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: linux-i2c@vger.kernel.org


--i62rotqdkjmkzspe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Juergen,,

> Currently I'm working on a driver adding I2C slave support to some Atmel /
> Microchip MPUs. I already patched the i2c-at91.c and made the
> i2c-slave-eeprom backend working on an ATSAMA5D27. But this is still in t=
he
> prototype status. My next steps are cleaning up the code and sharing the
> patch with you for review and merge into Linux.

Nice!

>=20
> 1) According to [1] the return value of the I2C_SLAVE_WRITE_RECEIVED event
> determines whether the received byte shall be ACKed or NACKed. The problem
> with the Atmel hardware is that it is not possible to manipulate the ACK =
bit
> of the current byte in flight; it will be ACKed automatically. It is only
> possible to (N)ACK the following byte(s) since some FIFO magic is going on
> inside the hardware.

So, it is not possible to NACK the last byte?

> Do you think it is a valid approach to ignore the return value and always
> ACK received bytes? Or would you rather set the behaviour for the followi=
ng
> bytes? That would delay the desired ACK bit by at least one byte.

Tricky, since both options are really sub-optimal. I tend to think that
reporting the error a bit later is the slightly better option. Most
client drivers will act on the fact that the whole transfer failed
somehow. Where it fails is not so essential. We don't have proper means
to report the exact position of the failure currently anyhow.

> 2) The Atmel hardware does not support master and slave concurrently. The
> data sheet [2] examples disable master mode before entering the slave mod=
e.
> (cf. p. 1362) Furthermore send and receive registers and their FIFOs are
> shared.
> How would you implement blocking master transactions while slave mode is
> enabled? I would return EBUSY if master_xfer is called.

The i2c-designware driver has the same problem. We decided to have
seperate struct i2c_algorithms for master and slave. The core helper
i2c_detect_slave_mode() can help you to determine which mode should be
used. The designware drive might give you some inspiration.

Hope that helps?

Kind regards,

   Wolfram


--i62rotqdkjmkzspe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnnBLUACgkQFA3kzBSg
KbbjJBAAoVu+OI4VJu15xAVeMjGkaUsdMH0ZYYI9s7Vie4+lMkTn0mQyCH+oFjCQ
3O4V8KUUE9KQ+9J67YSt/LBF7xPTQXM7ZTjD9Mn7u2DNbefl8hK75doBPiZpV7qU
mSDrVsHtjD1HDJ6o/8PBow/x+mDM6lRPwittsTt8LitD1KFKV1eYJaQenuNY+8El
/6PsmaFZZnbYPyFqF7IyEPBcJulWIu4uWt/LICDvftpdwOD5GnfTSQ8Hw+tStJ+M
xeLIgBcS5pxJZNtX1NlX2gGVR0EkvQuO/KL1flyzge2fWJ5ZDTY2k1zPa4wqvu98
sAnAtbUck7EjtuXbJmLLAacERcKQT3W+K/AFz5qh4f6tBHTw+d9IoT78ZykVh96C
DQUzLUMYgCX9vFsb1QssLOpUJe0LwCs8s9sEAjQU3ukfe9yxkbmbE7TBsKs2MsJ8
0FtsDm1EY6uDgEznkISdRROh9LoeUyzZmddAoOVW0K+tb0a9RVungoObnefMe/3+
utoKNZd2+WbVssFkq5SL+0WAZG6IWg9Y9uFaRgjqfJHXtCEa2h4ng4FqEeU/VPUr
4FzoY19mO8+0epbxxwxLnULkpwoaRmzvhCKuHwuEIldEfnRQafwJNwTlcRQAan7u
YttasVZRPr64nSs9htPCWv8KQ7Yj5/w8OWHwzyiNI6YljLVy7wE=
=JKVa
-----END PGP SIGNATURE-----

--i62rotqdkjmkzspe--
