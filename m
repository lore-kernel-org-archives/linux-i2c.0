Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001863;
	b=FAhP7EMN3KmMPNro92BPG2g4lO/K6hPBTLqBpnoiSLtBlFikSZqNixhpug7WftX/IldW
	 KFWr4b/k6tTOEcEJ149mps9vHiOwhbwVwZfnimqHoDLgIa2TGgsvb1yQzoRfwrSeLUgar
	 S8KpJqMbHIPVhFx63NqW6cgJ+YvZ1fd641pRQAnYWfpc7Osm+X0wKwPvMBxUfm1fKO5Xa
	 pzLulB+febEiiRbGF4A1eJAehwE0ukyV1r5RwHgDaSHl//PeDUVb/WexSkQAGHnFs1Z1h
	 2Kx3iOr0Wm7cZtVREUITjcvecfzgLKcQ6JqVvCf/dFTVJuMgTfOCX07A0tSthWMiaWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iNCYwBZdgrtZcJalM2BjSEQM3MkkZ/FKImLgDlnfdqM=;
	b=LZ90Q2GvlyFpivttMInkM9FvXCYuILYlAKlRewxI0AbAdMdZ79erfHLQbjDM2gWmTJpP
	 QAI3iZMkb7HuQ9QFEvwJ92bP0yABSl10IWBxuxreDaEudlhlBgH56wLeHzqs6gcGBNYuu
	 VVTIMn6vpxuPzlPjZVOL/n0os5AsfoCKIz5JRddAVhMWHwkgC3ZjdTLSd8Y6iEnRFSLex
	 0WKJRheUPrfeC8RVvMjs9m5bIkXAbPTBAfyvibAteaM4LTYyYsJWjskHPKH6E/TJcuyqP
	 ZDxL9l+9hasowtdJ0PFeKwgrgHDnFn3as/ke8wAzkRKcceMD8UuKFhT9gSohxnxjmmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BoE7FxnN;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F57606A32D
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 21:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F57606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BoE7FxnN
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab35a9d9ceso1347641fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 13:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794001861; x=1794606661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iNCYwBZdgrtZcJalM2BjSEQM3MkkZ/FKImLgDlnfdqM=;
        b=BoE7FxnN1K7l0CXFd8Wa+mszolll2w+Qb8d2wQ7vt9jO2Fn4RHZ/xQc1oBsHVglLV5
         o6jjm6WwoQ1UBDaNLKdA8Q19nho69QU8AFlZwkuXifxCXL2YAJPGEbeOLwkmjvpSvFKq
         7sSUBj7KQYnxaq/NxX6FcK1AeWZ85vXDqO4zvfEtZ4hKX8H0mBRQzKC7DjOwzQ51KroW
         zxaHIqUNH5qtlgv3W1wpfwp1WWBMW2q782ep8RO43KZ/wVM4AAAoFvvLOAGp4ZXMiLJq
         vh+aso0BhuX4BvehXxVLDn6ZbeiYN7zY+dBpDsCsOl2pJSMFxwd0bEzdOWd+kTnQbqTq
         oAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794001861; x=1794606661;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNCYwBZdgrtZcJalM2BjSEQM3MkkZ/FKImLgDlnfdqM=;
        b=yCHRtTvMPVZc3+XsmRORmdVtG4dcrygcR1PoemTZ1hD8h4KKkMmBRvIDBb023NjZHt
         VYa01itZ9m9jZQKvBI5GG/ZiuNioEyhl5KkdAMjVr+VOcEXwMg5vJF4qjvqaL8HyHBgv
         2m2VOoGLV1YNoCtmO7z1Uen4I+2m6oK7hYRR/5BNX2PdsbV2FgUqkMiWUKkIKtKk72Dn
         9xtMm7M30bKUEqWqOAqmlWK1DdgB40Yd8se1vOm4x1rPMRHSC9B3Lk/waW/Wo5EbUfSf
         zaufZRI5/nyBgIK3PSm4I46roaCt2Mm0Ja+P/MwYZT9vL9ERHP/eXrtCRNtl40cF0zmg
         t5Aw==
X-Forwarded-Encrypted: i=1; AL+hErHl5xHRVL4WJKlmu5e+RgDM0XaA7/TRiXfpRJN0A49KBdev46J86J1KVchPcxmJmK3gLJaSOIolysY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dlhA9kv1ept19h9VwyyKllpUZxfXU3Efg2hAFs9lU5Y04AVq3
	RPmts3IJxO+L7yp/tg4I5QXgqWJQUqdqDv3NsbL65ZYZiNcoEnmwAsN5498XSXJFdPE=
