Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221066;
	b=yvls/31K5KKYg9zvzRR2ov2ZKwraze6XoQtct5UV6nhSh9QZu3uGKvgSsNGnczIsOIvI
	 j+aDyo6XqwbC6NvdU89HodALEklIjbmqGLro2voj75uE/2aJf6DEiOOQtrSRo7pMrXhOh
	 XtmNSLua2y9qbNQ3teWqxhz9y79COsDG+FhNbPsYgLgqQmUFUDuT7mjWYHh6ZIKqBXsFX
	 hgsAr+932RAsP2eHY1u6dwXqnxIQevmsvicTCwLsphKiHEoFFNt7DEYd+cEzi9Vw9CQL6
	 0AiuiNrojiKg8C5Y20Yh2jyFFsqlPw4CX7Pd5BnHT1UpXM1oWjdsqqMzMoA9817ESPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TXr2TKEYrIDqnyQ+02ZfHnpl8vf7msiDB6kAkQN1rZM=;
	b=YbAVNSbzV1Q0G6YrutAEgs/EmYlf6QrVaqPDBh12Y9NmLhs7t2vYVnhwLOMzPVJn1F6u
	 e4wTYf/jj/MAfRJvEoLP3d9Y1p0A8cYn98vxrXYUfg/95V6A9JljgG3lnotScOyjOjgkn
	 4+Bqo9+JbjWnbs9AEtqlGqDYWdBpsSwIWKWkgMuSuv3BDCO/cfmMcWf77TeemzruzDql5
	 Lgx9Dxq0a5gvH7UfMCULgW+f8SZx2r5KjbMQX32fxbF7OP/mFvP1Cid30uWveYLKgejSG
	 EcQZOGRIXKTaYp00lKDK95qhGF9pmDHiy7h1KhLrMX4u0FJOdKHns/dMpV84VpiNeDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfOpr55J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1D606A31C;
	Mon,  9 Nov 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfOpr55J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E151F0089F;
	Mon,  9 Nov 2026 10:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221066;
	bh=TXr2TKEYrIDqnyQ+02ZfHnpl8vf7msiDB6kAkQN1rZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mfOpr55JSOEAKsYIRwZlPYVVji4xFQLSCZnYgYFBPvHuYw5tqPT6lpcFI9qJa0aep
	 VERbNONOWWRfHvh/4pt0kOHo5GTHTckTKsADwINYHKcBPYIEykbTiHYKFVvv6Iayco
	 P56iKD/4w8gwEuVziu3200TNGNO+AhB2cOwaCB72Mkz71mMNHxSY5o0Mp5g7LawzBY
	 /hqT65DQ7N9EF/R0bmufgMI1JGQVXsKSu8+Hb/tg6OQ6csPirqc+IoZQPamOaOwii6
	 nfY5lMRBzsqXWKW0jlB2p3CN9fmRVT3ZMcVZGIxc577QjbgavPnbuP3Z9CnA+a/9r1
	 tz7C6CPoEbMHA==
Date: Mon, 9 Nov 2026 11:44:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Gigena <mail@andrewgigena.dev>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
Message-ID: <20261109-slick-transparent-ostrich-28ddad@quoll>
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
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
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>

On Fri, Nov 06, 2026 at 06:35:34PM +0000, Andrew Gigena wrote:
> Document the Qualcomm SM8150 Camera Subsystem. The IP integrates four
> CSIPHY, four CSID (two full and two lite), two VFE and two VFE-Lite
> instances, with 19 clocks, 8 interrupts, eight IOMMU streams, four
> interconnect paths and three power domains.
> 
> The CSIPHY I/O spaces are not part of the CAMSS container device: each
> CSIPHY is driven by the dedicated qcom,sm8150-csi2-phy driver, so this
> binding only describes the VFE and CSID resources. Each CSI input port
> is described with data lanes starting at 1, as required by the CAMSS
> PHY mode.
> 
> Describe SM8150 in a dedicated schema instead of reusing another SoC's
> schema.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
>  .../bindings/media/qcom,sm8150-camss.yaml          | 285 +++++++++++++++++++++
>  1 file changed, 285 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> new file mode 100644
> index 000000000000..371ff1ce0bd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> @@ -0,0 +1,285 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sm8150-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8150 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Andrew Gigena <mail@andrewgigena.dev>
> +
> +description:
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8150-camss
> +
> +  reg:
> +    maxItems: 8
> +
> +  reg-names:
> +    items:
> +      - const: vfe0
> +      - const: csid0
> +      - const: vfe1
> +      - const: csid1
> +      - const: vfe_lite0
> +      - const: csid_lite0
> +      - const: vfe_lite1
> +      - const: csid_lite1

Seems you ignored my last review, so repeating:

From which binding did you copy such order of entries?

Best regards,
Krzysztof

