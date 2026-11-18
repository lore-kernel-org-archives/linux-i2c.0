Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003555;
	b=unt536EKLNxntRcoQHpTrbrl4Ey9Q6CiA2zw5qvHakJR3ZlJ3PVAgLUUz60mXLHt++Ln
	 dwYDcxEF+AbSNj+6oL49DUBopy7lhOHZmPgWKiyoML6I23y0erQeIqTnYnyc8jUfAjAME
	 t1xdhRlNhJIf+Maj6K1BEs+gxAYaT3Y5eN87D09A0h5PkHj0L1s20Rhx6p/Ab88Gjhao1
	 oRXfGqTeqPzXNc/NAc1gIGTDI7SImfbIQrnQikWDgmyg3vye/O3Ha4n8qVZLlLDNHK3XZ
	 wEMF9V1K3O7pkqClivKAOhhk6Fqmnq6qhHSzJzb3g8XLdo4VZrGfL0YVFkmx9vfe/Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003555;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0IHlYdsqTI5Vrn8R2+GHJnZCm0OJrTKPeh3UrUb0Leo=;
	b=PZ7kL7kKIKvjBvF9SCZgl0OmyGW5xWK1+ZmJVD+9PEmxtp/XMIKLjzgIEVWCBc7iB0OP
	 KstKapZ721+o7wyIsEqWf5LwwZHozoMq7mpciHct2szP5bpuU0aG9JjqYxdDoF4mtBSbE
	 Xug05tHBKPck4GSOUFRf8lCwtt0dcOtMIyTo3DOad9JAew7eKBmtlBwXSwSPet5uDSsAn
	 8jKBDOfV6h1/E5JSSxogJEQWcunceEerEANI2Lhi4bfkT188CC68zKsMGpzp1YlSxQyRF
	 eAw45CFxToW77ZlSfQFZPIXEpVBSF9ilhM0x+9J+XuM6GLU46rO+1Lwevt3uyIhyPOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=l1h30wly;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC259606A325
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC259606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=l1h30wly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0IHl
	YdsqTI5Vrn8R2+GHJnZCm0OJrTKPeh3UrUb0Leo=; b=l1h30wlyh8A1A4Jhon00
	hyCuaYzRncPsqgErLDMqr0ywnaaS3MZiCnHEsxlgSWezsjneZDTrB9g2ivRLcD5j
	RTCbT26GHVsKqy1/IjCTVy9bmf0qCceMfGFh6g96KuexWuj7BPD7Bd+EnIGHmZxP
	HholVtFSre9xDr2DuhP7DR/GulfupM/n0mNam4DlbOqsCAwVvm7utIUDBj5F3lDQ
	ell2I7T4yjjJjyev5qXvXylFF2acYCqyHZrZTf+37WmZGShBphUvrnfMYtVLTHc8
	sFyVJF32IjrM2lGGYg9AhFvKd0XGp7eLUxsTDmEdd6tOdzI7mMpY6wQUCdpVXGZl
	gA==
Received: (qmail 645122 invoked from network); 18 Nov 2026 13:05:52 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2026 13:05:52 +0100
X-UD-Smtp-Session: l3s3148p1@oesT1YtgnM8ujnsi
Date: Wed, 18 Nov 2026 13:05:51 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
	Luca Ceresoli <luca@lucaceresoli.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
Message-ID: <av2Ummom57XArTHd@shikoro>
References: <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
 <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
 <aPCfiJxyKOXsgNJe@shikoro>
 <20251021132529.GA4133357-robh@kernel.org>
 <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
 <20261118091334.3d51a5f0@bootlin.com>
 <CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>
 <av2Nb_likDLz1u2c@shikoro>
 <CAPVz0n2rZSRAz2NJsPUXYncgEAi9cFGM0ApfarFq5uMoO9LqsQ@mail.gmail.com>
 <av2RdnZofdcdU_td@shikoro>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="08h2Nl6XlzaOP5VJ"
Content-Disposition: inline
In-Reply-To: <av2RdnZofdcdU_td@shikoro>

--08h2Nl6XlzaOP5VJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 12:52:22PM +0100, Wolfram Sang wrote:
>=20
> > You are very "helpful".
>=20
> Yes, I am. And I am "honest" and "experienced".

You might try getting Hans de Goede <hansg@kernel.org> in the loop. He
is way more experienced in getting support for broken / strangely
designed HW into the Linux tree. Maybe he has an idea...


--08h2Nl6XlzaOP5VJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr9lJoACgkQFA3kzBSg
KbYUPA/9GAtQMCMej5RYs9mVr7dGMYAObTKhA9H3axj/WMiuVqyx+DRvjAqQFXj2
pCahYPdLRRIRFkxQfVnkYaNn97rAg9x4hydELiflOb8Xls0azptLht9nwhuELs4V
NBgxXs/8IDdZ22CHsb9mUB0spQXJWaCuRnXLYy8cenUFwG95bi6A+i23VRVCJKqR
rcwvkpmae40IX1AWGtqpoxaBh++s+qJ4FBJoWwH6Qli85OcrPUyBw3JbQXStPMTi
9z/8EDypaj0eNGOoknMofmXR9w+OfzlIwJR90nyZR2c9e7I2fkSI3HMRPtl5Ier8
scShqoIOZemgGwCgaOOxbLPI/L4xAS9vivvgGk7QPXqJpD6PN3+kzSaFhteew4mf
QgW3Xn7maP8uPveelPI4Zl6g7Zzn5nBLa+vDViomRK0Y2A6UC+cQpgamLVoyZ2EZ
T+BiBBg59MDfcyscEBBYKOPzK/d7I0P87sdN+xA90XWYWpgMhwj7u4xYo8+7HAhF
sVnBUN/7L4ckoKEvHBxWJ2pLo8Svu8B05L67x8dRhb1dFpxp/9ILmeWaxUEnyYzQ
OunwhsqUYctMwQNIPhAoEDNf1LGiHe+nqNKEyD8muw5+xVN/ND4UKAOaSfAhSvLv
0xZdOogI/aiH3cPuAal1QIk06Kr5kjwl0ga7fi1N5dK/xEmZPIQ=
=OuYR
-----END PGP SIGNATURE-----

--08h2Nl6XlzaOP5VJ--
