From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Sat, 7 Jan 2017 13:49:31 +0100
Message-ID: <20170107124930.GA1902@katana>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201612291000.58489@pali>
 <20161229134719.GA941@ozzy.nask.waw.pl>
 <201612291517.37474@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:60140 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933376AbdAGMtf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 7 Jan 2017 07:49:35 -0500
Content-Disposition: inline
In-Reply-To: <201612291517.37474@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > > +	if (!known_i2c_address) {
> > > > > +		dev_warn(&priv->pci_dev->dev,
> > > > > +			 "Accelerometer lis3lv02d i2c device is present "
> > > > > +			 "but its i2c address is unknown, skipping ...\n");
> > > >=20
> > > > You are probably well aware of this, but checkpatch prefers
> > > > keeping long log messages in one line.  I am pointing it out
> > > > just in case.
> > >=20
> > > Yes, but I do not know how to fix it. Splitting message into two
> > > lines generates warning. Having long line generates warning too.
> >=20
> > Weird, checkpatch does not protest on my machine when the log message
> > is written on a single line...
>=20
> I hope that i2c maintainers decide how to format that line.

Make it one line saying "accelerometer address unknown"?


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYcOPaAAoJEBQN5MwUoCm2ZiAQAKAndoV8zE+O3+CefegLmdxO
+72BQ9FUm2DuEf4XCdgpZf6qUcH6rCV6Nquz1rGvk0XvdvYrxapCnVQJk5gBPH2n
BRS3ZKQN7KR9FJXZBF+3odiyVKXHD1ssrox/b5FTvhD4DjduuMlE1FSY8dwsp4D8
SkE1ajBoNTA/VMO8A7Xa3k/N1Bv4Dl+hG+zmHtcDriXmZN/CrRq0GuLT0UFdDlTi
QzU7/hT9y0ALrnPCuJ14xHhTaB4LLu1ST6EI7J0aw0U9z65aRHvwUeMDxvA57tTn
XfxbAkCHO5gEZ2u7IdS3a51CcXAxeeSeqOZU8virgIkj/sLDzj/dz8gyU3rUxBVK
EbBxR1GsmuC8jizFeIzGB/xsQcZXXeNPU4nfNso3v1ce92QOlZDvUZ6r2a2uvojS
Eb0VNTkhp2IsEL9drxpbmxSMyaRbTIq5BzxwxlRFrffedJ5H4BxcoI1DYt31T8Pa
OoEhsMaUEVVB2xWYgMhaMGcR352JYObl5Fomcp8v9nGh9ODEB18rGG2AKAIhkMcn
DaB4YZfzPYsUCMg7B8zXpFJlUkv0YhpGcoL2z2H9tR9hZsOkSmyBdNqiw4mSFogR
/76W/kzXE+mnruULHX8mOTg6LePJ/KeRpYAFIr64TiuOHO1dfPDX5LErqadznHmK
BKPohh/EPSueEV20BGqg
=1F1a
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
