Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DD26ED28;
	Wed, 25 Mar 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462609; cv=none; b=W8yE/Xl/WOmZd8wIrwHU7vfOOPfQ2k9+gOoSJRdMTpGmqH9jd5G9WT83Is3OiJMt0KPIsV87qO6CCeaEOLKO9choFR8AU24Y93k2n5AyEQ6k8gON6s+r8QYVr4kcKZaPj8eixtE9gTpGoR28sOHQxcrsMgYP8PE9IDzLOQtLkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462609; c=relaxed/simple;
	bh=Rnj85twtesCZWmRKlew1BUMysMtURXXKALXyvov6u7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZqls97xB/gPJCBlBQedld7Wh+2fbs1bBD+3jNMrnveip1rQtapNUGWHvAqi5CHKHc35IfgCig1QsFmBChczifHXiGnBKRMNAd5HIS1OniIHD6HQQEFlScohFX6/YfM6VqOO6nIK7INyH59+6Sxie/dEaiqH8k6DBfdvtYfWZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuF3YWGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuF3YWGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA426C4CEF7;
	Wed, 25 Mar 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774462608;
	bh=Rnj85twtesCZWmRKlew1BUMysMtURXXKALXyvov6u7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuF3YWGvw9rVb3ip9/c+ttWK8jvlcYjD58J0u3wjHwEpPltSf/Z0JkY8yWhjz+qWy
	 jnMQFZDSIJBUFv8xAOzHXhAjoVtTNl1L3o6VHHBFZfe6yTuUK5GV32jbHQp9irWkEj
	 uC9voQAZ8/X4cBkx6JSVQHDN1oD19BNIcNRYMNfnA5/KSM256P+WzmPAHU+tiSH7mi
	 brD9gtRfEGVKxoayq8J1j0bBjMEB/xh8pK9q2h6veOtdh7qG0axatgkK403KD9Dy+1
	 4LTarJwt7+6zLvHUcodyUwxzmvYQM19r71R3nnWtPIXsLqKlzTbomfdSmSgSroRoBf
	 G83DjrqHzuHNg==
Date: Wed, 25 Mar 2026 18:16:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Yixun Lan <dlan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
Message-ID: <20260325-thinning-apricot-c156914803d6@spud>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
 <87zf3w6o6q.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PJMmZAkwfk4triIZ"
Content-Disposition: inline
In-Reply-To: <87zf3w6o6q.fsf@ocarina.mail-host-address-is-not-set>


--PJMmZAkwfk4triIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 02:20:13PM +0100, Javier Martinez Canillas wrote:
> Yixun Lan <dlan@kernel.org> writes:
>=20
> > Add a compatible string for the I2C controller found in SpacemiT K3 SoC
> > which use same I2C IP as K1, so make it fallback to K1 compatible.
> >
>=20
> If is the same IP as K1, shouldn't the "spacemit,k1-i2c" compatible be
> used in the k3.dtsi instead? My understanding is that this is the meaning
> of compatible, and there's no need to add another compatible string for k=
3.

Your understanding is incorrect! What Yixun has done here is what we
want people to do, because even if the IP is the same there can be
differences due to integration that are problematic. Having a device
specific compatible allows us to handle these kinds of problems if they
crop up in the future.

--PJMmZAkwfk4triIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacQmiwAKCRB4tDGHoIJi
0qthAP9kd3bs5AG5Rmqrqov+rI1UksYOg3k8ZWPEl0SafVYBvwD8Cxm5AxliDjKs
5EwdvAOJXa8tCAw3rTT0sMwtNvkREwk=
=lc5S
-----END PGP SIGNATURE-----

--PJMmZAkwfk4triIZ--
