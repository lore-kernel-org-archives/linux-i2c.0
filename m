Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDD340402;
	Tue,  7 Jul 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440833; cv=none; b=F1AVxyUE2pFNzHHadRSc3CDjVzxuZvAP8ozU79RenrQuZx+CCXsty4KF35T51947O5wFGOOn3tWq4gIDZPnexVcQjRkyDPFoLWcLzWZ1GB7g0JeAKwl6U8ypehCZaScx+oPwTKIrEyaINt2i6xTeUCVJChLazn+XzNHu/DbZgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440833; c=relaxed/simple;
	bh=1IW6FjFzcEmU1Ry+Or56LLsYAe9HoY+J/8hZ+32I1fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjRvzM0LToyXDhNUNIkg8DtbYOg7QjVpZOI/j1ZlfO7Iszv/WEGRIoKiChPNkYyb4f4wgpCet4GyeYRvneZYwyBZkelEX/4Dr4TaTmpSnyydPsSPtp0aaZ/UKvZFF0pCO30ykDUhR6vraXAi5yn2iFEvOThM/fTwGl2mdGVolGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOqCvRfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOqCvRfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE79E1F000E9;
	Tue,  7 Jul 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440831;
	bh=1IW6FjFzcEmU1Ry+Or56LLsYAe9HoY+J/8hZ+32I1fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOqCvRfbYfZF0O5VyM8CiBywQyPPX2E1wCMD7gM4yInm91TRtmy/aQIR05IyNxUwq
	 LDZqB7yT54hfarf1FXqFHKHcYDsGlv0W6On4NoQ6xSmH/63rJcbOGtslB7jcSOE+i+
	 uJAyLOrqlyVOMdCl8TV3oeXxI73pLN00DqhFpK2IRcj0FfGeN/yh/atUwDSscnvKu7
	 JzOpo/94qGaJx0/qC2xhtS5tZbb26VW/ybWDWd1QTo2IByKaKStaAytZMGlpC1QKfL
	 xTf2vWwJ6q6sNs344XyCNKFE4TtfJ4USUreAwY4rXs2o8UAdHKrxu9ks+Wd0d8Asom
	 of+hKcHnd/3Ag==
Date: Tue, 7 Jul 2026 17:13:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: mv64xxx: Add Allwinner A733 compatible
 string
Message-ID: <20260707-protector-overblown-2fb9fa42e976@spud>
References: <20260707-allwinner-a733-i2c-compatible-v1-1-566340542bdd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/26oEDxPHKNqYJe4"
Content-Disposition: inline
In-Reply-To: <20260707-allwinner-a733-i2c-compatible-v1-1-566340542bdd@baylibre.com>

--/26oEDxPHKNqYJe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--/26oEDxPHKNqYJe4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0luwAKCRB4tDGHoIJi
0lkvAQCFp+d4OmaIv50EpvX4KECyhuI0CTWoWEwiY/98IDXO4wEAy9EAPdJoDpH1
t7JmQ1zqInnhtHSFmTyn2yfng8+ayAE=
=YDaZ
-----END PGP SIGNATURE-----

--/26oEDxPHKNqYJe4--
