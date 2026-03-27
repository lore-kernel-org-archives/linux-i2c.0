Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F53F23AC
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620953; cv=none; b=IVFK1GYvRhbsVVqu6ZtNQcgvCID4Rofbykq8eibNW/9DSEHlLl25jOBZmvdM3aS+iHodQuAkkU2cdP6tUDDZzoXUA1ax5ZBW3LUWRu5pPLQlVLENwajCYPjMV+BemEniDjfdEJ6zbGVIQwQLriw1Ve1sn5vZC89irYWBgEaa0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620953; c=relaxed/simple;
	bh=CMCodREyX8+SopcJOJgbtv3/VIX8gK3dnN/CbucnNlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tewcCL9JN3FR12Y6eUFq81FKH46hAKqH2PRr1Jc6TsNCDascQxE/paTPyXrvO+wqirxLPc8mQKsxZln1p/5q3hy3o02B+cQqiDtTPiQ3Hr9Xz/qg/uro2/P/kMiYEFyZL7wbiEViWzWuUE5KbQwFJ0PfSZFbv/jA2vN+/I9DS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8fZVgPE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8fZVgPE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b96760easo24340765e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774620947; x=1775225747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENWfid/HKNpDLLdwdQudk9l0qrO8hsNfLIypj1TrVms=;
        b=p8fZVgPEHNnTksMSBOMX4LnmoO24radOGWSVp/pc1EG1g59Vp3ogz7/Qf9NJsFdJKF
         PXK0/fBZPbpKNfuKSBzwDvPJs9JdBPzHcCDZksq4yN735f8ZI6+VbSQPR5gpoGqrkqFE
         YwV6AyCIsYTmNJYJkvqZdtfavh3TdZH6+K55jowJzUAO1ujnTLei3EVXSu49UBnM2Bi7
         oL/nB/ysRnUpk3mZ8quV9TNZYb/n2GSQbsda8I0zRSrzcwyXmFNVTcJ8kezfIqvYnPx0
         rpfWqDgaj3yNINw8cKuXVoLWQFxyqFDSSHAvkVyjjMmI9+mbukDgjhmCexTO6a5mYdci
         2vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620947; x=1775225747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENWfid/HKNpDLLdwdQudk9l0qrO8hsNfLIypj1TrVms=;
        b=C2IeaFeg4c78SR3H8Xs2+MlapN3g0PWVMKbYFkqbrXGK8SYCImk50Sc1SMAI5Oll/o
         xDrpp+mcluA7nBwNRKfrevA4+wsg9W7dtqxO21BZwtg4d2WSpb8lHti8/9myqqQmIGQ5
         k4xdgOCCXTxF0sEqvXQ0eo/FH+UOPzhdX+hTvl33A8EzwkMyvmfjRg3VvQlXlfRCp/mG
         m3ICkSV/npIVMkDlaMiWWgwOsagIgfE/wpsdJ4dNAjUIq8l3CPrVnFKPZUjBuM+EVb63
         db6sahkwq8ChFnLeEULsZVPGYMthHiW6yUCx2nwrGmbJKmIKTmpNkG5nybAPYwLN9ef6
         YOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZhkb6QjdQEKlHvwg0Jdsn/VWKNtyWcExLpxIvTxCzOpjXEOb5UO2m8FeImPTPWJ+qI1erw1PiroU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinlYvTVT4YjCDtPQNJ8Il8yfQ1ErWpYRacZ4JBhugI7gzWib9
	BXJdtkQgRaBZxpKUtYY2bOcJXQZeddDIz/+AAcDADNoFhWlYUkYiXUOi
X-Gm-Gg: ATEYQzxy/nSe4Y2KRzOEXKIU2xPTHfXMKbiOEPzs5uMieBYcaQJJg3mx94/cAQGPnF9
	zy9yG4Ko2nEKhseyakpFWIkNwsEuC7a7Q9bRQ1xUYCpKSvbWbJqZM32eTC+n7XHFejvbYWbj32R
	iJbX+ary8hkOS1DZucaTn81NBjC/01ClFMauiqzGdr4T0veuf2JxlZPgH5EFphOrETOaMmcWQPA
	0+NUBVEhj+4ti168N5Nk3J2/sUaa9pfZXR6ukXP8YOuVyYiJvbDeZlsHkvrky9sNtn9jXjuiBfX
	V6Y/6qcw4opfUyXIIXl7FRzyAZm/eaBAdSFzRVLn0o23Rrdis6NeypKicMJU8q0KcX7mkaADnSn
	QaLLujZ4afNTKg2pKmm/ZPRHJUQQ+pORi9Lz9uQd9J0whDJskgM16vQb8WQsIZLIjWUn0qudraO
	0FFIODC5xL4vMiWe3zPpt3V3NhIQK+rSSNFmbR4m4K7NKFttfkSqzBKbj1ZbdPgNx6GewDV/HnS
	ZxAr7MpYeu/Vw==
