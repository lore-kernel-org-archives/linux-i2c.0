From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c designware add support of I2C standard mode
Date: Sun, 9 Mar 2014 09:07:53 +0100
Message-ID: <20140309080753.GC2575@katana>
References: <20140116193345.GB4127@katana>
 <1390236338-21407-1-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390236338-21407-1-git-send-email-romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Chiau Ee Chew <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* fast mode by default */

Please add "because of legacy reasons" since the usual default is
100kHz.

> +	clk_freq = 400000;

> +		/* Only standard mode at 100kHz and fast mode at 400kHz
> +		 * are supported.
> +		 */
> +		if (clk_freq != 100000 && clk_freq != 400000)
> +			return -EINVAL;

You didn't add the error message I requested last time.


--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHCFYAAoJEBQN5MwUoCm2naQQAKHnlAs5QVp89Pwg1CUG0E8S
I8xzKt6poP+bNznTsxNCrQiWJLSGAh3fu6PYtTaIOpF6syuayzuC6PoEP1wCUuFe
6Z4srh5j1+nqmGs4TarLD3+Lu7nkGGalw4KMavpXbR0QdHuGZFJuxmE+iKuhE5Zt
xhuXoK+i4NalPEXoA5c9oGFZ5ETPu7wefu4sANnyYchwDyS1JvmflMqrzC+WqYvz
QiUrGk8Ar3qCMVbRX4guAZklRm/OZnNH2S4/G0cQaVUeERG0f28KsBEaEFYnFG5s
F+569ot/mBeh1LoJQjfjIdHJwKJf4swbjmwNeB78OA5xXfwPVEsypH5GmCeVWapR
j9pbV6LHVyDIXn+HibIlGNzyEVWkc+qs/mFPBz+ZycFKZxLoskfN7UNq7+BgIXfa
/86WFki+iutPv3xCrWNDGEhWvgDAK0sxysJoLev19d0L4WkPhLTQ6Fn/laHc+y+2
1UH2mA334+Cg2sE81HRdg1KZhx7Rya8QO507Dgbu9f+MPOUPd+lpTkE1PnLP9ZKS
hP9UgbR/wLIEA9paMj99hZ9b85mCv0qX7E9u3wX6dtfQZuAKqqPtgj2rKc1YPuEu
HX9BhsxteXMDYtqEGmKwJIYfdxFgdX0j59tx64ru95uwVl3uIA9X7C/MQtZIbSrI
4vLYTXDiHWcgpLwbC97+
=nyS+
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
