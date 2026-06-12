Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED435CBD7
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251016; cv=none; b=teWljPc7c4e1za+L2nN7H4CARlTh5kVLAmnlJehfys51AcDetP0VMYzZwDdY2F8pBxrYUL2Hvhl8rUrdlw5uZBhghNZJsQHXsGZfS2Tu40AwHo1E60m13fEpgNvJldf/+JwTgZS74Tn63xmosmSiMO5k2tlkpVp0+EjyuuKt7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251016; c=relaxed/simple;
	bh=ojfQXHezIap4Q2ED7Rej+tWoCJU08h2r1pKMtJQAkTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYXjDz7BKTx2UTG3Zmhv7Eu5PgRz8wpM5rTByM6UBX2CB2HJrRwduAGg5safc8+pAtuzwDerL5/KQc+HvZLObyUcFz60f3lk6JNW+rdf/WDn/Eh+ueSBJYyDUgkhmWp8AGaS7wVcBYTr1UFet/BC0Wtim8FXlSlwBP1E0Zd+RD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eXj0Iio0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXj0Iio0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa61284d58so81362e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781251013; x=1781855813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLIFEbFe2aJSbSCxVWR8no0e1CK686vhmp4FsclPvxE=;
        b=eXj0Iio0nvlu+zovIFgC5OZThnAhlulptkf5XjgCkyJPAwHP/kNb5sWzRx082/QEl4
         8tII9mTyHDCfc+DuuzE9L+NfNzfp+BXdSABU7/ISMJixWlPV+iU+IpqUW5664UU5Gp4y
         L4neP8x95QfFhMGDVoIMw54B6f/B/HXGUuoJ7WGSkXVp3Mfhba9AZ52lN5uRvkwsjKgq
         eTa6YJff8ef6Nt1qn0tClgWKrzAstw0xxlF8SoxBULlgCWwnMh32RCg6cddLYY0hq9zF
         lY1LCMg43jGRDFMZ3xzsqfSd0655EHjz9NHAheg6f9d/mUfEYZObvimR6OKRfTHiPI4H
         eYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251013; x=1781855813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLIFEbFe2aJSbSCxVWR8no0e1CK686vhmp4FsclPvxE=;
        b=RhsNqjUVLz++4CLctiHJIfgu7yPcP8gv+Jh2HN0iC+5V+06m/yv786D82MckBGWMUJ
         ZDyMtrRPy1FxT7lsKnan/OLNv29o79K9ou6ygPrDpUJ6pF2dDFojg0s16nA80FfHpsW8
         d/4Hfr37PHx3OSBw2pRkUNGsuw32MmeFp7bbxthCX3hzdhg3xH+XUQ8L4043CZIyKdXy
         Lng4jKIfDWqJ4HOfNnbXzkl8p9pfrLB2ccw+z/WnB4eRqjF2EQ9NLkG3Yx49pBQGvnCS
         1RjhDjL2h4NRrVCByqp57mPpOUJTK9WCCmUfJprF8kDetnv0vlvHaNyRZlhW2DK97WJD
         vlbA==
X-Forwarded-Encrypted: i=1; AFNElJ/hEobEsmZUEXc981AnH3a6KH2gKKtrDcUOzp9M6fP/a2/C0k5KnO3CUtpXiKHbwHK9S/G/WAJLXoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQW/4Dwqp9FVsClsRUT1VIR1HTeQdqsyBS2Ofxm0Bl0YFfGmUf
	n08A82YPvOWDBIAEDct1cCoaJnEEGnEzigxhNJ8Et2e1W+Nx/H8NDbKJeaYF+jbPkoc=
X-Gm-Gg: Acq92OHxlqdQVqcDQoHJ8q2Zzyt1cSACiJRzKGsE8vWnFHysgAKVZXhV7UtfseaotJ8
	d/vdeoP8w13QCocteTMQ2aKw7p+thqybQHhEMUwKlHlzRQEHQa+A9Yy26hNeqeQUxuFuQWBqeb/
	Z1jYvIDNlLX9jdAdZ/oLepGkMwv5XkjkCdo9AJbQUdJUy5oAKT/VuZY0O/yWR9vlDxH7DmLQ9lQ
	ZMadmEZRgjEHxVCEqGf/vJR8AjS9NQeRJnW+K3vH+Q1Cc8use1Qwo503NWZpk7CiZ+qPs40mTmm
	RGjd421iY3mqr5gSOiT0+WAPDbXuSQx1xUGZ3FulyBa8DTePxujJZd1+3ztgMlSeZ2NynAXQQ+f
	doIDLlA0W380t3gB9IefesZnWKLHhNdUHiZCoQ3TRmdbitJdNEyg7oNdxgXQDYn0kxPvOz3w7td
	WY75F8nFzeBqjS51HxCIZM0HdUfujUru6/De4b2jiAT1yMD7mGAQhpyZq4n96/3mVh7sRgJPkn/
	bUxPw==
