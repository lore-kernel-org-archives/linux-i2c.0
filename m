Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDD3F8257
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002979; cv=none; b=e/Dent+b4DJzP1iQtqPFKUChqhuwWzcvkh3dD4LM41+5/m29MfLjWGE+mImupbKt/foWpcyyMNnwzLllJBshXZJaFQPWTxvLWh3KJx7N7K3GPk+POO4KIzWlhK6iRps4VNHCrhY+MUZNYbMr3vSnyJa+6ixUzPR+//DZCqIfMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002979; c=relaxed/simple;
	bh=eDNoB5RGJmOVfcMPByK4i7bKnJa1fIywj2xFgdSQSrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9ZZNFz5vDLtldW4DnhFk09aMZfHkt+adf4Q9xT0j9aqnzquyyQ0JPL2UFhzzEdehe7h7YCGNJB/f/dEGmY2jqPxbiEGOOIXPlUaJaprfWrAFWghUs6GOBegOVSccYQLC7K06xg0tfoQwkUzT2G4kqyPZx+2DNZ/LgKE2NY2t+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NxjHrHCy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NxjHrHCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=pwaX
	6RCaOibEIyNuI7kcq9+uLt+TcVmh2NYeLQFKnvk=; b=NxjHrHCyQsdtN9jM+NIh
	sEg/VcIpnHOYZNSDTZxI4kW3ZCYFa+xARHkEW7AqRspXtgFYPP0QbXkZoOsDjL9U
	mlo1M5sSOYkQmjCLLGzEvmP8epGYmAAWMLhzjCqvlbHjjVz3b0IF/RtJm7X4mFk9
	M5gRuCoAkq55Obl/4BHw8tifeK6KNeEjNkzB/++x0j1v7jACwMzBQq9TDuqj26SQ
	gu3hUSxqWglET5DiF4rSIgkba8ZJCr0M4IySWmu6Wma/3c/wuNAHJchd3Hgm3OxS
	+gJNGuIoQykejTocf56ldqfR8XigeRC6TFABIE82HOCRgzQ+vNda/0dx3HSGzB1X
	YA==
Received: (qmail 1242701 invoked from network); 9 Jun 2026 13:02:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 13:02:51 +0200
X-UD-Smtp-Session: l3s3148p1@jHJuEdBTpNYujnvA
Date: Tue, 9 Jun 2026 13:02:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v4] i2ctransfer: Add optional message modifier
 flags
Message-ID: <aify2jjX4MZsXUGy@shikoro>
References: <20260608-msg-flags-v4-1-68ad6f0a4e4d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oV22Kbyvh/Qn4ZH4"
Content-Disposition: inline
In-Reply-To: <20260608-msg-flags-v4-1-68ad6f0a4e4d@bootlin.com>


--oV22Kbyvh/Qn4ZH4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

Looks mostly good, I think we are nearly there.

> +	/* unexpected next part of the message: length or address */
> +	case '0':
> +	case '1':
> +	case '2':
> +	case '3':
> +	case '4':
> +	case '5':
> +	case '6':
> +	case '7':
> +	case '8':
> +	case '9':
> +	case '?':
> +	case '@':
> +		fprintf(stderr, "Error: Unexpected flag '%c'\n", arg);
> +		return FLAGS_UNEXPECTED;

I suggest to drop this error message. The above characters are not
exactly flags. By removing the printout here...

> +			for (ret =3D FLAGS_GOT_OPTIONAL; *arg_ptr && ret =3D=3D FLAGS_GOT_OPT=
IONAL; arg_ptr++)
> +				ret =3D add_flag_if_supported(&flags, funcs, *arg_ptr);
> +			if (ret =3D=3D FLAGS_UNKNOWN || ret =3D=3D FLAGS_UNEXPECTED || ret =
=3D=3D FLAGS_UNSUPPORTED)

=2E.. and simplifying this to ...

+			if (ret =3D=3D FLAGS_UNKNOWN || ret =3D=3D FLAGS_UNSUPPORTED)

=2E.. we get the error message of a missing r/w-flag instead. I think this
is more helpful to the user? What do you think?

Happy hacking,

   Wolfram


--oV22Kbyvh/Qn4ZH4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmon8tcACgkQFA3kzBSg
KbYn/w//e4Y0FNn2C9FUSWV4f08vhBKnEVI5JOwFQAF+8qfXRbZIcQ2xLwgK66Ak
mVDBWv0CN9abrXCAe0hKZZmxSS8Ns6d2LEb0wKqYLfEo/+J0+VejTwy/mgmMIXLu
mQf+CaC5wCZ5/8v3uitaYCODS184h4l4p1dllIgB+o08JavECXkaXo8hDzUcsQxL
ZxbDnI5NtxHyTNr9Z/LNv2Ry+t4lDXwDRZrgPORpCzunbGhpnOd5HYSAjh+qzjwX
n5u28Lb1MdrQRX64XHUO+L+LLOLXIMXPCDmYy8MP7cnCze94TOJpDH1bCBc5A/nD
rl2SMhNTuWKVOKQ3vrioJNAtYIOHJQe0WsVbuovx7SanUDJxPSxWAOwZR3HC/GKQ
KGe3uyiy8gq1ULsDF/Rcoioe1DKwS4PLT1plStJMQNzHcZvxgtfFXXIRyA9wltaq
oME9Y/hzs6HdjytuOFDTEZqKCPjl14zwTuT3M6VMTFyDzcDIbSM3lCAHGA2qZgaW
6kY4TP6XGcyfl2THC2aN/ilGzE6k0hDIr6ISmVKQg/DvPM1Nsn4ffKUvACYi1Vco
aCSL0nU6kYL6pRtVlOAn0ybjUAqz7Vyuqjty0PeL6mh3zGndcVwskVt1E1d0Mqj1
ilFcBeDbPgjM1uobFod6wz9OW65d4ziXVFockvZ4SpBV3DsnyPc=
=FAxz
-----END PGP SIGNATURE-----

--oV22Kbyvh/Qn4ZH4--
