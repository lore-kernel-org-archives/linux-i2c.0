Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895622;
	b=aHZW6jy/d1OZYioiy4xGYthwfPAa+xZ8N4up6Ep93LqRfkdIgnbNzajBKBLAFyeTCamj
	 8XaNw6s6A0uWlBtMJOFSXERBnj35OtfNro5VoI5Vi7SdLzjbo32Mw78h9EoZfEuy6MvYQ
	 roxhaIzHDf7qfsoAhPkEm9UZJFIpCuwMKr9faAG5Oc+NA8LFwo8yhbACMi/lAjHeGFWjk
	 j5WOAzJ9OoaJTNze0cXmhwLqYxzWXFNmwdlt96+Xug1wPPWLaSC8ctGmnCklT5t+sPp8r
	 pT3W9g9hdHBcaP7iQaPfaD3eJ+c6cmwKbkSOwjhQxFbEH/BG0Ah/VChFuOmcrEa9J5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y/Sxw5ch/x81dY8hqEEEUwXIqUNRFcAb/AcfPGdjlMg=;
	b=0Sfn9c7RKwSk/tfyNU4K6DJAi9eLaRCfRGff8BmX3V8G4ty+RpUdNtLtxPNLz/01K5FB
	 1U4V6WkI5znxySpRJMqp19WywaU2bFzNlJHj7x7vnPYmtTapKppLJU/j15txsr0DVJrGg
	 RsI2fGKkqUn3nH2+VZEqlXKtmaH7esbW8uTCxLtA1eA02uwZRMgJ4iq9EezWCtbv9Kc47
	 BHppTjzB+kyxo7Jgvf5ji6/rG/cjFENnVyo6gp+n6eImbSxL7ZVBzogEkjuc5cVOa2awa
	 3nl4zQXFAHJOWc+wrxpKYNjr+geLGUIsS4HjwQRYNb2sISCQFY6z27LJl41rFX5j49Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAJWky2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EB606A328;
	Thu,  5 Nov 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAJWky2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798D01F000C1;
	Thu,  5 Nov 2026 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895621;
	bh=y/Sxw5ch/x81dY8hqEEEUwXIqUNRFcAb/AcfPGdjlMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAJWky2v8e95w4biSTiGSqglMKizTFvJ3QYBSL7Y7qdFiE6pS7OVqAW1q/CxdAvtL
	 FEFajLTAN3L0B4B1xNupBuHpMZKbtWrI2zWQexy4SqzzL6WzGLbkCBMlx0/QlfPhBl
	 sh3QCsifx8Lb3/JwUQQM27f0WpazOgNTwyToZeMLxJhHjl8QbjQ//TvXyVUl5rXufQ
	 iaXvySHs7vLFxhwukoO47IbsmSOkZ48I1q6aUZ+daOXvFwvvUvcRdboc7u+ZuLcEP+
	 29HHp6yfaaWwEDiZyez1kdUJdgC/TN8AySACgsI6hAW2aktXweB+jXIE/nLPrUD2dS
	 MPoy/k09V1rpg==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 0/5] I2C and pinctrl support for Apple A18 Pro devices
Date: Thu,  5 Nov 2026 17:20:04 +0100
Message-ID: <179389559452.15725.13059409362781617526.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 13:52:31 +0200, Yureka Lilian wrote:
> this series contains two small formatting fixes for the A18 Pro device
> trees, and adds the required dt-binding for i2c as well as the dt nodes
> for pinctrl and i2c controllers used on the MacBook Neo.
> The pinctrl dt-binding was already picked up from the previous series
> regarding this topic [1]. The dtbs_check passes when this is applied on
> top of linux-next or otherwise combined with said change.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-7.5), thanks!

[1/5] arm64: dts: apple: t8140-j700: Fix property ordering
      https://github.com/AsahiLinux/linux/commit/2bf05983cf34
[2/5] arm64: dts: apple: t8140: Group cache-related properties of cpus
      https://github.com/AsahiLinux/linux/commit/d2de25922a49
[3/5] dt-bindings: i2c: apple,i2c: Add t8140-i2c compatible
      https://github.com/AsahiLinux/linux/commit/b843aa34726a
[4/5] arm64: dts: apple: t8140: Add pinctrl nodes
      https://github.com/AsahiLinux/linux/commit/f5fe46328186
[5/5] arm64: dts: apple: t8140: Add i2c nodes
      https://github.com/AsahiLinux/linux/commit/3757588f0cb5

Best regards,
-- 
Sven Peter <sven@kernel.org>

