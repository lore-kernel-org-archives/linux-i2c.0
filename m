From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Sat, 17 Sep 2016 23:49:12 +0200
Message-ID: <20160917214912.GA4395@katana>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
 <20160826173019.1f939ce5@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58493 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbcIQVtX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Sep 2016 17:49:23 -0400
Content-Disposition: inline
In-Reply-To: <20160826173019.1f939ce5@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Yadi Hu <yadi.hu@windriver.com>, linux-i2c@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The eg20t driver uses i2c_add_numbered_adapter() to register adapter:
> >=20
> >     pch_adap->nr =3D i;
> >     ret =3D i2c_add_numbered_adapter(pch_adap);
> >=20
> > Variable i is assigned to 0, it means that i2c_eg20t is the first adapt=
er
> > by default. if another adapter registers before eg20t, above code return
> > error for index conflict:
> >=20
> >     i2c_eg20t 0000:05:0c.2: pch_i2c_probe :i2c_add_adapter[ch:0] FAILED
> >     i2c_eg20t: probe of 0000:05:0c.2 failed with error -16
> >=20
> > So, we can replace i2c_add_numbered_adapter() with i2c_add_adapter()
> > interface.since it dynamically allocates the index number.
>=20
> This does the exact opposite of:
>=20
> commit 07e8a51ff68353e01d795cceafbac9f54c49132b
> Author: Feng Tang <feng.tang@intel.com>
> Date:   Thu Jan 12 15:38:02 2012 +0800
>=20
>     i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number

We have the same problem with i2c-pasemi:
http://www.spinics.net/lists/linux-i2c/msg25761.html

PCI + i2c_add_numbered_adapter + another device adding i2c busses

And we cannot simply change back to i2c_add_adapter() because it will
regress on those systems which originally wanted to have
i2c_add_numbered_adapter().

> Looking at
>=20
> commit 03bde7c31a360f814ca42101d60563b1b803dca1
> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Date:   Thu Mar 12 17:17:59 2015 +0100
>=20
>     i2c: busses with dynamic ids should start after fixed ids for DT
>=20
> it could be that you need to set some OF attribute to reserve i2c bus
> numbers <=3D 1 for static usage. Assuming you use OF. Or is it automatic,
> Wolfram?

No, you need to define an alias in the devicetree. I don't think this
platform is a DT user, though?

> If not, it may make sense to add a helper function exposing
> __i2c_first_dynamic_bus_num to drivers (something like
> i2c_is_dynamic_bus_num().) After all, i2c_add_numbered_adapter() mostly
> makes sense if static i2c device definitions exist. If not,
> i2c_add_adapter() is just as good. So something like:
>=20
> 	if (i2c_is_dynamic_bus_num(i))
> 		ret =3D i2c_add_adapter(pch_adap);
> 	else {
> 		pch_adap->nr =3D i;
> 		ret =3D i2c_add_numbered_adapter(pch_adap);
> 	}
>=20
> may make sense. Unless someone has a better idea.

Interesting idea. Need to think about it some more. I didn't have a
proper solution so far...

Thanks,

   Wolfram


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3bpXAAoJEBQN5MwUoCm2Og4QAIQ8IPKHJ1C20YlEZMbHZsWD
LS19Z8f4bnCop+G+B/7i6zw3ckv5Xtq3DcIWe0ZgWoCowJMDNhh5wRvwW+LZ6DlC
po8xrDw/0GJRAgcBKDCHOe/gDtKLyGblf3m+6X54nShuklsbg1wNUfljsSZR8xiC
KubNL/HIUv7rXDn9A9CLXTfmJA2NYbGhewaXZ8p3vTIt8tm7vebG+XT+awRfJyWg
IGXxB0Qaa4thJfGJd5iN61rJfVnbBSJ+ftyhEYe29MmO5BRjx3wcSh99iDJU/IZC
L/beyTYSU1iAQ1R3JvS6bafk5fuHr65nMdJVMhqiHSVY3OChmpMlCQt8HRNUjmt5
q5yh8X0nhQJ1yBJfx0onlNXHxD7kJQKp6FOKIi+XRfU4THQgQnGk5kW5SOALR/CZ
X2O5AFEhjIgawxR9T0DHwtJxyCw3Moaltqr1u62TdrSsqbTm8jlf7g7u/EmaoPf9
HBhgRB0Z4UfzxpC4nUr4wPZnGPqCdhz8knzWKZ79xmp0ZDENInaKAXy5uTjzNBTZ
EI3Fb3SBZHwb/tKqBuQh0vRTVDr69GuvMqMEKIhifKAazzRj3KpzC4GXvBpclNsy
jnYOSicqLBthGNZS2GlnZ2ukNu0nlwvuOVwB/N62KHZeaC+sefloI27sIm6nEUdw
x5cCV4yLIMMe4W62gEuz
=SzjV
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
