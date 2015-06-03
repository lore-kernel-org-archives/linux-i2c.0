From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: Add acpi support to enumerate i2c mux clients
Date: Wed, 3 Jun 2015 10:19:39 +0900
Message-ID: <20150603011938.GA1548@katana>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20150602161953.GA12451@katana>
 <556E4C7C.8050009@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <556E4C7C.8050009-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 05:38:20PM -0700, sathyanarayanan kuppuswamy wrote:
> Hi Sang
>=20
> Thanks for your comments. Please find my reply inline.
>=20
> On 06/02/2015 09:19 AM, Wolfram Sang wrote:
> >>+#ifdef CONFIG_ACPI
> >>+static void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
> >>+					  struct device *mux_dev)
> >>+{
> >>+	acpi_handle handle;
> >>+	acpi_status status;
> >>+
> >>+	handle =3D ACPI_HANDLE(mux_dev);
> >>+	if (!handle)
> >>+		return;
> >>+
> >>+	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> >>+				     acpi_i2c_add_device, NULL,
> >>+				     adap, NULL);
> >>+
> >>+	if (ACPI_FAILURE(status))
> >>+		dev_warn(mux_dev, "mux adapter slave enumeration fails\n");
> >>+}
> >>+#else /* !CONFIG_ACPI */
> >>+static inline void acpi_i2c_mux_register_devices(struct i2c_adapter *a=
dap,
> >>+						 struct device *mux_dev) { }
> >>+#endif /* CONFIG_ACPI */
> >IMO, this shares too much code with acpi_i2c_register_devices(). And it
> >pulls in ACPI into mux.c which is not really needed.
> Even though mux is a just a virtual adapter without any ACPI ID, Its slav=
es
> are a still actual devices and needs to be enumerated by ACPI. So think i=
ts
> accptable to include ACPI in mux code. Don't you agree ?

The resulting function should be called from mux code. But the function
itself should be in the core.

> Also ACPI handle code in this function is slightly different from
> acpi_i2c_register_devices() code.

The only difference I see is that one takes a device as parameter, the
other an adapter. So, you can read out the device from the adapter in
acpi_i2c_register_devices() and then call
acpi_i2c_register_devices_from_dev().


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVblYqAAoJEBQN5MwUoCm2EcEQAIjX0D7c0GmDBd8u51ia93NH
ucIddwI5tPTuX0f23svL5YcYcXqWG/kHoKn4Ek2Xrp2L4nmuLamtNBQ8AvFYOpdY
5Q30c01SonkkZsA94gXRs6bNR+49aX3sdmNBrRIWOoM8Ciuq0yJNP1e16X/ju/xn
nrF/A2eXsg9lfXtEtykLrLzMIT/1UOdYpJnSmpuzzh6kPT3tPyD+GI8PA22EHllS
pno58tvADdFoKX9KaGudO5d5UjZK5i1FccWC8kKjP/lSDwdQR5e95zzj7Xp5curL
v77PIiiIOLWcCWR4I6YJlOhf2k/ogl9ojf52jEc9MugkrWYo4JBO8cbQnRuYa87I
O4UQQtxYxjyVikGRBmejELd1m1Cf0EDrvbGfz68lO0b5zmhQ9bB1/L7L1LPyGehr
hHCn16k2uk+1NxG9w2VUaHHrU8F3QgY/SaJcRvwF5/GrVk4xThyrGQ0/bcSMrgG/
zhWkm8aY3sZetFEc6wB3DaSPZa0cjRvNWUy9M0XdKRHqeG1W5CaB6o0hJxMZG967
4CWLGrEqKOalCpvFWx9M/OYwtzZOlsXcZ+JnqvtXLP5qNtA0Psdy5DsAZ5xP4G5+
gjJ7KNpyZpvaV5SJna4tBSZrUsqTGSykpz/8dUUMxR9amx0GVuSq6Myh7aK3tW+Y
ht6zXFjshqkTSDU6Hu1t
=J5s2
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
