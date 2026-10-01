Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D00347BA9;
	Thu,  1 Oct 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859821; cv=none; b=ljGlgQEbEI6xwbzzYRVgZYM3MZnPMykLi2PrA6tDkKD1rtO2jzB5jYAIdgTpIdG5uO0pAPjs4DHeb5sMydZBvSqihdZ08qUWPv2bs2ruQudHH6LznBinXUSRuqYFV6JKeem6nvjKk15ODA67Y5COGBM8bsFjxb6oDyGCNuzCa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859821; c=relaxed/simple;
	bh=NQfRjS/w1yDiPkwU+ZzcX4Niw4nJAFk9Kehp1lQE9ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k24oMdh7OTCM/VKEC30VaOdGLfMXAGgR/cwpiW2CfDWOXoKFgdYhnUfPnYvTTbxRTC19YdJIEKHbpyHhCKY/FmHM63XfxJape6XrZDdL0uBb9T/NKguw1OTJC4U4axvxd2LpSFj4TUmB1uS1TYNLrVqnoaaZAKm8VDTFJT4olGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5y1GMBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5y1GMBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5DB1F000FF;
	Thu,  1 Oct 2026 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859819;
	bh=UCAMxkCZRHa+GugYKtkfIJmJutu1vtVExPXtXvNif6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5y1GMBzuFtD8ivvlKYpXY5YDTeXgi919F0mfNs46rZdWhrPizhQKzL628v7IjUmz
	 caPhwFtYRTsv498IzghTrpw80NPXfoT0AWxF54DbjbEEpwKeGVjIJvIwQropIS1/Ok
	 XzaQk/+wPvhh2VEeUsCSn9LP0kplh3dcooLWSk6oegvda9B/iwBGCtRmYq8C6hIseD
	 xG1ghk6viGOgKymX41CHwYm2DxS7AGkFkEtbamoYr52pHIkY8l+zWRFvikNjCrvdw5
	 mvISX1dce6jTGgp3NENNi0eMGVJ3nI7c9y4l49qyIr8tCZb7Cl6rq7jvQvEhQQBzzM
	 /xqCXKEQbgeBg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xCGRl-00000008Qpd-2bwH;
	Thu, 01 Oct 2026 15:03:37 +0200
Date: Thu, 1 Oct 2026 15:03:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core: document preference for
 i2c_get_adapter_by_fwnode()
Message-ID: <ar5aKUz1BMiMP9Wl@hovoldconsulting.com>
References: <20260716133029.1565853-1-johan@kernel.org>
 <am5dvgXS09CA3ohj@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J8tRddM5R9pXdXGc"
Content-Disposition: inline
In-Reply-To: <am5dvgXS09CA3ohj@shikoro>


--J8tRddM5R9pXdXGc
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
>=20
> Andi, I would suggest to apply it to for-current even, because this is
> an important doc update,  but I'll leave it to you, of course.

Can this one be picked up now?

Johan

--J8tRddM5R9pXdXGc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCar5aJhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQj17QEAj3UK7Wjmth4GEuKoCImo
5meWznbjUQg1VA8PnupT6vUBALyIvi/tJsQBdMxdSdDuOKtDZgLcegGVNxV/CLWX
E7sH
=AJ5J
-----END PGP SIGNATURE-----

--J8tRddM5R9pXdXGc--
