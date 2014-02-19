From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Wed, 19 Feb 2014 16:16:26 +0100
Message-ID: <20140219151626.GA13973@katana>
References: <cover.1387588711.git.luto@amacapital.net>
 <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 05:45:13PM -0800, Andy Lutomirski wrote:
> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
> contains DIMMs.  This will probe (and autoload modules!) for useful
> SMBUS devices that live on DIMMs.  i2c_imc calls it.

Hmm, after thinking about it for a while and a couple of times, I get
the impression that the functionality of i2c_scan_dimm_bus() should
better be in userspace, i.e. a udev helper. I could imagine introducing
a new functionality macro I2C_FUNC_DIMM_BUS which can be detected in
userspace via i2c-dev. Based on that, the helper can do whatever
necessary. What do you think?


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTBMrKAAoJEBQN5MwUoCm2j/QP/RweNaFTpVw9nI/LU07tolwU
/W202vUpU6lVGxLRS6WSDfjO4DvzAp7rXUdMWioxvfr3i8t+bCVkFDvm/dcpnToS
ts67v5Wq5vPYEDxrBvsQ/+IHJmKc+i1hjE8FkD+iqUN+ri/c1Xvb6YaVNsVjZ0wK
Tdm95w26cy7rcUyBvvJU8xjO0hE/T2N8mE/B7ZUpmhKEEONPv5LqEPGPPjGYJnXa
KeoqdabLmdgrQa1GfAyZ99qklDWxZ6zs4IvjonaD3cJqLnRwa/dU/kRKFYtOewNA
kUnlqSZ8Hf5F+nnBFL8Q949cv0SH5uK3WxK/0iaVMQyjJuk1bfHhIReuU2WSW1g6
gg1ZCrTQbccBv/pj76u+4JbZ235lYmOXcj+QkptyAnrmnDIg/ZneH1FT5DumQzka
VZ0WC071EmGfPGe2MZ3ZcMgzC0OzqbkaeHoVDAa+19YNjKQfKzdYxxv0kz4S/bKC
+BEiAD/7u8yH6rKiN9A9KFhvNZo5iqfNJrO62l2xcnN+GVEfUFt3ZRKkOHBT2NBt
ZLVcTEM+uAZsLPylr/hXhEQeML4qaolHiWbLalcgrmnTthiYRcktrht5MS5tsUBX
+jT+MXE25YiqazfXQ1SX/jFi/34xfcE8dGKjw/TLNGil2j2mV+hXI6eyTBkWGQOl
6zaBJWf4EhbrBLsaxnwX
=wrrz
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
