Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185C332EB2
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329010; cv=none; b=HF3QczySDYijtx6ZKdnTCO8Ymf0UgHwu6wD9W/0Jqfac1U9k5LQdORy/YG3SU7KRM0lxlU0ezSb1Rc6pAiG+0VY+XoEbJVJcNacAsNiCw6CVT1UAM2REzbBHkUBnIzcaV8VDzycCDn1F8yhjvytTo1wtWCpqzszmeDzTY85ElNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329010; c=relaxed/simple;
	bh=NCjtlNucLfyp5zlzwXlpdQiVGY+9jr79qHBlVQW93/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6b5ayNhS+bi1ZtotLIDELgA8hnkfv2QUawTVsjpjwjYiLzmJOiGreNoZzIErSd+l9kA7j7iYTN3YcavR9cr5UXMuPQ06S8H+EvSOZj/Oc50Jzp4/0MTMzdHV7UN8EzpcxYaXkHOUuqqqOc/BeOJrMfbH7SVjJHtMGMtdOSt7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgyJuyKy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MbdcrILY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgyJuyKy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MbdcrILY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB4dEh127040
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wga4hiWjY8cKz3LP1L4qE8mRvDcvLKscrPkdZN0JmLI=; b=EgyJuyKy+UlE7kLu
	TcgkWiHq47DyOvjI2TerhEFxSuWeArTwIs3/leFfEvADxMWNKmNT5oQqKq8f9sHt
	8kwUJJmInYuOAuDn2uT2ciQOI/zk97oPDMkYtapVL/tOlZkeRJzNAk385vY+W/Tt
	3uJZM13hpN1ulBcMxO5EE9AAvP9pqHt/OKqnADTE0Vu5flCvkE7qCkc81sCyRzKZ
	2FWRBqmKokFVUL1wQ+9geB2jDqLO/aVOA3Ka+IuWqbFm3mLjx1ChX57f0FqIcXx4
	+24nDsGxMQZZxU1eH99Hb64l3ClxLjYtTG5Q3NIqhxHTBeVUCGqK5udomOpKB/lM
	grh/sw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxuk9e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:50:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-896f5c90f07so42588006d6.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771329007; x=1771933807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wga4hiWjY8cKz3LP1L4qE8mRvDcvLKscrPkdZN0JmLI=;
        b=MbdcrILYi6DqL5tU67ImhHUmdU4ZYzGu2O5ATubPxmz1Nh5tF8OMeoHlU0ljn4f6ew
         rMfmBnsogWeVdxplL9LAWuRvkBaJuMIIOjE4tyRIK0jBOSXc7ycl5cUcs3PJ4QxfqYEB
         2FsycpcebM0SOxqVOGbAVAUtaK6bEWXQhnBVNE76ooVV/PROOwfuqQHEkwBZIQ5Wd1/1
         S9O88P3nt7C3f/ohBjDN035lajLd/mLiUWhKSorTDll/QKcaQu4Y01E+qBs7n0VvN1zb
         2PSwb9bw5PIFGPTOA21ux8uIiHyCSElFk9asIZRSRBIhcFtAiRy9BU98ND2+MYn/pYTm
         J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771329007; x=1771933807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wga4hiWjY8cKz3LP1L4qE8mRvDcvLKscrPkdZN0JmLI=;
        b=WvYQX1XuTZ909xdkn9RNSkXWhMpgZxo/q3/5LjpD3EWxhgkBoT29zOzHNf7K5Gur+a
         aiQZTJzO+P8jFeInwhKNEijN4zHCwy+y9ML3oBZFkZMJbCLqgNb0H3Li1046hpMOp4xM
         ubHUmNbKB759aPT7XNhaAp3ku7KJYv26w+ttMsEXfvAKHZXf4QUipsaIAg9kb1uZiK8R
         xTizGiiFqfJA2enILo1iysAdszyMkkkXTJ0k+G6E4pjV5kcCXm0zos98dDqXDE8x0QTY
         5zTTPU7mqpXD3qwf1TeiHAWU/bSlJ7xzE+iMJ1EWL+nWycba16dbvDzsWMdQ9oaw4w9z
         FoJw==
X-Forwarded-Encrypted: i=1; AJvYcCWpl+bsFkC9iKGAg59pkYtEgt9MH3wbprSdg1HnHLgPVJWvJHh04IpPdyR78hTplLWmRNsmKw88k8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLqcOs+4TGFYpi7SmJ/A+0MQxhRfVo/pgemQEW+8MP3IrUTVN
	IuK0bYwBR0hPlt/nCgo6KF6esAOS64nmU+XaRPAysf/rYHEBXdhpypsrEv+68G1bRNRwE+LJCk6
	UEjb/q3XHBwt/8dKegKIozyQXQPJP/cTfWcYF5/FJa995/G/0w+gM4ud2nuUJHy4=
