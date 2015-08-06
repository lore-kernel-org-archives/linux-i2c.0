From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 3/4] i2c: core: add and export
 of_get_i2c_adapter_by_node() interface
Date: Thu, 6 Aug 2015 02:50:24 +0200
Message-ID: <20150806005024.GC1743@katana>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1438007451-8553-4-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438007451-8553-4-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 05:30:50PM +0300, Vladimir Zapolskiy wrote:
> of_find_i2c_adapter_by_node() call requires quite often missing
> put_device(), and i2c_put_adapter() releases a device locked by
> i2c_get_adapter() only. In general module_put(adapter->owner) and
> put_device(dev) are not interchangeable.
>=20
> This is a common error reproduction scenario as a result of the
> misusage described above (for clearness this is run on iMX6 platform
> with HDMI and I2C bus drivers compiled as kernel modules):
>=20
>     root@mx6q:~# lsmod | grep i2c
>     i2c_imx                10213  0
>     root@mx6q:~# lsmod | grep dw_hdmi_imx
>     dw_hdmi_imx             3631  0
>     dw_hdmi                11846  1 dw_hdmi_imx
>     imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
>     drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
>     root@mx6q:~# rmmod dw_hdmi_imx
>     root@mx6q:~# lsmod | grep i2c
>     i2c_imx                10213  -1
>=20
>                                  ^^^^^
>=20
>     root@mx6q:~# rmmod i2c_imx
>     rmmod: ERROR: Module i2c_imx is in use
>=20
> To fix existing users of these interfaces and to avoid any further
> confusion and misusage in future, add one more interface
> of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
> sense that an I2C bus device driver found and locked by user can be
> correctly unlocked by i2c_put_adapter().
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwq9QAAoJEBQN5MwUoCm2QoQQAIZSLiXkxOke3JRfUKotuQnC
qbTjMxwRetnb9b6lGCzdgbxArq5Qo69tADksBxioP/VGRl4FaqS+xWmrdLmwQ+r1
KAO9YMPbRVuPzxl+Xd9dfefsdXZ8T/UJxreiQHtaXzy24GlB3RSmHK1uFJMTnU9K
Jc0LFcQOSVsz9pg4OrNK0iM1LSVkprtpWH5UF6ye+BzEmu5kIuJDXuoR2sFjuFgA
5Uvvpr/EESlUGFApmi79nZKlcZ+JnjSQLkvhM3Tc3TIbBOuY8dMiha8Yo7ZU4W05
EEHY+OZNiFqUQychwMdZCsVJv8v2vh2BV86Kw3ORo0r13i0EJWS5UUNAsQzTPUkk
jS0mQmU3K9KuGmUFXcv3fd7/iMmlmBCOx4tQw31qrrjp85I+69BL38TxUVoXcWCK
B+8CKI64cNH+w1dRx7w+VQ7Ft+2s2NAUovdHmX4wEiNbpB2UzezhtJFXzrxD7bzA
hNaxSGUyHv0a+NGlZgwPheg4SKxUlXOoMVFRD6l3FIoSnxVK8QaG6cJefLc5BTAt
Fve+1sv4w7rSH5pSC7OJjFGNPsJMoWjqgoYtBOBiF/semgHpVjd113MIyLkiBwee
Inl3eoalVy9lIkpv3IgVlRPhemWkEUHTtYCsVLzGi4wgUXNsR6FkZ+f4Wh242wy4
oYiytIxGKzDNP5M4x+L0
=1I1+
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