X-Gm-Gg: AYBFou05S0HEOSSLkJIqtbmqRKIBrshxaCEU5E9xNOm7EprIXd9alLqkkONjSiwKM9f
	y0lOHnbYb41i64rLCJCf2B22eZ4iL9DAaw/dRr2K/wtaxcRb1TsZh95Xb9I5tIXo89vznpYBDzv
	zRdff3wds6XHBQwjtirbAmN1nCZ5kWVHUgRpXMg25DPYCFhITi1C6rmj2kaA864M5F9w/RNlH8s
	Z2gAQvLhWoB1Rg4Q98DULwrG3wvqPRFchtlB3XlNPh+/dQQqD5yOE9N3dgJNW5yzHxBxxXCnuj0
	e1agXz1ZQWYi/95xhzYN/llAUSPnkRP4Je9vGeqwAYmR5dcNSL9fPrGdnoxyHCFkqCwDrvIiAmf
	aC/tzfaP86Rgd94NHsfyMmWRHECKpawd23l96XqwRxjsH0pCF75g1gP58/BB7ssA5QOZ2gi9y+i
	ZVVAqh2sG9tV/3RMAIHfm3LJoGA9Wnd2on4CUeGJX0FRBGh+J6W4VKBoVkOHw+am7u9iQtI40qC
	phFxcIYM1vIPcXAMOhXmT90ZTemSGyNoo8dBejKG8NlD8afR/dTKX969/pH0CKuD5ENtPcz8v9q
	rbRbrzAYBgL00YcbDuR8DNRurdMwuWED/uZxR+0z/G1I78CpMOI1idVba7wrIiNl4h7xB0tc1e8
	FumAZnA==
X-Received: by 2002:ac2:5690:0:b0:5bf:ff57:b346 with SMTP id 2adb3069b0e04-5c003c44406mr1310242e87.5.1794001860247;
        Fri, 06 Nov 2026 13:51:00 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c002ed5629sm551625e87.12.2026.11.06.13.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 13:50:59 -0800 (PST)
Message-ID: <160aa94c-c726-4cfe-b8cc-b1f974b32f13@linaro.org>
Date: Fri, 6 Nov 2026 23:50:58 +0200
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
Subject: Re: [PATCH v3 5/7] media: qcom: camss: Add support for SM8150
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
 <20261106-sm8150-v7.4-rc1-camss-v3-5-0103e8a0bbcd@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-5-0103e8a0bbcd@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 20:35, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Add CAMSS platform data for the Qualcomm SM8150 SoC. The camera
