Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259F480335
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184034; cv=none; b=HRaNCL/Xhn4r4BlC/gRTRBt8uhIRSdkVtSxlaKVI3hldO3uvzbn8AYZ7IJ8zUfTkPplP7AQVEcftY02UYyZCW+wSXbXfx2Eub1lCdwMtVJy8+axVvtsqxUWVLN50aNuzMMrxKnOSiBq+MMdDyOSeaFXN4TZMptOPzi0BFo4rbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184034; c=relaxed/simple;
	bh=RDS8mhwjVf14yRcayjmIuw7e27kZFXYwZOsQtjsP0uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9ISWqlhg91zfvRtX9hPokGHKz9lUnItCRoaDvniWUDyDAY0Pk/HoR+6UCT0NWgAyUtc3wk+WC9Rn1QDQKcWWn3QS+BEpI93JKwcfrNcmH64JVeH4JHN8I0I7octXv4b4BI6tgqD4LM+xa+Po+SuPRoKsWe9f3NiAmfyHujdVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iO8t1/uN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iO8t1/uN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RDS8
	mhwjVf14yRcayjmIuw7e27kZFXYwZOsQtjsP0uM=; b=iO8t1/uN0qYy3pcAI79J
	cUBOkVA4Ssh1A3+hC3rI0CCitCwQSGk35HhYlA1I/RuH+M/K2wvPtreGUU9oQjU4
	EnPAM0c0gWkvIR1P6cgdykKsfplkCxelwpi7+y1u9dsBm5hRTx+Iu+HbrlZECuE6
	GKFjSffFLHhUO3YpC+zxvjlzNrj/AK4HtNS9gEfyUyQB6e31a2cxOMLXHMriF259
	lVISDO/CoVjIm7UP5YMX652s9M3NmXn0gfVkf9YQts5SOpLAmyTDDDaQh0A2JhPr
	mv8hWmhzPBX916wPxsKhLOvKFlTXrmUO+7xuHeHNv7B+ubAGMIImWvVMpJrdR4dK
	Lw==
Received: (qmail 210299 invoked from network); 19 May 2026 11:47:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 11:47:10 +0200
X-UD-Smtp-Session: l3s3148p1@HAcZkChScyBUszca
Date: Tue, 19 May 2026 11:47:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baojun Xu <baojun.xu@ti.com>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/2] i2c: acpi: Return -ENOENT when no resources found
 in i2c_acpi_client_count()
Message-ID: <agwxnY0SmwJz-Chz@shikoro>
References: <20251125094249.1627498-1-andriy.shevchenko@linux.intel.com>
 <20251125094249.1627498-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tlnjildoYICVgfEa"
Content-Disposition: inline
In-Reply-To: <20251125094249.1627498-2-andriy.shevchenko@linux.intel.com>


--tlnjildoYICVgfEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:40:11AM +0100, Andy Shevchenko wrote:
> Some users want to return an error to the upper layers when
> i2c_acpi_client_count() returns 0. Follow the common pattern
> in such cases, i.e. return -ENOENT instead of 0.
>=20
> While at it, fix the kernel-doc warning about missing return value
> description.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--tlnjildoYICVgfEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMMZkACgkQFA3kzBSg
KbbVjA//ZmW0iA5uJ0/bOELUnOvgDS2rLAZsLVEgx4b76VnaQBf6PG+sNZW9uXqS
awPxtQH5+FRGYjE0Yqo9QJ9y4+yQkLapZWbs0Hjz7asgWCxBa/rIMSLKAhLA8Yai
BKtGQcgRgWrx1IfaibtTlez3a8NN/1WVICC7/B9PtHqpUwUp9ONFr15Bi+RAfoP5
Q9RHQ1WtQSNAw3GhpmoFNbQ3z59+sSvD5Ja6eDuf2nSle2JnBs0b4xTOg4b3jLWb
mh+YF+mMDX5DVvwC3SC3v1KiVLjD7ySKRIBWKvcwJEKNslIiIemkExUMsEUF7tnH
wJAPbTiCRsPL2USwVE3DHT/lCMKTN7wqcm/z++Y4WTPA1MfFA3m1aVB8ua8YxJXO
VlJZqNvSqeg2h+cs4vMRCfSfNTw3+x3uMitTHteZ4ERdAu89n0af1ob1mZfLY5gk
TRzW1lvWLeuN+v3a9V3oG+hV7CjF0pHVaiaraznjITiFe3g9gZKEymW+MoMG5GQM
Mpmo0cTRgFZ5PTpFU5+kDyHc2UNGHThunKwSBUwVufR6CdALjx+ubolCGEzuiPRY
HqM5IeiMrBoweKE5z7mo9aEXnFx4WUZoeeOWQAxbgYnj5n/0Ft5Vw1y2Roet7+pO
5BUSgJFFfzWHZudRbI+YQIGS1K/A5k3pTX7yfZ4oWiGRi/iQc9Q=
=FMtO
-----END PGP SIGNATURE-----

--tlnjildoYICVgfEa--
