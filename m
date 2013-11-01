From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed
 mode
Date: Fri, 1 Nov 2013 14:08:35 +0100
Message-ID: <20131101130835.GC6734@katana>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381960909-1735-3-git-send-email-tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2013 at 03:01:47PM -0700, Tim Kryger wrote:
> Add support for I2C high-speed mode (3.4 MHz).
>=20
> Signed-off-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Mostly good as well:

> +enum hs_bus_speed_index {
> +	BCM_SPD_3P4MHZ =3D 0,
> +};

I just realized that you should update both patches to add the supported
bus speeds to the binding documentation.

Thanks,

   Wolfram


--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSc6fTAAoJEBQN5MwUoCm2C+oP/01f0n7jc8cQcCU9zKRno0JT
WeAuU3Oh/y56dMjRO0DFJaYgBKBmshWopxa4iIBfQtKfNeIuneqiVIMGSlQA/qyo
vYuYElpAFMSZMOtJ9dEelNpyR43qyqZoOlRLouv6JmwGhoMEs2lUjBD3AfKwbDCH
CfTFv+2KrRQMmoag6kBC55nCP47y4uKfa6B+cjIvkh++XYJShD8ZkTtZ+SXObZZ+
GMW/nrGEtazAtyWNhwhrpMeULj9PcOmQxzsLlRU8pONhCz/KENy12aHYEuKOxQud
UnhZcyyaMHnb6qhsQNTjmRsEDPHwca3fyVjY2KWQzjR56SxtzJz5fWnkX6Uhsr6g
c3DVwiAOBFo8bP8bZywMXD+aqJe2Jv9dMXjGgJt+B5eoew166EcS1Ffcs3q49Ck9
LuytP80VlhMye1hjPlFD/tBbCiOufikdZSXpFRdllQuH8SThPZiRFF4s7B1csDtP
B6yx9ZjQSQF5U6NckCX8DMPgwB5NuOLjDhqHnEUcjajCRsH2LBGjq+PiTQH+2V2e
KNcEgbzuwMrnBId9wk6g/nL3w8jpZGfiQdXHIh8XAosRhkOpyOL5rixhvvfOX+sG
7WffNTUWSrlMhn0JYLAZH4J7vEBu8VxJ5bFAjrQiNqgpfFifVZXYysCPyLUfscpR
c1dftctVWsKEJMgT3vrW
=j+lt
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
