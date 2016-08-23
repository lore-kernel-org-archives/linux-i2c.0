From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: Export i2c_init_adapter() for use by drivers in
 early initialisation
Date: Tue, 23 Aug 2016 23:33:09 +0200
Message-ID: <20160823213308.GG20872@katana>
References: <1465462435-5240-1-git-send-email-chris@chris-wilson.co.uk>
 <1465462435-5240-3-git-send-email-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37325 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754716AbcHWVdO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Aug 2016 17:33:14 -0400
Content-Disposition: inline
In-Reply-To: <1465462435-5240-3-git-send-email-chris@chris-wilson.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-i2c@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 09:53:55AM +0100, Chris Wilson wrote:
> Some drivers require use of their i2c adapter long before they can add
> the adapter to userspace (i.e. before they establish and expose their
> objects in the sysfs kobject tree). Currently i2c_add_adapter()
> registers the adapter with userspace, which causes a conflict in the
> ordering of the driver's initialisation. Exporting i2c_init_adapter()
> allows for the i2c adapter to be used early in the initialisation in
> order to detect whether the device the adapter is attached to is even
> present. The drivers still need to call i2c_add_adapter() (or
> i2c_add_number_adapter()) as per normal to complete their registration.
>=20
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Do you have a patch for some i2c driver making use of this change?


--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvMEUAAoJEBQN5MwUoCm2gB4P/3WSV82TOiFq1s1oHFi9A9p6
kc+j6bowzMcv0q/gqNfu3svzAFeSudJe8osNLZBQ9HSRaGdknBzfVBK9cNzX4k1S
vGWhJnEz9ZIgpxv+pKOiII+o6q0XkTEfLPDvGmwrs1H1hwJhOWOvt4ZYKHlJGG8m
WL3BEZ46VGwLqryhf8n/nA0/KwFvmRXlvLwHQ1vsLuxZ7FaQUQGPqLvBDuFsvs4J
hV0UqWEXnQXpp21uzDGiCc4A2rMrXsenyAnPX6vLrS5QLFo9rDihW+5L2+2GxEJt
EyDNq3o/xwUm+10oymTPjMvsJCK1IAARneXSzSsOpEqLCk2V+6jrxN3ZKFEW3k/i
2oas6uRsh5iNOPw/2J1M9QqEXaHDe9PRI5BnITldfmOkxIXlWmN/qflbnyupo7Sy
Zd1ySGEJTfJ9Hg/et0iyBRqeRV+ftRBWt2Bf60jxZEK+P2liuCHQHljqqXVVAImZ
niOaLIA14JSIvp2re/VpZq2IfVFXOSELiVAQ0KkFjZc9HDPRp32hl+KzaMerA7Yg
dv9ioseMdPXwK0/LkYq0gjZy6oPESHCCCWgjQTWE5GLl3C3l2GVTD9nfeCGTMeym
LrcY9TkOLvkiqoNEUOxrmFY0ehwFNEeqrqPpGapMQpibNBF0OQvV8o1XLxo6NwDZ
v3qeK6EipPIZg/m5vORG
=kgTx
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
