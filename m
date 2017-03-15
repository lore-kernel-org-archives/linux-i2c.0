From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Wed, 15 Mar 2017 08:58:35 +0100
Message-ID: <20170315075835.GA1438@katana>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So there isn't an agreement if is better to just rely in the current behavior
> (and have a superfluous I2C device ID table) or fix the I2C core (and need a
> OF device ID table).

For at24, the i2c_device_id table is not superfluous! It is used outside
the DT world as well.

> Indeed, but these all are compatible strings used by DTS in mainline and so
> should be in the OF device ID table in order to be matched and the proper
> modalias reported (once the I2C core is fixed).

I'd think we should fix the DTS files instead to contain a fallback we
agree on. Say, we agree on "atmel,at24c01" as a the generic fallback,
the DTS should contain:

	compatible = "<your_vendor>,<your_type>", "atmel,at24c01"

And we shall only keep compatible values in the source file which differ
in behaviour fromt the generic case.

> One option is to add #ifdef CONFIG_OF guards for the OF device table definition
> but again there's no agreement on that one since some maintainers say the it is
> better to always build the OF ID table than having #ifdefery in C code...

I don't like the #ifdeffery as well.


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYyPQrAAoJEBQN5MwUoCm2yXIQAK0WBgKrU4kO2slxLo7TKcqj
YDlOk1Q/YXlYawtzF4QHHf9m5bYxjpRUXgQ2J3fK3OUJBI5x5hoWwa+tGEZfGH/n
v7QidJM0auxjdjKegGQs50+MOVqmDjsn2pOlXO3Ogkn5AKBEU0RG4ZZH94GGXX+F
/HWF7FwWwdKh018I940ezsrS9SA4/tl70AuLDypgJe2zLs+4Am2DkhmdqaoXk53o
14NcKz7fAGWOEpT8jVCd0iwgt1ZjX5YZUauFjEPi/mRuYGovLbFltAja4V259gZH
6CJBL7Tor62OQQbyoexzwFC1rXGzgg7UuZzK/1JKoZyvPH//rO93+y8x73ZK5tZ0
+/IakE1n3IVe6aB7DepHYmf4ghqF+KdEbzOPC9lnxrPZjJT3Ynlp1YEdGUKrGQIm
xcipgbFU4HW2r83aqpU9Xj7NWAE4uOnVDnhhJZFZTa/UkXOpB+oa4MdXtPx/FD7C
usjc0kgNA1X9rSPqm5OBZjEbsAN/PsKiR3Yr+KedNMyXB6K4EwZUHH2GSGR6x5UT
AIXPVaSxY9uIqdzvHkxP6MByR9fiQKCQ2qeWAFhjkxfnuMMBbQhSpcTAEsL0vTN6
yJWtLd5EEI/bZIklgEh/vwYJ7TFBI6HhfIcgB/wtiOEATLm+oyno5Oj+gS7Yu1Gz
UDdbs4RcAT3r6MfGrkST
=JY+s
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
