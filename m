Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CE3F7A84
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620980; cv=none; b=a5ljbtVkMbNUz86XgddIuFAwIz3qdQ7TeHCDxwjZq2GIhLVTHj6TKa0cxcV12MHSc/AfyrIHtRD37tyxrFJwyNXA8isWkXIkm3EudAIwu6wVT6KPPoi8hFv5NJEqD4jn6CHfCljoxXUXanYMdevNCAVI1AOXDGiBPg6xWIleLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620980; c=relaxed/simple;
	bh=R+sUtBhGW0J1RHQ97pjYqKZXkZNN3enOEC7i8su2Pg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2pT83G+XJG9YCxraVEgSSmBEyHiSBbrriNs7aN1BI6gDqkONYOCoTWXD1ZRQFygOTb4jpWozoLr3umBZ0cT2ulRirupye/Juk7rWQ6Ht4CwQQaYa0V/0C3rQ87cSOmI+nifMMtH2HHr3KADbQEewv1v2Eu4wmx0k5RrLxzhmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtaYmaAt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtaYmaAt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4870206f73bso12731515e9.3
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774620975; x=1775225775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHsqb7OMW67C3bSA7IIsVMp/6VgZJI3d8eT1J40HkNU=;
        b=KtaYmaAtevPBlgj0sXaYXRQQt53GKmaRzHVX1vLFp0AcvTllutWTtotd8Yr3/34aUZ
         3+gH7YRDBEk6T/r5B/M7k/1sqoUKPfq2LwouOJvk75K/Up8LWhsIxXu+0n6L6BfvXcUm
         7/OVraLilqYnSRC9SsAbFxOeaCU+xGBS2jn0gXlp1e2DibIT7CXOkjuyRm5ZdVM3AcPm
         mR0YILdCmk5VQRGYg3pskVZnHTYjeiUrTSn3NnLbxCJZwQQrgJvVIxt7exRGOnE/stcH
         2cXg84TZXQ00icLbWyQKEzlnKzF5jSU+xLscrlFBPTJ1HTJGyBNLpAphnnU69gQyMVx/
         /oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620975; x=1775225775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHsqb7OMW67C3bSA7IIsVMp/6VgZJI3d8eT1J40HkNU=;
        b=UuNpROKEzkd2T6MflW84gw9zXEROvGW53pprX6j8UQV5GfZgs7sWtwpsoDHQ6ozg3p
         SeWlkR7gdQEe8hVrr4pbCu7ACoQXBNBRgnC2FVDra9WVjVCZCRrejtuyA+6x5IZJvk1+
         yF54fFFenijROWodIehQnGtOm9QUqppEUEDm/7905D94TBzRXibo/RIKEWTf2aecDCOd
         jqIMyd7rK3ZB9wTHBaDgkXA6uOgcuHkZa3JX2KoV53GXrwlFyuWHgbKMqM7HM+Byw4bj
         CwH+gQABSFyIOgL3CdiGKWmVc7rVlCC1vtBuGIDrbcn/gF7l6aYD6ypNDBIHT/jm599J
         g6jg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6qf1mqCm/2eDeUlgznyb74BwIUwTr5vd1L9WRKSNq8901ZkfEpkH/L4G9c3+agCTaZjfUcD6FOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZwUliXoDwINJvWP8a6zVCiUVqwIwQcPCNWYT2l0J178bFipl
	fkK46soVaYw9yU7761bPnLbnf4/eEurDM13+2mVHaX/5d+dixFF3sixO
