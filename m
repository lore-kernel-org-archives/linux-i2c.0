Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88726A0D5;
	Sat, 30 May 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140899; cv=none; b=N8CMQ15PemhPOVw6suINE060ebb6GRx+fZ3srN3r0euyrO6pGJ3F8clEffvXAOS6njHzfj7IL7oAreJBQngpNh2c99hkCxtGtkTzthxyqbsFvOjR45CrRvstoS+rMi/YdwvauH1E8MI8VvRXPEneuqHOsAcrlAcxA2voyt3xsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140899; c=relaxed/simple;
	bh=Ku/aFaxUgfIGXui8jRwFs/0PTJclzFiBbeu2QzFxa64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDCRvW4ORcCTZ8MacDPHy9kpCngnJqKBVk5StK4SnMS0tKyBIGIt8f5W2s1pyDVOslh7MYYVjY1Vtas1IdaiRNPaQTx9NVwnC9qq67ZIW10//wt1TMtq8Gwgucz46S9ESt4uFuGiHpwZfmuxYjaCPb4UyFtkk9cTxU9vnKmaknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imYG6wHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imYG6wHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AE61F00893;
	Sat, 30 May 2026 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780140897;
	bh=r6iJ03g0GN7RPUEqnMX9QzrhnN3t4K3RUDcacgMvbpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=imYG6wHpndrIyG2kUXah98OBeOwxAQDxY+wnIJP2tmdT81J8jrlgyC9zjchdYinrp
	 qrUwgYBT9G5apv8isIO+ZfnGbXbykqDUC1FDnE7Ay5q/2UR5W8EZyOe1i0mxgZPKIy
	 iIPeqjCEDwKD8nsV8rhLLHL1+Ev5/QAyb3zCLONelalhQa4Lpq9RpJtoRu/3SLYSQ6
	 UW2ecTI7wyeuNZhHfcKVjz2R1WFhmrbOJVHtcx+VcYPUS6Py/4NsxZwC+CbRiSRC4d
	 qL01rbpeAjc9gEJmvEQSKpvHrqY+MAWqSYcPSuE7/rMcGqnz1mvNLBj+QYcfzF0z2H
	 psI/LmsNcVEUQ==
Date: Sat, 30 May 2026 13:34:55 +0200
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
Subject: Re: [PATCH 1/8] dt-bindings: media: qcom: Add Shikra CAMSS compatible
Message-ID: <20260530-lorikeet-of-strongest-honeydew-fd9b16@quoll>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-1-645d2c8c75a7@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-shikra-camss-review-v1-1-645d2c8c75a7@qti.qualcomm.com>

On Tue, May 26, 2026 at 10:42:45PM +0530, Nihal Kumar Gupta wrote:
> Shikra uses the same CAMSS IP as QCM2290. Extend the existing
> qcom,qcm2290-camss binding to add the qcom,shikra-camss compatible
> string.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> index 391d0f6f67ef5fdfea31dd3683477561516b1556..7b1469d6a1601413a1a32dc452d7d1fc85aa9eb8 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
> @@ -8,13 +8,16 @@ title: Qualcomm QCM2290 Camera Subsystem (CAMSS)
>  
>  maintainers:
>    - Loic Poulain <loic.poulain@oss.qualcomm.com>
> +  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>  
>  description:
>    The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-camss
> +    enum:
> +      - qcom,qcm2290-camss
> +      - qcom,shikra-camss
>  
>    reg:
>      maxItems: 9
> @@ -76,6 +79,7 @@ properties:
>        - const: sf_mnoc
>  
>    iommus:
> +    minItems: 1

No. Same feedback as before - you need to describe now the items if you
claim that there is distinction. I already pointed this out to Qualcomm
at least two or three times.

Best regards,
Krzysztof

