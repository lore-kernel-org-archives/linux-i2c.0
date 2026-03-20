Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A40368972
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041302; cv=none; b=YRJVsdV9eF7xfFX37Hqpkf4Y0G7ZbCne/QWdV4QLNr3NT+UgK6o3IOy1olQwFodWaDjvdCnxaCFvaH+XqI3gICJNrqz0PR7lCTX6pESDvdCYtmidJUkSpkxhlhNbCHWQurO+ZsJT3EVH4GQ2XuVjGXo5pWV5vFD2FJbFsIYE7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041302; c=relaxed/simple;
	bh=gO5UhDNhFn1ojze5ogbDG991DIMWJJB4bmVCCn865V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8RJJ9LrC+gdbgn7Ae3OFxOGDRBs3K4+FHveD3L9Bar90753pmGv2GQJvUCecWlJhPQGgomwtToeE5fYtTRPjoZaqn8To7Y3+A7tE/Eh0DnY6Uv5E9nsYBjRXbUjrV0yap2MKvTtrUvWW79fHRnpu8VLMoOhQvyqas2pXoxtn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vg8Hpznx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vg8Hpznx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=gO5U
	hDNhFn1ojze5ogbDG991DIMWJJB4bmVCCn865V8=; b=Vg8HpznxbbPncQ+oD/Gx
	uTP5MuK2gtU86+BgVaiobyOxL8/V9XpjhGfjc6upZK7XfpS3mK5lmhDdnXjKCTT+
	sseSWGjuGE6HwOpA0x+zneOFN5n92Un2kDDiSGjYbK0pDxLSolYzwKf4HsGxHTxU
	FkDsKaN/eXTlf0QJD48IHx9aVapCKYsr5LQS1B1e6JOkyLzaVDo9RcmuMqSik1gt
	A1PwN4asXfybC3B4CtJ2VWqTQogCu0ui+gXMOe5IZ3Akfs6KxJUuoig1Vh04cLhT
	nHW1Waaurbcvn0o3hzADqRTAdrsWcTnDE9G/4ysCGodYAdWac+eIvEsAvXJscqHe
	Eg==
Received: (qmail 1698466 invoked from network); 20 Mar 2026 22:14:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2026 22:14:48 +0100
X-UD-Smtp-Session: l3s3148p1@z72LLHtNjoEujnsL
Date: Fri, 20 Mar 2026 22:14:43 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: i2c: qcom-cci: Document Milos
 compatible
Message-ID: <ab24w_ESHK46nG8P@shikoro>
References: <20260320-milos-cci-v2-0-1947fc83f756@fairphone.com>
 <20260320-milos-cci-v2-1-1947fc83f756@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pD0ll/xn1Oqxasoq"
Content-Disposition: inline
In-Reply-To: <20260320-milos-cci-v2-1-1947fc83f756@fairphone.com>


--pD0ll/xn1Oqxasoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 09:09:49AM +0100, Luca Weiss wrote:
> Add Milos compatible for the CAMSS CCI interfaces.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Applied to for-next, thanks!


--pD0ll/xn1Oqxasoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm9uMMACgkQFA3kzBSg
KbZ0tg/+LUI3JxaBw5Qt8zsyDLp5qi5ASZQO/aaaU4PH8JR1EuCcV4lnbEDr9TnH
85Z88F4dpUstC/vB8OXPpU0pZbOvQiq2NFQihiGA0Lq0oqiylmYDieJxiVZGDjwZ
U4WpM91KThPy7c9wWFFV24XcPTs5YFKcR7nYi72O+ukGePF+31CrTFRgmbay3C+y
Fb0lqtY7rKlxvlZP4qhQRNOuhlfwH/mJkpCvI8FzQOe048Zf5hHq0p+Un+Ndap3b
C98q2HTTu+UOFNVgOqEIatFKBtZY2GhLenXwCmCtuNDJW7XLeUfjCTF8eAnQsK1q
eG7ZJmzLR5KYI5ly/BlSDefVS9Bd7cfLtNnaGDDhVLB25Vls9uT1F0mAeXDVu+20
j796W6D94GInA0PFdOHB8Hh7r0GHm/zfABI6yuE+8e1W5oILXyMj92SDup7ktKEL
WcNRpDivBGof2aYmcHkXF54zGULcctuYNrbNzQHi89+NQd1+u57uLGgBgREMbwK5
EVTUGmjn7yXNStuWTmHghj/hkNWVcOcGVw57p1zrJiL1MK3Dwiw57FsR2FMhohzp
cxaJv3Ky5EDsbFh1ON+T59UFXp7Lqr5LC46AMxNJ3Phpi5leXT8iQb+KY3jG/olL
iIMRTua+RFtyfw4Stur3reyPB60d3lfHkYZu7Q7RybCs99y9ZtE=
=sp0J
-----END PGP SIGNATURE-----

--pD0ll/xn1Oqxasoq--
