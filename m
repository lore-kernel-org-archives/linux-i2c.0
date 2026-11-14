Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680108;
	b=HqFT/N75cI2iktPmSPbbGhKe8HgDlp3aZwJgPtf38F5CUCwEGQYalbCLiuALyC+jLj4K
	 8tb1z5yq3/mOWdUQt1rJbVylnFzrgoywGoKysU/kjRSBiMbbIeN59s/TMquW4kT4G3Ori
	 HlXr/6+AK2EpUncrOgG8NhwyexRx8mduv9SARiQ0yeTz9ACh2Sn4abwuGiwRY712uBHZ0
	 e5BXKgluVYTJgwcv15C02MxWyvzSgOtmoC0/+EZEOo7aWzDjOda2aJOi70wik//hM3dvw
	 4lME++ZAu+aPtlm6EcHcMA9KrWkIR/ytwri5nu+YSbdeJqc5ZaRay9gZq99C43FVsEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B5ji7cuO7EsHioP5va69m2jRcMzdD5Rhczoh46ifi18=;
	b=pebFtHMitvF8fdP/68/gFzq1y9bJ9Z3EN9kCjHt3Ias6xO7p069fJgUBHG0UU0SR38r4
	 fQ9zSNkxG3nLU0CI5Kl19lmDlE97FOeEmg3XS6O2wnZdYUXf2FVXfct42QtDhAIFuSwEp
	 SUHwPG7MblfzUXRZGV4YqV9OH0rucDqk9thAssaY7ubQ1dUYUcl0YdOvwaB59yiiHaLU+
	 Bs7q7ICi5/sFO13ZKvxhuz1etV7j941BcGrS04Er/BLP7MjJehfiF37JeVQFABspt4tDr
	 R5m+LEzVAI47PW+eGc0vvHP1bmpawgCuuuX3EmAFQi02vHMZxDUTGr7q+S1ZxKiClSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMCLhQiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1C606A323;
	Sat, 14 Nov 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMCLhQiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED221F000C4;
	Sat, 14 Nov 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794680108;
	bh=B5ji7cuO7EsHioP5va69m2jRcMzdD5Rhczoh46ifi18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DMCLhQiE89pXY2hCG3UHC1YAhqDuEitJqHFMi0ak0xAmtBbacYymck14A4v7WJNdF
	 nGjG+bwH8LJS4tsqbaqBeF8tuSGBsWN4+JnbGfT925piJIKfFNIMHUaT8VcAd0RLXq
	 fMIwPGBbivDAE1LyhCy+3DIeIScV4BawM1dx/iSoXCtBo/WAy9+zucZvEk4nTnjaU7
	 BggpUPkRIBl6ZPL6sZf66ftFMiPq6XI8rCH1JhmAU0e8WIXop5vj0Ukz7mTiQ5Ezjq
	 8Rs0RG5lTcx+UzJDKjbLm/lkjZ28HMnumeBupnqQcMqZvF2nN9FA5JtrJXZvzIsGAu
	 4JkbBavuhuSkw==
Date: Sat, 14 Nov 2026 19:15:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>, linux-phy@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v7 05/23] dt-bindings: i2c: qcom-cci: Document Eliza
 compatible
Message-ID: <20261114-versatile-woodlouse-of-attraction-6adeee@quoll>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-5-8ff2a11835f6@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-5-8ff2a11835f6@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 07:29:22PM +0800, Wenmeng Liu wrote:
> Add Eliza compatible consistent with CAMSS CCI interfaces, falling back
> to "qcom,msm8996-cci".
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

