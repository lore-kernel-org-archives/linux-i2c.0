From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
Date: Fri, 13 Jan 2017 09:37:27 +0100
Message-ID: <20170113083727.GB1446@katana>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
 <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Vladimir Zapolskiy <vz@mleia.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com
List-Id: linux-i2c@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I would argue that the "info" message means "the I2C adapter is ready for
> transaction now, and we'll start initializing devices on the bus". That is
> the case before it calls i2c_add_adapter().

I know what you mean, but i2c_add_adapter does more, and it can fail
because the adapter is *not* ready to transfer. Seeing the success
message before is also confusing.

> When i2c_add_adapter() runs, it will start probing devices on the bus. Th=
is
> yields very confusing output, as it will output things in a reversed orde=
r:
>=20
> - device X on I2C bus
> - device Y on I2C bus
> - cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197

I agree. That being said, somewhen I started working on moving such
messages into the core to save string space and have consistent output.
Then, we can print at the proper time.

So, until then, we should be consistent with the other driver, I'd say.


--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJYeJHHAAoJEBQN5MwUoCm2QfcP+PkCcUAnOjzw5hs5Jw1Y7ztu
zgtFgADle3izUh9Ch/rSQ7ayQyyqB1JtIpYSdU5UzYztaaJ1Ehsp8gYiGcftJJYx
0K15t6AaIPActPwpGuwPwkY9ESY8LG2rKvWICosWAoMg1KJeKlHJJTHwr4Vtbn4l
c+0qQF2Zi1RqU6A6ljyb0ik7PclAAzMLH9mQZwdaYvosFSSmipjvLUWA48fPVk99
yi8v51pUIjg0RFDPkZ4Dd1XNrnL+CS0RDwPu3g4uU52oHij2mPxcTFX1+rQgglb3
PkcQf0HAV5883Vh+rHrm+53pGAoD6d2fAJiHwuh+ogsFQjbs0umArASaJ2s4EoXm
GQwNV4lrAoIOIgVGvIlpZSTSvZ1nFd6ZgyAyujoMG9XUMdActSQBcNFsdmSG2ijC
BjOE2oU/UoAV+mn2UlB4Q4lTU19GPsupZk5ldui7RgIKJwxQF2JFMTCXas+7rjCY
m2sH3rLQeoLoUk6/6ZpH1RSV7ueP2yXfk0N9UnKpsPEYzlOHXHAtCclbeyl+tsSl
Te5c+iciwZZ9vWSBC+KBaWansRKPV1Lj2svFGSNZu5DCSj1CffO96JeYXeAQyT4r
IFv91cgCewdKcf9IJwCLQwVxWZe9SL/YAwQ/uwIt3dgOwceATymkbA+w1FSd/+Yh
D28JWodv4CvAXf7528o=
=VUyY
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
