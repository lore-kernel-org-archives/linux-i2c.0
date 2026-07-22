Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D147607D
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706998; cv=none; b=Xgr1lqAOushg5NoAW7qUhFgoIk31LzgoA6TdX4bb0rg9937XjHLjakARqdiqr+gySeSGLrmi0Q7PZVurqCGqNvHRVwPzzkFjRDNEgBJF/Zvqml0y/hCIsXcF2I9/YRdA03xWnjIS6ntqBAo+LprNsAhx1v7chb6u1qwLZxwHbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706998; c=relaxed/simple;
	bh=3cu0k1QMZBhmvliQPLJ6WS1V8wK+bQ5rbEx+U6SwPwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwqKtUwDVdqq7hZgJiRDE7WSTWl2eoRCuUNIudlWYMrjgSeja0HaWDH2BU6S+OpW1DRtpBkRP9S6jP31vcXLaOn1pe/tjf+foK7m01QdgmAkcL88r3fD08U7k50l+MsjTmftI2fZyfbSy6lNPD/gUv6+ECegovTa/lP0dHezTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mGLiPXqC; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mGLiPXqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3cu0
	k1QMZBhmvliQPLJ6WS1V8wK+bQ5rbEx+U6SwPwc=; b=mGLiPXqCwFOMLp2vguUV
	ZJjdGHQpHa8GXQfIk7V2kVIjerpJz3FVsyDmsNwTmdFNTMwdIETlrUdxTRi0jj10
	7J2vjB7tKiLLmrgYKG64oGvqX11730JtcJRKb/XTjDdMtImGcDp2sxZkP0TVfb+Y
	RnCotlhdkSyQuRXcXg8S52/4Gf0xlPqualm8y46q7Lrec3t9J+8epfuKS4KXQ9pO
	i2IDvKQwyR40+FVWF/bg954lU3c34e+bNgv31sv/8cLLXBG7k+K9vJv2UX0gEitv
	ha8ZFQ/dljnr3g8hyheQzp5zesvYzIfqU+jsuQ58n/w54qxSla7gu389gAxTzvo/
	Sw==
Received: (qmail 3128026 invoked from network); 22 Jul 2026 09:56:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jul 2026 09:56:24 +0200
X-UD-Smtp-Session: l3s3148p1@R7/VeS5XfUhtKXDg
Date: Wed, 22 Jul 2026 09:56:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>,
	Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
	Aniket Randive <quic_arandive@quicinc.com>,
	linux-i2c@vger.kernel.org, jdelvare@suse.de, git@amd.com
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Message-ID: <amB3qFSwbeDZ5l7Q@shikoro>
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
 <67436ff9-e440-404a-a52f-e5b238256152@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UIt1LAmLYS4JvK3S"
Content-Disposition: inline
In-Reply-To: <67436ff9-e440-404a-a52f-e5b238256152@oss.qualcomm.com>


--UIt1LAmLYS4JvK3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Why userspace need to decide and set the timeout values for adapter ?
> Adapter knows the transfer frequency and transfer data length, it can be
> calculated by core layer itself and can set.

Freq and data length are not enough for timeout calculation. It is also
board specific (e.g. capacitance) and environment specific (surrounding
noise). It can be argued to modify it from userspace. Unclear how much
that is used in practice, though.

> Retrials can be fixed and hard coded for everyone.

I don't think we can remove the interface because of the "don't break
userspace" rule.


--UIt1LAmLYS4JvK3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpgd6MACgkQFA3kzBSg
KbbmDQ//YV29lovlQ/xGMqoZdsn6gxFRjGuE1JYGno8HetY++zBP9Ixut4QGu4E2
eT8guoIjxCW2myd0yjXOwnzlEC2AVyAbbtPvmgFu6gvFk3uppYCpAs55kIHUqSUv
c0aBSolLaZqoKxhBDCZnZ59HtrcABd6q4ZydARL9Nx3iUSb61pF2QUhkQUSmcJ/f
D4KoAQX5xNVDgHhPf8BKj9GtJj4T7KGJhDy4vRzPOClYBCpoIO5HVxjZ7Iu30oc8
c4tZAoYnVlWS/snQGb1W7Pt9tCl3c4WDP32jX4v5ctEHEPPY/pHo0EMLkPwRBG2M
Mb3q4/B6NohtPrbPzc42qosrQjQjCotU+NL67A/UtIJkusGb71XNJldROKaoX2dn
fH/MakrI5aXbvsm6RYGa3+qHViET4w0RkCuEs4FS67YTK/cv2CNbS02X1YWnX8kU
eeODoxbnisuClYjQfqegagddkTXDb/fWcAQ4KbZXsf4dll2pgCxO+FW4HmSCKyVl
dYV251h1aUpbrdlhSrBmPJT/B/xzq0XD/07bsWkUGiPr3FAWENTGW1vwZkhXEGBr
o+sKtg68LRhJPP4W3ow0eW8j7FOIqwxfW751RLiVQkFcjLBQfaIBeD+irFn8dTL4
H0/Aj3csTRnza2sQVQ3/Obfj0CiLlJN+FrzO9As0eRi8qLnRlAo=
=8P7C
-----END PGP SIGNATURE-----

--UIt1LAmLYS4JvK3S--
