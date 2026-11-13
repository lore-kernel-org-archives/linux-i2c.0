Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590568;
	b=i8gNKatNxeHOzn2swjmf5LXO1TVsvt/8/wplEu/MogaIYWIn0rold35RSoVSisVkN9e0
	 DtZn7PJqfquOZxoLgU+w10poJvnerIZLZ3JGwkNGOOkH79e9B2ekYxiOPulkz8TpNXWYi
	 ccaNMcpq9k4HKwKLgGNZMeprhnxPJ6jq56KrTzAxqrQysQn/f2hGL1k5JjC0odC7fFAX6
	 od3hWM9fOXnxb1oziXljp6ugxdpzl+HrM7LltB5cqIB3VY4JHL7PExu6DDAxmDGoV42cI
	 USHbmRg3R/4DNsCHRw6AR1D+vW510sHbOW+tw2BaAGrKHlHuLc9Q7d3+yzF0tGstgpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9mbztNyPF9d8Im/tzoUpmqFw6e3af2GVAqcZ6iqDoSk=;
	b=3JyETPg9GICl/gieSO1PzWec8BS6iPDrMbyeXX3eaFwm0QN8aI1CyOtwIDDOx9rP1fvQ
	 jGVKgPabEOelNI2ZxhbNpsda9glCqBH0vheqSghUvoRs3F7OZVAQG7/rCTGDe/kyzqQua
	 QliSKTTqFjJbTnAFgnpp70us4maftAre3su8xSq03FujZ9KoeYsxz6eoyhnkfZ1SEkKEb
	 Gzx3aNAkJxSVAX/4UR0VEusGb0H/6x2W5vdMpI5dP802xT/lCuToqC0pmjm91BzfXP6Z/
	 59Tq/ysWEXSK5kVOIE+xjxb/ouZmRQOErius+2c3ysjX1s9vodOSoBxXqvGrnYp+zkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRm9UCDM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E78606BD27;
	Fri, 13 Nov 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRm9UCDM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED0F1F000C6;
	Fri, 13 Nov 2026 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590568;
	bh=9mbztNyPF9d8Im/tzoUpmqFw6e3af2GVAqcZ6iqDoSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRm9UCDMx01yJ1eZjRSvWVwJjF+ThxhtiQzAZ5LaHiSBj1+shDrmOGD3P84+GcY7/
	 eo9Pw33LwJ4cdfDwykvrV1//Eqm3+heyBYbDTahGHF6CmHdUdVkW4xJ0WkgD3oaWu2
	 rwB+tgaMvqxzMGLkR1aeyM/nmTWDlBI2gci5FL4chF/57fXInlkKU8lJ2RJMrScvQF
	 Wb7aSki/XMIasZsffSJPe5rhM9Uwww1Z6Lvnq35vVNohslV+zb467TiIFzYR8Dcp7D
	 coFQs6om05frsoCFMdPrsZ/Sqsi/pQmSztTMg/CGWKdSCVIgLmZ6qM7gqauhY8JJuV
	 LfAIRtCdyoAQQ==
Date: Fri, 13 Nov 2026 17:22:42 +0000
From: Conor Dooley <conor@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, lei.dong@airoha.com,
	Linqi.zhang@airoha.com, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Rajeev.kumar@airoha.com,
	upstream@airoha.com, Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: Re: [PATCH v2 2/3] dt-bindings: i2c: mt7621: add Airoha AN7589
Message-ID: <20261113-sturdy-cope-372ec5b8960a@spud>
References: <20261112185820.1315718-1-john@phrozen.org>
 <20261112185820.1315718-3-john@phrozen.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VZgVvdyuSJJK1emx"
Content-Disposition: inline
In-Reply-To: <20261112185820.1315718-3-john@phrozen.org>

--VZgVvdyuSJJK1emx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VZgVvdyuSJJK1emx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavdHYgAKCRB4tDGHoIJi
0oDaAP9he3qI6FNt/UB2Y/B7fxOlCCpoPFJ7Bke6ChCknlVGNAD/VX/k329GipMt
+C+bFz9cDCTLEnqOag0FIkDLojAwLgc=
=sD00
-----END PGP SIGNATURE-----

--VZgVvdyuSJJK1emx--
