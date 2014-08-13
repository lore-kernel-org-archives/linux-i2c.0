From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: Make I2C core able to be module when I2C_ACPI is
 selected.
Date: Tue, 12 Aug 2014 21:03:07 -0500
Message-ID: <20140813020250.GA2853@katana>
References: <1407740455-21269-1-git-send-email-tianyu.lan@intel.com>
 <20140812095321.GU1657@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140812095321.GU1657-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2014 at 12:53:21PM +0300, Mika Westerberg wrote:
> On Mon, Aug 11, 2014 at 03:00:55PM +0800, Lan Tianyu wrote:
> > Commit da3c6647(I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI
> > config) adds a new kernel config I2C_ACPI and make I2C core built in
> > when the config is selected. This is wrong because distributions
> > etc generally compile I2C as a module and the commit broken that.
> > This patch is to make I2C core able to be a module when I2C_ACPI is
> > selected. Original issue the commit da3c6647 tried to avoid will
> > be fixed in ACPICA and it's rarely triggered during unloading module.=
=20
> >=20
> > Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> I wonder if we can do
>=20
> 	depends on I2C=3Dy
>=20
> here? If I understand it right, then we only build the ACPI_I2C if I2C
> is compiled into the kernel. That way the problem da3c6647 tried to
> solve doens't re-appear.
>=20
> We can later on relax this once ACPICA has been fixed. Thoughts?

I had the same idea yet my travel to Chicago interrupted thinking about
it further. Once I get rid of my jetlag, I'll have a closer look. Unless
you already came up with the perfect solution until then, of course ;)


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT6sdKAAoJEBQN5MwUoCm2viUP/iE7LDDK53fdD+K1QXtQqfgh
qOwuE7SMMDfd3LEx59xT89qersLFIFQkxOY7V2gWywDo7yHspyzDl7mSWVFVFplp
JlZyTuswGE+QieDFKMLTccmtQJNBN+o1UXadk+QRy0NmEQ0sJbKjl0YZdPhcdDrx
+qGscfxizoeMcOTBwYo9O7V8CcoAIVZLdroF/SHi0FZnpZNqokDvrpbFJeTi4iPc
V4OZYIoc507JqZPIWxl8gSckh0yBw03DAsG68ejuhuLE1wMj2ZY1G1VkCHd880ED
giQrMt4Ia9+vLNtMfslGg7bSdxuFr9oBO9CxneteCQeiKAvuoPiuSiq+Y64GgjJm
3vXOqT08/v00wYikWq7431uDgo9dpx5SobfnyhbYuQUYJ0oaQiQFEe2NnrNxE2wM
S0+jFPZZ0kcD5JHnIbu85KWXlDiOuMjq/6l0quiMBVHW7uuAcVEKE/eOvzePtX7V
BKsn5Qti0bFfJhBVNGCcp2QZdhz+4KkaVMuNMiuly8Y6SW3HMABjuHel7EKxDmda
Yzle17bgRiR9mV+cLZxYsG7ME0P56gxme4Dz+7ieX2banci4qqDCHCdGCzwMhcKN
Oh2gghHPn7KNHvHf/jG6btajqvoKH8nbdvjx2HLR86bdoKzXJLWxJIC/7mx7XlcY
3mVc8MNsPYkryxfTE+2y
=thib
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
