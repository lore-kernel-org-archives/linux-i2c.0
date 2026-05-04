Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4D366DC1
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886128; cv=none; b=eztkqiKONpI9Ppz+2ro70HnQSVmbt89crojWe2h+uLtIuudndyx7s3JFpfXEH90BBygxNNhM+fdWRcQ2M73ugLPQD32nOQlgJG2qb/cGTbNC7LcyhJ+cL0TH9LR63GS7kAL2gy2MNGoqbxVsfEHbbVL7Slvd6uLnDiYMqWd0fGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886128; c=relaxed/simple;
	bh=JbvVwRWnEeQz3UAjYHqPuRMQIr3Q3OvLui9QzmwzEGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+QLxKeQGaRPUoM9IYhjQml2cwaH999XdlTw6x6lEZu4zimNsuF5w0H1jXiOoY25Q99l7fWq0kmEnkBWddZ8sfV0VW9xcwVF6mZIeGKh6hgMO0HnfIdBHMBymMh/L4D6RzmK8EyOFEAh2n/TJ7h0nPY4JTR9SqWmamc0U2J+vOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=baKUv6ER; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="baKUv6ER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=JbvV
	wRWnEeQz3UAjYHqPuRMQIr3Q3OvLui9QzmwzEGM=; b=baKUv6ERxbYfo/uJ0Nql
	S8YfU91AB0d4R94w2u1UjSxMm8Oivcs9Swu3ui3ClNDWnTZgE4mC3S1ER0eG7AV8
	9EHG2FohlOBW7BrLm1uhVbNpscrHbTFg3y6UnYa4aZAkrVJHHWT7wIaatmTttRgF
	rw5+XV7O71qak37RT7XFs1GKLJDzhBPMOWaKpWRiW9OP57aIUBbOVw2yg3380t2F
	9y5Ft1hmPwh+X0twvC4PavE7nC95m+w3eOezR1cwSsIGcWsPUIBWQ2VtBaFroXix
	CXRpe9+SMI30/1XR+zmkuLbENn8gOZrau95PEKebz9hysJagBZmDA9CRPvjlmFU5
	QA==
Received: (qmail 2121395 invoked from network); 4 May 2026 11:15:19 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 11:15:19 +0200
X-UD-Smtp-Session: l3s3148p1@TreWXvpQKukujnvR
Date: Mon, 4 May 2026 11:15:19 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] i2c: change return type to bool for
 i2c_check_functionality
Message-ID: <afhjp_ib0padlv5z@ninjato>
References: <20260421161607.61314-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5c9GHz7y+raFS1I7"
Content-Disposition: inline
In-Reply-To: <20260421161607.61314-3-thorsten.blum@linux.dev>


--5c9GHz7y+raFS1I7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 06:16:09PM +0200, Thorsten Blum wrote:
> i2c_check_functionality() returns a bool - change the return type from
> int to bool and update the comment accordingly.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Basically OK but you need to fix the in-tree user first using the 'int'
behaviour [1]. I'd think you can send it with this patch as one series
and have it go in via the I2C tree, but Lee has to agree then.

[1] $ git grep 'i2c_check_functionality.*=3D'


--5c9GHz7y+raFS1I7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4Y6MACgkQFA3kzBSg
KbZh1xAAg+9HnUshttxoJdd6z7l3Y7NB1ro8SC7EJlGhmzab4rEOWAU7W0YgtudD
xmU9rVG/ImfUDKXExsU5XqUo84l8Vlipw9xpzrsJFYjTLsqIFbSP9DvGiyRO90zf
Z/pWg8EFJpqqhGjoMv90U8IB0fhIfUYfwha/YVlbtDIBTYnioHvcvDqN0E9vCy9J
tYlhQ+bhPgWsBCPCRSvu2dWb5tlhAaY4cwab/vE7gyOXpwnHJe/Topo8ro6db4O4
vqtIlGU2PIcXgEiG3Y7fNhXwbqQeQYAzV4Mb1SPBO0RZz9O951JEI+KdxjFOQN5c
Z4TFThYHd7oJU9zfeY0JgtiLPTFwFVWOGpNoSSBoiqMUce03EsAp3mO2zg867N0V
kzPHSCdtvsbtNivJOmskEEpbVZtlxZ+nCyWBtUMULm5alLDev/xUVDXbGm5tYLCE
wEZlMEEzWPXrEQBLvnibSEI9Qgy/gkJ4IQrkT2uAtBFD8juW7B5WXJ3TV8gK15BA
VCEu/9ovEB1Ss+ZK7o3Qu4i6wJDG1ufJdACY2AxsjJP+jyhn2wNRMe2iVkO3L8bn
7UGurR/oNag9Ulst1s+2sXNZULrG8GTg+nsQzTmQ8Oqi4IWcXhW56e22TIEe7Dsm
LzTw/MBThcU3iTobBcbRRp3B2XQFikgbgiwL7IlCgo5BlAs/op8=
=pJR8
-----END PGP SIGNATURE-----

--5c9GHz7y+raFS1I7--
