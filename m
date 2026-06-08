Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40F224D6;
	Mon,  8 Jun 2026 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951581; cv=none; b=BS+g97PyjufEq4QVLpeQXGTFupDRn2r2iMmcvs5WPu13dPJGUjNFB9Nf80fIJWQMHMkGrUQGBSYDk3s8JsCCrhmao9uSV8oMA+pHILc5rA7dmGHHTo/LAu75+IusnjsrwZQ2HUSviYxvCDOacp9Ats1Yz4fg9hi+e0UjcCqFCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951581; c=relaxed/simple;
	bh=0QPCDQzTCPZNBhl21/y+K5HBQJmbRX+dtKa9HQj9X9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxw+0nVo9pEZ2jj+zmdOtk90pyc5SUWkifo9KaD3u8BvYpNkeEEmeWGLqt+EOWZKrFuyK7xFxGExUiPmJ2K+Ob+PAcVpxK4RT65fvThtajKOMsAGmd8VYvKTpoA5CA3F9vtNoftujRc8U+wExcFg0DTuuXSlq7t5ksZNZ6UwPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxjZYV02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxjZYV02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947151F00893;
	Mon,  8 Jun 2026 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951580;
	bh=p2BLSVr+4kvNFJjBTGY4+qp78B1yuQ5e8zYjH+i9H6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TxjZYV02X/cedFJMm0LwdABiIWZfT70z2K8k8ZfEWYH9M+w8XlnGbSJoVN1XNH1wu
	 CYE8p2Zv7777w3ZYhrrD4ux3Y38j7tDNX4WPXGMYbnrplTURSM+EqivbOZRXtTK0X2
	 efwcYS2XFiHIHCaCJ4+8GUEbGtp2CaGyiW0xeNfkz/ppkzBlpCQnaDgdrai4q6VM4k
	 9A7FrAGVM72Jj1aoUYwlSRXy/vnyRvlKbQx6flxPuuA+jLWNEDcgAxpJW0Z1xe9owU
	 MLPccBWhxkBaFmW9rHQaigvlgrUFHTtTV7K5XbNp5XmlDhzUxWAmEeNohzjQmRNSsj
	 VmqD7PYlMgPbQ==
Date: Mon, 8 Jun 2026 22:46:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Suresh Vankadara <quic_svankada@quicinc.com>, Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: media: qcom: Add Shikra CAMSS
 compatible
Message-ID: <20260608-reliable-vivid-stork-f4ea6c@quoll>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>

On Mon, Jun 08, 2026 at 07:36:38PM +0530, Nihal Kumar Gupta wrote:
> Shikra contains the same Camera Subsystem IP as QCM2290. Document the
> platform-specific compatible string, using qcom,qcm2290-camss as
> fallback.
> 
> Unlike QCM2290, Shikra omits the CDM and OPE blocks, requiring only a
> single IOMMU context bank instead of four.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,qcm2290-camss.yaml    | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> index 391d0f6f67ef5fdfea31dd3683477561516b1556..4f39eefb4898ebc22117407f26cfb4f41deb111b 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> @@ -14,8 +14,11 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-camss
> -

Do not remove blank lines.

> +    oneOf:
> +      - items:
> +          - const: qcom,shikra-camss
> +          - const: qcom,qcm2290-camss
> +      - const: qcom,qcm2290-camss
>    reg:

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

