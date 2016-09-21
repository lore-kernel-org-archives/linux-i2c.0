From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Wed, 21 Sep 2016 18:16:09 +0200
Message-ID: <20160921161608.GB1432@katana>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
 <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45843 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935053AbcIUQQX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 12:16:23 -0400
Content-Disposition: inline
In-Reply-To: <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2016 at 06:52:31PM +0800, Yadi Hu wrote:
> From: "Yadi.hu" <yadi.hu@windriver.com>
>=20
> the eg20t driver call request_irq() function before the pch_base_address,
> base address of i2c controller's register, is assigned an effective value.
>=20
> there is one possible scenario that an interrupt which isn't inside eg20t
> arrives immediately after request_irq() is executed when i2c controller
> shares an interrupt number with others. since the interrupt handler
> pch_i2c_handler() has already active as shared action, it will be called
> and read its own register to determine if this interrupt is from itself.
>=20
> At that moment, since base address of i2c registers is not remapped
> in kernel space yet,so the INT handler will access an illegal address
> and then a error occurs.
>=20
> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>

Applied to for-next, thanks!

Please make sure "V3" also appears in the patch subject since patch
management tools pick this up. "-v <nr>" in recent git versions makes
this super easy.


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4rJIAAoJEBQN5MwUoCm2yA8P+gPkCMSj3dlmU90EMiZw911i
n4AmcdR8QGvIxzDjBmApTbsWczKUVFPDrCzxAkYiRntzsvavpF8W2Z7PubXl1kIW
11Lbu+kxE42l6VXsn0OsiTXn6ksT/inE4COB4rpYdLB2pmsp3Ybq1QWKYdqMxTsv
1wn6/5ioFQSH3orJC4FHOjC4SVKSPJlhs5lzLZGTOF5fbWTNRZ7RkfWY+/qBZTYb
gkLVrLPRklh8rwiV2yZELssjFEzv43JYvsLdTAB0YyP/xre9c9lbPkeGYMlDVRRJ
roz+krltmc5en0mYLQuA/s/ci++WKOorys4dqkiBdQHs6OpAbKvVghuowtjeHleb
r6A/mykvzceaggxYwd2toEMaIWDU09Du6I8seExp73GneIxvQc1fH/2Uqg1pwWXl
RM9nxGo+YhgnsJk5BHry8ndCtyB0YVfJURI9rIlGqvFAHZOEOQ6NNrNWiIrcvQWg
2u0i1g/jvlOhdF7DZsKmejd1SzQkB5QXQCeheo3dqBAuU82LO7q/kZE8rDFTd7Z0
tU9WmJ5oRweTCBXuftshufcvgJFthNT8rtxirM2aOeiTa01+PjwPZC87pNOIui6h
OWav1yHxq3F8i6+HVq98XHctLvt6VKrN+Gg/SiOVvXJueGWmhGJqZn/SJO0jz0a5
wk0ETo9fdibzUAVklXrr
=XuKI
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
