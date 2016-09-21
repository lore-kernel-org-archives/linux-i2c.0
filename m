From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Wed, 21 Sep 2016 18:18:47 +0200
Message-ID: <20160921161846.GC1432@katana>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
 <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
 <20160921161608.GB1432@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45953 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933504AbcIURCB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 13:02:01 -0400
Content-Disposition: inline
In-Reply-To: <20160921161608.GB1432@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 06:16:09PM +0200, Wolfram Sang wrote:
> On Sun, Sep 18, 2016 at 06:52:31PM +0800, Yadi Hu wrote:
> > From: "Yadi.hu" <yadi.hu@windriver.com>
> >=20
> > the eg20t driver call request_irq() function before the pch_base_addres=
s,
> > base address of i2c controller's register, is assigned an effective val=
ue.
> >=20
> > there is one possible scenario that an interrupt which isn't inside eg2=
0t
> > arrives immediately after request_irq() is executed when i2c controller
> > shares an interrupt number with others. since the interrupt handler
> > pch_i2c_handler() has already active as shared action, it will be called
> > and read its own register to determine if this interrupt is from itself.
> >=20
> > At that moment, since base address of i2c registers is not remapped
> > in kernel space yet,so the INT handler will access an illegal address
> > and then a error occurs.
> >=20
> > Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
>=20
> Applied to for-next, thanks!

I meant: applied to for-current!


--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4rLmAAoJEBQN5MwUoCm2x9QP/ieOWTRZ+/Twz4PtDHQa+j9k
MJVWne3tWv97fvtXaMQXYujG0HXpz6AhrI1FKdbj1lpkDsDsQLtRHc6SLLJSv0Vl
YALZRCOjW63/zH1LlaERt7Tvx6YaoADYKQqH+8kRN8UyWnUrpKIa2Fwn4XG0tPLD
fQtIUyTIFjNOW6UjjLD5mxbeOvjXerTGhBE7stnr1xzZ+4qTNrY2ZWiSEqCFhdys
Bu4ZRjm0WjPA84XFHqlKWH6ikKP7QBlY95eD9Bu3HV3BqqL7g4dRyvvsfrD230hq
SG57//uauFDY8R3SShodIHSrtoFa9xh9AZqAPV3KpTeuvjbEmI6VZnXFdkxRvmGp
WZbllJxdP/cwOtMV3EGTHINar7X0+vQhaq1npEZQDdKICbHdQ2Xrnb9MFCp1MyfL
HFvX5yeNMIvtdj7+4Zx3tE+xDvfzeQLhLYCE/p+Vbc6akVJ/Pr0BVvALGcZahs6t
nNsv4TOXuI8LJKfZ+VeuDw2cT6OoKXch8rEGfB2rWacWBreQid9NzlzWLQ7ERNNy
QmbIJfyi/JxwMsakA6e7YRHSpKIbOmbGPk4G4xGLgieOW2xQDRv6VLMKLbH8mP8O
KL/8ZB7tGo5hkifSWiJcnr4o8Oi3xIlqlukCcGNFkRIn/RseONxPY9XJr1sVZGiU
GS6fLyl9UCZ2BeoUPOIB
=bG2r
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
