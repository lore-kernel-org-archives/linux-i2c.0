Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232E13AD0
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jan 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735907764; cv=none; b=fIK6UAsBBhXXMbVKyHsS58j2KzhVMgTwd1w10SFPECWkvJ+veREtlo3HhOYYvmWNbDoe9oeGp4rf5JKRgDiF9H94l2E5l5Jq6nA4raIOmnhrt6Q/dtV3q42XEhJyxVAcNadOs+v7ARQLNTnPloH+7dl6QBY7OUolnwKvyEtq72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735907764; c=relaxed/simple;
	bh=NpvlRkgyfFOAk74wZIMgyrXrk9djTGo33bdTe+QE/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUDZgBbrsETM0B4Tlau2YxnKHLFi9QGEYtU6X9IEOx5gp8DqMfsBQhxJtGPSULYrcrK+wiNYkypi4D2E8KSdtUXlKfs6NBz7U66iXvTsGtIQN3PsCztPSXK09uu0DsXF1z72rQgUfBLe30OSPwlzRH+4scqLnorHaFKX3uz+DbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DuzU9hWl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DuzU9hWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Npvl
	RkgyfFOAk74wZIMgyrXrk9djTGo33bdTe+QE/1g=; b=DuzU9hWlPCXYMqBHIg2c
	zgnC5ZsvQtXzeNs2NeOMruK9wAXgo39I8uIugGT+wbxKPUrYagvNUDNBtv2kSQy6
	9BRvzbax7HGwE6XvpBpMTk25M2UJRLhY9e1pDJ9afzoMd+cxm6L/7oZHZ4padCsV
	Qn2IBiiOPaexqKaaKbvv+bvh+BLy7LvFcDqe2VOHLd+hcCFuDchrXZpJwqdToXQM
	4kib4DHU/I9kO124KfWwxFQRvdSAfXnqrQn5Vhhogon2CRBlibrNsKax/TOmC2qx
	TYyxg/3rxrStv+WF3qSGmw3RSvhUTf3XqlK2a4Qi8CR6Pu26OckB3VqT+OAbK6nm
	ug==
Received: (qmail 901071 invoked from network); 3 Jan 2025 13:36:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jan 2025 13:36:00 +0100
X-UD-Smtp-Session: l3s3148p1@W29uhcwqrMUgAwDPXw20AOMQ2KO98fSH
Date: Fri, 3 Jan 2025 13:36:00 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 4/4] i2c: core: Remove obsolete members of i2c_adapter
 and i2c_client
Message-ID: <Z3fZsMAcFhp1K8AI@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Wolfram Sang <wsa@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-sound@vger.kernel.org
References: <97970201-24fd-473d-b20a-d21d2cd468f3@gmail.com>
 <9052426e-2503-4f5e-aeba-74b78da5f3b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9roZhH8wv16gGTaw"
Content-Disposition: inline
In-Reply-To: <9052426e-2503-4f5e-aeba-74b78da5f3b1@gmail.com>


--9roZhH8wv16gGTaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 11:12:29PM +0100, Heiner Kallweit wrote:
> After the lists of auto-detected and userspace-created clients have been
> removed, we can remove now unused struct members.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next by folding into patch 3, thanks!


--9roZhH8wv16gGTaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmd32bAACgkQFA3kzBSg
Kba7vRAAqdkhqQkI1blsAOWHvnhWCgKXgisdhH3PBoW8XQgaxG1A/PljVR4vaSKr
aQax0QcuwghOAGp/y5VLO4HHDxPsSAdS8Zz950zZSjhXpQaoJb/5riRdYRIYMHy0
vGlqodUkfrqbR3v/OwlGLd1qAtunqYPVzb+2MnpEmqy2H1P/qibZ0Lj9SQqOjaVp
5DxLdtbz7oXKwxGX5etrvzicQFf50dEMkREI9el0OafWB+QkaInQoJ0h8YLd6Lxo
7m7CNXjwMGnmScDu7vjuaNi3H5zJqjyTq/jQZxsO8eLHGx+WGjVm54ULRdOYbGwv
6OWnbnMrSYCO6p6+VgGpnfIGLoVO7BugGFVgnztO5XFRIR2APKFiMP7bcJFsIONU
Nm7YCLfVBoy6T6d+lHor0cvYA0CO/KISBVKcbvyUxOQEW8/AsHP9pY0hAe2CVTa5
WqzcvgbSGA3Cq6z4lsFcfJ0dUn/8cpfRH52dPspZos0MzZje6725koeb04yJTK9L
QQBR787FEvepPjkSG/U2U8XpGDu5YdTLAtHUYPjcKsEPfQrHW7RT4HMirGhWBMo7
NhOLOd540MBhHnUKhqs4DuFj/lYSTZciH51wxV1eMubht5/Tp1sx1JpkhZUg4M4d
y6afskDxJUUyW7rI4kDEdZvRXBv2B8EuA+5lAjD6wz+dwt4YTH0=
=YvI6
-----END PGP SIGNATURE-----

--9roZhH8wv16gGTaw--
