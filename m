Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FD2DECCC
	for <linux-i2c@vger.kernel.org>; Thu,  4 Jun 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566933; cv=none; b=dJfuv4KP2qDQtKGl5n9faN9wRGmjSCzNJ6i3bttMZk3RkmxE+OixAhZcAXvgC5t+aq5TQvJqSOztEOf9U9E2pkwEuKabZLQllnF1SSvyBqRhVjJuQ40KrXSf5YQktp4ejzybKyfvcZ2/jxba061/Qq/uo3v7/IigPrSp0xrMBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566933; c=relaxed/simple;
	bh=BICU/qbWX9jWZnSLg/ACfHtn0ZOqwg5OPKDN4RWM1yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFetHUCKFY77tw7hegxR+L5R19ohZ9oRBeLaexwooBZyTs0pcBG+CRrBZouqq4INU5MUm8ax7Vob6c6RKQ1JNqucmnwdESyeJqjq9OPtlJexikvA6ODoygiWDHUq3gRDb1Ys7Fs2n3Lz67d50spaqhk8a594fDjtdJZRMt5bhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Sb9YBGKo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Sb9YBGKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BICU
	/qbWX9jWZnSLg/ACfHtn0ZOqwg5OPKDN4RWM1yE=; b=Sb9YBGKor/SSTy8HXbYX
	+DmPVGnnas3eJG7FgnE5HXAXOpv8KcVbyYvvuEtkLUHtZgE3Wlw1UZzey3pwpMLK
	IB0/14cGNeknDe1LBCXZI+Yyre7Blty0QywOr30M66zcZ1yOSPHRKT9DrRtHcf/f
	y07YXoecAqtnI5oM3lGq6D69VCPTVtwNvsJADwHcjZXSAqB4vRCD1lYxesjqHpE3
	TylY/XusFwd8KadqXZkWHL3LbaHLdUF+Tnf9aon63ShraS/ltrUwAEh//Rvp5cO1
	RPDx0kHtlPKrezhQ3rrrP7tIgceoLKzYLFOwGQxUn9IIfLnezuLe6QD3QpSlhCtb
	Iw==
Received: (qmail 3591957 invoked from network); 4 Jun 2026 11:55:25 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2026 11:55:25 +0200
X-UD-Smtp-Session: l3s3148p1@tL4ai2pTWocujnsi
Date: Thu, 4 Jun 2026 11:55:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] i2c: core: clean up bus id allocation
Message-ID: <aiFLjY8AttE7hu3j@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-10-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/iAIA9toTnak6qdo"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-10-johan@kernel.org>


--/iAIA9toTnak6qdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:14PM +0200, Johan Hovold wrote:
> Clean up bus id allocation by using a common helper and deferring it
> until it is needed during adapter registration.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--/iAIA9toTnak6qdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmohS4kACgkQFA3kzBSg
KbbNHw//XIk/gqyFruy4KYtjvbqdEkFLfKleK8014W/wtSW8vSLzxl3Z7zTs730o
9lDW0B5CaS8SGGoIRrIn6+p0fJOZzrZQeGhw0MHwdf3UWFqUY0dl4ZYQunFEea/F
LG4GJwZk9Etev/L0sxHHM+LjsaMhwybOsF6anVDAmPA86P2YbvC919V/0Nw1M5kV
ILIamEaI2VvM+UnLv39OGsTgBolAeTZKH1tavQQUz07B9c3gKHo5CKZ6g5OMSJCf
UBoapfeSRLsNHxG533PUITlQhAFph3ObJOnGfFp4DY8n8rEpBR7UptJ80P1mSTFR
CkJyX0n68921ebXZnVmsLekYpf57YEeIFCeBvGWW5+M1lhUmWqHuQeM4WwZ8lKYg
+HE/fP0Woec3PlZJ61jNBMZipldplFPzZsoVjoljnYF5nqDiA5W+fpAyhD/Odz9Y
tcciM03jCA2Eu0D9Kv1OXkNEB1udtzZtBdtno1cyuny6RbGBh2myOxV3A/3YxLn8
zHnHZ/wFmFUSNqgUm7+zco8hBqXdDM7pFxOg7AZzINvTBt0R77FyNpKt+EjPmTts
XYpAt0IJSkn5A1ZeETWBSxwNV95Ry9lGV67czonEujt6X4Hom2M2z64fGLfd+psK
GFUdq9yoT4zkpMpv3L+JXcdYBDAO2ZAf5R83gIymt67sKPEPFQs=
=I9h0
-----END PGP SIGNATURE-----

--/iAIA9toTnak6qdo--
