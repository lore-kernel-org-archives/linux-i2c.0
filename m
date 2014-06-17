From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C Slave monitor mode support
Date: Tue, 17 Jun 2014 14:19:12 +0200
Message-ID: <20140617121912.GA2683@katana>
References: <CAD6G_RRa9C0umBrR6CUF3zb5cSKKfZO7y7UPUKHjJOx41A0aJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD6G_RRa9C0umBrR6CUF3zb5cSKKfZO7y7UPUKHjJOx41A0aJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Few of the I2C interfaces are [operated] with slave monitor mode, when
> there is a requirement for
> a particular slave may need to wait some time to get the ADDR before
> sending an ACK.

Can you describe an existing scenario? Why can't the slave use clock
stretching?

> This feature is an optional and defined in few of the controllers, Can
> anyone tell me is this support is
> added already in kernel, if yes please point to the respective driver
> or code link.

None that I know of. The above questions should help me understand why
it is needed on master driver level at all.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToDJAAAoJEBQN5MwUoCm2JuAQALDU6i4qYjK2gT9H5dAltd6S
K4sHq+HhodND0ogAOufLgD0c8uoZzT4G2ucSp+9Ygjxs1H1hKlSaBJ7+9d0C9CGG
67ODxaWOFc1IVnPQ/btFVlZMCpHexWsUhVCoLdXkwON54PgNmp1g9EnEPEqZy97w
t5ZNHPcd030cqmAGhMQ95DJyqvMa9xYa5UQo42BYkFcrw8bDATLdxPSa8It3Or4p
BA6m6/I1AFmsQf1Mj67GDmG8e9BuN7qNRzO5P9iOc19LH3BYLfXvXkiRF3kfUdG9
vauS84dhXB3NYV7ZwaEI517dEbMQoLbhgR7RSKtXjFYM6Uj2sfUMUsu0YadjJ52h
3zCGHe5Rvn0bKCJ6jf0HMPDktqTXKW68dKZ4uZTZEbLAUDcySUMDjl4G3Lq3adsl
44OBEcwbtstG7+cvOVE5+FioFHRf2rhk1jBxZqdJ0BBWmas84qfBupP+aMP5B8Fi
jrqHUTNhSHTDHZYTASRxglKd9JV8lCCL1cxugCQjhNKslgzeMehbs0egzXoZ00V7
LPM2CfOde2H+Hdxpumc/Ij+C6LUCoMv58BTgniI8QQgFWBSAJtYPgbazGNyetcft
T76NDNisc98qLbb9XUPPu8KN/hnK5nXKAd6dVAByuJ47U/ZEDDeZjBrCAS6Hp2TX
B2YUZndeqZN7HoDXJgoE
=PhC+
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
