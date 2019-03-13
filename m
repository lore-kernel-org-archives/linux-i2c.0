From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device
 idle state via sysfs
Date: Wed, 13 Mar 2019 17:36:10 +0100
Message-ID: <20190313163610.qbuexiowfcqgqndu@ninjato>
References: <20190228114343.36443-1-robertshearman@gmail.com>
 <20190228114343.36443-4-robertshearman@gmail.com>
 <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
 <20190313152044.GD10250@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="llgw3btxonqpmrgm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313152044.GD10250@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Robert Shearman <robertshearman@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org


--llgw3btxonqpmrgm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> > I was wondering if you think the below ABI addition looks sane to you?
> I am not the i2c maintainer :)

Peter is the i2c-mux maintainer, so I trust him very much on the I2C
side of things. We just wondered if you'd notice a general flaw when
exposing such an interface to userspace.

> > Or, should I ask someone else for a tag?
>=20
> It's the middle of the merge window.  None of us can do much other than
> focus on that until 5.1-rc1 is out.

Sure, thanks anyway for the response.

Regards,

   Wolfram


--llgw3btxonqpmrgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyJMXYACgkQFA3kzBSg
KbbzpQ/+M02AKPlujhv1kRj7HSJrCGl1qu1TMnqPq7crcHDCiVcJzOf74+pepT4i
LoRJu8/BGU1WffoDgkzdWQ3iPxi++UT9oX4LvhNjvhvVqbT9bScukF8KVwu/dAt/
I7DSD6LQ1Oo6A24o1FUKxN79hivztZ+O6d4XsXSFJ5lgnJ1xV9uShH/jjLeJsTB1
rxtA//h0K4/sDe8Fyb2IYWz8HnULE0IlGCqEs9kMRvAW6ht9csWr15OExmZps89g
EhDipq0a8xzxvUK+UI+SLjzLmXRzWro5illZm7H7vH6itUEHeAaJgKbkiybtWmPF
3aArYi4iSsD1IgGijD58Mm13aHCD25ZhKANHYKXFrwcrs4klCtqAHD3O06OZiY3l
Zhlw7TXcFQ1Aq4Yw9DpWZ13Y/5bzLj1F5bjP05kU7gnSre8Ku8hQtf/3/A6xcqkv
C3gFdVRmsNdo42YgvT72nifuTra1oQwm42X2rZF7Bjrp/ajFKu6zvJG6Y0Leo3ak
zdrnK89y5UPpdE88C1ZRAkdL1mWAbLIONYpELjPm7OwTSsoo9akrj4mqaKIJPxnv
/GTxXIhH2NBa5xbQwpaYRoqYKX7G7zanFmb5XEAnHArEAFkURlEdBBdBXoZInN95
vdp3ZLK9s8XJofuuLyHqQbEWdtvOUbc/kH6oQac5s/YpdoXbijI=
=DVdy
-----END PGP SIGNATURE-----

--llgw3btxonqpmrgm--
