Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DE33BBCB
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260140; cv=none; b=SRJJM692ccPYmlilo25KgXr50g+5JEuo6VM04BbuLAIdEQZrDIa3//JVYcnzpRlKH1S1P/o/iP0rP9wED0lRGwqonnoCAHfWSmhwIRWGCZK4FkBkhsdja+PYbpOcSHQr3aNRmJWSolfOiecz8OudNMOQ5iClqOZv0j+MuQchl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260140; c=relaxed/simple;
	bh=0xZnyobnDTN6EpYnIqEzFusGm+Th6HeCIfCKZbX9FF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw6jWrszgeCiwtyd0KdGjJbWsAoNaIgiE5/cga4/ZJDJbg+a8xDMPgTxBFImYZAm1bZuizgbW46dyS9nhCpnMjU+J4xSJBe3cPmr8EXmadgkBlci+gMQM/8wZ741YenG5fInKIs7ek0vu5FGPyyYt3FI9U+OStMh6sI5D12D+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gOwefI/2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gOwefI/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BEZA
	JIMYn7qCWgrMe/q+7Sm+GALcAp6puRc4Aua0vl0=; b=gOwefI/2M5vFNqhFdXBt
	sDHMV1+yizmGRl4fqWhCWIR7hRdWCXTkVDjOIX0LwhBbRJQAkhq7jQ1FT9vnWdk0
	52S9XeZEVlySg6qr8NrO7fiRoW48scniVyjvMdt/LS9uHN+S/2cHB/7JlVN8f94U
	eNUs0OLuRZKteub3Z2QT9xsk7NXRGjVonwVSSp5KvaGwUpyQdIe/wdBd72HgPOFC
	vT9qsjFEALusKI1o3X15iEOkqpBdBYKOUzMQ9liVaJwhgRJ/cDadPh3dGIyBzMAY
	aWgRLdXAu6e7VlbtcX/fRqx9igV/r1eh6g3ZJR4TILcQB5ITlDaGERKxBGbadiOD
	HQ==
Received: (qmail 553104 invoked from network); 20 May 2026 08:55:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 May 2026 08:55:34 +0200
X-UD-Smtp-Session: l3s3148p1@XdA8SDpSqpoujns7
Date: Wed, 20 May 2026 08:55:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] i2c: mux: reg: use device property accessors
Message-ID: <ag1a5TLH7L-BSWWp@shikoro>
References: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GpLqKNGRsPZGxh0y"
Content-Disposition: inline
In-Reply-To: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>


--GpLqKNGRsPZGxh0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 02:18:50PM -0700, Abdurrahman Hussain wrote:
> Convert the device-tree parsing path to the generic fwnode/device
> property accessors so the driver can be probed on ACPI and swnode
> platforms as well as OF. The helper is renamed from
> i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.
>=20
> Accessor translation:
>=20
>   of_parse_phandle("i2c-parent") +
>     of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
>                                          i2c_find_adapter_by_fwnode()
>   of_get_child_count()               -> device_get_child_node_count()
>   of_property_read_bool()            -> device_property_read_bool()
>   for_each_child_of_node()           -> device_for_each_child_node()
>     of_property_read_u32("reg")        on ACPI device nodes:
>                                          acpi_get_local_address()
>                                        everything else (OF, swnode,
>                                        ACPI data nodes):
>                                          fwnode_property_read_u32()
>   of_property_read_u32("idle-state") -> device_property_read_u32()
>=20
> The child-node branch uses is_acpi_device_node() rather than
> is_acpi_node(): the latter also matches ACPI data nodes (the
> _DSD hierarchical-property children used by PRP0001-style
> firmware), which have no ACPI handle and would make
> acpi_get_local_address() fall back to evaluating _ADR against the
> root namespace and return -ENODATA.  Routing data nodes through
> fwnode_property_read_u32() instead lets them resolve the "reg"
> property the same way OF and swnode children do.
>=20
> Behavioural preservations (deliberate, to avoid regressing existing
> users):
>=20
>   - The three-way endian fallback is kept verbatim: an explicit
>     "little-endian" property wins, then "big-endian", and otherwise
>     the host's compile-time byte order. device_is_big_endian() is
>     not used here because it ignores "little-endian" and introduces
>     "native-endian" semantics, which would diverge from the binding.
>=20
>   - The "if (!mux->data.reg)" guard around
>     devm_platform_get_and_ioremap_resource() in probe() is kept.
>     drivers/platform/mellanox/mlx-platform.c registers i2c-mux-reg
>     platform_devices with no memory resource and supplies a
>     pre-set .reg / .reg_size through struct
>     i2c_mux_reg_platform_data; without the guard those
>     registrations would fail in probe().
>=20
>   - The "if (!mux->data.reg)" ioremap block (and the paired
>     reg_size validation that depends on it) is hoisted above
>     i2c_get_adapter(mux->data.parent), so the fwnode path
>     preserves master's ordering of "ioremap before parent-adapter
>     get".  For platdata users the validation runs from a slightly
>     earlier position, but mux->data.reg_size is already set from
>     platdata by then, so the order is functionally neutral.
>=20
> The OF-only of_address_to_resource() translation in the old
> probe_dt() is dropped because the same address is available from
> the platform_device resource table on OF as well as ACPI, and the
> existing fallback in probe() ioremaps it.
>=20
> Acked-by: Peter Rosin <peda@lysator.liu.se>
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Assisted-by: Claude-Code:claude-opus-4-7
> Assisted-by: sashiko:gemini-3.1-pro-preview

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--GpLqKNGRsPZGxh0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoNWuEACgkQFA3kzBSg
KbbBfBAAtZhpDYCLgXIXG4cwHa0GcllqDNKx1tMGxG3iP1QdHkYa/D3Sytdf77Kr
qr3UIGIoDvo9Jfop56/oBeGaLncx3Xvpbq0TenSX4JZ4w0/gy+UwC2zB6YfC83Yc
CezRW9QuheTGGCpG441q95zcs19slaZKFFOw18iY2dzs55RmwrnHTZeybXjgzPzx
HLPtiBCt690nBYwRw2ISirtSMO1phsOybwocN9tnqnorHBDNvSYhunAPf/G6JE9+
ZKZo7Xv4gmEfm5YY70RT6OjGzK3af+/CYThfC07k75fYCR40IclBH1Go893c+pTW
TWmameZS2tqdgskMxRL84bKoK/Z0m/bpFJ42Haf7VuvmsANi3SVUXcq4eBKOOuF9
mMhjUzC+sIHazd6wm6LEB8jT/Ui3i4y73LVkz4RJVcHk5Z1BYzfgy02ftQeKZQjM
YYHblR+XZjSS9Ln52uJpGokmv6hp4qNldsFkW20BytZ9Tf32J/w3eg0GAycCfOR1
FuXQkZdbeDRGSdEHiTRax1c339KUJXEPwOm1nPyTdeBzlW8Drp0/n4QWjUW59NE1
2svbqgHVNFKibFe9i4iJRbmSQfb3AKO0ZaF9z9mr7cc3Igu26YaFN4E7DcgEAljO
WfOQdb2zWhKXl6MNTQWonktVUgVUYd0AhOxF5aDpzpxygjklCHY=
=a+R9
-----END PGP SIGNATURE-----

--GpLqKNGRsPZGxh0y--
