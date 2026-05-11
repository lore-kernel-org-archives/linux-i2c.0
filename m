Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56431402426
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513958; cv=none; b=Ae8LLoCRcTRXHbfuz3mWdep5UCa3+NyEwnac2uOdybuPDw9yGW3VhhU7e0APBBvamX48IKz15qfpiHcbd6cLumYPWYGzFgSEkkvaHZJNtLyckSa8+24xtUALlRBzrDGN+yX6MCy44bMSRzACT9TqX45/VElQiFdeuKUQpU73UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513958; c=relaxed/simple;
	bh=MSAKLrOMeVtUXrdQMu5EnltEbk6TAoSyUpejlgS/hmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNW3GxMNvVXqjgYALzalc1IM+raOw6bNcYhwytRf8K7Fkh4/kwsfdTww7ERsc7ZxIDJgQUmt/Pgfh1BunCHV9RDoL44NWQsRjsgUUe/4OHMEqLv4rD4Ie2WrFpLGsEa3rldlA0LmNyxK/ZKFF7XSKECK2cDlaExxF0fKMAe+7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VRldLf8a; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VRldLf8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=MSAK
	LrOMeVtUXrdQMu5EnltEbk6TAoSyUpejlgS/hmk=; b=VRldLf8aewNL2O/C2JAu
	VCMKEKYZX9+cevIflsskCzZ/ZvLOXSX49I5bwfoT4y6V2ajHr75N+hKpBGlCqtw0
	T73RpLBLnm5nKaLkRu4prBlQmJ7ffPPWf95b0RjSEk4BuwtygoVJKDe/Ct4hMgbz
	sECm20HpNbc9gmypEs5tCDdJqN0aJapNnDHwZ5RpcU4+JbG02UzAX0/c1Gw8OApF
	kLYnU+eWd1tredl6A4tyxaWdzt/emjd+CT/kqaXdoPBsQtCLlpINEKnlveYTKAyT
	Q9reGHdO4DGsJYYYt2F7GQhv4UGJOlEMijRI4PtWOrRMITY51b4USh/1DmKZTSFt
	1w==
Received: (qmail 2642381 invoked from network); 11 May 2026 17:39:09 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2026 17:39:09 +0200
X-UD-Smtp-Session: l3s3148p1@LiEzjIxR0pYujnue
Date: Mon, 11 May 2026 17:39:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: markus.stockhausen@gmx.de, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Message-ID: <agH4HKEQ0BGK4fbt@ninjato>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de>
 <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de>
 <af9xGlIWG_OmREzX@shikoro>
 <00ef01dcdff4$42318c70$c694a550$@gmx.de>
 <CAMRc=MfN=jNiPRp_fS9T-39s7c366ak4MC6DWGFreonCZM92FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z9YnADdDyeospyf9"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfN=jNiPRp_fS9T-39s7c366ak4MC6DWGFreonCZM92FA@mail.gmail.com>


--Z9YnADdDyeospyf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> @Bart: is it possible to share a GPIO so that multiple i2c-gpio
> >> instances can use the same GPIO as SCL? Use case is explained in the
> >> cover letter[2].
> >
>=20
> The way it works is with a kind of a voting system. As long as there's at
> least one user that votes for the GPIO to be "high", it stays high. Is th=
is
> behavior fine for the recovery use-case?

Ouch, I guess this will not work then. SCL is high in its idle state.
So, all busses except the active one will request high :(

I guess Markus would need some kind of locking for the shared SCL-GPIO
anyhow. Like bus Y has to wait until bus X has finished SCL toggling for
its transfer. That's how I understand it.


--Z9YnADdDyeospyf9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoB+BgACgkQFA3kzBSg
KbYKdg/9GifAR9WaIkCVQud7aSXG8sX0UYrqWNi4X3BYDQVXAor01W3TxRcPOvn1
iIu30ifdrZZV5hpqTr2aAcxNbNaiULxrRgTetsksdh7r47gABuR8bBPQuz5fTDis
aGyTOrgvpclvBzzdTCrVn+HuxTeBGSzI1yGePliyc2y4xj2c9t6kwVAeggs39pY4
5nWZO1/P1Ya36rv5en2QhEIEDqlZ2Crau+CgV3L6tqsw7Y6C30blsiZkglebyt4d
L48dS/xjOdxu7JQtH0U9M726V69z2qi8SZjGhL0IC/ZtBNxlOopCR/rqGUuymtPw
QuB0vn7rspwz8qeOieMd4QZy1PWA29V6X3uJeaCBRUbLa+Ncb7mF+0rGIn4qeOAd
tS2gp5evHGd5KFkGvUjyvKn8IbACIx/fkAp9hmU1/mpVGUEiWZn+3nKcwfcDY1GX
cgeqGuyisDWIET/Ayer0eNpgW0X/AI4qQBMu0YYElSdSukMAC45/Ko0v3gxqaHNL
brm+b1f5T2QgkFQMYMlwLia05t1rig2fuDXrKKBEGkPQ/6f3MAVfIZne8MSSLgbL
+sEpPQa17xjsXi+dyn2puwl1JjU7QuqH9QsT57defv3te3iZ2qIMbdJ+sRr/19TW
friMYB84FrMHlQkKZ1fKZpPMydNN972lKP/gM+uDSP6bF3Jt3Uw=
=dRWa
-----END PGP SIGNATURE-----

--Z9YnADdDyeospyf9--
