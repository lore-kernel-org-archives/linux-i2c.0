Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2B3F3289
	for <linux-i2c@vger.kernel.org>; Fri,  9 Oct 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553360; cv=none; b=HU5Z71KFGN9EcKo1ZUB7BtIm0TSXfVeakCaoGWzhocVS4XDcG2wXTC/EefIwubRftNPUon6aFhbj24IucUVUBOmWR+/bFRUninzgBuvTunkUtcrpaFDnFTo88RRkrGPFiS909asWhRUNHGVjheAURAea3VRXB9uRhUOfrAFbLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553360; c=relaxed/simple;
	bh=l7tTeWaVF0qKRdqZlL6aFTskiuO/6Kxkimri1C5q58c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt4Ih+JUNZkwl47bMV2UODW5tgnZ1npIR2QqT2IhcLMdlMFlXRM0OSxEoC6PXn/pvcd6fIan6R0Xqa1vQm8mh6ti/l4LMNT8m7rJnpoqLiJyxPKGpncGECOMBCFtBxKAedyGrTA9phiQ/hYcK6Cvw73fnaua4sIdxqj6pwlgRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AsMTeu9K; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AsMTeu9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=l7tT
	eWaVF0qKRdqZlL6aFTskiuO/6Kxkimri1C5q58c=; b=AsMTeu9K18h5T6EbBPbM
	Z/IJlKsqQyq8pC+WGdCLko2B/7TqCOmhah2il43FC0izUcxQyEbOMNKDxKpaW2ru
	TckHRCQZufr72MK7gn+nc/h2Wf/k5AmgDii4LW+RqUZUw0fRr8qPT/CvGx5/RfSx
	ZIqCHM+niY9pteagci8RpA+b0soVTkfs2P2tT0U34hOfLbNl9wtldnV0vmejPAmA
	FdO67EyBcPZLH2wtgrY5rEZKpWGzFMPpngWS7x5+9FQTgkvcm3lkYyIK1pJb10fj
	tuMw/FBMTliFOHB9GGoCTUoqrrL9nxnWN5HjqNmMjofTp1f+YroSROURnZkd4uSD
	2A==
Received: (qmail 1207273 invoked from network); 9 Oct 2026 15:42:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Oct 2026 15:42:36 +0200
X-UD-Smtp-Session: l3s3148p1@ux1nhWhd9IzDesiu
Date: Fri, 9 Oct 2026 15:42:36 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core: document preference for
 i2c_get_adapter_by_fwnode()
Message-ID: <asjvTCazRMSNMojQ@shikoro>
References: <20260716133029.1565853-1-johan@kernel.org>
 <am5dvgXS09CA3ohj@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UZQvO+nwQ3LWqEFb"
Content-Disposition: inline
In-Reply-To: <am5dvgXS09CA3ohj@shikoro>

--UZQvO+nwQ3LWqEFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01, 2026 at 10:57:34PM +0200, Wolfram Sang wrote:
> On Thu, Jul 16, 2026 at 03:30:29PM +0200, Johan Hovold wrote:
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> >=20
> > Document that i2c_get_adapter_by_fwnode(), which also takes a module
> > reference, should almost always be preferred over
> > i2c_find_adapter_by_fwnode() so that an attempt to unload the adapter
> > module while in use fails gracefully instead of blocking
> > uninterruptibly.
> >=20
> > Note that by implication of_get_i2c_adapter_by_node() is also generally
> > preferred over of_find_i2c_adapter_by_node().
> >=20
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Andi, can we have that in 7.4 pretty please?


--UZQvO+nwQ3LWqEFb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrI70wACgkQFA3kzBSg
KbYX9Q/9GLtiebBz1XEAUnYk+0knWLzvXS+qAGJNPFRDJ5LwX7hJAoibtzfEcyve
vXqmJEwwYIFcdLlIJL7qMMd3AVeewXWMyyfpGEY+Np5CkDZlxw2IZgyjhx7kl0Js
gUV2P0zH7E/hVLRCpN7Fu73aRlX1M0b+flX60PrzSCcpgXgDEJ40CN6FiMFevgMT
H5FPXih9YI22bKFlkk9DYKhmXLNpLkd1AXGO24uCfa6e4TGA7wbiGvryKh3Cmojt
Z7HmPBLhh4ArUP75OatmWQNSgT38523N3/N6p9I0EzAvm3sDMO3bO9Fpn1djNJzS
XxSbUQj2q0/4EYICtXwnMJzZ8GVmyXWAk0Hg163HGQSwMZRnmAnmZK7tzqCJGHo6
rRUQtMnC7Z0Gupsht/PH1SxBIglGQH+bWm4AAd/n6EpQH09O3wY0p+gSUhpWhNtR
pGMEATEHy9n8CmLxQDCKU0aet2eNSFMNdWtPkHDkz+ATc878dehS4+ES9ilz9RFY
oCKAHNIEpeTztjfJCq0TvQRvHku5+ej7PHjR1Kp1ECZQ9povd41V2ckHeOuHdz4L
V+sZ7fSLLSrJQXcafov7Ds7nPUuMzpUsbiMd9ZmXpQxAzyfrdw/4gmQ3KF85Mye1
lLe0dnNI0xeCvCEKQ6DLCbDTxVCJjk9jS/wb4lqjHV/AyehRiFk=
=6Rp3
-----END PGP SIGNATURE-----

--UZQvO+nwQ3LWqEFb--