X-Received: by 2002:ac2:414c:0:b0:5aa:635f:7c08 with SMTP id 2adb3069b0e04-5ad2db710dcmr172654e87.7.1781251013504;
        Fri, 12 Jun 2026 00:56:53 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f69sm329636e87.4.2026.06.12.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:56:53 -0700 (PDT)
Message-ID: <3ec2bd75-4d88-492e-a8c2-b21000ef2afc@linaro.org>
Date: Fri, 12 Jun 2026 10:56:52 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: shikra: Add CAMSS node
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-3-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-3-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Add the Camera Subsystem node. Shikra shares the same IP as QCM2290
> with two CSIPHYs, two CSIDs and two VFEs, but does not include CDM
> and OPE blocks, so only a single IOMMU context bank is needed.
> 
> Co-developed-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/shikra.dtsi | 99 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index a4334d99c1f35ee851ca8266ec37d4a200a07ee5..b93ce4a92a998ea5d9d4268d2fd46030fafc4084 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -604,6 +604,105 @@ opp-384000000 {
>   			};
>   		};
>   
> +		camss: camss@5c11000 {
> +			compatible = "qcom,shikra-camss", "qcom,qcm2290-camss";
> +
> +			reg = <0x0 0x05c11000 0x0 0x1000>,
> +			      <0x0 0x05c6e000 0x0 0x1000>,
> +			      <0x0 0x05c75000 0x0 0x1000>,
> +			      <0x0 0x05c52000 0x0 0x1000>,
> +			      <0x0 0x05c53000 0x0 0x1000>,
> +			      <0x0 0x05c66000 0x0 0x400>,
> +			      <0x0 0x05c68000 0x0 0x400>,
> +			      <0x0 0x05c6f000 0x0 0x4000>,
> +			      <0x0 0x05c76000 0x0 0x4000>;
> +			reg-names = "top",
> +				    "csid0",
> +				    "csid1",
> +				    "csiphy0",
> +				    "csiphy1",
> +				    "csitpg0",
> +				    "csitpg1",
> +				    "vfe0",
> +				    "vfe1";
> +
> +			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
> +				 <&gcc GCC_CAMSS_AXI_CLK>,
> +				 <&gcc GCC_CAMSS_NRT_AXI_CLK>,
> +				 <&gcc GCC_CAMSS_RT_AXI_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_0_CSID_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_1_CSID_CLK>,
> +				 <&gcc GCC_CAMSS_CPHY_0_CLK>,
> +				 <&gcc GCC_CAMSS_CSI0PHYTIMER_CLK>,
> +				 <&gcc GCC_CAMSS_CPHY_1_CLK>,
> +				 <&gcc GCC_CAMSS_CSI1PHYTIMER_CLK>,
> +				 <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_0_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_0_CPHY_RX_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_1_CLK>,
> +				 <&gcc GCC_CAMSS_TFE_1_CPHY_RX_CLK>;
> +			clock-names = "ahb",
> +				      "axi",
> +				      "camnoc_nrt_axi",
> +				      "camnoc_rt_axi",
> +				      "csi0",
> +				      "csi1",
> +				      "csiphy0",
> +				      "csiphy0_timer",
> +				      "csiphy1",
> +				      "csiphy1_timer",
> +				      "top_ahb",
> +				      "vfe0",
> +				      "vfe0_cphy_rx",
> +				      "vfe1",
> +				      "vfe1_cphy_rx";
> +
> +			interrupts = <GIC_SPI 210 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 72 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 73 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 310 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 211 IRQ_TYPE_EDGE_RISING 0>,
> +				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING 0>;
> +			interrupt-names = "csid0",
> +					  "csid1",
> +					  "csiphy0",
> +					  "csiphy1",
> +					  "csitpg0",
> +					  "csitpg1",
> +					  "vfe0",
> +					  "vfe1";
> +
> +			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
> +					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
> +					<&mmrt_virt MASTER_CAMNOC_HF RPM_ALWAYS_TAG
> +					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
> +					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
> +					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
> +			interconnect-names = "ahb",
> +					     "hf_mnoc",
> +					     "sf_mnoc";
> +
> +			iommus = <&apps_smmu 0x400 0x0>;
> +			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;

Please add an empty line between the properties above.

> +
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
>   		qupv3_0: geniqup@4ac0000 {
>   			compatible = "qcom,geni-se-qup";
>   			reg = <0x0 0x04ac0000 0x0 0x2000>;
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
