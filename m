Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF541A515
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231781; cv=none; b=uW3TPE0gVIfiXpyhmmT04o19COwrzwWOwvCP3D2xPvBNripmr7YbsGOBxbZM++3DwfR48oUiaBRzDnbzEQA4U9HlTIN8dDecBPxToRxnYgVNCICNZxbsJ8iwUkxOhhNlF9N9QpXnpXJNwsXxyffuYG+2SfPMA+CmNysFDPdPQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231781; c=relaxed/simple;
	bh=7SrdqHLZC/Mgf/uKk2l49ldmXUG3z05MWUkGtG2aYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gch9L9jNsnAPQAWf5J/G2J0ZQUVgLxP1/r4a6FiBQZ2uV0X/Jac4+PLT0RT4Wo8LI/Hza17hwpUawQF2NBsrFYIHVccahGkaDs64TcwAG8J0Gke5KP7BJmz+9bvwZWvJkzuvl38YYJVmRTREGa6mMN2yuZpNdyS3PnrL5kELjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MA834bxO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MA834bxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KZmC
	LxBNWHZYJMBqp1YnmEmNVoi5E4Wr67qwBaAZ8ug=; b=MA834bxO1bPi0ssQpXtn
	HhcH1CzLXv61O1s8rfhSJuQWDtexloq40wOVgLSaeqRxy37Ee6+bnCDydjz2fnm2
	perGQWAxDsauDiRtymfLEJpfKlLKxgFeeBXix5//yybrUR8v3mQtTG6u8ybLelTn
	NNj+0BIEXNmacF4w4gbN+IPruOmg/SvTKkq9ty/wZ7wJ+hAy9hu3jxjQo1fcGNkL
	hQ1HF3FFQ5GeMGDTAGQBos3R1usexYeDEzRvoEDZW+2SAS4fUeeunxspbpNq2afF
	B4L615/IUlN4FhNAfiFgiHHDLIV2I292tB149HQ+ErornS21MWnFQ7Xy+iMy1xQG
	Pg==
Received: (qmail 917632 invoked from network); 28 Jul 2026 11:42:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Jul 2026 11:42:47 +0200
X-UD-Smtp-Session: l3s3148p1@mR5WqahXMKgujnsk
Date: Tue, 28 Jul 2026 11:42:47 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <amh5l4Yvwemws6Cx@shikoro>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sN0OwJ0uFvrRYx46"
Content-Disposition: inline
In-Reply-To: <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>


--sN0OwJ0uFvrRYx46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> My thinking was that we are trying to derive a timeout for transfer
> completion, so the transfer length and bus frequency should already give
> us the theoretical on-the-wire transfer time.

With my experience in all these years with I2C, this is exactly true. It
is a _theoretical_ value, and the practical value is at least board(!)
dependant. It may also depend on the environment in other cases. So, the
theoretical value may supply a minimum but IMO this doesn't help.
Because we want a precise value, but we don't know it.

> On top of that, we could add a fixed margin to account for interrupt and
> system scheduling latency before converting the result to jiffies.
>=20
> The exact margin is open for discussion. I was considering something on
> the order of a few hundred milliseconds (e.g. 500 ms), but perhaps that
> is still too optimistic on some systems?

See, you simply cannot know. So, why not leaving it to those who do know
for their system?

> Alternatively, the core could provide a calculated baseline timeout
> (transfer time + fixed margin) and allow userspace to add an optional
> extra offset when needed. That way the default behavior remains automatic
> and works for most clients, while systems with unusual latency
> requirements can still increase the timeout without every userspace client
> having to determine an appropriate value itself.

We already have a mechanism for userspace to set a timeout.

> Do you see cases where a transfer-time-based timeout with a generous
> system-latency margin would still be insufficient?

Regressions. You could time out too early on boards which worked before.

Happy hacking,

   Wolfram


--sN0OwJ0uFvrRYx46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpoeZcACgkQFA3kzBSg
KbZ3uA/+LLmsCG/OCnRbhf8qigFt+/wDB4BemNuEsK0QzvnM4ly5rlFwWjXKQ+in
/KQ32mWqSoIMK17S25I3p9LqgG6TaJEmrYSWPzU1Echzqa0hmcZlDCcLzN7pUtSg
J/b49cn/blp5OytnrK6nBK/QP7zhkSdPGsmQQxPvwKTSFmzMYSS1rf8ZcWz6Gqlz
bN1OWKl15JpVmJ1aU4hkgIPKVHdtcTLFUIjBxLyRfQUD/nB5aRf//rO+CKKP5fnr
wU2L7L8lwvZkismW1qy0PVhIj1SPLDWLr1moeeC6O0hPWjyG3GWUs+sKuJFmH1dn
yV+PCkhNsUSil4fKxCuFjoQgqckG/JUwm5CmxgGioqDRiWGHWw9ynULcrj2ILZ4Y
QtTW8frG4hdTvlK8Ybu+M7Ta9ZWnckiXztUV0wtW2SUWD2KxhwnhwXOJIYcLXOCL
g2c4M5Jk5TSEdk5vOkRoSGl+zxRYS/wDbD5SMmOwDMZRrFer7Ab0/lcOTtKKlX6q
gwZl6wZfR8OmL97or70Ztxk54gzq91usOelAcsNH5ZxZadp8w2pNKlJW0xgMf3LJ
0RIJ2KA4kb4hrMVix0Shhclt3Qmu25L3OP0r79nOoCY15/MJf1c2GcGaLOGWxbxz
IESX/xcAzvLBrYrR4ZJepdiNwf0ozjBZTySCpu1i7Kw6uSmDSYs=
=cJj3
-----END PGP SIGNATURE-----

--sN0OwJ0uFvrRYx46--
