From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Thu, 22 Sep 2016 08:02:53 +0200
Message-ID: <20160922060253.GA1433@katana>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
 <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
 <20160921161608.GB1432@katana>
 <57E32E06.8080803@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48193 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbcIVGDE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 02:03:04 -0400
Content-Disposition: inline
In-Reply-To: <57E32E06.8080803@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Applied to for-next, thanks!
> >
> >Please make sure "V3" also appears in the patch subject since patch
> >management tools pick this up. "-v <nr>" in recent git versions makes
> >this super easy.
>=20
> Got it, I will resend the patch with V3 tag.

No need, it is already applied.

for-current carries patches for 4.8, for-next for 4.9.


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX43QNAAoJEBQN5MwUoCm2yBwP/2OA/KcYmeCOPaikV3jZo15K
duZSoHKpp7zgJFUfWFCmJGBbBkM1yHbyDB/ZxzxIn6oePmH6trHp+8u0mcBYLzqG
DdVNgVgnp4iaCVUJknQxOHGLMrjL6txikW0C8nYcA+8hunImu6aPDMTI4O43ZJeZ
4xHafYxJ+9hzYioP6xCqQRcKEFT/5dyT/vUcSDD77pI+jPdaYlWmi0imt5ywBdKi
1iJfybIHCUjreIIg8xAMwPoIX2743YTMZNRWd01/t1xCKvwud7ag840mEVpbsBzq
5eKtzc+x0Y5sd9OOB8KV/sjAU53fC+hGviz8MUL/EwnDWYX5gb+vZF9tgkrUVFs4
cy5VNAs2iq/N1ITkEW7eprQALvvVbgOO8tVns1YFRhUjFILmnDAIWOAoiqWJjarq
S5gesmMNX3q6x/3D7ZqWjNo3kcAXhZts+89H+ev5j7cR/8YHdeG3tYf2OlNzC6Me
YYt5xtH2EDOMeseNypA8bMkNFp32ljN/9hePPDDMIEOkRCuLySAWfRZz2t7WDFGd
rBxRGKhwJKeysyUFhROehIYAEHA4G52wFqalQ4fcOH0aq+aR2dMKh6/h2ldqe5W4
9r5wq1E6vzxwzzCQMnpjVjsj4f5Se0SzKcyg4xmKzFsHGhsny3AdnPSqJZcWCYlQ
uVMtRtdyvlkZTSn+NxsU
=w7oa
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
