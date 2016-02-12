From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: iproc: Add recovery mechanism in error case
Date: Fri, 12 Feb 2016 20:31:19 +0100
Message-ID: <20160212193119.GR1520@katana>
References: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
 <1453940842-9658-2-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FNX2SHge3qdlDajY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:59316 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcBLTbX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 14:31:23 -0500
Content-Disposition: inline
In-Reply-To: <1453940842-9658-2-git-send-email-rjui@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>


--FNX2SHge3qdlDajY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c);
> +static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
> +					 bool enable);

Can't we move these functions instead of having the extra declarations?


--FNX2SHge3qdlDajY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvjMHAAoJEBQN5MwUoCm2W1EP/0QEw4aaEXQmpFMMEITpHn+O
ycTY7fIQLgxO6ShQX2gEtWPP1svqyI6HYOyOWobZNBbntK4b2FqLv4ynkn6xkBYd
f2OKa0nhmiI/nK2j/xiLxya8ELH9KJ95vTJx0S5aQWLWbHm+SHCoIHxUr4hdPmFd
Ejsizhl1N3uk17p6QNUB3/tTAyafkfZL50DWi1xj5fWMgM1fx1iAqc5Odiu0nXnv
GEd+nNfSUmHw549fr2w39zaV5FTfxLDaAysUvSWOyh7Tw5v1PAQTfe5G/YaIJFpB
umK06nRe1pJ9o+FOvQ+ZFIan9kol5kVePr/dCK0/X8HCVWabe9wOR22KcRWLh2sj
8xqpt7L3fSh7rnkpCSGJK2PqspVt2Y1sXYKZLOBPqIDGuN/c2oK/FL9c834v22aT
0SQQ2s+Bp3ZYY3fnCvuQCgK6an3hvQyGT512Sz217RsqNbEgm+Az8/JvVx450Bv+
c5Y/ie9AwWeLXKVR5pDrNdo4E4/J2ifOwhLVVD/JjKlSyzpHrKbzlxhQrTuNAewr
sdVh8ylVRNM05w0hQSZM+XN/QzlUNtDVVSMVlOnKh5Nu8MFs9SGETJcwBwEWDT2b
N8oeCYOelSwVkk1w6TawTjfjjglqqQisQL0QxhRAIEqZVy/1ZwYMACdoKZnfPqKA
4P2yfWwCd1FRPio6I8l3
=LoKT
-----END PGP SIGNATURE-----

--FNX2SHge3qdlDajY--