X-Received: by 2002:a05:600c:4f44:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-48727ec7819mr47471835e9.20.1774620946562;
        Fri, 27 Mar 2026 07:15:46 -0700 (PDT)
Received: from orome (p200300e41f249a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f24:9a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9134fsm169393935e9.9.2026.03.27.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:15:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:15:43 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: ldewangan@nvidia.com, digetx@gmail.com, andi.shyti@kernel.org, 
	jonathanh@nvidia.com, akhilrajeev@nvidia.com, smangipudi@nvidia.com, 
	linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 RESEND 1/3] i2c: tegra: Introduce tegra_i2c_variant
 to identify DVC and VI
Message-ID: <acaRB5dt4EtM5-3j@orome>
References: <20260324055843.549808-1-kkartik@nvidia.com>
 <20260324055843.549808-2-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfnd3kil7qhew4ug"
Content-Disposition: inline
In-Reply-To: <20260324055843.549808-2-kkartik@nvidia.com>


--jfnd3kil7qhew4ug
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 RESEND 1/3] i2c: tegra: Introduce tegra_i2c_variant
 to identify DVC and VI
MIME-Version: 1.0

On Tue, Mar 24, 2026 at 11:28:41AM +0530, Kartik Rajput wrote:
> Replace the per-instance DVC/VI boolean flags with a tegra_i2c_variant
> enum and move the variant field into tegra_i2c_hw_feature so it is
> populated via SoC match data.
>=20
> Add dedicated SoC data entries for the "nvidia,tegra20-i2c-dvc" and
> "nvidia,tegra210-i2c-vi" compatibles and drop compatible-string checks
> from tegra_i2c_parse_dt.
>=20
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes in v10:
> 	* Suqashed "i2c: tegra: Move variant to tegra_i2c_hw_feature"
> 	  with this patch.
> ---
>  drivers/i2c/busses/i2c-tegra.c | 112 ++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--jfnd3kil7qhew4ug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnGkQ4ACgkQ3SOs138+
s6EeTRAApxEOk4jnbGUYNrBgi7YuAjHtOZZB7FrDo3dqbeVfm0/psgQ8VYyFSJ2o
d3jTB0eAUw7BDoqzOMNqAzqMf35zysGF/E0/vvFy/zsdbjCS8RvKzcgLCzwMb5LU
v87B3bFu7FMdiyC0rGDixzbNa0fmNHVNp+9DcDFxj82HeklGPhp960UDchudoHSq
ncvCO6HSB5ahqJNLqtRreSKSYDShgOA3BvNYhsjkdR3ZYCnl1HiedFmfkP+Z2UY0
oV7id1b/R1ZaO4Kc+fNu6iYM0yBjS9FL2JNZwUYL0kCf9xWJRvXe5+3nHIKLTCye
ILEcM6cjkgsBzmjIR5sgOGbIGu2El1C5OVarVQE71rl7mcMicS6OP1uEFL62glmj
yQffc7p4NMNor3WB6bzWwa+4576wT7942Pb6ajUIm9DfBZ4zvlrTTJERTtXVpjBK
tviH5nCYvl5/2bCQ1ZBvEXDcmOOh1ALstlsMbpXCfBobK84CaTp4dPfIPaNjyoq+
nT5qVQo4HqYAPKeL++wrWZyCCmmp4z7JA4sEPRR0Al/Repnao67x3aimFBLePJvl
9GN8FF4z++foxG0/Mf5jIWQ8uQEghG1WUWgOIs3LQReYxJo6P1JMqSwXyH5vnFdV
SXmpZX3rb3DL6YlXSENaAG7b/uj0IBtyUsyH8RerSIyRg3YLJdg=
=+qhH
-----END PGP SIGNATURE-----

--jfnd3kil7qhew4ug--
