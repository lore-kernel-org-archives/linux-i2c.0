Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2031E832
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524940; cv=none; b=YUo8jNsZlR7trnxaJQEfdVleZWXTngz2Y6g01Sz3cnOBeCAtitwL+LYSx7u2HjssNXl+o+kCkY7J/7XxbMTFEXPbUvmo7nNAqGpXo9QGH7EPzbVM0HQV5tali2xkVtEJ5zoTG9SrGdB5Ano/Gry53Kbic/iKf0JCkhUV/RTWPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524940; c=relaxed/simple;
	bh=GyjfgPTMRC/yGsJXMwpQENizHPBd6a2BQoquwtHMM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU0/OFiqGH5aetSBS1FeOxxjR1auhHsZxBMnxWqh7vJ8dmivGscYZgP8sRbL5T2HSvFfqPgaE3rK/BpRkd24zUBCdjW/zgOF/MrkmjNcrRVkyUvBIrjbzv8Jx4Hkw72Yv0ceFsCCoySnnBTtlOPAYdF/IZIVcIt1eLbpivrIlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PBk/Ffnx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PBk/Ffnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GNTV
	8SgU2ZssPNLB9xAnHkQxaxSN7daJSWZhzfq0l/4=; b=PBk/FfnxqwZuSqykNVRq
	lGCpIIq1YMfeC+U80XsbBurUvau1CKfHSMo680qZSDEuOtkdguWvWcq80bdR/Ks3
	dNhkXnpVk+ATNJSj//qvlEeUiLmjv35kW0klX27xuH+4nbnoMO1SXVQD6S0hxoIs
	7nR/BLMY0RLwombQlEuha3O7hDgED6z7njPCOMU/36O+jXFwfbvSAUZgz8mbSFg3
	cWEQ0OYrpX/UdMDt30VtWR2t/c+SVkLsBhCD8HoF4uogUJDa0Y+jyq7x8ykTdQ8b
	GArQH4RwlntgxGInqrRJ+nqVSF6ubOHU+g+oH6Lvni8trRgIrShvzDkgFprpNILL
	vA==
Received: (qmail 2688003 invoked from network); 27 Sep 2026 18:02:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Sep 2026 18:02:15 +0200
X-UD-Smtp-Session: l3s3148p1@Ic61EnlcBqMujnuD
Date: Sun, 27 Sep 2026 18:02:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 0/2] i2c-tools: Make tools accept bus path
Message-ID: <ark-AXt29OBT5hbg@ninjato>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
 <DL9EB60C2IIA.228Z11CQM65Q3@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJ6I+j6OOBJs+gpX"
Content-Disposition: inline
In-Reply-To: <DL9EB60C2IIA.228Z11CQM65Q3@brighamcampbell.com>

--FJ6I+j6OOBJs+gpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brigham,

> I appreciate the feedback you've given to help get this series to v5. Do
> you have any outstanding concerns about this series? Is there anything I
> can do to help get it across the finish line?

The main problem here is time :( I have important conferences coming up,
so I can only schedule this to the second half of October, I am afraid.

What would help a little is maybe a description what cases you tested?

If other people want to review it before, that would help a lot, too, of
course!

Thanks for your work and patience,

   Wolfram


--FJ6I+j6OOBJs+gpX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmq5PgEACgkQFA3kzBSg
Kbb8eQ//QdpP0hh0T3r4j2Wvh6riVbXX80xOVl1sJKpE9TCAH/m20y8QQbqupMAd
J+Y+mFRmlD9qCxtogKfBMCETVhciI/OB938cVC6yF6KdOgqTkVJXmhkz/PRf4F1B
eFOwwAEcAt1oKlCcwOUPMAt4nPnELag+TEUEKmb3mI0z7kuVfw9aOtEOpcA8Hkbb
ou58sypDZwIQOfmup4+JXV2fx8PZPykGB0lHupdoKX6E5OqxuG1Xjgb7BzWqHm6x
AerzBPM74qvINAJ44XAV2G1Ilq7vX8QO7ca24vFY21jXOabTdW+U5dbCrc5a1oYF
+RPmFU6E8vQ77O8mM/aMNp9BtezoIiEDdm1aep3QnvVIWh7BWq1fucuYEK0h3rh4
iYj9hLeTHMt02WAgvhBC/BYIx3RkvePW1NZoQpL8KrfVVtmQgDzuJdUbomZO5NNJ
LwVHfLoD8EjUFmhDtx1vV5lDH1SYN59tdpBdvGmVX0UH2YaCSi+oOF/syzSUcxi8
4Qwb3CJRrKVxR92r/eoAZ/x96ziHcS0JMs4tSBzGsOSg2hBNwY51wmEPnhdl5jly
LQfscdiOLwaNs1vyaiav1JhXMbi1o7Sz5UGce30Jlp/mvX3xCWdOSrfFBbC3w/jY
+APfW7oLQ3B9q+vXPeXQeaYrIxVdeFyFoABE1hGqq7DACjdaArg=
=PJBU
-----END PGP SIGNATURE-----

--FJ6I+j6OOBJs+gpX--
