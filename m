Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F03F4854;
	Tue, 28 Jul 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227932; cv=none; b=TbILfZvrGUEKSSzIfZGTIUqNugNtZ8LZnyu/HFlNT5PxX+QQtAP7vlNFp2byMVbYeC19UqWdfEnqbh3xpVu8V+t0fjotB+GXvZUi5WRiiq5PHaplHz+RI7yJZR6obaYTDRDyKHLnTiYtu53ZXbV/CEgK+Im0BUVY8CBQRectWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227932; c=relaxed/simple;
	bh=/+3WW/263h2+7sfo7G3yXBjL2PrSIaFOs3LMhgKDWNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp5C/buFD5mkTOoEWaKqX3p9UPX98SnVVwmznWnrAggTKPAcdNp+FH32uY29DsqPSzWvxk7GXksvh7xEoX4A0o9prH/CY5VCAipLl8hi+qCvc9PwbE3E24Jm2a5Xzv/RUMjjFWXSE9udqKX7GnguDYKBIT6PrP/B/qY3eSyAzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNceyOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNceyOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93D21F000E9;
	Tue, 28 Jul 2026 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785227930;
	bh=JIKbj3Lai/hOj6cxZ+umv6T98HNivsqn1aYwSt+Qz/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khNceyOEPKHd55JXXtl21Yu/g6XmudTclb7rFSLn5/EW9DiTkshdPli5JWXmR7R/V
	 R8ZjpI0/H64hz/nL4dXrKjSh2PiME2DP13xME6pswEUaaDu6k7HKqUf8ssCyxI0Gmz
	 dei3EyYmcKHC5qhpGQ/B9FMAldLEf1JwLlJa00LMpK/6lbsuwpsqJkBwD9jSPEJq8L
	 PL2xAz7LLQ6vFjCgz6bBQCqyKzpC6OQ2FfMKodn2b72WDfyb30x26xktsojQWkY0Pg
	 C5FCc4nNjCmgEcj1El007cHQ/bg5CBF0sQ9pAUv8jBki0FCcyPMdU5UNDHq1C5/aH+
	 BpJ9hOlWNT7xQ==
Date: Tue, 28 Jul 2026 10:38:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: qcom,sa8255p-geni-i2c: Add compatible
 for Nord SA8797P
Message-ID: <amhqA_av-HNk99Ql@zenone.zhora.eu>
References: <20260707095708.3801043-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707095708.3801043-1-shengchao.guo@oss.qualcomm.com>

Hi Shawn,

On Tue, Jul 07, 2026 at 05:57:08PM +0800, Shawn Guo wrote:
> Add compatible for Nord SA8797P QUP GENI I2C controller, which is
> compatible with SA8255P controller.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
