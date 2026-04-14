Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE23238166
	for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196191; cv=none; b=uNfd9ffA7iuCqIoqEQjNGNtZbOPuL6ulAabdVkcZVv39DdI/9efT0PuhEQCu2D7DqOcKKvYCZ5fU+Yl8WjVPLQmih7SKjlwrvXyiq+JAetDgnZupWM9gHN5c5xEDIRfxxWQn+gi8EdJ6fCRpydzNuZ99DPJ72fff5In3tYsHmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196191; c=relaxed/simple;
	bh=tuwTBMZDQLqPzPX3DvOqNAjwkKgb3FTW+LcVC30oye0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4ap0HEQ6WA7UWCeim/VtYzHOE2pi2ZS/NacYzoowWZaxnAVZzwbzju0MSsR+VoQoYFSPkBTHfgIbThJEeReaUaSrqhazcOMUlX9T3+zRlmzF9Wdd1SjNKg00c/fK8++sZNQ7UYH+LtsRRvmxms22mXe/kiZ7VPq3uxNYHIMmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gkMk2spf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gkMk2spf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=tuwT
	BMZDQLqPzPX3DvOqNAjwkKgb3FTW+LcVC30oye0=; b=gkMk2spfjRyGX2KrBO7d
	6wCKGvmkggGkihg8lqEwwEcgsngAww9YkHz8rTh2lQGx4Kz6ke4tznfGqWi9bFRq
	bPwPBjFRxzJORdHnscPacC6KaoHfDwBpo0ipprhhP7ldZjARsJ8YfyrteNMWptFQ
	KIyX4sDLF6j2onxESBihjG2bNnjiBooCl/l1lpSJmAV5d7sVKF6N4haGhu+bvC3X
	gLPVwOQzqlG3zWTtjDezCacYjPN16bBmqExj2FBf3ZiXF0atJh5Fznx4ZnuUgd1b
	AiavuzofqKaONCMRQ59EvTpYytwb69okJk9fzdvbl3r6SkCXF5m4ILBqnh+yZf2/
	Hw==
Received: (qmail 2847502 invoked from network); 14 Apr 2026 21:49:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Apr 2026 21:49:44 +0200
X-UD-Smtp-Session: l3s3148p1@4V2a5nBPmJEujntG
Date: Tue, 14 Apr 2026 21:49:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host for v7.1, part 1
Message-ID: <ad6aVj-hRpA_vaRP@shikoro>
References: <adr2UAyCWpT8VwB8@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JFIFBDGQf2nh/ETz"
Content-Disposition: inline
In-Reply-To: <adr2UAyCWpT8VwB8@zenone.zhora.eu>


--JFIFBDGQf2nh/ETz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 03:43:40AM +0200, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here's the first part of the merge window pull request.
>=20
> It has the usual refactoring, cleanups and updates, with no big
> surprises. There is also some new hardware support. The main
> chunks this time are the xiic and rtl9300 work.
>=20
> One patch is already queued for part 2, as it needed some
> dependencies first and I will keep collecting patches with no
> major impact.

Thanks, pulled!


--JFIFBDGQf2nh/ETz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnemlMACgkQFA3kzBSg
KbZkqA/+LHEwI8RvqL2hhmoRZQVlo3qayFZ8L7AXetmpFGL1jIUbflkxOnaJk9Dt
owKOjfyLwnAh0rzrTgWEhe8yRlxpkWTi3KdLFia+X68pvjDAXWh9hSY1+MJ8Q5PH
791OPabY9sqzC5AnzO5zqf6lmDCA/NcA0bHNAII4gSoPuRs4755F645EhueQJs6q
J5rYfWZveQXfUyo0QWA5FmgMINZdclzAK9PnCpIV3k+9qxAG8QkxCvR5nDSWw6e0
103+3y1044S8nH2fG7vw/OyaZA83twmQZN3f4ZxJ3PaqOR4zYhmTI7DLUi8F8IKO
2cTJSyQbBnYE2cODMzhmOMlYl6M+1lxnYrMq88Vl9PzMKo+CENhfdEZy5l1ood6N
UOA+08pvvVlY8EYgPS1SLaMjI+LXPyfCHliPdmCo2JcY+tSvZJBOZmprUi4JgEex
FjbmDR5ZbdgrFvF97/BoXsQrlFd67LoDDxc85COzfqbV0jAhV2/wvlx/wywBbFen
bKmCjLHmsdefA27ORa1u2jZ1872sP0S3FjBBUvO+gYgoVcKBRyd/wHMjX6e+4FdS
nfQeXuGW3ppNJmPx/LgcuhargTdd4qol64nu8vuSrlySly+3+q1HEXb18Q80pDS8
G4ck3LOc+zt5VAsm0dXiiYzQJmmO7wqjuaXb1/vPy+fNPL7jYek=
=ZPL6
-----END PGP SIGNATURE-----

--JFIFBDGQf2nh/ETz--
