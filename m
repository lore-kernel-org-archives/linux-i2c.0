Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20821C173
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714714; cv=none; b=drzl6NLRwMN3lCywS8E9lTVZ5ya284IAvESOn2dW0lorDfvHjNpFbu74Hjc1NU7/dREWDqyTAoOqhbq8BGF1wYJnl3CccV6JqtDv1OPkDh6/dge+CNoDog+aUUt/3EvUaNA3I3pHiONR8EJ6twrRgu+MSAJGem+MJP/U/W5Y7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714714; c=relaxed/simple;
	bh=trr4d1sTrGpr2aY03kNxPBzBF1EvWLrKFNDm+lgOJe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE7mewrj7HdOyd2uC5kMQDEqkXvqXZ2rayr1Qmw0/KiE0zVYmMpRMb31hWauBu03HIFuVoxD4x60kGBxrjjSsSOTePz2jQFM053l1tZ16HD9RSbsByqeidujMnHyySYQ0FTlmterAZnpv5/RyIuhHE9tnbkq/LovVx75g5M8jG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YS2MKwXb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YS2MKwXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=trr4
	d1sTrGpr2aY03kNxPBzBF1EvWLrKFNDm+lgOJe4=; b=YS2MKwXbvXVrdWuTTQ/2
	FYS1qWI7GuXKTN0AGM7MmQYD1Ej0gWCiD2vb720IhWl3XJ01KJX9s9oFx/ZwH0Wb
	JrBJx72pubn0zAdXh1fEfBLJkDLDHokYJMN/yycJwX5eoNoRbrCj/GffS6N24n6e
	dk5f77fKVFLv8VZ0byqu5m04XIJ3Wq8v8JPb9ZqCguOFxy5w3OpDitTzxUA666DT
	lgpqWF9w7rve2oblCpWzM2moDGAQSfuZwXjKXPtQ+7ssDFMaiDvO0gBJLlZpHWot
	fk+6WwlK3V3cDLwi3zohULUvuLmaHMpoBAQ6/9k1LsFOBdzayxvb/yZuhFxyRLkP
	Xg==
Received: (qmail 258426 invoked from network); 29 Jun 2026 08:31:50 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2026 08:31:50 +0200
X-UD-Smtp-Session: l3s3148p1@NxUOnV5VDqMujntC
Date: Mon, 29 Jun 2026 08:31:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 08/16] i2c: Let i2c-core.h include <linux/i2c.h>
Message-ID: <akIRVj94lmCasfEF@ninjato>
References: <cover.1782682124.git.ukleinek@kernel.org>
 <c176fb7e8503d61e08f055a5bb1ba4989aba6ffc.1782682124.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcXiU31v82W3/5W1"
Content-Disposition: inline
In-Reply-To: <c176fb7e8503d61e08f055a5bb1ba4989aba6ffc.1782682124.git.ukleinek@kernel.org>


--kcXiU31v82W3/5W1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 11:58:43PM +0200, Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub) wrote:
> The subsystem private header i2c-core.h uses several symbols defined in
> <linux/i2c.h>, e.g. struct i2c_board_info and i2c_lock_bus()). This
> doesn't pose a problem in practise because all files including
> "i2c-core.h" also include <linux/i2c.h>.
>=20
> To make this more robust add an include statement for <linux/i2c.h>
> making the header self-contained.
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This shall go upstream with the rest of the series, right?


--kcXiU31v82W3/5W1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpCEVYACgkQFA3kzBSg
KbaLRQ/+JTA+OeDi9z4EitLQLME7CwHY4QqXO3GhsTXpRWmV7Cmxxd8JRBJXx4cW
09jLHSQDLMyWV7uh5LMkfExxghBN669l9iyD1x9OHKhZm/VvmVpvFvg7Pfg5PimR
FmjEFW5sRb2X8KYnmvBtncO6VpPmaZu2kbmY/lxAdDqn2MwaNqWpt6EV4j8xpBz5
uXDRsk/o85HBc88cg2CY0j2ukwxqNYf6x5D6mjMApmvcIOF+BHGrx0VxX/D8wGms
4tayS2icQ8E0M44Bi+jsU3OhZPji+c0t85BdMURFK6BbKR/3TGX5smqy2XSKa/EL
bEnmD922/wz7x3SSev5a5nIjAmHMGvxXc/qF6vaP2ZeNVY4QiwJKsVcXc9xEFcDP
RuMvbJepeEPIXQP8VhYdiBk+O+euzYVYjlRftte+ogpkou9Em0a9vvkz9b3q4Bo7
O2AWJ6VZVvUsh4tT9kIIdyE9s2V8MLvu1oVckRCBwS/omEpkNAQ7D+GIrDrOpMvD
/7APQLXzxs27NoXD82FB6+FuEPBvrEpTMfKRizMr+U+XWw7ufzyNQbK2u+12EzuU
148iQqVuzB1V+6mAgAZY7+xRP7mSvCjRt3QbP1mCLgDYWRKXsfcH/zQylj0hfoaD
yMYkJZ/xDZiqjhp02zdm4eL1G4taG3ICIxu4ktPbMuYmKRD2bv0=
=gmER
-----END PGP SIGNATURE-----

--kcXiU31v82W3/5W1--
