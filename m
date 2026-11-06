Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001126;
	b=Nx1GkJKY/hvikQ+10xk/Q8uOKgk8876C3FgKXuYL/6kecK483regvXRDOMFJ1qLk25I7
	 x1w6CGAJix3+2vT1Wb5YOn8mpTc0Wd1butSyYGRjYsVm5BAOzH639jBIfUcRc2g0Jfs1/
	 D6SYUPsDhZb3g8OpCyxY2cV/9OQj3GZpoEKVw87/VpGi/ic+la0AzmgaZQ/Ei2rYJnCJF
	 ++ia+zk2/Z6GXicxUyeGvyH9mosW78Mt/xy+uXnOp90k1F3lGZJuyWLy3sYnkto4vnI/N
	 Aip8I9wOmmaETe2vDDaK8w0SxWL+GNTAzD5lMV+jh5qlxnAnnfhRpnXKJFHbeYbu6FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uG5G+zK2Jay3P3mKTZXtyylvcBJ3H0UWbosExNjzy0o=;
	b=ndZtVvIzzGq60YHWPL+0XnoSfSR0qJ+wTbq7Ge5P8cbUawR6RNQqB9PY744mx3ckRT0n
	 sg95bbzgJGdZyCkfx0Oe4ny/jf+NpaOE6loXPFeuLpcXIQjHkRm5ZvgfktAl2c1hqOXyQ
	 +Nl/lCHuSOe6OqeP6t7Yca8UJtYOo+jcsWeephuxD3LyI0pY8+eDAOpu43zruQ2gyEYX8
	 1cdEM0FEcyVYIXyxKpTGvUExNQJy2EEMreAoxnn60UvW1FUJQ8hxIxLANqw7H0jL2M1/d
	 BDhOyECnGPxWqTfxMSTrJwi36mZWRvyKNiQIj4vG1/QUr7T2cDztOMnpJJ2yRCoiX6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L7aE91qk;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF32606A32E
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 21:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF32606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L7aE91qk
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3acde6b7b29so1293341fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 13:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794001124; x=1794605924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uG5G+zK2Jay3P3mKTZXtyylvcBJ3H0UWbosExNjzy0o=;
        b=L7aE91qk9vecJq8zTzP27dLTgyVJCswm2XZidVX3WuyBJEc1mGk91x61+rG4qV3+NL
         +EQ91tviyggSbfVDrH/i36AAUzYjkl0rxI7hUQB/Bj1bfaaGuLj3+hBd5tBXXrLlJ71Y
         qOAH+hELVjlwUS3s3P28kIvhl9rs7KYdv0+TAuHs8CRtGkTfUp1KjGaccUkM+CAp5Wa+
         h7HAV8Z5AzAvs4k2NV/2/ln4RDDKJgj/1mnJikViiSVHHAijVC7RCh0oHGa0KXVwCFPq
         nZgwirwmqtjeo9oZ9XFoQwJmbe/md1s5KLW3W4gIZemNSkNJGrytVea/ecZ3dBcjOmXv
         tx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794001124; x=1794605924;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uG5G+zK2Jay3P3mKTZXtyylvcBJ3H0UWbosExNjzy0o=;
        b=PWnFdxbOSaX5cRQUam5Kdum+xvBRXXsAH+MoiGqr3j2uGFMnXcR8u21HnRKVRMar9T
         dHd2tmPIY2ktOaJUbQ7JcZXnVaSWUVJ5NMaNP1MmqODCRZUZWmkgVqsAV/KxF9OK9gd9
         NN6Km7j1p9flZxaQwXB36lnzojQrPJj4dXECRdu7Rm3DnEVGhhgzizEmL2oqHdoAwDY7
         EFQNbVczTDN/an9Rr91BnFsAvW9b2dlUv0yE+s7V8QtJ15YqPQkkEH9wF/+E3Ua/l0RF
         KbM75+zk2Zzc1e1SJ0VeUB1Fhm9DjvSejFHmnTR3AZjVvPo5DNIgPfuEaH1ruvlfPLAS
         XSlg==
X-Forwarded-Encrypted: i=1; AL+hErEfVqK25D3Vjj2PgZKtVZCUXJTzdsnOX6HQahCmrq7hnBK1fY/8kOzuZm5QMgtwx6eExrgw6JarRcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o7oyclvZFmb3gW3LjxhZE8qC4OjZKTEIrlLYGI72rJWeP9H84
	K3tiRe6W0kccT0wQ26bwx31H1IY+gSMiRkGQaPWk5QO1WEqdfAVgVzFDj9/FAckADOQ=
