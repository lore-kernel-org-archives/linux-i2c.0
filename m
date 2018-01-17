From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
Date: Wed, 17 Jan 2018 15:37:43 +0100
Message-ID: <20180117143743.mnsmhsbydyp3gv7r@ninjato>
References: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
 <20180115175906.4ezync7thrqvqjcu@ninjato>
 <87k1whpp4b.fsf@jcompost-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5yffpxfjt5p22d7q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:51875 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbeAQOhp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jan 2018 09:37:45 -0500
Content-Disposition: inline
In-Reply-To: <87k1whpp4b.fsf@jcompost-mobl.amr.corp.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc: linux-i2c@vger.kernel.org


--5yffpxfjt5p22d7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

>        unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>=20
> It uses the first element to store the requested length.  Therefore,
> in practice, we hit the issue with "greater than I2C_SMBUS_BLOCK_MAX +
> 1".

Right, there is one extra byte reserved for PEC. So, the actual buffer
overflow will happen at I2C_SMBUS_BLOCK_MAX + 1 since
I2C_SMBUS_I2C_BLOCK_DATA does not have PEC.

> I have a added a little c ternary instruction to keep the same level
> of debug/error information.  If you don't like it we can remove it.

I like it. I just didn't include it in my proof of concept.

> I have updated, tested and attached the new version to this email.  I

Very good, thank you!

> also improved the commit message by adding some information about what
> is expected by the documentation. I don't know what is the process to
> update the patch to the mailing list.  Should I send a new email with
> the new patch instead ?

Technically, yes. Usually, resend it as [PATCH v2] with a small
changelog what changed since last version. Just dig the mail archive for
examples. However, since I really want this in v4.15, I picked this
patch from the attachment and have applied it to i2c/for-current and
attached the stable-tag.

Thank you very much!

   Wolfram


--5yffpxfjt5p22d7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpfX7MACgkQFA3kzBSg
KbbSDQ//V+gkfXmTOdZybjQ5FmWtbZCgCp8rwyjcsTQ5WVfs8wtDcmVS1HVKosBw
AFSS423Yr3XH/iSG7V5pR+VB1rH0ye1CddffUXFhZHzOpnhNbiSD73rVrwQ9v/G2
4dCHp+LWvMNTjR1DMSruvIuiEcPjRyJQz3JJK0vIgf9tUm9CbmfBI99E1cHq+MRv
pFUm4TNdl/OCjkJt3pxAIBdZXhivUzUu2GEVruvtt7nXAEM6uSE2Mpc9uCHkRGnX
Strq0yb7faVjeci0ghp4gG+TJ4N+iUIgKEQ8jtfaw76orMrlvsZ1FPn8O/wFVg/g
EmG6Okn7M6SICPQ4Im2914rHrUaEutTueoqx/bm3/Tql34GNzKzsE03ow9WyGkXw
LEWcQmZw0XZd7m9wxrcYbaacd6CsgpuXjhQS8zKVV/mXNJhpvJhOILHdpHPMlYD1
5sJGOIK3jGgj1aLAYAeawOFcGMidR+JeA95pdvWKiuElwABU16iWPrrwpLAES0j4
A93i5Y3ywfTsNVgx8aH12P8kWNqT06nZt+fRj4NfEkAQ2kFHnv25irnV/D3m2/Jl
xfUyOoirF/MO+VjdWtrVt0NlkQ1ahy4f5kgMLAlD6+zm78w43+xZEoDI/H6YDT1r
M4m52SPwT0Z5fUkf0SsDD6adIszsYc3aoIL/IZptv0H8AIfLa3M=
=WMsE
-----END PGP SIGNATURE-----

--5yffpxfjt5p22d7q--
