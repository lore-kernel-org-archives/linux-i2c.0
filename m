From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: parport-light: remove driver
Date: Wed, 15 Jan 2020 18:26:27 +0100
Message-ID: <20200115172627.GB1239@ninjato>
References: <20200113210643.5033-1-wsa+renesas@sang-engineering.com>
 <20200113210643.5033-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38770 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgAOR03 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 15 Jan 2020 12:26:29 -0500
Content-Disposition: inline
In-Reply-To: <20200113210643.5033-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 10:06:41PM +0100, Wolfram Sang wrote:
> The justification of a light version of the parport driver was less
> overhead for embedded systems. Well, today, even if an embedded system
> still has a parport, it surely can handle the fully-fledged parport
> driver. Remove it to reduce the maintenance burden.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4fS0MACgkQFA3kzBSg
KbZvJw//e4NbuWYj1ezrmJ5r6BIJ8emvvOBtnzTmbTcuauNdzGA4pj5dSNOy0iCY
zILAti9+BHc96jAiMpVr5Sq3n1+/ECgfT4TO5+Z81MpFyKre0VneUhBUkfiTBEA+
N9Y3LwvfcZCvatcPh61oVwYhBn1n2FbH5D2oYqdGRws7c70FzcjD2Sr98OyJu6jU
M4HOjAKO2P88larxU+oyWcw8IOHBemZKtvRHJRbwHMvtOoFAwNZlrnJWBDv1OVjX
ZnG6joxdxnIVoLrTJtvzt1fR2o2BYT4vXJTcq0KJgEpWh/uCxSuLHctVAyZYytLk
f7207BKUagfs2tXPhNTGboWSArwIiP+wFWC29BuLR39L5MJkRRIuZlVTSPi/5JJI
i+L0EKgLlov57ISZAlZt3jMjiolLCW6vL0Mr3VpjZYa0vFbCBNWMYQ32mKwTf8q6
N1qrapOCaAdB+3p4hFRrhN7hV0mLIHUJNlOnz8lGPbiivGjx4Po+j+xX7OrotyBU
t3cbVyAB8IbBLqUQNo9BCZrWqU8wlT2+1uqDA23Dk5gn0jE/ib1F08WhqVPB+/wh
5kwThdESysSFXGsOzoyTosywYcTP390fEoLPJQSp882Mse69i3JkyAxLTqJF58Oe
UPtwrikBSvszQPYO0suk2d/vZegohm+fwo9MfxQ5M68/qH8Zr38=
=oO4b
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
