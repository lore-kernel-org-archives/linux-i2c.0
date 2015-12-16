From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: xlr: fix extra read/write at end of rx
 transfer
Date: Wed, 16 Dec 2015 11:43:27 +0100
Message-ID: <20151216104327.GC1523@katana>
References: <1450221306-5289-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46215 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbbLPKnc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 05:43:32 -0500
Content-Disposition: inline
In-Reply-To: <1450221306-5289-1-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 11:15:05PM +0000, Mans Rullgard wrote:
> The BYTECNT register holds the transfer size minus one.  Setting it to
> the correct value removes the need for a dummy read/write at the end of
> each transfer.  As zero-length transfers are not supported, do not
> advertise I2C_FUNC_SMBUS_QUICK.
>=20
> In other words, this patch makes the driver transfer the number of bytes
> requested unless this is zero, which is not supported by the hardware
> and is thus refused.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied to for-next, thanks!


--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcUBPAAoJEBQN5MwUoCm2t+sQAKusyChSOzpW8hQvA34hUzDJ
ddVUnbyqnEEP5RFZqKscIyKY6HrAg9xqXChpwdnoJcA67zycE0gLdp6ihD951D+w
1DVTOKvIqILqVM5jjAI9+xmZ1A6WSlMOCugZK/BAep2RVRW4/n0+4Q2AsbzxN5lW
qMICEOFZKpDjjosB7g04nEZpeWf1pXu7bC7nNSw7V1nzAR1n1mSnZUh2vqqk7fMh
B4UPO8xtMuyieY2A9T2+AA747RDJym1zRnxt3j728UnOi5aqTr98GIDlEiMauy1s
/jtzERkcA1c0YNxa6Al1GguPj5OERKUXIEUJGXmzy3jxsyo4T1FRTGofmWJQJBlj
HLemeedaass32ewq5PH1Q4YGxh5z6v2ynlZmzGY3WaMTMwVs62PZmLYFnCTqX2Zk
db9QX99k1VMc8R/r005T/99bUxjaz9yObMmizu/9XJLkzgvG582XsIYbUF1KcI+/
NbIB9ehXvZSmtpUAIvvCMtar0U3ep5AwTQST82spMkl6nAc1r9c/haCSNt5PM/C6
T5/ZFRBpnYghtcU7qdFTmtbuMrOpT0qpHV1he47yeKHg2cwFOZK0TcqweYzPB9EW
wqgfmRfE0UxwpXJap+CePQYzh3NeS+BX1Q23W4n5rXZpDsNYUh15XcyqzHtGnIrn
26tpJw8wQagL+WwIG/jn
=8J6+
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
