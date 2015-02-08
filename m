From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 8 Feb 2015 17:29:37 +0100
Message-ID: <20150208162937.GB6033@katana>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-3-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423373126-30024-3-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
> Add initial support to the Broadcom iProc I2C controller found in the
> iProc family of SoCs.
>=20
> The iProc I2C controller has separate internal TX and RX FIFOs, each has
> a size of 64 bytes. The iProc I2C controller supports two bus speeds
> including standard mode (100kHz) and fast mode (400kHz)
>=20
> Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Looks good. What kind of tests have you done with exactly this version of t=
he
driver (not earlier ones)?


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU147xAAoJEBQN5MwUoCm2l7MP/01udlkaj+XSZ23MzexLfyJy
bw787DNzTF0rktMpqrv7UkL5X0ivRrZQ79uRiOFfG7KTUof8MyT26SZ7tbhvq5b1
rP5JcLN2Rblwf5ww8csc5V4x1zcHb5Q8aOVE6UlSL5yocPjfHEwqqMqMLPEGn1sO
shSraXY/wiSU3NLq7ih03V8fydMzAKJOMnnDPqp84wYvTCgywYiGHjzNjblAKLJO
sJHWPX9uI2WltPVIFsklX4GbR6aMC+kfzjo8A5gj6K8Behg1gHDdVJzvfoBlE7dd
QBEBD7tc2TZtohrBCTb4n83TPGr1q5D8iVZaIDFQ2CTkout9dAQ7ED6TCtv3vemN
azakAOomsE5e3kacmDL9GSCKmsFVGnFAakolpPfN+vZzYRDXYhjw1juu6z+v7GfQ
fSwbOSOzIhWqtyNKHLCITg0THznTW1bENccn8H43tfdcJtE02MMZzWSTsDJUDr/N
5zsf3ja5HDIdIxX13JnQaWMlss30LZTq+NreRFyduDRPCK4WwKuZV8lkA1NLcufO
ry1E351h6UO8xQlITKzJ9aCI1FzeUNv5ibL0dr5wm5GoisFAt2LYJ7vKtPplKIY4
rHOscGAOjqY0pl8veiTI47Ka00AYVDpWv/xgzbrSfwAeya4AIcNk9dXy6AZCTaJ/
8vBgUOfjb+TV4SyuUO2L
=iPE6
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
