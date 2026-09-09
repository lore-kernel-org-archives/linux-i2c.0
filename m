Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2B3A874F;
	Wed,  9 Sep 2026 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948048; cv=none; b=nxRZpQkoXZVDWCk0oUz6I8Dv2QO7/yExQpY+RNJCd6t/MTM+5LlQ32YFasS2yDH3pFzrV0vOldlyTwa21kSSxNn815uU/10LBzRm52aSnSiZcGCuYWZ7DGLnb32oPvzZ/ZVZERD/gU/C7aV035t39enQBF5yYeeCbnFAVHSVYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948048; c=relaxed/simple;
	bh=/+K2FWb0NqMXX3bNyrlhPit09ZtX2Yf7/0Pz4DvGUf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDen+DycjF+ClPNMiE0ew3/eXmZ3UmJ4CNzBCE0lKy5+u/Ff0MiJEKt3ZbxY6hrGa7yok0/Dn3xk4I/+OVuJ+ScDLybV07oWcaLuryJ2xH+hb1xNfIUfbmq/6fwonMAc/u4wq/77HtsPV/IJTcuze9isbU6rp+bEVCgiQGVecI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsjIsfeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsjIsfeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDDB1F00A3A;
	Wed,  9 Sep 2026 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948046;
	bh=mFYIey+4GUg1N9wRii2VCB2Fb1doK/c3LSlsHkcprr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fsjIsfehzy/iKihALwmiT/UyeyfHvyRU1F5YQFkL38OvIClj3WMMcCrf9xyXl28dN
	 7wfRCwBwKIP3D8ssCUMdcguBwS+EzvncaC4XNn6F8Cp3CdP/FJ3tMdx4Js8j1n2I1A
	 xL6KceIBadVocGv2zdtHwvLnJnDqwC2MrqsQegckSi9/2icgnD9d9XEetvhml8fyC7
	 ZIWFF+KuCO2gPi3rpvMTSsrTGUN/RQrONZEW2BPv7b3StFfyciJKBAZ58p2C2adQx4
	 hFRn2CIZZAApG/RYlG0Tdw6eUuOzzKM3x9ngyyMEgd5PiubgdOBMcpEvyE4NHeZZ4F
	 jWDWEss7UqBpA==
Date: Wed, 9 Sep 2026 11:00:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>, andi.shyti@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: i2c: Add NXP PCA9641 I2C bus master
 arbiter
Message-ID: <aqEuPBNsbdGZ1MJX@squawk>
References: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
 <20260908123146.1839854-2-shivprakash.gupta@nxp.com>
 <20260908-skirt-makeshift-2050f3bcbb22@spud>
 <aqDt0uC7FNRmsv9S@gryt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HSmNYzxqv+7gjE2q"
Content-Disposition: inline
In-Reply-To: <aqDt0uC7FNRmsv9S@gryt>

--HSmNYzxqv+7gjE2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 07:25:38AM +0200, Peter Rosin wrote:
> Den Tue, Sep 08, 2026 at 06:47:01PM +0100, skrev Conor Dooley:
> > On Tue, Sep 08, 2026 at 06:01:45PM +0530, Shiv Prakash Gupta wrote:
> > > Add device tree binding schema for the NXP PCA9641 2-to-1 I2C bus
> > > master arbiter.
> > >=20
> > > The PCA9641 arbitrates between two upstream I2C masters competing for=
 a
> > > single downstream slave bus using a lock/grant ownership model. The
> > > binding supports an optional 'interrupts' property for interrupt-assi=
sted
> > > arbitration.
> > >=20
> > > Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> > > ---
>=20
> ...
>=20
> > > +  i2c-arb:
> > > +    type: object
> > > +    $ref: /schemas/i2c/i2c-controller.yaml
> > > +    unevaluatedProperties: false
> > > +    description:
> > > +      I2C bus node representing the downstream slave bus controlled =
by the
> > > +      PCA9641. Downstream slave devices are declared as child nodes =
here.
> >=20
> > Why does this node need to exist? Can't the i2c-arbiter node itself
> > contain the child devices?
>=20
> For symmetry with the pre-existing I2C arbs, which all have the extra
> node for historical implementation reasons? I don't know if that's
> considered a valid reason? I prefer to have all arbs follow the same
> structure...

If this is just how these devices are described in general, I think
that's probably fine.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

(Also, good to see you back active)

Cheers.,
Conor.

>=20
> The "documentation" describing common I2C arbitration details went missing
> here:
>=20
> https://lore.kernel.org/all/20230731163833.319258-1-krzysztof.kozlowski@l=
inaro.org/
>=20
> Cheers,
> Peter

--HSmNYzxqv+7gjE2q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqEuPAAKCRB4tDGHoIJi
0s/xAP9eGC1HEFjaIFD5tXdlGCyTXfKghGC3PRNhtlzsTWx++QEAq1xMfj6+tL8R
K+FZvGJGfh1Rh/B/LlS6BZ4yBDwLzAo=
=ekYY
-----END PGP SIGNATURE-----

--HSmNYzxqv+7gjE2q--
