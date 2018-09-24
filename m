From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
Date: Mon, 24 Sep 2018 23:58:51 +0200
Message-ID: <20180924215850.GD18592@kunai>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
> On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
> > +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
> > +			  multi-master is set, defaults to 100 ms when not
> > +			  specified.
>=20
> Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
> property.

No need. This binding is not a HW description, so not a DT property in
my book. I still don't understand: Your IP core in master mode does not
have a BUSY bit or similar which detects when a START was detected and
clears after a STOP?


--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupXhoACgkQFA3kzBSg
KbYcSg//eYUAZ+Ei5oK3se2SwBPIkZTlvmpjcMfKa5QbS+fKJqxFaV8T/Qe4GZ3s
6ZsDG3y2pXPOJbKN0r9QBUPPkoz3OXB8Kgfl1euuOodMGUnZkLoK6jtFGxlvHgPH
gBxd2GKFiZUAQJDjjitah6xOU0Eh1/t7t7uvSlfthY3VFmjvK4iKM1S5es6hxCpl
ViGuyu96+mhq1zbRXlrKoqWFAKhfvIeyLG8geVeE8/eYVhCbLKkL61WUl/9K0H4i
ZAdH/y198EF7fqzDjgkkDmuR5YPCAEXYjSzaT4F8JxbK8p5HqwedtIEd7ar41orz
SMj8wQwvgSBNmL7lO8Qbnn3AicqsBX9shtNnb6gHBC+i0SRO17MTy3or+Js5C6W0
tklQa1bZjZ0eubnmQoYFqujzaTkKR4FFEKaArz31cLIxR5CeUr1X3pJ7rKebWFpZ
QBZV1xbXcyQdmqeHM/dzhMBJil7TM8t1FieSfh2OBdGw6mqqG3XoEUSOGGyGRpdl
oUwZETMtwlcNByE0r+8rCCgY5yvD11zwGrddHZnbbfBmzp9PzyJE6sIE1pTCp/n+
fdC3O7IW4feWbiPs1UKF+EO1mFkbQl30ctEDMKt3p6anVtJ5l7A/2G6jmoeiAOVa
IRzDv8SWZjnQJFEdcwNp+Iewn7yTDgaDCXTlVnZsa/13TPz6lTE=
=iYSN
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
