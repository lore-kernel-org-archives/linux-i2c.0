From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
Date: Wed, 3 Dec 2014 12:15:18 +0100
Message-ID: <20141203111518.GB1039@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417574237-4328-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + - rise-ns : Number of nanoseconds the signal takes to rise (t(r) in i2c spec).
> +	     If not specified this is assumed to be the max the spec allows
> +	     (1000 ns for standard mode, 300 ns for fast mode) which might
> +	     cause slightly slower communication.
> + - fall-ns : Number of nanoseconds the signal takes to fall (t(f) in the i2c0
> +	     spec).  If not specified this is assumed to be the max the spec
> +	     allows (300 ns) which might cause slightly slower communication.

We already have those bindings from the designware driver:

 - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
 - i2c-scl-falling-time : should contain the SCL falling time in nanoseconds.
 - i2c-sda-falling-time : should contain the SDA falling time in nanoseconds.

Can you reuse them? Or do you really need a specific rise-time property?
If so, please matche the style of the bindings above.


--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfvDGAAoJEBQN5MwUoCm2yL0P/2Cq0bFmZ5iMyVr57iImqYC1
8DAPzsnY66k7lj5EsdDpuM2wskRR6BoKjrmQb7VaeMtsLA7yaa3QmjDg5fBtsQ5C
D+O+EXEKYQgN2DVqLDW/5oebJKHQYOEpCSQrxa4ixwFjf950bcN9DbYwl8TJvy51
6uJKuJ3C8OGMnH5o0mqY7Tmi60yBLqYYVVwLay19zxWoeRdmtSpcVle0AuB7FtHp
UiOAWVBPRMnT573VfckQrZ0t8EcWAz5nZtpmceJyU9dB4B5I1XY0PCpKx/Djc0aJ
zQ0maXf+R8zyAcooyVKIab4mHnsG3+I9Toe7kJN/Fu5p5sxAfCrHnTgZyC7h4T/2
Wk3+2vSkxux0EYDDUUZIQQeaHdUjhnpxyI+ppcxDQEk1xoa/I5GulMFrVR8zXuNv
aMJmJqQsmmarwSgvcakbYOdyeZXLZtQlvDfGDdqC0Y4ipWvvl6vRLQvsYnixsDsV
LswxF/hQfWu/HepIIGWh6IOPDc4TlZPsYdBCyl/o3Pi9NZkrcD36BZSz4WDjyNo7
qXLvCi+6WqA2Svhrl6/fk8aKgMeBcBUv//X3cwNtrhQPH/nYurLeJuMpe5cervNI
QkPiEyOZZg8S0ZwhC+vQkCaWK7DBWiKKS7WH/2zWF6HHcPTbOlZ4Ys8/D28h9vAF
mjTgaUSxU1E4dVnz+J/R
=6GEG
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
