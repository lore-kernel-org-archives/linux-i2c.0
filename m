Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378A39B4BC;
	Mon,  6 Jul 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357194; cv=none; b=mWXwo0C9HoK8DKubzGgKJ4EfrkN2l5TD1pzLjgnKVt/Ia1f+U8ZcjHSbBVJ4VacaTJDm6NO/x8v8Z3Xu33C3df23YWqrqT/20qo6LOKopEOKRi+yRgoRf/O5E+gQ1+83UJ2AsR+xKr8w2GDOugePlNCR49fCbJpTGhMNfiiCRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357194; c=relaxed/simple;
	bh=yCvrY1Qlzegussb8UyfbT2bAtd1gtr2pkvURLSHLCjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLTfkNlEDPws4+PS8fmzvrivy6S9A8sop6dd67X1wWsQlmXwDCAsEXBdcVJ3NjEF6P4wA/fYbZQ+Gf1ZXOpWVVBcu/Jx+QTZKnQaE61tmzu6aFw+/pEy3YQOaAicD97rdsCyCtRApJG3XSYfVYF3TzqMaFZ/AfiZBl6QBscD1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isNEjTTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isNEjTTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2071F000E9;
	Mon,  6 Jul 2026 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357193;
	bh=yCvrY1Qlzegussb8UyfbT2bAtd1gtr2pkvURLSHLCjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=isNEjTTR8a167Vcf7bhOm0cEoDaqZkP/TY4jerlztUHGg0IIFOX1DbHCCUiniN5ov
	 rZ7pXqfRT9DCsyvoiHNTczdG3MnQxTlBaf+MvSMit3x/xq0MKCDqxjojVvhholAOSn
	 BHSbX05rpn5HAjjOq0vTfPWQ0l3CE2pvsYu4Wv5bbHNiwzBXzs0dzwiwoENkh1ZluV
	 zCKWdrcf9q5FzQygCROw8TarLZpYd7wfvJKIm0BoQp39utWYkSVJz5u2Z/GhwhHoiy
	 mETCrnauAY7LprWptjWPd33HAk8f81O5luPxUSEqI++xcr6KZLFcW1iOxSYVVYNcM5
	 W1tK1lx3/oK8g==
Date: Mon, 6 Jul 2026 17:59:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C
 controller
Message-ID: <20260706-shelving-dominion-2e2bfdd1dcbb@spud>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
 <20260706081055.1126275-7-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9ox9MgWlzK4N9Ub"
Content-Disposition: inline
In-Reply-To: <20260706081055.1126275-7-pinkesh.vaghela@einfochips.com>

--l9ox9MgWlzK4N9Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--l9ox9MgWlzK4N9Ub
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakvfAwAKCRB4tDGHoIJi
0tKRAQCDQ+rJRscgm58ML3Ivf1nzA/E7knQkY0nZL1PKbQIGIgD/QJ74B3qqakGq
bNq9+rE9wRWp+lBkYr5TW8Att9nN2gk=
=n4AJ
-----END PGP SIGNATURE-----

--l9ox9MgWlzK4N9Ub--
