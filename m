Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA12820AC
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151934; cv=none; b=WmrYMpfAc42b3jd1xTGYLJ28fIf4zZVdYmtTcF6IIzRN9Sbp3/INYe/ASELFSOA1gsXEgkCOeJSC5IfzTHIDyJz6M38cscZWOkil04Zm8Ag16IokgEM6KdKkeeRQ06o99YykygS/1tGAiVhg0c2K8mwO5SIIDac351dfD5WNU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151934; c=relaxed/simple;
	bh=X9WTrVSFUounPOGaVIIii+C+mSd/Zh35xazajV3XRf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+7cYd3sQue6pG2Zl4ZlF6pM8yTjQkgBRbI2r2Uj21ZbXDhzhidxELjzwEqWOXQFEnlC5ia6o7lKw+GcXH3thVm6TD37zZkf0TOV8TXq1C7yo4lGmbC3PVwRSwBC3SlzuoehF3zfWAakIb+dgMvTmoLE4hB6vvS604UKESPtgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GELE6HMV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GELE6HMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Cyac
	JKNKfEv9UF4tTueejyJLKNYk8cJgfzgRyFu/R/4=; b=GELE6HMVX047ieDLrWXZ
	InU8ZCmVdQQQLlK9ve2ysajhfS6nzacd7rf1000CtKCM8b2f5y1BrKl6mpK8cuSc
	/6FzD1GEEHMcCRSOycnpjNW+5hJLoa2Qkigt/NrAqDgIDYNNPvmv1a28GxwoMgmx
	tb+FuTgAtEd/y3KsRk436bHaqjaTxkXHLY29L+gh0B7mEyekAocITB9ngwpHxrrP
	Feo3Wcbp5rS+b1RbX3PSHfQxWnFYkvHZyyqExbj/EzKwDAto0Yp4y89dAVgs1vuH
	VlRI1CV0z7IaI6k9+gCjtU/4crzzbuEovqFe2+/yRBvVutPE0Ua9nIauL+VSyXsG
	dQ==
Received: (qmail 2068158 invoked from network); 3 Feb 2026 21:52:02 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Feb 2026 21:52:02 +0100
X-UD-Smtp-Session: l3s3148p1@BbiCnPFJoNgqAAAQagvIAoH29ntsUY5F
Date: Tue, 3 Feb 2026 21:52:01 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v6.19-rc8
Message-ID: <aYJf8X5hpVFMeyeR@shikoro>
References: <aXyk_FOGDp7qIReN@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ul+z89EnD8WLUbsf"
Content-Disposition: inline
In-Reply-To: <aXyk_FOGDp7qIReN@zenone.zhora.eu>


--ul+z89EnD8WLUbsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

> another single-fix pull request for this week. It addresses a
> potential endless loop in the imx driver.

I cherry-picked the commit instead of pulling the branch because the
branch was not based on an -rcX. Will send out for 6.19 final.

Thanks and happy hacking,

   Wolfram


--ul+z89EnD8WLUbsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmCX+0ACgkQFA3kzBSg
KbaCsxAApqS7b2e5e+Fjae2XFRb407BcIpALSzxjwhi8hHzzLb/L3DRz8gk+I90C
EzBavhkIkmwFkkM3cjdVj9hyQ5GoOCZBp38ZF472eGE4AwUF4zHJGNREGK/s3dM9
V8Ph4hMLZPGO7526SU2s8TvucsJvSyIztp6Zd5AS9JBO66z09Z5vnRGiDGt+SfWR
d0CVeFmo/6AsAQ3UxgVOUI9XhLk1/mSMaolmoL0eLbBLDw8cP4wFCQgMlUSgG0cd
n8pEG5naBAJkApO0AiYglqsSaHSBxsBZe3mu/3zka7I4aWe7nI9h6wPiOyrQkG3w
VMc8A2I5JppuFk1D1nyx4Nc6SnlWbyIHNNUDihczvw63l0Zg2xzx2/v96751upTl
qMQyeeLaU0WbactzODrZ5yDvr8TFSe90w27y4lbcq9vt5pdSZhZOWy5A5mOM0+7B
hF292U8S30u1nBzcFdh0M2a9l6iORVFchO58J6tZpf6+9tNIcgjFSRl2ZB5QsVaI
QrJUPtUAsUBnyCzDfp9tBC3RnPanr3beeGNbfk6FPkx1XmdFxErD1cwVhfdFpYzs
/Ekm2a8W3urt3p4hmMh+kyIf6BUFMlz+hMTY30E0eOqYrrFUqBXRpnbSGZGUkVdn
22GA+TdZ+rxHVlB4sIXS5l6ovQpmLRVh+G7CG0hGzr5gtqOXOVc=
=K911
-----END PGP SIGNATURE-----

--ul+z89EnD8WLUbsf--
