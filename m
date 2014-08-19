From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2] I2C: Rework kernel config I2C_ACPI
Date: Tue, 19 Aug 2014 09:44:51 -0500
Message-ID: <20140819144450.GA15371@katana>
References: <20140814093743.GB2824@katana>
 <1408081139-6292-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408081139-6292-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2014 at 01:38:59PM +0800, Lan Tianyu wrote:
> Commit da3c6647(I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI
> config) adds a new kernel config I2C_ACPI and make I2C core built in
> when the config is selected. This is wrong because distributions
> etc generally compile I2C as a module and the commit broken that.
> This patch is to rename I2C_ACPI to ACPI_I2C_OPREGION. New config
> only controls ACPI I2C operation region code and depends on I2C=3Dy.
>=20
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Removed the unrelated "menuconfig" change and applied to for-current,
thanks! Please don't send V2 patches as "in-reply-to" V1. This gets
confusing, especially when a series approaches V10.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT82LiAAoJEBQN5MwUoCm2jQEP/0t559EzXDLobua3YLKgiPi8
KNv+E3DPYYiXx3TZ4jv0tSfx6UuhI6TUTmzVZ/Inv9wcO0lQiDBIuI0AUhdidI1s
Ljjzm8wiryr0r6R9CNTzRqUvw6rnrFaEieKQR5doVA/GdjiQaFlXBXOSbOZ8loR+
RkQtwYO7mN8W9WHLGpTMf3mOWRcuPIKkd9POQsT5Ax1PyBQlg0yKSzoGNleEnr0J
bHK+IwQxVx57AU3uGDe//Y13x+czavhNhEXqc2y76Do8zx2A/qzIeWxlwTdsnxpN
skYqrcyZC6DNevMJmIJyb2VaQNiPod+/VHOirdmrdOFJCEwdD1h/JGWNbzOJis1O
3i2czT2APSDLu2yj/3mS38F7+wZXe4JjDxo3VEwFIu0W0HAh3PbxOXJUoO3TlLYq
6TT7bYaRe2EJipUcGhMYzbgFM+5d2Dz7yfpLbi1MCKEI3wTL4u/JAQUsn9tA1Y5z
0pis9z5Z3V+L/LqRS3OnNPEst/E8i7xI+dcE5Dwn5C0rGWh1Ltp7/igsWk1zRPov
3muixEp0/pZFQsA84V4HLefU+JXA1OF1E+ZjoJWs/PrZz7pL0F4b7Klq69SJMiio
ZRuNMvfqy4MPTFUCPsttL6LycVOIfuQ4sgghWurHfZ8R5Z84n2DJZdcYYoKg6Hxo
iCGREOyL8HrkphV6LBal
=iDqB
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