X-Gm-Gg: AYBFou3+YCCGCNxP2GLSbSrxn6k4ogbaSs1JTMUCuG7zAp3IFE4Z09dhjwFhxYoRMXS
	S+oNODiIa+ESrNrCJ1fObHvrSaJtHCod8p4yoHt8ZnjxlrBaig/vZu0eoEC2VNpQuxmQTe5WDdv
	EUn7IdDohcEI3UJX0gJQCAEaEcGY9u1Z8vZkvtrfI7F+atSJU0oSDsyTBH6zEEY+v7ySW4ujQWz
	WcgfX5VdWQR/+NXS4AhHVfw7g4sqLwR+ch4rekdkVlNpngp3a/D8gLRgRSpR2zhgZLbMYqfqhj3
	WwEpVoXZfslHPvidbJVfhuGFTmaPBRBaGiUcXhGWu69vHmLOXlQYAMhNRkCoyFRwz3zPYICTpaR
	RpzbEeVRKdXEYcmpvmpShr9UD8afv8c7+WEm7B5DhfkV5JiKU1in9SQAY+/R5QjvL2dnMWCHQtB
	c7geUJjRbaEaa61MP6WKPB4wLOqcd7kAgCBoXdIx0iw/zEdk74ZVxEVOBtynWWGgRHzuRzfIxIa
	J6MNZXX2Lx2DKKF47Iz+WYDfm2JsgGQ8uydfo4ZVNiyogQwMLdN9t75ct0w5kyx2tnQC/ZkDFUM
	mgcbRULXexIHVUCELNxJxG5WXezvNvqXYguv9y6TiqZOX7lkQe9DPSPN7LlhBg/Mlx2nRcVbXyu
	RLyt2tQ==
X-Received: by 2002:a05:6512:23a8:b0:5bf:ce1f:cdb with SMTP id 2adb3069b0e04-5c0039162fcmr1408155e87.1.1794001123717;
        Fri, 06 Nov 2026 13:38:43 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c0087ddd18sm270965e87.21.2026.11.06.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 13:38:43 -0800 (PST)
Message-ID: <21be3761-9da9-48c6-aaa1-b56f8625167a@linaro.org>
Date: Fri, 6 Nov 2026 23:38:42 +0200
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 20:35, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
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
>   .../bindings/media/qcom,sm8150-camss.yaml          | 285 +++++++++++++++++++++
>   1 file changed, 285 insertions(+)
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

That's an intermix of names, and you will get a review comment from
Krzysztof about it, I stand aside.

> +
> +  clocks:
> +    maxItems: 19
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +      - const: cpas_ahb
> +      - const: vfe0_axi
> +      - const: vfe0
> +      - const: vfe0_cphy_rx
> +      - const: vfe0_csid
> +      - const: vfe1_axi
> +      - const: vfe1
> +      - const: vfe1_cphy_rx
> +      - const: vfe1_csid
> +      - const: vfe_lite0
> +      - const: vfe_lite0_cphy_rx
> +      - const: vfe_lite0_csid
> +      - const: vfe_lite1
> +      - const: vfe_lite1_cphy_rx
> +      - const: vfe_lite1_csid
> +      - const: gcc_ahb
> +      - const: gcc_axi_hf
> +      - const: gcc_axi_sf

Drop 'gcc_axi_sf'.

> +
> +  interrupts:
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: vfe0
> +      - const: csid0
> +      - const: vfe1
> +      - const: csid1
> +      - const: vfe_lite0
> +      - const: csid_lite0
> +      - const: vfe_lite1
> +      - const: csid_lite1

Here too.

> +
> +  interconnects:
> +    maxItems: 4
> +
> +  interconnect-names:
> +    items:
> +      - const: cam_ahb
> +      - const: cam_hf_0_mnoc
> +      - const: cam_sf_0_mnoc
> +      - const: cam_hf_1_mnoc

Drop 'cam_' prefix and 'cam_sf_0_mnoc' also.

> +
> +  iommus:
> +    maxItems: 8
> +
> +  power-domains:
> +    items:
> +      - description: IFE0 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE1 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: Titan Top GDSC - Titan ISP Block, Global Distributed Switch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: ife0
> +      - const: ife1
> +      - const: top
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    description:
> +      CSI input ports, one per CSI2 PHY instance.
> +
> +    patternProperties:
> +      "^port@[0-3]$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +
> +        description:
> +          Input port for receiving CSI data from a CSIPHY.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  minimum: 1
> +                  maximum: 4
> +
> +              bus-type:
> +                enum:
> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY

Or C-PHY, right?..

In fact you shall drop bus-type from here, because the link between
CAMSS and PHY's output is not a CSI-2 bus, it makes it inapplicable.

'bus-type' is needed only between CSIPHY and a sensor connected to it.

