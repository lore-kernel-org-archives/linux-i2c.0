Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D338886F
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647860; cv=none; b=mKsnZOUfeBIKE0SJ6Ff0qcUn78PJxFk/GotCIAtu0Rggx2Bf/xC8bv0P/a28GFSjtJErUTgvi5vkzsGm/ewFGW1PlJ6qQUPv+dtKx71/PE9pxUEvyp6TyE7wNLImuI4KOkays6+iihsQSTXLHt9KQ1Sbd3Kezgtjt7P5d5zm52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647860; c=relaxed/simple;
	bh=41f5Pqxk/tEuzvRIFPNV0Mr//0X8y8j2ZbayFb3p7cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvTsIUzG4hGLNNx0dhyfJBeslH76/Obm9XVUtoQ67Ptrtpz2cQcruzFHSTyS22lVQXmlCXsF8fi33dk/mhvfevZMjF3Mwf4Ra47bNmOQXKEyDhwuQgDsWGl+7cI8LUamgR2Nk0a5GikNwus/eOnWkCZKu6b7kZvjm2pGzznkhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SiCqEB9u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SiCqEB9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dLTu
	nY8KrgPLjCZuvNRDardUCjFD+q3zOAnvYqiBvNQ=; b=SiCqEB9uQXb9h8BglpV7
	V4ZC3oNiu5SNxVkg7ei7MjOdRoB5u2pHKWuaZvcMvKQax/46kqYkQyWYwenf9BBt
	fwUnYqJSDv9MBY3TkqIsupAp2EbZAFRrYtQoxIeBEHNtQCTGRjLFdZ4mGyo5SzW/
	FcjwxokKoYA4IzV/XecuXTQf65o99eNrY7km0mb7xckpNvz0OJjEW523so5U6VFP
	xmnrDwuMvp/rCLWrzNuAJ3wDlvMG4a0l5dVsEYk6ehHrAd3kdDhfXgue+Zf7BHMk
	fpcOkz+KGrbUBQ6YfRhkEU4gJ0wq05ZoRLpvhacqpsAclbwIFifaSaVJq0LterPh
	xA==
Received: (qmail 3273995 invoked from network); 13 May 2026 06:50:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2026 06:50:53 +0200
X-UD-Smtp-Session: l3s3148p1@K2t6uatRyOwujnsX
Date: Wed, 13 May 2026 06:50:52 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Odoben <odoben@flipperpa.ws>
Cc: Niels Franke <nielsfranke@gmail.com>, westeri@kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0678 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <agQDLAXhJO-u26oI@shikoro>
References: <20260418053719.15766-1-nielsfranke@gmail.com>
 <afhkiGREdd50vYNN@ninjato>
 <1453fe0d-230c-4655-93ad-3f685b8ab713@flipperpa.ws>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OqcfH1uCUtg8dJh8"
Content-Disposition: inline
In-Reply-To: <1453fe0d-230c-4655-93ad-3f685b8ab713@flipperpa.ws>


--OqcfH1uCUtg8dJh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I have what appears to be the same issue on a ThinkPad X13 Gen 2 with
> Intel=C2=A0i5-1145G7, but with ACPI HID ELAN0676 instead of ELAN0678.

=2E..

> Would it make sense to include ELAN0676 in the
> same=C2=A0i2c_acpi_force_100khz_device_ids quirk?

Sounds much like it. Can you create such a patch? Or can you test such
a patch if we provide you one?

Happy hacking,

   Wolfram


--OqcfH1uCUtg8dJh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoEAygACgkQFA3kzBSg
KbaBIA/6AkUUiLJC85/0nc6aL+w6RvITg9GKWAefYmISbCQ45gG5wrUZ6rx7zjXW
LH1QiNrTJ2vtaWe6H/94+GHUMIA4DMUZ55Wi/0JCCfeNLatUZ+NDgPeiNbuU11Dx
34HEkXoYgU/hdkMicQV5T4FjEBZPH7BVUQFkYWL7SCuX2ahmuFGAewtMWEtnxd62
evb1iGSj7rEiV5eWBmiTtwAqsvQWFzDxNQEayk2NDgaoHL72GwFjk1akK8VCj+55
sgnQ92MctzkRJqF6++PvUvz+eN26wAtes5x5trroeBWiEZOVnGZsRLYXDu1EWehu
zlaKGJxn7tWByXOczW1yaaXDFRj0Bt8FhBtzy/2ZBZMvDIto9NWXp5byOwDPEoUs
YHovGsnQdrUPmxML60yWQ4lqmlDZOFf1jJ3I1o//J2akIHWYlYteWUpo4O6lMA4p
HcLL/p/6rcTb1LRvZd5e+iRWepBXq85UDjRiGXB9eDERzi33Y6Jt+t5w1oqtdDSU
cvKYY61J34hBknGcoqO7IUC/WWzXBEbZAhkS0BMuZ00au0Mjm6u38YynksWy3CL2
QK1zEv68AUtzEBVvLRsKsbzGCRh9ECZtY7A2X2Sb1TxWya5JmHU79ntLR7xBwtLp
yJQHZEUDZtbf0fnUP9DHnWKfox11nu+Xjn+Xxq5tmCZbWhDtfhk=
=594j
-----END PGP SIGNATURE-----

--OqcfH1uCUtg8dJh8--
