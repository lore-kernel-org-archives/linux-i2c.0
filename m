Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51863346E58;
	Wed, 14 Oct 2026 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976623; cv=none; b=pdF814uxwn+0QEzmNQsV5IJz/0vRcqkVTL/2pvhG4hP4K+jCJbiGZ7gEETX0HzWFStzW37Gw+7ZsP9D/YGmecj4mmlIA/rqzPUR9ZpgP+hwJ90zLXMivhHbDnmaoiwLYZNw6SZmpyeMyJXTQTZ3sUwMc3oZrqmY+yf+PAhQvFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976623; c=relaxed/simple;
	bh=L+MtohG4GbXS7D6UnzKHrDotiKLueGVOSuAcxqs0pzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftbb1RTKo/+Hmdo+rj4pMBjcLJDxppSIUy8yZpm2kuTTCd0RuJhkE2gXJHKF2EmQEovtjm+mLfjoh00xSD9wVVeUZD52sK1zxkWD29xD+eppKTXRyE5qVm/FUy+Ht9Qn4HPydmPltAPugpi57tB7nFKWSjCCaw2MyPNMgkma3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhz7UHzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhz7UHzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D41F000FF;
	Wed, 14 Oct 2026 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791976621;
	bh=rBhUfWwmtFV9SH5R0eRvnOKIMcnSynjkjTl8PjeSz4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lhz7UHzQM0jXiZouCibvkaiGauM3hpNDGjMg+VlCq380+NSW8GiphogCmEnlZKKjZ
	 NXg9rPsmnjLpumojiAuMedZIytMofuvi+mxKXOeBtyZbbiJ3eX4qSmTHF49o/0k1qU
	 k4XCEp2ZLrWe1o2MrjMAfTbLYgfRykioG6PEm/CJswqeI84DiJud1Q3tVfg6Q/kaMF
	 ndu/bBpxSMnQn79piZq9wlMrqUxzWQq145tw4MGIZbQreWP5F/FnzFztM2qilHWKoM
	 rVlSyqE7/rj+dXWnuUH3z61KLJOKxdjJeL1Ov1gdYVWkOAKxe3hzwD2jkGoRZtzw9+
	 Hf0HjyraSng7w==
Date: Wed, 14 Oct 2026 13:16:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Vikram Sharma <vikram.sharma@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: media: Add CAMSS device for Maili
Message-ID: <20261014-gifted-dragon-of-lightning-bb79d5@quoll>
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-4-fc93222da89c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-hawi-maili-camss-v2-4-fc93222da89c@oss.qualcomm.com>

On Tue, Oct 13, 2026 at 04:32:46PM +0530, Nihal Kumar Gupta wrote:
> Maili shares the same IP as Hawi. The only difference is
> Hawi has six CSIPHY while Maili has five.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

There is no such file.

> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> index 5bf0dca3d24621bfc4a09feb8e5037a925869751..d1d53d6f024cbf7d2a0f2525aa4040260353b200 100644
> --- a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> @@ -4,17 +4,22 @@
>  $id: http://devicetree.org/schemas/media/qcom,hawi-camss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Hawi Camera Subsystem (CAMSS)
> +title: Qualcomm Hawi and Maili Camera Subsystem (CAMSS)
>  
>  maintainers:
>    - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> +  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>  
>  description:
>    The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>  
>  properties:
>    compatible:
> -    const: qcom,hawi-camss

Did you just add this line to remove it?

Best regards,
Krzysztof

