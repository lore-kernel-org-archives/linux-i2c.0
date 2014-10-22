From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of
 the _noirq hooks
Date: Wed, 22 Oct 2014 19:24:49 -0300
Message-ID: <54482EB1.9030407@vanguardiasur.com.ar>
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar> <7hzjcqe9ge.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="o67mOOA02CFoSqxtKNN2KTIT905qoTBC2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hzjcqe9ge.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o67mOOA02CFoSqxtKNN2KTIT905qoTBC2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 10/20/2014 06:07 PM, Kevin Hilman wrote:
> Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> writes:
>=20
>> The _noirq were previously chosen to make sure all the users of the
>> adapter were suspended by the time the adapter itself enters the
>> suspended state.
>>
>> The {suspend,resume}_noirq usage was converted from an earlier
>> implementation based on suspend_late and resume_early on this commit:
>>
>> commit 57f4d4f1b72983f8c76e2f232e064730aeffe599
>> Author: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
>> Date:   Wed Jul 8 13:22:39 2009 +0200
>>
>>     I2C: Rework i2c-pxa suspend_late()/resume_early()
>>
>> However, all the I2C devices are probed as children of its I2C adapter=
,
>> and hence the device model guarantees they are suspended before its pa=
rent, and
>> resumed after it.
>>
>> In other words, there's no need to use the _noirq hooks to get a suspe=
nd/resume
>> device/adapter order.
>=20
> Are you sure *really* about this?
>=20

Hm, now you made me doubt.

> It's usally not the children that are the problem here.  It's usually
> some other driver trying to use an I2C device e.g. MMC changing voltage=

> using an I2C-based PMIC during its suspend process.
>=20

So we can't know for sure if using suspend/resume is going to work OK for=

a I2C adapter?

There might be some use of it that can't be accurately modeled in the
device model.

I.e., the above example is a dependency of MMC on the I2C being suspended=

after him, but right now there's no way to model such relationship.
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--o67mOOA02CFoSqxtKNN2KTIT905qoTBC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUSC6xAAoJEIOKbhOEIHKi2F4QALGG+FKMoGy5p4HXw6JWuSG3
hKS0oszyxFN9ml9KsH6IvAJMLQxcqZIaCL1cgLVQjFOl2fqUunHjMiUWfD6cloiK
wkep+i0nELy3U8CGqd8rtsnwBXW3L1EilnBNtBpuUHPD1E3YwOna1JtAJJJZLkEY
Kut9fglwjCMR0k1AdDtSdGcRQFCST22ALCAZdUMuR9sflB17wP+eourE07DtvvxG
9ybKHeNdPpRMt6sKAvdvNxzyvoXBgRKXdsRvuuHNFg8aLTqhy1OKk/2+queUYymA
C3DxcR65tfgbqLM6BDNOf1bEuOAmvypPaVEVp7ztGp+/zXkvZcBfPPicQJsIqLYU
6s+p5G6+Q46r9n0Ekwe8w1ox3NkcrHXLdEYX0uFrlDdlKLFlNkzcKCypU2MseExo
Y0WWSu7PkxFNe6Z8lnkb75M8VKLpjyWwT6C6P8361dWamyTYXwSrJKMFQdtUtevI
7VsVocGJ7at9SNYDeYdQSnhXjYpAI576RXIC8jnBJBqDKq45PYPqXgu/XeNEo3xm
arcKxXMHmlg1FQLWHj8RXHqEGcGR+khSErtVffV5s68hD84YVj/7X5GCpDcBlO70
iIojkgFew6JE7k+baS05l3ehay+5N+/lsm/8rSRs+3Oo/v2TO6aiI/vNDbJ/wVa5
YnXdYSH0FaCS/bQCRmAE
=aGd0
-----END PGP SIGNATURE-----

--o67mOOA02CFoSqxtKNN2KTIT905qoTBC2--
