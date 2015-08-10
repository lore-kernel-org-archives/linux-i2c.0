From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: unmet direct dependencies in -next
Date: Mon, 10 Aug 2015 13:55:41 +0200
Message-ID: <20150810115541.GA6479@katana>
References: <55C71FF5.1020902@nod.at>
 <20150810091004.GC3249@x1>
 <55C86B66.3020601@nod.at>
 <55C88738.80400@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C88738.80400@suse.cz>
Sender: linux-next-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: Richard Weinberger <richard@nod.at>, Lee Jones <lee.jones@linaro.org>, linux-next@vger.kernel.org, sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, yann.morin.1998@free.fr, linux-kbuild <linux-kbuild@vger.kernel.org>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The result of the given .config does not matter as much. The point of
> the warnings is that there are missing select statements in the Kconfig
> files.

For the I2C part, I think they should rather depend on I2C_MUX.
Selecting I2C should be rare, like when you really need that PMIC to
boot.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyJE9AAoJEBQN5MwUoCm2omcP/ikOy+3u3CkzSyfpJFqfINE0
owxiVuJXLp70RTE8eQPimfxCgD0otCADSmQ67zFJVTk7TQbyA8rzCnePnqmNMi9+
6BajoS2NC+wZKjNu50spB+f4ozQ6/4TCU35j7QODo4b8XAotdDvyJ2P7/DCkwaRf
NP+8ViNS+UsJiw3/V/53OtlVP5IKtWnQQRoJmrdN63NsOux6dakzuEjK7c/fCusa
XPmmZMqiPNYhXLZskhqxfSvRQNYV0LfutttLBPSFWVA93LqbNA64B17mfQI04Oyx
jSBfNqofGFwFM1c8errO6CVSfeD3co+EfRUm9P0/8UN283aQ05Owa11498UFaGac
t+D2xYzlR+vnqZBEWyjzuJRdTimqlOZmHjlomemutchH0RBxiulGog6Q2E7AsMPL
4dEujVxQSjXV0bR+lqjFU2x1FMdRWhw4P7NJRmSvQi6COjjOMW67X8KDqLOMrpsp
3wOhdDH9IDb4Rqc9Bc7LDL8Jo7N1mGZ1NvUMmJ8cjHQ0sejcL/9RMTXRQOEU7qIk
ZvZUmLmm1WqxcDp7kLbwmsL4gYMKKkVR5UdbUrg5QbOV+ittCe28aeS9a4zieITS
Rl88M/DdN/Nfl0Q/d5ZbdkNuoWFmSBVCITmaHOuSfN4i9JTrBiAGhUK8oYxYkLhj
18UPcW1CewfoEOij9wwY
=jTW3
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
