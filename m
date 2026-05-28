Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA0282F09
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977346; cv=none; b=h+Oi5dyPOe4wO0qv2JTLM9Yxph8ItHaaujM5yTvZbbG23qtrhhSHj79mlL+gtgCLwytNXzQWiEDSSYUmeH6HbE+0rnWNOo6DmghhlkVsfbnPl154Pj+k2yR4kHsd5HtogLDl6yIubSrApO3Xa3Gkm685YpIP13glVReBq0EpOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977346; c=relaxed/simple;
	bh=vt74SxlAclJ2J0JLmLO6On8pRs0kqz8n43jCkoXkyAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc3N0csSvUMrdrhhhWY67SVaJfSw57M/q+x4I7KyxMwEdGz/37/IbTtsGYJSFh9TbZKUzP+8j9UOFO/RKdeYpRU0P7+wDWCxCG5xpISnpYP+E1sb8zTSj+PhQ87Q1ze0lV5HxbOa+HMUl04qLUCEtKkffBTAcPjZ59kFHvvVyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NzKLkYZt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NzKLkYZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vt74
	SxlAclJ2J0JLmLO6On8pRs0kqz8n43jCkoXkyAY=; b=NzKLkYZtn6/VWRUfHlEa
	AvFMIlskOFPOldUjo43IpG87UI6d66G9XLX6pcVdiCrf6fnIwgXe1o7Y8Grhe7QS
	LhUFVbv43IFkT5rzlK/tu23Gkqyhms4L67X99OgPqmPlbEZrElytmDXtdGg+AsHi
	ZQjkViLeTWbbfkten7lmY4psYlArVY676Y9U/oySXe3OiB16Oo/+zleCypG3yKwk
	I6IeB1++Vu3F5BEUBP7l878qrcNAERQK9htgfLU2OyPYR7noaraZBhDMbgwKMHr0
	KZK67mSWd+gxNPVpaQAUOdyngV/EwTjrEGELFsmEXaJkTz+ZmurL+VTle1sgg7m4
	CQ==
Received: (qmail 1062514 invoked from network); 28 May 2026 16:09:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 May 2026 16:09:02 +0200
X-UD-Smtp-Session: l3s3148p1@EYIuReFS55KSAB9x
Date: Thu, 28 May 2026 16:09:01 +0200
From: Wolfram Sang <wsa@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org,
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] i2c: riic: Drop empty line
Message-ID: <ahhMfQVvXbyX76-w@shikoro>
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
 <20260520131206.932050-5-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U6PaJa1j5/zFIBoz"
Content-Disposition: inline
In-Reply-To: <20260520131206.932050-5-claudiu.beznea@kernel.org>


--U6PaJa1j5/zFIBoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:12:06PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Drop empty line to follow the coding style.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--U6PaJa1j5/zFIBoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoYTH0ACgkQFA3kzBSg
KbbK/Q/7Bp0+gkAs6sv5hIpJnquMfizrSIc/iwZ6Yu6a0uPFEhWXPPRXgKoal7vg
5g2s9T1TBU7WYcj9OyOxSZsGuxbOlZEdLPfqBOVaxVwXNhY0IpwsyIYKzQ0Fqzxk
mBitJXGmIErjIIHyPJXxlZNWVNyjOzMLOSKsTw3JaWJ5ZnaKDRIrDvetGnd/fVlr
ng78HLX9DtbzTXVg5Z05EN8J8l6ROR5OdBR1uCGBpAG7MAdriPWHT27qlM/NH4v9
RQ0yA13HYexSPn5wDy7Um4XLXuCnYhtmuKnYbvEFjcc54IkW2SV9K0JBjhj3tCGF
GdJ9o2cRbZ/H+2VxalMIOk7cnihBGJYCSVXULCtEKwm3YrXbYtJlj723/LyDdYsn
a69xpVsZ5rRuYKWS/0bHeIDGJWptHhZmpDCaTY+V4CyLt808Zj/7jLUYB3X9YPu3
cT/WuemOvKtmNy0euDF/wq95feaIQC6TV5xI/wj4zDjgPtjHmGSFNKVEgqmEKbSM
R3s3B+SdO9In00H3oyVPGGkjU94e5viw25TZ9YEILZwD8zTW45qGMf/RdJnVKWEA
ZxPDzmfZLps/3sAFUawHcsuuDEK8foIa+lQ+IvclxcgMGSnW5WbENj4XE1Ikyn1K
xBdDuVcxfKUAOida0cXd6I912Vn/PIifK+GlbeWQe6E5R5KlsLE=
=Kil1
-----END PGP SIGNATURE-----

--U6PaJa1j5/zFIBoz--
