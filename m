From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 03/19] i2c: octeon: Rename [read|write]_sw to
 reg_[read|write]
Date: Wed, 13 Apr 2016 10:44:09 +0200
Message-ID: <20160413084409.GD1563@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <be18c6fc7331af1b383419819a5a947f35dd6d00.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34771 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934094AbcDMIoN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Apr 2016 04:44:13 -0400
Content-Disposition: inline
In-Reply-To: <be18c6fc7331af1b383419819a5a947f35dd6d00.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 05:28:34PM +0200, Jan Glauber wrote:
> octeon_i2c_read_sw -> octeon_i2c_reg_read
> octeon_i2c_write_sw -> octeon_i2c_reg_write
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Please add the motivation of the change (the reason). No need to resend
the whole patch. Just reply with the updated commit message and I'll fix
up locally.


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDgbZAAoJEBQN5MwUoCm22xoP/1lTAORlbYCn436iUzx56IAG
zZNOGAyqOCPxItf5/+l8ZCRPooz+DbmDQq2542EF41qeDBl0BEG3X0joSxOoBQzE
xwbMxyYmsS8EHMLe/xvwBKBQL67EzQUMSvSW6bphmYB4acHU2aR9oWaqU057NWno
AX/7mp9KXeo0zutx8acuGsLweURvyU1B+RqPP+NwRS+uEKIl93ZtDpu7/qTFjyUx
MdUiG2CRnMDh8+zZOF2W48k0umhXb/OgZ5Cdto11VR40WWWrd4kn1KRRW0lv1Jkk
xyqOeUOeKWtspo2T9m4mg8prguLWM1z9kdd075IhCibmjsFCM+sOTIgfvsmPlZ9W
1I21A4Kyh/bGHAeGwhRLK/60h7DGDLDpOhSShgMZ6ZVDhyxLfxlgGklR3qzuv3XV
lKLgH51kExN+hha9Gg6RQW8VFP++ShQ5xZnwndJF9fungO4zKTUmFE5uJfzzNgs5
yzYutqsB2U3p2CrYxFrTE0G0g9JFoNARHXXajjlkDnCzk7VqH8SCkwJYfuT7ZUUM
OHK+5g1tB+PtR0i/4r3p8vK0wiou6e0rZUGAiOjGjVacBSfj/i3SZ2f9ZvKxoJkI
D+SYAG+y6ZwZ8TIsIDYPu/naJUKqYiL0yy91kxCTUab/7F31QoBogw0MPevDrz3j
WP6d0oKY/2jW19CgzOAS
=lXKW
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