X-Gm-Gg: AZuq6aJgyzt9NqSscrVq3/DVxK33Tf2expOVOK/OxqXi4mWfk53kGAy2aRy2lGsVtfv
	3B+VaR5+OUe6s8ZbkLFhqxoKOPf0R1DjZ7cgorvUCiDXlmQeq5rbUZUV87J8PwNGHEn9xq4BEN4
	+aEvPENLQyl8Grh4v0M7X5HUIE44faZJP9BFp8j60hwgLSxizdNUoyXl6yDB81QncbcAxfKROD+
	M8IP5eXPLQqAIamWX3q0hW+dT6HF+/ezEnJyVyJnlk7Q3t6csbfuuM1NNHwk2wmM+hTDft18Hg5
	42LKMhYQCfcNCqb7tfJ4Azd59aBbc4uY6O/E3SD2F34XXLWxtQaBn/aYNKQ49qJu7RQiD+uD8TF
	eJqJ+o1+hHoHdc5mH/4i+Gted9tABZLE33yLxUvXudp40hsZzGVew7raHdLsDtnrNH8Fct/p2CY
	Bsz44=
X-Received: by 2002:a05:6214:8008:b0:894:de0a:4cf1 with SMTP id 6a1803df08f44-89734819033mr138987156d6.8.1771329007417;
        Tue, 17 Feb 2026 03:50:07 -0800 (PST)
X-Received: by 2002:a05:6214:8008:b0:894:de0a:4cf1 with SMTP id 6a1803df08f44-89734819033mr138986866d6.8.1771329007004;
        Tue, 17 Feb 2026 03:50:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc76655absm333837566b.51.2026.02.17.03.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:50:06 -0800 (PST)
Message-ID: <389dc762-bd20-44e5-a3fc-256b42f3c82a@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:50:03 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-14-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-14-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _FthLZVvKqcx-5NjFJa06NJwTHzndGf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5OCBTYWx0ZWRfX1s2hlqZ9YThF
 uGVzZ3c5PW3+nA5qW0gLGfuIoZGN4dicMCxow2fFnQmzcVo92eudtX1t5E68PNPIBVxoiLWTZOu
 2F0HtvQZkw8mDeEofXTgIRXLRPXt+VOImN5/Lvv0+VmiBEfKV23YLGkG+xtLpP45Qrqyxo1V8UD
 2xd1S7ujQkjEMrGcMqs0UYJ0SmpmcVs4ka74UglcuURxfwu3lmJeJPcYRh8yYNyB5ktgLHttsu2
 TrA2tEfEa0KM7Za/VTeDS98H015vgGoGsugfB4V9lsiNsD4TxFrzTwyp9kizs4RZnDfZCvzMVOB
 h2cSHhgQaVNiGhOJKVfQPdghUzqWzSHnx4Qz4S7u76rAb+IjY/gbXJxCFQZEKj1kmBoFGOlqa2c
 Cgt3RfNe8sFFr//4KH1SZqUSA4wtT2wD+iUxCXBBMnlcEGDcdrcMCtpGDJ0XDp6sGRz3w3e2Tj7
 eetOCe98tQTKorxt6fQ==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=699455ef cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uvtuXJDLjHB1kenEHasA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _FthLZVvKqcx-5NjFJa06NJwTHzndGf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170098

On 2/6/26 6:41 PM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power on/off.
> 
> The SCMI performance protocol manages I2C frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate..
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> @@ -215,6 +220,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>  	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>  	val |= itr->t_cycle_cnt;
>  	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
> +	return 0;

ultra nit: a \n before return statements is preferred

[...]

>  static const struct geni_i2c_desc i2c_master_hub = {
>  	.no_dma_support = true,
>  	.tx_fifo_depth = 16,
> +	.resources_init = geni_i2c_resources_init,
> +	.set_rate = qcom_geni_i2c_conf,
> +	.power_on = geni_se_resources_activate,
> +	.power_off = geni_se_resources_deactivate,
> +};
> +
> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
> +	.resources_init = geni_se_domain_attach,
> +	.set_rate = geni_se_set_perf_opp,

I noticed that because this lacks .power_on/off, the
pinctrl_pm_select_xxx_state() functions are never called. Are the GPIOs
managed through the power/perf domains of the QUP devices too? (I would
assume not since there's a TLMM node in [0])

Konrad

[0] https://lore.kernel.org/linux-arm-msm/20250422231249.871995-1-quic_djaggi@quicinc.com/
