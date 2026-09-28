Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09E3DA7DD;
	Mon, 28 Sep 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598566; cv=none; b=ldNz82Sb3VqtaHeBTZBEWt65uY9zKaYvitLhvIqeFF9kFpSmQr/qXX3uDjq4FosCMw+YkdwMrGZTMu0N8jRxmTY7UwJobTTF13KbXipjSEoBifLpTNLK5lK3vR/vNVIR+1PisrqVQNEItP5pH5qiS8qcdsNFC8o2fCCrUlanrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598566; c=relaxed/simple;
	bh=XQjUBJOOy1TstLwqjCkrkgPV70qjb4a1hvRxcvO5NBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3iPK8Dqlgr9pZCvFsP4lmV0uwlPDRA6pd2+vrrnVRoS5AYY8AViKonfxqj1C7WiHgDvjGYaN88N5MKeOyLYJRNrVPRYXcowhD6nXBAy7siTpkwYODeQwAQ62zs7o4Y5yEz+WaLYI4VNuQOE6qR+BT1XsN1z2w4RKQsWVczowtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgISBTHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgISBTHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4C1F000FF;
	Mon, 28 Sep 2026 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598565;
	bh=91pwuU3OgL0Wr24qMPAa6xDt2dy0IpMtRco3IPDhLJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgISBTHIMG8Pboxc5goHyUdq32kOJBjr3EhjdyMvX4FlJY4UA6dK4Q5eENJdFgi1n
	 QZmGFFL5zyIklL1B/Zmbet1T3Akaym3eaGcBG1QvwdzbAaWk4Q5uVaRk+U9hPid6O7
	 bf6WvXFjXM5t8953wETH9r5dQNQLAGksEpfE5laEfA1hihxK39AUn2XdB9YtKS2Eta
	 UlTIU5JtkfJ26iMDocPwAFbtT+Rh6/euSqvTsf44fqvlYL6hy2VOZfFeAt3UZ6JUcx
	 OMn52AxsbJctqvpfnZQlURHy6nZDSqqbmeOUBQmzwOd2BWNeDdnzkt/JxIXAgEHobv
	 0bo37iDuiSFZw==
Date: Mon, 28 Sep 2026 14:29:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v10 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Message-ID: <arpdMZ1KHd00_oLK@zenone.zhora.eu>
References: <20260921083753.1109826-1-zychennvt@gmail.com>
 <20260921083753.1109826-4-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921083753.1109826-4-zychennvt@gmail.com>

Hi Zi-Yu,

...

> +&i2c2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +
> +	nau8822: audio-codec@1a {
> +		compatible = "nuvoton,nau8822";
> +		reg = <0x1a> ;

please, remove the space before the ';'

Thanks,
Andi

> +		nuvoton,spk-btl;
> +	};
> +};
