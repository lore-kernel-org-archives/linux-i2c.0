From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V1] i2c: imx: init bus recovery info before adding i2c
 adapter
Date: Wed, 9 Dec 2015 11:18:09 +0100
Message-ID: <20151209101809.GB2305@katana>
References: <1449221594-29603-1-git-send-email-b54642@freescale.com>
 <20151205190736.GD1597@katana>
 <CY1PR0301MB0858B65C8F06804400B791F4CF090@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34606 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434AbbLIKSN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 9 Dec 2015 05:18:13 -0500
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB0858B65C8F06804400B791F4CF090@CY1PR0301MB0858.namprd03.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pandy <gaopan@freescale.com>
Cc: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Li Frank <Frank.Li@freescale.com>, Duan Andy <fugang.duan@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> 	I have sent out an i2c runtime patch which was acked by Uwe Kleine. I th=
ought it would be accepted, so I sent out this one based on that one.=20

Ah, I see. That is okay to assume. However, this patch is 4.4 material,
while the other patch is 4.5 material, so I needed that rebase.

Thanks,

   Wolfram

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZ//hAAoJEBQN5MwUoCm2KjQQALGAAGr+H/a/GDqVN/4JZxgE
OzkMs3bzWL/bysWX9JIqkMAJuDSeSscn80eJe2oByPoz5Ni2XNAMhSI6jrI6CIKa
cE92nR6YjwugZD0CLfyOva/TeodxkoGmMKuhJQDwxwnXn4awbQyCUeUdVwH2PJYN
xGZTBtb6m2rHsYSMOmHip5oPnhvupZE4Ar8RQPAM9YHBXF/YdwJZGzGYjvdd3TaS
2lSwefOZA4OkRpkshnMKFynHmFDgyOtfYXQJ/IA1MwV3byjpNzdieP3YTxBYOXCi
eu+2qyHZUpAb83KkRzH9eT4XngnGr16hUaXO36vGVRJ95pGtfZITmjjEDyhKnlfI
bZBF1OWONTnF1JyvnPzkEICfm5hlijA+Pze0WrGwn0b1IUYyhv0hFWdncB2fWwz7
tfuA4FsFR7NqffJDF8Rb9jXPDXMAMsslnfVr8v+0TWzuc7CqQlfw+ccJmhc2d6a7
fSZzTOd9vMMr8r8FTt3mxZZP3STDT4uDK55PX17Kf6vJLGXy7PSMH1xvsAXyvyUI
I/D4QlzsL7cWyOzQQs7EUaMW31qfRKEXsBYto/lrf95JYTflESrAiirsGImgJd9P
5h0HzjpLWmKBForpvvc02YiB5aI+Tth2zYvhCk58Kofys+xwhqc0g1DESbUCE6bD
E94iidJhUf/WZNQUoRTE
=ibVr
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
