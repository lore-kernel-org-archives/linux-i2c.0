Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438707;
	b=gjfdxgvJkNkVaC6vOiX69m4BKN1hINL99UCqgMLclwm1gJ4MCF8MChF1dReu6e0fPRPG
	 gvhJJ2VSsWNzwU0vGaiWbOQdj20eApOCPv2WGpfDLIwEnn/M2HO36eNNvGs/VuOXCSlhl
	 2lsbExN0ZBtJcFTKJjOTe5xNDZeQi/bFg8Jood2CO29qMY7vB2zfZvl3ZVwq8ZYeA6GCb
	 M71CRgWQGYw1gigVe8NHd2W7dJSwl3vNfLEl+fVlGc2KpdtrvDSghZrwgq8b3wpPyFdZQ
	 7GNd+LE/9wFQxDbl/5i85iQ14QcovIy//n7iNYJlHA9pGhEcVc3ITMiSQ4DOzJdFDcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438707;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=mzLYYjAmydjw3H3/oXbJ9XiThuY+ICSqgnzPmYbDz08=;
	b=hVAVGRvDrXZscpKF6COdxCjaHinIEGtk5X70mo2C2NX2fnkUVvtz5Rxncm4664++aTht
	 qwkig4dw/j35JNWqMfxm8wd61SLzN8ixnVS6VaLNui4UrijdEYfyJu21z8OrBKphFyk4q
	 KQGPerKxe56SPSlwArlCXbgqQ2vaxvGbDHa7B4idMmuTaTQmHt87rKVYAlFmg/pUa6pM1
	 CleDzsMdc9JmzsnHvHZ2SexYHIMqY2daoKqd1k9kBly4oeTdlK1ZZ9dtdOB41BaZbAUXF
	 QlHP/Ad2ZgswlfufTULnS7xVQeW/n4Q72I+LcYSXz08BaksPH3C7TP5B3CTfG6jcohQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E2wByWoI;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D9606A31A;
	Mon, 23 Nov 2026 12:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E6D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E2wByWoI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 92D26C69149;
	Mon, 23 Nov 2026 12:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 789EC601E1;
	Mon, 23 Nov 2026 12:58:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC4DD11E6A3A5;
	Mon, 23 Nov 2026 13:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795438699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mzLYYjAmydjw3H3/oXbJ9XiThuY+ICSqgnzPmYbDz08=;
	b=E2wByWoIaY23R3puLatDPLo+z5PjWAi3kGCZP04B8GCWr6Dok1SfsugOIwgjs+AkYSKDyW
	KNTYfB88hg0gjngpo3M7nMivD18NdaY3VhTAyZsKoF3juKCkcs7Z/exBx0ZmbaGByFSM7R
	1dx/wKuXAqt5pUu0R09OV8nnvcKjifsRzeY9NK7vCLWKSZvFXndD7bmoXiptzSzj8+E9l2
	PhPoAxhtguoqFKNS1DafeaB6+aSE+akKEXUcUrEVw6BfWExwvdRAiEHVPgE5C4neoG+/Bx
	QAzh5nMAmFCgeO7/MfNmRuABYaLeph1JZZqCGfIw4wROAycRqoNMaBlD2xMDIQ==
Message-ID: <5879612808355316fb7ac7a0a7749f6ea96484cd.camel@bootlin.com>
Subject: Re: [PATCH v2 1/4] i2c: octeon: Fix infinite loop in clock divisor
 calculation
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Robert Richter <rric@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Umesh Kumar <ukumar@marvell.com>, Shashank Gupta
 <shashankg@marvell.com>, Tanmay Jagdale	 <tanmay@marvell.com>,
 stable@vger.kernel.org
Date: Mon, 23 Nov 2026 13:58:14 +0100
In-Reply-To: <20261113134128.58826-2-paul.cercueil@bootlin.com>
References: <20261113134128.58826-1-paul.cercueil@bootlin.com>
	 <20261113134128.58826-2-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Robert, Andi,

Le vendredi 13 novembre 2026 =C3=A0 14:41 +0100, Paul Cercueil a =C3=A9crit=
=C2=A0:
> From: Tanmay Jagdale <tanmay@marvell.com>
>=20
> When mdiv_min is unsigned, the signed mdiv_idx variable is cast to
> unsigned as well in the inner loop condition comparison, leading to an
> infinite loop.
>=20
> Fixes: 03240f826b02 ("i2c: thunderx: Support for High speed mode")

I get only one complaint from Sashiko on this patchset, which is that the F=
ixes:
tag should actually point to 114c69f4be3f ("i2c: thunderx: Clock
divisor logic changes").

Do you want a v3 with that addressed?

Cheers,
-Paul

> Cc: stable@vger.kernel.org
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
>=20
> ---
>=20
> v2: New patch
> ---
> =C2=A0drivers/i2c/busses/i2c-octeon-core.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2=
c-
> octeon-core.c
> index 93a49e4637ec..85e18ca2410e 100644
> --- a/drivers/i2c/busses/i2c-octeon-core.c
> +++ b/drivers/i2c/busses/i2c-octeon-core.c
> @@ -823,14 +823,14 @@ int octeon_i2c_xfer(struct i2c_adapter *adap, struc=
t
> i2c_msg *msgs, int num)
> =C2=A0/* calculate and set clock divisors */
> =C2=A0void octeon_i2c_set_clock(struct octeon_i2c *i2c)
> =C2=A0{
> -	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
> +	int tclk, thp_base, inc, thp_idx, mdiv_idx, mdiv_min, ndiv_idx,
> foscl, diff;
> =C2=A0	bool is_plat_otx2;
> =C2=A0	/*
> =C2=A0	 * Find divisors to produce target frequency, start with large del=
ta
> =C2=A0	 * to cover wider range of divisors, note thp =3D TCLK half period=
 and
> =C2=A0	 * ds is OSCL output frequency divisor.
> =C2=A0	 */
> -	unsigned int thp, mdiv_min, mdiv =3D 2, ndiv =3D 0, ds =3D 10;
> +	unsigned int thp, mdiv =3D 2, ndiv =3D 0, ds =3D 10;
> =C2=A0	unsigned int delta_hz =3D INITIAL_DELTA_HZ;
> =C2=A0
> =C2=A0	is_plat_otx2 =3D octeon_i2c_is_otx2(to_pci_dev(i2c->dev));
