Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5447082D;
	Sun,  7 Jun 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780841209; cv=none; b=FaY1qHhUBx64BoPiRAysKIDLozuvihboSaEmCBGIx3rQwxA8lNOOBPj59VmOk21tzTYO7gEQPFM2neDvAxVYD39rzIrIJRI3YJpr/MXP5daCxcr7nNEsOgHA6fyyTh+xNQf6cDNxW51RQvtyfc3r39PT3aGJ5DZLjQayT+Qc+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780841209; c=relaxed/simple;
	bh=J/8fiCVbcaUaxUte+ciVM5v33W/TAUCqGrnzymlFrog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJxamw5/zk7gTQgOXq5GmrT6hdjegVAZz8AtF5//Dx2C91tsoq0Wr6QGxI/RvdS5s/vSdawQkKfdtvcGKiiSwJtxWapdTfOll2/MfLDaq7OBBknI/sgK7aUaIbtfKp57WxIXviLukWkbLfhqwlOTEDRbIDhGr13MRMUrhGsmBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML77Eize; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML77Eize"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC91F00893;
	Sun,  7 Jun 2026 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780841207;
	bh=J/8fiCVbcaUaxUte+ciVM5v33W/TAUCqGrnzymlFrog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ML77Eize32/GXJe4p6nWp8w+9qu1wHGXfmHWVPi6xRalaIuCwVYM8tETRYYGVUrP3
	 HqKMpJtMnC/vKjlLjk78iZHYbVldSgRairjD9cS0sGmHyc3CKpnqquPfzJTtLRB0eP
	 TPrE63Ue/n+X86vU9Szj7bfClPLOk8OV8bhMFFbvGfZ3ILoMOv2Iu/xYQ9v0fVxDkO
	 5cbrhDz8FLVxu/lSjf1SONaDtQOt6Ac/YhNO9YmoPWu1Tm3tDiAmM+HTUcZw0DuBMx
	 WdOENxDGMlrsiq7FU93JvLe+hjKleOVtkIUNglurKLrbRE/QkvOft1uzj+mAntrkm3
	 ekScN2RVCbVWg==
Date: Sun, 7 Jun 2026 15:06:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: convert i2c-mux-reg to DT schema
Message-ID: <20260607-cozily-majority-edb0ae263c0b@spud>
References: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
 <20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qRBna9aCywnL8HoD"
Content-Disposition: inline
In-Reply-To: <20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>


--qRBna9aCywnL8HoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 01:20:55AM -0700, Abdurrahman Hussain wrote:
> Convert Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt to
> the YAML schema so the i2c-mux-reg binding is validated by
> dt_binding_check.
>=20
> Also document a new optional "base-bus-num" property: when
> present, child adapter N is registered as Linux i2c bus number
> (base-bus-num + reg), so static references such as sensors.conf
> stanzas remain stable across boots. The matching driver support is
> added in the following patch.

This should not be "hidden" inside a conversion. It must be a different
patch.
I think it is fairly likely that this property won't be acceptable.
The conversion itself looks okay to me.

pw-bot: changes-requested

Cheers,
Conor.

--qRBna9aCywnL8HoD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiV68AAKCRB4tDGHoIJi
0jrgAQC5ZKZAsUebpzMpxxWjuRaggIUnLxzhLGXvqAbT8Si+DAD+N+2PU8cFPWlm
RhLLzL0Fe+0II8YhxtZRawkJjIcQeQs=
=3MXy
-----END PGP SIGNATURE-----

--qRBna9aCywnL8HoD--
