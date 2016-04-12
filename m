From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Tue, 12 Apr 2016 23:27:55 +0200
Message-ID: <20160412212755.GD1526@katana>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
 <20160105222100.GA25443@pathfinder>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59562 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241AbcDLV2A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 17:28:00 -0400
Content-Disposition: inline
In-Reply-To: <20160105222100.GA25443@pathfinder>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 02:21:00PM -0800, David E. Box wrote:
> Hi
>=20
> Sorry I missed this discussion. I believe the following code in
> i2c_dw_eval_lock_support() should make it so that it doesn't matter how
> IOSF_MBI is built:
>=20
>    if (!iosf_mbi_available())
>            return -EPROBE_DEFER;
>=20
> I added this to address i2c_designware probing before iosf_mbi. It worked=
 but
> I do not recall if IOSF_MBI=3Dm was the problem scenario. If so you can j=
ust
> change it to:
>=20
>    depends in I2C_DESIGNWARE_PLATFORM && IOSF_MBI
>    =20
> Give me a few days to confirm on my Baytrail device.=20

What is the status here?


--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDWhbAAoJEBQN5MwUoCm2+lIP/RGXyMefOYE61YiJ63N1I44o
n5zCRaA7JAVtUr2chMwXuqiBhE9HkE5AkiQ/7oadTRi1d+saR0HHWCKv7IXLHADO
KbQq2GsSChj580Lzj146tVEL/N8CUcdiY92HAfQdPESVb545xMA5uV9TT7yHX8Pn
eSJn4iehjJxpraGprShVOx85GC9HmDbIPyMs06dvQZXUorRXdMWyl1mbNHmhKo4M
CtfTEnbhC3ztOC8ugvWJKA9ABwiCTmIMgGnH85uwpsynE5WM5IKuNRP7gLFz1the
+WRmmroNEJatYl4sbqdnva2M+scS1cHcCnRAQbWQvvURefr9xEqt6nEqTJUZODlM
WMtQF5S9ivDSJxXa/XJhMaNR3yItRJtKhK+5s2ZPehaTXtyei4ZcPtRKJyg45A0y
QeXv3HI6FaBmWRJ4vruvXstPSyAUBnB0DlzwDBTatCAqx8rCQWHkgz8KACmzmgZm
rpSI4O1+AOyfPpmlrUPXAB+mwwLExh0V+6EF0k7Fo3cAtR7bhtrKR/i1gQADTiDF
CUwtPxnPr4NnEjM/KaxVCv1hhxAITgeBC8Nf/kb6e8QJLo2DpeepEqowZWrW4TZY
v6arnBQOzjFtZwnRHfjAAIAnKfYb0DMBUKAygQqlIX8ZNnxqoHp4khefNB3zGYSK
YvzphzUtJl9Rs1kfgoJL
=qCjU
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
