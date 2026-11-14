Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680059;
	b=t1Um+LTl54Fr8/GZaFGJNfXROng40OHpJv7bM5x2kICUWweB+QFFyGSJnazWatZTZR43
	 Ahjt+lNLXZHbY8DhnJQAwwWN9gomCu2HKBnZtjYhN/eNtWAOpvYf4fUhG7NoOGIQsfhn3
	 lWTkH/SGowlJYqdVsjtliQJmQciFfPUEKTJ5mJIdP7MyioILLSLSFXG8jcbcwq72MRepJ
	 aeEhdbF8RJscYBfDyiyaPHTb+s+oDVfZqh473dSWlHs5J225JYXrMJ5zm1+y+uxah7kIK
	 /3GS21Mrmggy3XlgrT3nXKlGs4DwUoIF5u/Irr/nYVretGyQSY87VZzorGdwGlJ8q6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680059;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6+Sauw6DJEUpvtWX2SFkG7bCwatCc5yOD4eI62wroEg=;
	b=bqOmRT9akdkfegx690lZwUnpDGSvl9hBz6jBt+vKawGaUSbeRJ5FSZzxWH/c+Vhxf9Ls
	 Xm2WmyJ0M9AhTwpfuZM9PTcR+LNeWeDSU1LrTY9AfeF2y1Sp/EVuU/RDr4goY5tIUVcNw
	 ooT0W9xe0bHmjhtUPg7xyAcpXWPZJkulm0mMjp07qbKB8EWn6WyJv5Es7oJ68kWVFv06f
	 l4VXjXHEm1l6NWe05zfbTlb9AEsOdzY4dquyakhCGc98O8YQ40DsEigkGqdIXLmtHeyx6
	 R8Bt31rY4dWMp41tVGPNyfITtDKajKMl+DUz8wAQ9V/LrBVqbPtXGQ99/v3AntKSn9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O31IDxaP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183F606A32D;
	Sat, 14 Nov 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O31IDxaP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9F51F000C4;
	Sat, 14 Nov 2026 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794680059;
	bh=6+Sauw6DJEUpvtWX2SFkG7bCwatCc5yOD4eI62wroEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O31IDxaPX1oWthba/bb0Wh2Dy6QOzeoJUK4PX+eHCWzEUhA+IEjMv8+HcKRMQ9/4R
	 jtM6OOS8dVQktx6jnG+oljOYLXylqdF/1485ysuDcGSYy/3BwDsS2QaqsotaUpbuko
	 lI/wwGeEmvmQlsr0kIr7QQ+byYfA5S/cryquWhl/71rx7uKD+jpK0bccmH1Bij3WIy
	 aMc+mI5VPivNX7E3XmNuZR0UgYHrKA91qQPeYXmDY7wb9Z44LSPsN3/OF9DnXUiliE
	 jou/+0dAXb61uk5NiETB7ZrYba6D5I59YqdQQb2mbf6Y3oZau4P6YsZZzRh7FBnkq7
	 bfu7oqCRyirLw==
Date: Sat, 14 Nov 2026 19:14:16 +0100
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
Subject: Re: [PATCH v7 02/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 Eliza CSI2 PHY
Message-ID: <20261114-garnet-doberman-of-elevation-ca33e6@quoll>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-2-8ff2a11835f6@oss.qualcomm.com>
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
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-2-8ff2a11835f6@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 07:29:19PM +0800, Wenmeng Liu wrote:
> Add "qcom,eliza-csi2-phy" falling back to "qcom,x1e80100-csi2-phy", as
> Eliza integrates the same CSI2 PHY IP.
> 
> Eliza has no MMCX and MXC rails: CX feeds the existing "mmcx" input and
> MX the "mx" input, so only the power-domain descriptions need updating.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