> +
> +            required:
> +              - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interconnects
> +  - interconnect-names
> +  - interrupts
> +  - interrupt-names
> +  - iommus
> +  - power-domains
> +  - power-domain-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
> +    #include <dt-bindings/clock/qcom,sm8150-camcc.h>
> +    #include <dt-bindings/interconnect/qcom,sm8150.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        isp@acaf000 {
> +            compatible = "qcom,sm8150-camss";
> +
> +            reg = <0 0xacaf000 0 0x4000>,
> +                  <0 0xacb3000 0 0x1000>,
> +                  <0 0xacb6000 0 0x4000>,
> +                  <0 0xacba000 0 0x1000>,
> +                  <0 0xacc4000 0 0x4000>,
> +                  <0 0xacc8000 0 0x1000>,
> +                  <0 0xaccb000 0 0x4000>,
> +                  <0 0xaccf000 0 0x1000>;
> +
> +            reg-names = "vfe0",
> +                        "csid0",
> +                        "vfe1",
> +                        "csid1",
> +                        "vfe_lite0",
> +                        "csid_lite0",
> +                        "vfe_lite1",
> +                        "csid_lite1";
> +
> +            clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +                     <&camcc CAM_CC_CPAS_AHB_CLK>,
> +                     <&camcc CAM_CC_IFE_0_AXI_CLK>,
> +                     <&camcc CAM_CC_IFE_0_CLK>,
> +                     <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
> +                     <&camcc CAM_CC_IFE_0_CSID_CLK>,
> +                     <&camcc CAM_CC_IFE_1_AXI_CLK>,
> +                     <&camcc CAM_CC_IFE_1_CLK>,
> +                     <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
> +                     <&camcc CAM_CC_IFE_1_CSID_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_0_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_1_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>,
> +                     <&gcc GCC_CAMERA_AHB_CLK>,
> +                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
> +                     <&gcc GCC_CAMERA_SF_AXI_CLK>;
> +
> +            clock-names = "camnoc_axi",
> +                          "cpas_ahb",
> +                          "vfe0_axi",
> +                          "vfe0",
> +                          "vfe0_cphy_rx",
> +                          "vfe0_csid",
> +                          "vfe1_axi",
> +                          "vfe1",
> +                          "vfe1_cphy_rx",
> +                          "vfe1_csid",
> +                          "vfe_lite0",
> +                          "vfe_lite0_cphy_rx",
> +                          "vfe_lite0_csid",
> +                          "vfe_lite1",
> +                          "vfe_lite1_cphy_rx",
> +                          "vfe_lite1_csid",
> +                          "gcc_ahb",
> +                          "gcc_axi_hf",
> +                          "gcc_axi_sf";
> +
> +            interrupts = <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>;
> +
> +            interrupt-names = "vfe0",
> +                              "csid0",
> +                              "vfe1",
> +                              "csid1",
> +                              "vfe_lite0",
> +                              "csid_lite0",
> +                              "vfe_lite1",
> +                              "csid_lite1";
> +
> +            power-domains = <&camcc IFE_0_GDSC>,
> +                            <&camcc IFE_1_GDSC>,
> +                            <&camcc TITAN_TOP_GDSC>;
> +
> +            power-domain-names = "ife0",
> +                                 "ife1",
> +                                 "top";
> +
> +            interconnects = <&gem_noc MASTER_AMPSS_M0 0
> +                             &config_noc SLAVE_CAMERA_CFG 0>,
> +                            <&mmss_noc MASTER_CAMNOC_HF0 0
> +                             &mc_virt SLAVE_EBI_CH0 0>,
> +                            <&mmss_noc MASTER_CAMNOC_SF 0
> +                             &mc_virt SLAVE_EBI_CH0 0>,
> +                            <&mmss_noc MASTER_CAMNOC_HF1 0
> +                             &mc_virt SLAVE_EBI_CH0 0>;
> +
> +            interconnect-names = "cam_ahb",
> +                                 "cam_hf_0_mnoc",
> +                                 "cam_sf_0_mnoc",
> +                                 "cam_hf_1_mnoc";
> +
> +            iommus = <&apps_smmu 0x840 0x620>,
> +                     <&apps_smmu 0x860 0x620>,
> +                     <&apps_smmu 0xa40 0x620>,
> +                     <&apps_smmu 0xa60 0x620>,
> +                     <&apps_smmu 0xc40 0x620>,
> +                     <&apps_smmu 0xc60 0x620>,
> +                     <&apps_smmu 0xe40 0x620>,
> +                     <&apps_smmu 0xe60 0x620>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    endpoint {
> +                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
> +                        data-lanes = <1 2 3 4>;
> +                        remote-endpoint = <&csiphy0_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> 

-- 
Best wishes,
Vladimir