X-Gm-Gg: ATEYQzzXr+JwLilOs+TprLTaZ4E2N934TJWxczHcZ/KD9nHae6pJKo6NUhGx9EEaCwD
	+5k58KQGVigOLJQ9OseLCLqaRVnHoaoU+NxNFv1I6PfymvUW1tK/dOJCwR8deISeph8IxFLXTY7
	DQgKU3YjFjSXeYBHXtC39KU23kwc/3IhgmmpbyGNdZJKaTvTenXekg7JxzzyecxGDITKtJ087k+
	8uCiMQ+GmbYpMJC50tMbZ+lDH7TnRZ5hjMOK80dpOF3TE7jXbtyFhXvP2R4upYDFE1eF57kmMbe
	3/TaeHKOntFMz7AEPGd5y7b2YdzGBxFad4+JUeoZTdGGkod9KxcU6IU1rVoWcMbg/yxTuA0xSR9
	SKIjOVLEfvGTROVJwyiXRADYEtH4xRu1st0IZQk+iW0ipo+fpazR3eMKZAC59BQqKc1PjnvG2Ub
	IPgNR4TiLn683i5zLcKNnlbUIvuNda4OU9FeXe0csdkPLE+mKndgW33zkrk7FnsqF/bcx7LmttP
	Txez0Yao3Lx7w==
X-Received: by 2002:a05:600c:6287:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-48727ef1782mr43695195e9.3.1774620974725;
        Fri, 27 Mar 2026 07:16:14 -0700 (PDT)
Received: from orome (p200300e41f249a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f24:9a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c95041sm92036255e9.6.2026.03.27.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:16:13 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:16:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: ldewangan@nvidia.com, digetx@gmail.com, andi.shyti@kernel.org, 
	jonathanh@nvidia.com, akhilrajeev@nvidia.com, smangipudi@nvidia.com, 
	linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 RESEND 3/3] i2c: tegra: Add support for Tegra410
Message-ID: <acaRImyfWsNZfkkY@orome>
References: <20260324055843.549808-1-kkartik@nvidia.com>
 <20260324055843.549808-4-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awbmawfi5hvhlc66"
Content-Disposition: inline
In-Reply-To: <20260324055843.549808-4-kkartik@nvidia.com>


--awbmawfi5hvhlc66
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 RESEND 3/3] i2c: tegra: Add support for Tegra410
MIME-Version: 1.0

On Tue, Mar 24, 2026 at 11:28:43AM +0530, Kartik Rajput wrote:
> Add support for the Tegra410 SoC, which has 4 I2C controllers. The
> controllers are feature-equivalent to Tegra264; only the register
> offsets differ.
>=20
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes in v3:
> 	* Updated timing parameters for Tegra410.
> ---
>  drivers/i2c/busses/i2c-tegra.c | 63 ++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--awbmawfi5hvhlc66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnGkSsACgkQ3SOs138+
s6FV1xAAgJZmb+oxr2jVWnAb2IYEsWqKbYgyeV4CovWYcak9Ed0DXKXyQdQQK/X7
PN4VmnwOfmQO47nsjYw1mu9S5MOW8q6UC64zeiPLtar3b4oZs/9Lg3YYZju3obFM
JSqViJ39PaEzWrepVhUnfP0DvsNhSsv0xMi3o/j3BwBJXq2v1vzCPzsZaxWfpSrL
+3X7qLz1Rk6A99HfChwyBwHbxx2T+xOW7lp3jp46CMM/xA8t6Y4m6U9cGBDO428U
GtfJm9gez9ApI8n0wUueb2LAWb8MBlvbJf88cY5gr39H+fMP7xAxcwyPtim8CJP8
7SqvW5rixhMJAEEpJts6Rd7rXc2dx2Hk47FwRERtSQNSJcs/sXWCtv7l2HnYlstq
LwMOYrq2ZmF2bs9gigJ/nKKEARaSL4JDQ0xI3T+c76tFQzDO76+JZtxwWjUOChsn
q2IV332QKpKAZ/CZDMSPqG6vNTgdKwr6W80MTFK2FLW6tzKiRuIpU5GX0IJsag5w
X7OFFD5XEvu2QrUHq18PvoHhasi/da9B7vf/vE7jkqF50adaTqMzS28sxKoJnEsR
4Rm7QcHhbpNfw8URA7OkEU6LHCTUXZ+d3Mq3nvaDoJySAE6G9mIUyRl0Ct4pMPvJ
8koaue3j2VuGb5CpO70XX/N/T1Tzt16e4CTkon8AFvOiS7J2fYI=
=OLSz
-----END PGP SIGNATURE-----

--awbmawfi5hvhlc66--
