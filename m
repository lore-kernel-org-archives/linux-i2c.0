From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Fri, 15 Jul 2016 21:24:30 +0900
Message-ID: <20160715122429.GA2620@tetsubishi>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
List-Id: linux-i2c@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +/*
> + * Both reads and writes fail if the previous write didn't complete yet. This
> + * macro loops a few times waiting at least long enough for one entire page
> + * write to work.
> + *
> + * It takes two parameters: a variable in which the future timeout in jiffies
> + * will be stored and a temporary variable holding the time of the last
> + * iteration of processing the request. Both should be unsigned integers
> + * holding at least 32 bits.
> + */
> +#define loop_until_timeout(tout, op_time)				\
> +	for (tout = jiffies + msecs_to_jiffies(write_timeout),		\
> +		op_time = jiffies;					\
> +	     time_before(op_time, tout);				\
> +	     usleep_range(1000, 1500), op_time = jiffies)

There is one subtle change coming with this change: the do-while loop is
guaranteed to run at least once while the for-loop doesn't.


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiNX8AAoJEBQN5MwUoCm202YP/1gIB+YNwakpcsRp5OyPZVYr
sXtuQRaWBywq1d8rCBMnbaGUZsR6yZam4FVrNkBHPJ/imebTrEyiRZDyApurmftF
RJmy9ITv6PG6BuFdtDW+aaWBlmM2+cazZRW+x3JXcbBxsNV8XnkrTzJs3MZQMvfW
SVI8O78YG0YE3+EjfIXGrAxjb7V5bhUVv5Z5qnYiUegwmG619jmO2aItleW3rngf
05DEDE/4acnmEmSTxQlVCNEqQA7gkqd3aDdj+LcNjkXDJeUixgfNGeleLpABxVl5
AzrENHNai0h+2fMsqb9GgpFrtopnoT914t9R+zHYfZSjrBfwdSdAyQ/f4vFNdFZk
OziIRxTPtX23Yj/87JFICI/+v7a699A1YRvejBSCyeoMT0mmrYHtW6r/NBFzLjVa
Xp1Ae1fdAsmd5yFTVSCwrpCntPibQ+oeB8uMYcCOWreY9qtSEDz5QCUDd9M0Cge2
dvEqfYAHx6KEGzGwm3psV6EFekw1Q2QOHFLC+ltnfByngV0pD6CkKbfVRR8QZmEL
aqHw7OYYRr/fWLIBl3OyptrftA3FhkA7d+YwVBXLup1EisRKwy++DjDI1bOf+gkK
LQjUWKnGc0oblbPFm/2rUYNpiCtD5N8LK0KLGD1faxwDQkLhgiL+dDPuMbkTJ6zA
sgoDVs6fphy7T4Od8Khr
=riAe
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