> subsystem contains four CSIPHY, four CSID (two full and two lite), two
> VFE and two VFE-Lite instances.
> 
> The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> layout. Add CAMSS_8150 to the version enum and to the shared code
> paths, then add the per-block clock, regulator, power domain,
> interrupt and interconnect resources.
> 
> The CSIPHY resources are reduced to id/hw_ops/formats only; clocks,
> regulators, registers and interrupts are owned by the dedicated CSI2
> PHY driver.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
>   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
>   drivers/media/platform/qcom/camss/camss.c          | 231 +++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h          |   1 +
>   3 files changed, 234 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index dac8d2ecf799..5e7c2e67ae88 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1133,6 +1133,7 @@ static bool csiphy_is_gen2(u32 version)
>   	case CAMSS_6150:
>   	case CAMSS_6350:
>   	case CAMSS_7280:
> +	case CAMSS_8150:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
>   	case CAMSS_8300:
> @@ -1235,6 +1236,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
>   		regs->lane_regs = &lane_regs_sm8250[0];
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8250);
>   		break;
> +	case CAMSS_8150:
>   	case CAMSS_8280XP:
>   		regs->lane_regs = &lane_regs_sc8280xp[0];
>   		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index c54185c93a8a..da4d2213fd3d 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1940,6 +1940,223 @@ static const struct resources_icc icc_res_sm6350[] = {
>   	},
>   };
>   
> +static const struct camss_subdev_resources csiphy_res_sm8150[] = {

Drop csiphy_res_sm8150[], and pull this:

* https://lore.kernel.org/all/20261026224957.1115370-4-vz@kernel.org/

> +	/* CSIPHY0 - clocks/regs/supplies owned by PHY driver */
> +	{
> +		.csiphy = {
> +			.id = 0,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845
> +		}
> +	},
> +	/* CSIPHY1 - clocks/regs/supplies owned by PHY driver */
> +	{
> +		.csiphy = {
> +			.id = 1,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845
> +		}
> +	},
> +	/* CSIPHY2 - clocks/regs/supplies owned by PHY driver */
> +	{
> +		.csiphy = {
> +			.id = 2,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845
> +		}
> +	},
> +	/* CSIPHY3 - clocks/regs/supplies owned by PHY driver */
> +	{
> +		.csiphy = {
> +			.id = 3,
> +			.hw_ops = &csiphy_ops_3ph_1_0,
> +			.formats = &csiphy_formats_sdm845
> +		}
> +	},
> +};
> +
> +static const struct camss_subdev_resources csid_res_sm8150[] = {
> +	/* CSID0 */
> +	{
> +		.regulators = {},
> +		.clock = { "vfe0_csid", "vfe0_cphy_rx", "vfe0", "vfe0_axi" },
> +		.clock_rate = { { 400000000, 480000000, 600000000 },
> +				{ 0 },
> +				{ 0 },
> +				{ 0 } },
> +		.reg = { "csid0" },
> +		.interrupt = { "csid0" },
> +		.csid = {
> +			.hw_ops = &csid_ops_gen2,
> +			.parent_dev_ops = &vfe_parent_dev_ops,
> +			.formats = &csid_formats_gen2
> +		}
> +	},
> +	/* CSID1 */
> +	{
> +		.regulators = {},
> +		.clock = { "vfe1_csid", "vfe1_cphy_rx", "vfe1", "vfe1_axi" },
> +		.clock_rate = { { 400000000, 480000000, 600000000 },
> +				{ 0 },
> +				{ 0 },
> +				{ 0 } },
> +		.reg = { "csid1" },
> +		.interrupt = { "csid1" },
> +		.csid = {
> +			.hw_ops = &csid_ops_gen2,
> +			.parent_dev_ops = &vfe_parent_dev_ops,
> +			.formats = &csid_formats_gen2
> +		}
> +	},
> +	/* CSID_LITE0 */
> +	{
> +		.regulators = {},
> +		.clock = { "vfe_lite0_csid", "vfe_lite0_cphy_rx", "vfe_lite0" },
> +		.clock_rate = { { 400000000, 480000000, 600000000 },
> +				{ 0 },
> +				{ 0 }, },
> +		.reg = { "csid_lite0" },
> +		.interrupt = { "csid_lite0" },
> +		.csid = {
> +			.is_lite = true,
> +			.hw_ops = &csid_ops_gen2,
> +			.parent_dev_ops = &vfe_parent_dev_ops,
> +			.formats = &csid_formats_gen2
> +		}
> +	},
> +	/* CSID_LITE1 */
> +	{
> +		.regulators = {},
> +		.clock = { "vfe_lite1_csid", "vfe_lite1_cphy_rx", "vfe_lite1" },
> +		.clock_rate = { { 400000000, 480000000, 600000000 },
> +				{ 0 },
> +				{ 0 }, },
> +		.reg = { "csid_lite1" },
> +		.interrupt = { "csid_lite1" },
> +		.csid = {
> +			.is_lite = true,
> +			.hw_ops = &csid_ops_gen2,
> +			.parent_dev_ops = &vfe_parent_dev_ops,
> +			.formats = &csid_formats_gen2
> +		}
> +	}
> +};
> +
> +/*
> + * cpas_ahb is left at the CAMCC default 80 MHz; it is not matched by
> + * vfe_match_clock_names(). The VFE/VFE-Lite rates are set from the
> + * remaining clock-rate tables.
> + */
> +static const struct camss_subdev_resources vfe_res_sm8150[] = {
> +	/* VFE0 */
> +	{
> +		.regulators = {},
> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi",
> +			   "vfe0", "vfe0_axi" },
> +		.clock_rate = { { 0 },
> +				{ 0 },
> +				{ 0 },
> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
> +				{ 400000000, 558000000, 637000000, 847000000, 950000000 },
> +				{ 0 }, },
> +		.reg = { "vfe0" },
> +		.interrupt = { "vfe0" },
> +		.vfe = {
> +			.line_num = 4,
> +			.is_lite = false,
> +			.has_pd = true,
> +			.pd_name = "ife0",
> +			.hw_ops = &vfe_ops_170,
> +			.formats_rdi = &vfe_formats_rdi_845,
> +			.formats_pix = &vfe_formats_pix_845
> +		}
> +	},
> +	/* VFE1 */
> +	{
> +		.regulators = {},
> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi",
> +			   "vfe1", "vfe1_axi" },
> +		.clock_rate = { { 0 },
> +				{ 0 },
> +				{ 0 },
> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
> +				{ 400000000, 558000000, 637000000, 847000000, 950000000 },
> +				{ 0 }, },
> +		.reg = { "vfe1" },
> +		.interrupt = { "vfe1" },
> +		.vfe = {
> +			.line_num = 4,
> +			.is_lite = false,
> +			.has_pd = true,
> +			.pd_name = "ife1",
> +			.hw_ops = &vfe_ops_170,
> +			.formats_rdi = &vfe_formats_rdi_845,
> +			.formats_pix = &vfe_formats_pix_845
> +		}
> +	},
> +	/* VFE_LITE_0 */
> +	{
> +		.regulators = {},
> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite0" },
> +		.clock_rate = { { 0 },
> +				{ 0 },
> +				{ 0 },
> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
> +				{ 320000000, 400000000, 480000000, 600000000 }, },
> +		.reg = { "vfe_lite0" },
> +		.interrupt = { "vfe_lite0" },
> +		.vfe = {
> +			.is_lite = true,
> +			.line_num = 4,
> +			.hw_ops = &vfe_ops_170,
> +			.formats_rdi = &vfe_formats_rdi_845,
> +			.formats_pix = &vfe_formats_pix_845
> +		}
> +	},
> +	/* VFE_LITE_1 */
> +	{
> +		.regulators = {},
> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite1" },
> +		.clock_rate = { { 0 },
> +				{ 0 },
> +				{ 0 },
> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
> +				{ 320000000, 400000000, 480000000, 600000000 }, },
> +		.reg = { "vfe_lite1" },
> +		.interrupt = { "vfe_lite1" },
> +		.vfe = {
> +			.is_lite = true,
> +			.line_num = 4,
> +			.hw_ops = &vfe_ops_170,
> +			.formats_rdi = &vfe_formats_rdi_845,
> +			.formats_pix = &vfe_formats_pix_845
> +		}
> +	}
> +};
> +
> +static const struct resources_icc icc_res_sm8150[] = {
> +	{
> +		.name = "cam_ahb",
> +		.icc_bw_tbl.avg = 38400,
> +		.icc_bw_tbl.peak = 76800,
> +	},
> +	{
> +		.name = "cam_hf_0_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "cam_hf_1_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "cam_sf_0_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +};
> +
>   static const struct camss_subdev_resources csiphy_res_8250[] = {
>   	/* CSIPHY0 */
>   	{
> @@ -5725,6 +5942,19 @@ static const struct camss_resources sm6350_resources = {
>   	.vfe_num = ARRAY_SIZE(vfe_res_sm6350),
>   };
>   
> +static const struct camss_resources sm8150_resources = {
> +	.version = CAMSS_8150,
> +	.pd_name = "top",
> +	.csiphy_res = csiphy_res_sm8150,
> +	.csid_res = csid_res_sm8150,
> +	.vfe_res = vfe_res_sm8150,
> +	.icc_res = icc_res_sm8150,
> +	.icc_path_num = ARRAY_SIZE(icc_res_sm8150),
> +	.csiphy_num = ARRAY_SIZE(csiphy_res_sm8150),
> +	.csid_num = ARRAY_SIZE(csid_res_sm8150),
> +	.vfe_num = ARRAY_SIZE(vfe_res_sm8150),
> +};
> +
>   static const struct camss_resources sm8250_resources = {
>   	.version = CAMSS_8250,
>   	.pd_name = "top",
> @@ -5824,6 +6054,7 @@ static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
>   	{ .compatible = "qcom,sm6150-camss", .data = &sm6150_resources },
>   	{ .compatible = "qcom,sm6350-camss", .data = &sm6350_resources },
> +	{ .compatible = "qcom,sm8150-camss", .data = &sm8150_resources },
>   	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
>   	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
>   	{ .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 7dc2fd9f03e0..74d8cc2921be 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -89,6 +89,7 @@ enum camss_version {
>   	CAMSS_8x39,
>   	CAMSS_8x53,
>   	CAMSS_8x96,
> +	CAMSS_8150,
>   	CAMSS_8250,
>   	CAMSS_8280XP,
>   	CAMSS_8300,
> 

-- 
Best wishes,
Vladimir
