Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB693E6DEC
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182818; cv=none; b=S51pdWEAZISvBpuTjhWzOCdWVCeLw37Dy7v4BEpT3tRq+xHZuunzbtMauu1x5uZPmv0yhj0z1vQd0wzIy8l7jINAqUgriLP6tCEaICTfvHg4TrlYEwPCJ3Se2/K+sCw7NwZMPtT67aNyu67Pqd1Xp8FQf/zk8MuFI8qSO2apRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182818; c=relaxed/simple;
	bh=VCpHTjzNvli9vS2mofK8+7h6xfHuFTQkUqUZ8o7CN4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+TmgvbPXqUtmGchOHK8iN3Vk42Oq6t+WoBOmZplQo4MHJtvtjy9E8vMNJTOF3ulsqDkpOkMWMm3Qp82ke8utLpIUSJHbND+EkcsZMpQfV3zQRIP6i7FmIBa0/bQplvcC373iqn1MAUl9jPJt5951q8POjuIu4affBHI6RIK+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HgEJh6p7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HgEJh6p7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VCpH
	TjzNvli9vS2mofK8+7h6xfHuFTQkUqUZ8o7CN4s=; b=HgEJh6p7fxJ4dP174UpN
	6Co3dV71qC8aTcfyFmorTXAT6vW69o+WYgirE8sXhqTtt4qQPq0xf1BjJqpf+mCN
	oAju9AB2wMOpYtBYgClhN1VtBm7Gi1CXrTes5VMiF41RqSfuL6VK4vv0F93ofLai
	8Vq4DcumOaWgX+Y6KpCceDrHJ9WAXaH51QuEnUBhtjgi/oV0xHe2CIgvcN1HIAS9
	TfQKVVgT8JalhvFVcWcvB8Kchfm46MeT+i7kATgT6zTMVCiq/AMfg38d1rYHItry
	7trSZiwXpWSh7xzUS/w7N1BDYEHaoVKgmfhfzLlqQ/UxeRMO0JA/3qTEoWAlC3DF
	kw==
Received: (qmail 203839 invoked from network); 19 May 2026 11:26:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 11:26:54 +0200
X-UD-Smtp-Session: l3s3148p1@IA+mRyhSVgxUszca
Date: Tue, 19 May 2026 11:26:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 1/1] i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
Message-ID: <agws3r1sro_MK7-C@shikoro>
References: <20260511161355.35656-1-herve.codina@bootlin.com>
 <20260511161355.35656-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eiE5dycG2Eva62qm"
Content-Disposition: inline
In-Reply-To: <20260511161355.35656-2-herve.codina@bootlin.com>


--eiE5dycG2Eva62qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 06:13:49PM +0200, Herve Codina wrote:
> The AT91 I2C driver depends on ARCH_MICROCHIP.
>=20
> This I2C controller can be used by the LAN966x PCI device and so
> it needs to be available when the LAN966x PCI device is enabled.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--eiE5dycG2Eva62qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMLN4ACgkQFA3kzBSg
KbbcGQ/+OXlj1qU17pqb8y2m2avx5LKV2yhQU16C3GJo/Rxpq0h6MoW5Pw87lLA6
xv2BUKbpL365+THbtamtpRJw0Iwxl9cbqezCvkc7/EPj0PlMetowbS4xWCYC+oR+
I2R1rM2yMKW9VVc8RmLv9H+VjHo2ilsSpJtdt1P4LJaAA2API3Bl+HIWEh8TbQfL
4Ytn7a5fm5J1nGOyOdBCOaw+a5OIoGv782uUR9+536M0gQV8SsDWfWedrnRXjt5U
v/V6jeQlBxXWKf5WHS6QA/XDn88cJ6zl++zvmWi+K7whmMiwY8VwXZsCCjW7xFF6
Tg0jTrt8Ls7wz0/FUYSPVqQ3AQ7s65E9EzGI5wvvvnNWPwQOnQfcZu6YyD21igjr
nYEbjZ1lmJArHnRN+ImbAKokKKSjk3jyjHE1DJRxB2Usu6YYxpj6beO87cwcl5et
7rM2dJ+IEspYa3jlkGvEFdV+vzXWHjrxQuFXMKdxXcaHsSuOFfQ8SQAJFCbNSLT2
z9mmC/lsriKMXabNtqpbKeMg4+Xg4zikqMGCNMwzFlj60byJnZUD8OSbNadffpgx
x9DZz0JagoaywqBMnEJPTf7WKUegxVcJnRffEErT91etUbUV8ryiVSdygqzakswc
5452ZNRPwZhsnCZyGygnmhjEZJWd4jRXYpqgboPPTA1K6eCApbQ=
=yIUx
-----END PGP SIGNATURE-----

--eiE5dycG2Eva62qm--
