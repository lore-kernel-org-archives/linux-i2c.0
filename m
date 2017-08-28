From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
Date: Mon, 28 Aug 2017 18:07:02 +0200
Message-ID: <20170828160702.x45hagij4kkm5zzc@ninjato>
References: <20170815072102.23067-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2bsylw4bkiptnjz5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41105 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdH1QHD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 28 Aug 2017 12:07:03 -0400
Content-Disposition: inline
In-Reply-To: <20170815072102.23067-1-andrew@aj.id.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-i2c@vger.kernel.org, brendanhiggins@google.com, benh@kernel.crashing.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryan_chen@aspeedtech.com


--2bsylw4bkiptnjz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 04:51:02PM +0930, Andrew Jeffery wrote:
> In addition to the base, low and high clock configuration, the AC timing
> register #1 on the AST2400 houses fields controlling:
>=20
> 1. tBUF: Minimum delay between Stop and Start conditions
> 2. tHDSTA: Hold time for the Start condition
> 3. tACST: Setup time for Start and Stop conditions, and hold time for the
>    Repeated Start condition
>=20
> These values are defined in hardware on the AST2500 and therefore don't
> need to be set.
>=20
> aspeed_i2c_init_clk() was performing a direct write of the generated
> clock values rather than a read/mask/modify/update sequence to retain
> tBUF, tHDSTA and tACST, and therefore cleared the tBUF, tHDSTA and tACST
> fields on the AST2400. This resulted in a delay/setup/hold time of 1
> base clock, which in some configurations is not enough for some devices
> (e.g. the MAX31785 fan controller, with an APB of 48MHz and a desired
> bus speed of 100kHz).
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied to for-next, thanks! I even considered for-current but it does
not apply there. So, I leave the backporting for the interested parties
:)


--2bsylw4bkiptnjz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmkP6AACgkQFA3kzBSg
KbaFrA/8DXKBteAeaG3KIpU1zfUMAmnm2gHcJ4zZIGj6+vrqSZj09kNvfgj634La
em9UYdIjuoAmxoyX31A3PyokYstH2wi5U2Mxst06bfLg7AjcA5yuSt9j3DllaJof
ZdQgkcD3S5F4c5K27F6zN8mJ4C3tHPy5ydtzAxzqwKgaxv+5RDh6gcv5SzRt4yKM
sshSW1RxLL9Vsa1tPzU/FzbEhbQkL2WDaJGTBwQdz/zxhBULTahZUFsdYJT8La3n
COo5EqOKP9MRC+Fv1oi7YCI0uShZcaTxPNNlym/Rmh85awFycAJfStkTNtPwP3Ej
MFynTxU/ZkT3MR2GS3pyGbRAmwU3kdlG53lkjZuDupwO2V8A+ETavSywayCFrNDA
UHW2UN5SboHKAxpuA8NOUK6TAlhqQJKRLXPCZSVPyjQN4OEwTZm0G06usHJjXyX7
VvAxSx0sBanfRMZS866kEccltMYQ1PGy1mDgmmu0t6GeWxqjcE8CFVM6/rFWUEQ+
tvmK+KC4KRzWt3OOLHBwgVekKYf3unH4/6sa0anfRlimzFVsLwiTbvGKLchjQg+3
mdZVWl+4+eoUHzXiiEmrYLfZ9XozTsh/rKvXf73ohxVEw6Nwgn3CK/HFxkgdVhB3
MlwprgeT37Hs+Ci1z9Sw1Y5oHT1GrG5IU3irpzWeQfbeJufbrUs=
=nKgd
-----END PGP SIGNATURE-----

--2bsylw4bkiptnjz5--
