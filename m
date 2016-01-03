From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: imx: Remove unneeded comments
Date: Sun, 3 Jan 2016 19:28:15 +0100
Message-ID: <20160103182815.GD1522@katana>
References: <1446394972-19463-1-git-send-email-festevam@gmail.com>
 <1446394972-19463-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55947 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbcACS2T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:28:19 -0500
Content-Disposition: inline
In-Reply-To: <1446394972-19463-2-git-send-email-festevam@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2015 at 02:22:52PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> These multi-lines comments do not follow the standard kernel coding
> style. In fact, they are not useful comments, so get rid of them.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

There have been some other changes to the imx driver. Could you rebase
against my for-next or for-4.5? Thanks!


--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWg/AAoJEBQN5MwUoCm2dGEQAJZchGbof9DUGt1yTU0VdxGu
Cyw5QquSq4M9esMLjKEXWylFvBFnMIuK/mzgTR27Y5cyuJ+NEy7mT/fdTN84P0JJ
anSbCcvnyesrdJ7zu9FsFenyxo3to+1naTQcHA0pGML6ydmbqdB6luYjmgsBnCi8
vtICAUdM45mqonLXtQyqq/wmwrEtqCzLAiT28jrPh71YGwwiDZn+6vEjRKpDCbg+
ZK+SlYqz+lAwdGGliuU9o4YhwcPHe++FcvEEtVs9QlltQZ4s0XPwqheVIC6Marrn
XmtLQRS3bzZaJUlVNOHKB4RFWFA+IeY4EznhmE5VNDbKsxfkrbhYEgnQ2yeoyoEg
IKNAbJKJXwtYBL82g9hPIRS3b0umUfIKba4QFDu0NL/fnRB1maIkfMetbbJaoApm
mZRrDweeo+1LLL6e7kFK4720labqc7HiMEdMin3Fu5qaiH/eP5cZStCSpHgu6mc5
0VAqIzDzFybovsvqhhFcyDXU7jZ4R7muOPS1vem2jwQSaAwudMNkDLu7KfsU8cB8
zbWC/32hzqbceU9ej11HxzxPYYKeFqYDuhfzc9UlIbiyjH66pbU7NPFkkynpqr1g
ng0Vs2wJShf+1v7qR+CbgFsrzFIUw3MErDPNA3bUrTMQ4pMlfWmFuAKCYX2+bsmy
Zk/aZPovOVHeqeORu4Xi
=E6nf
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
