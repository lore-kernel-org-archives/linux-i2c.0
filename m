Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241D2F746D;
	Sat, 10 Oct 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639928; cv=none; b=uosdJXUxwCyp2tPmMDaleaZzaHQVzXBf2c4BSg3/p8pGsRgn4j/Fwdi71/o3JIFd8gMm1AyXUzItvp3SziO7VH+h3WTXgS5Q7GV31AmRMqaCthjwMwU1fC85clVnfnvScFGDO3rpsqsidDa1Ec3YTYvvSFLGmRsQaYvfAo7aGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639928; c=relaxed/simple;
	bh=gbL11+W9Q35aQMHTPYqZJmyCA5BPZEsxaoCaFRF7joM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni/GnLIvi4cWIlKRl3hmBTSCNzQ8qbkkHaNixnaGM5KuK3lBJvR+MM0du5b/NEIkEKnUsm/6TKTqDNNzHCFGUAQnUDoDPxxa4/WhMVvIXqD+JK21fg6CdD1+rRapYU3fg64sz4ss5xDTaiv31jVSRcj9TnOdRI/8vmy2iPfSX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqqPL+98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqqPL+98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080BA1F000FF;
	Sat, 10 Oct 2026 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639927;
	bh=6p3Q4UHmLA/FAIeBYxvX1+VG/3q8uw0L4WRoUdkA3tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZqqPL+983fpFFL11OLJkyQykEMherA5fB7vOAqZxWc6dyEQIoFbmgFgSY1KucttoU
	 T24q3tSxwns6N6czNuXOZZRbqdW8IqLfN206sQT2OlEQlJH+VhdpOXiUf4IsJEo/gD
	 RGz3QEJ1GzB6bLG5iqIxd3/THWjfVK4NoGqnXyRq54/eu56yGMPH7DXVnCLM0y3ggY
	 vLSzaooXS2yQE7zjSw/gQym5ysJMHBor1U7nnIGeLDJ2zQpz0DsM6Th91ie9/AELt0
	 eCDS+VyaPw4UmKha61Ngvpzmk62VeT6nz8NSccYkTAxVslUT+zg8FmJUMGw+CmUBsA
	 gfCAa4s5QhTMg==
Date: Sat, 10 Oct 2026 15:45:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Oleg Keri <okerixx@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-cci: skip core clock rates the clock cannot
 provide
Message-ID: <aspA3ZawIVWJ3iLL@zenone.zhora.eu>
References: <20261008230725.3228-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5ivrq7i7uo4ncbp"
Content-Disposition: inline
In-Reply-To: <20261008230725.3228-1-okerixx@gmail.com>


--d5ivrq7i7uo4ncbp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] i2c: qcom-cci: skip core clock rates the clock cannot
 provide
MIME-Version: 1.0

Hi Oleg,

On Fri, Oct 09, 2026 at 01:07:25AM +0200, Oleg Keri wrote:
> cci_get_required_rate() picks the lowest rate that has timings for every
> active master, but never checks that the CCI clock can run at it. On
> glymur, sm8750 and kaanapali the CCI clock table has no 19.2 MHz entry,
> so the request rounds up to 30 MHz or 37.5 MHz, the timing lookup for
> the running rate fails and the controller does not probe:
>=20
>   i2c-qcom-cci ac16000.cci: CCI clock is not at expected 19200000 Hz
>   i2c-qcom-cci ac16000.cci: no timing for mode 1 at CCI clock 30000000 Hz
>   i2c-qcom-cci ac16000.cci: probe with driver i2c-qcom-cci failed with er=
ror -95
>=20
> Only consider rates clk_round_rate() can deliver exactly. Glymur then
> runs its CCI at 37.5 MHz, which has timings for every mode.
>=20
> Fixes: fa1eb3af12fa ("i2c: qcom-cci: Enforce the required CCI clock rate")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>

pushed to i2c/i2c.

Thanks,
Andi

--d5ivrq7i7uo4ncbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQScDfrjQa34uOld1VLaeAVmJtMtbgUCaspBcgAKCRDaeAVmJtMt
brrDAQDqwo1/KEp6XQyTV0vNjk9XrnYAGFDVSKuHg8VPlx0ZiAD/ZPUp0SAYPWwt
SlMC60uksRZHy05hJXmz58D0ouEffQ8=
=T79F
-----END PGP SIGNATURE-----

--d5ivrq7i7uo4ncbp--
