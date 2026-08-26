Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25344CF37;
	Wed, 26 Aug 2026 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760229; cv=none; b=SBfFXYdNC5IgEdLvmU02fKKEJgirlPr9UOeDY77Cd5z7QEJcSr6TfiluAQpL7xZh97OpD7niVoB+1RkLLh7DxT7S5cHHjkckUlqQBaS3nyGRmgt8h4zIRhri/6ESYz4qEokgHRC/e35sNrJ3AJ1XKzYiVIdeT/+V9OBMlw2VkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760229; c=relaxed/simple;
	bh=RnxgNR5WWQm0yDzd+q6sVXxurB4Rd56QMbymwCLpFJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cip41VpiL5djJtisuqKBfpVZObQIiS9NhSXzPILmgkNsAUoJg3C04wERL2naodmsw2VRXbnyen0oKAiROVKV/5C8SPkIhX5zCCLnLv8wU991lh9TYyRvjq6GiBoTanU0adx2pwj8tbBGexWjaA2TIpFIjqzreZVXx0fctDpiaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETpPhqfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETpPhqfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6ED1F000E9;
	Wed, 26 Aug 2026 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760219;
	bh=RnxgNR5WWQm0yDzd+q6sVXxurB4Rd56QMbymwCLpFJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ETpPhqfns3CwldzFBG2OS3/dN3QyUtCNwkRid+oTT5k0johGXheLILQnPHig0u4l6
	 o+LEp1Boqs9+w7iUQnnVD+zdz5kzNuLcLcmS92A/1smUwI2UbRjQoZ+npq2ym96Q0Q
	 3o44NWDb6BRuw1fmeaOm/ki9OJ/kCauy1zLeiRcHFD3idQBOH9YFF5Qp+XDpZjZh1X
	 wmisNPy0IyhAmLq8DO9Q3Kuxwi/foR/bvFwNccL+b/iB8UHN/Q2CySsIrHYHs2liOI
	 UpBu1gUSmieU+xpNcE7sPn/4LcI8jA3hoif//XnRWDC7WEr6wsHhUxPO3SKimMtA7O
	 Vs0AvqpFpH1Uw==
Date: Wed, 26 Aug 2026 17:03:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: xlnx,xps-iic-2.00.a: Drop bouncing
 mocean-labs.com
Message-ID: <20260826-reprint-sputter-86be94026ad6@spud>
References: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CAxsDecBpRMJnNHp"
Content-Disposition: inline
In-Reply-To: <20260826103042.147735-2-krzysztof.kozlowski@oss.qualcomm.com>

--CAxsDecBpRMJnNHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

JIC,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CAxsDecBpRMJnNHp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCao8OVwAKCRB4tDGHoIJi
0q5ZAPsHM01xyuXDdgNxlHnBRoBPYW6bTBHfKEXhHFO0/fDDMAD+KIaPaGVuljPj
KDYwN2tvcsIUMznbWT3sPiILRBIRdgE=
=T58V
-----END PGP SIGNATURE-----

--CAxsDecBpRMJnNHp--
