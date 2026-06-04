Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC73F6C23;
	Thu,  4 Jun 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563497; cv=none; b=sW/A9aG3EW6+hDGJHZb+DO4IpNOSVuNaMgKNGMUhy64bZcgcimJWx6iMprTAPUXmSg+RQ5CvCnk9pxDPuhfquFmrg63p96I5cO59m4Txnj5ShTyzYTL2K6uJPsdlR1UTkSTOSvgfLHd9rfdBWN1plNiXqXVpHyusPK6HH+VNKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563497; c=relaxed/simple;
	bh=Oqw/BTCOa4qOEyv2l2dqeSFwZ0yug7JH+UYGmIjLZNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agTGcyIUtcviuAHIYZCiIQ+VUuXY/w5CYhHrHmbbDsSh4PqM59AShENS3feU42FvTEtEtyHLwhM+8XjkgQs2ColM9lGOY1MDSrv3s9o3zFu2qloWWRtFqd54XkrvXmPwYnQxLC2M+s7Navs8xb/ZQyMPLmsjYOVB32vMN7GQ9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrtUb5ZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrtUb5ZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B11B1F00898;
	Thu,  4 Jun 2026 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780563496;
	bh=Oqw/BTCOa4qOEyv2l2dqeSFwZ0yug7JH+UYGmIjLZNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrtUb5ZByRFiEFpZbrtRgmfNuv36YbTyPsQBNkllK7Qky3PEBUSDGTtyingVW4rzw
	 wniw0homTKR7hKmjD7BPqSbRSsHVM6HISvLe4tmV0rwnOVzrtV6zNK6O/V/BeCEV0U
	 UqH12BDhN7woIDNfu0uuWWk2sPnIm5+XCthrHgN08MOYz00l0LY5KS29ugwjxj1lLD
	 tNt1ajpYluj4t+uwoCWjUYKk278IIrOaEFOhvTnQB6+wMArEdPIMFfo6CAUTgqUGVR
	 n859YBTDEkLN8hzklqdEMoEI5c5rqc1/Lb7gcr5J9Lc6scWRJqbWNKnoJP161BtF/j
	 RWKf07FUXqhkw==
Date: Thu, 4 Jun 2026 09:58:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SP_ISW1_AT@novatek.com.tw, andi.shyti@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ben_huang@novatek.com.tw, toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC i2c
 driver.
Message-ID: <20260604-grievance-esophagus-a607a9d734eb@spud>
References: <20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw>
 <f6cce361-47ef-4488-ac1e-5f60d3cd578b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OH38BFenAuLHnwQx"
Content-Disposition: inline
In-Reply-To: <f6cce361-47ef-4488-ac1e-5f60d3cd578b@kernel.org>


--OH38BFenAuLHnwQx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 09:26:56AM +0200, Krzysztof Kozlowski wrote:
> On 04/06/2026 08:04, SP_ISW1_AT@novatek.com.tw wrote:
> > CONFIDENTIALITY NOTICE: This message, including attachments, contains=
=20
> > information which may be confidential and privileged, and is intended o=
nly for=20
> > use by the addressees designated above. Unless you are the intended rec=
ipient,=20
> > any use, copying, disclosure, or distribution is prohibited. If you hav=
e=20
> > received the message in error, please immediately delete the message an=
d destroy=20
>=20
> So can I review it or not?

Given the state of the binding patch, you probably don't want to review
it anyway!

>=20
> Patch is obviously incorrect, but not sure if I am not breaking your
> confidentiality rules.
>=20
> > all copies thereof and notify the sender by reply email.=E6=9C=AC=E9=83=
=B5=E4=BB=B6=E5=8F=8A=E4=BB=BB=E4=BD=95=E9=99=84=E4=BB=B6=E5=9D=87=E5=B1=AC=
=E6=A9=9F=20
> > =E5=AF=86=EF=BC=8C=E5=83=85=E4=BE=9B=E5=85=B6=E4=B8=8A=E6=8C=87=E5=AE=
=9A=E5=9C=B0=E5=9D=80=E4=B9=8B=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=
=E3=80=82=E9=99=A4=E9=9D=9E=E6=82=A8=E6=98=AF=E6=8C=87=E5=AE=9A=E4=B9=8B=E6=
=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=90=A6=E5=89=87=E8=AB=8B=E5=8B=BF=E4=BD=
=BF=E7=94=A8=E3=80=81=E8=A4=87=E8=A3=BD=E3=80=81=E6=8F=AD=E9=9C=B2=20
> > =E6=88=96=E6=95=A3=E5=B8=83=E6=9C=AC=E9=83=B5=E4=BB=B6=E4=B9=8B=E4=BB=
=BB=E4=BD=95=E9=83=A8=E4=BB=BD=E3=80=82=E8=8B=A5=E6=82=A8=E9=8C=AF=E8=AA=A4=
=E5=9C=B0=E6=94=B6=E5=88=B0=E6=AD=A4=E9=83=B5=E4=BB=B6=EF=BC=8C=E8=AB=8B=E7=
=AB=8B=E5=8D=B3=E5=9B=9E=E8=A6=86=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=AF=84=E4=BB=B6=E4=BA=BA=EF=BC=8C=E4=B8=A6=E8=AB=8B=20
> > =E5=AE=8C=E5=85=A8=E5=88=AA=E9=99=A4=E4=B8=94=E9=8A=B7=E6=AF=80=E6=9C=
=AC=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E8=A4=87=E6=9C=AC=E3=80=82

--OH38BFenAuLHnwQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiE+IwAKCRB4tDGHoIJi
0j9oAQD8t2bqErB10S9guhRMT8guD9pstkggxN4KH+ehUhSwGAEAuRyg6J3JBBI5
xUrDk2oG/xY/CXH2F41HW7RicGaCwAw=
=c9N8
-----END PGP SIGNATURE-----

--OH38BFenAuLHnwQx--
