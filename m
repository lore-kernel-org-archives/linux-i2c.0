Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C905616C9
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092431; cv=none; b=ZQxsJo5RbDSht7/SR/lmOZ9zm1r7Xpt5N5zxxH8cU4SrTjkWECYx2oq/vwes/ie5A0lGo0R5Agdvy/Dewh8VkapXN1sI3YTa5CiNjpdHU2WN7hiebrSIYPtQZ+FeWyxAJ/HUZ9iTXoHFXVV9r/6zBskOwt0ZsZCa+tDdIpMvkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092431; c=relaxed/simple;
	bh=x2Afa3TS2BODsNDUCq1vjP7z73/Tlk0WEhCAaO8UvBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNEQwsdbZXEGsv5vb+rgVjxJrMefJJn2r7wsf/noG+bGKarSqBYqLbM83eiB9X1O4DrxarfxQ7wtCwa22OK+1UE0GOUIDrJbSetq9zeM3PrzTSqLlTGESBIssJieqZsVAc2/PCQL7Fwb1+H6ICx2kg0Hsxs/dK3yTXxcHKgGbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NuMeLAuR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPbDacHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NuMeLAuR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPbDacHO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjOoN318316
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c+J89754OJs4CwOKUDXJfrEClFP9Q3mGTwu9yywPVJA=; b=NuMeLAuRxk12TzIe
	2IIKpHxD60B9aAf3ow+MH682YLp0nF6MS2HFAXX94vXONizlwGdqGAAN8sPJWzRg
	Gq9U9BEcMqtYxGyeZcoJHRdXXPjfWEKYhfaW82mTj7tzVT3UJGpzXdnzX5Az7ynb
	LUwkFaaqqddedNOJCQ6c+4ubxNthQFBXxxquvTjrvVD5uIQzbIwt62deMogHfY8C
	khe+yMHcpSwhrgpX8EZpa2sgiN5eKaNVnSncvYPVQpJmTS5cG1Si5f8ADGD3bwBX
	Z5QlZFbkrJKiizsw8ODUnvVcpZDrcDW3vrswzq0u/yc40XqZGiBcUblpn/jX5HwO
	FBIZtQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqhxvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:53:46 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c97957d83bso238e0c.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790092426; x=1790697226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+J89754OJs4CwOKUDXJfrEClFP9Q3mGTwu9yywPVJA=;
        b=RPbDacHOCxGzYv2JRPFvwEIMRF2F+24ayYtBgrBWOc7Bjjb8zUYGIfkXsvCg1OACsg
         akGd1+GqXDxH/mwacI8cmPg1JIWhVnOVtsxLt7D9OpQCO4SXkESeoqEwFfKtBjUy0v+a
         68hd1G61G/QEMtUJVS6L1sYMFEwNtGniwUAPLvdZMmWj1Td/Tdf48GEiTD07ElHdM+dW
         XYcYtonhP2dJ08K0LrM0n0MDVaZ7RXbA/O/H3h6+y/JuNx+fXIG44M134suqXwLwJ7lu
         5K1Zv7PrsBB24FB1L1splC+DQiKNK8a+5MW/xQsA24vvjIJC4BukWBNt+vxMiWlb+XQ3
         g3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092426; x=1790697226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+J89754OJs4CwOKUDXJfrEClFP9Q3mGTwu9yywPVJA=;
        b=JAlcuk5JycVHSKTl8vyeKABfBbh1qM1F9/zAbxn904D6fWefLNHy/e3ESL3lAFn4RM
         qhTJwLgeyYI+OGG6uobv72GXaqx+XDoFiWrFJ6g7l5rILn6LRdW7lNObcnaWjCL6WP8V
         DEKkeKL7bCG63e8xlTtGVeQLYEnwNllIvqxyREdahU14rytlKJUdRvbvkyU7L5X4RObb
         4zMI063Dw7xxiE6gtlNPZINg1+CMP01DGkn/4naVUvX2f3lwwsXSRob5dc0SaBmmGSJE
         /fO4WRHYHBJbVwny5Fe+ch7KS14f8TDuEJVbSEUf/sy0FWsZsRNanA7MsJ42zjpi4WbP
         Qavw==
X-Forwarded-Encrypted: i=1; AKwUvBzw/EiKxn+L14U3IoIXVs0CLw/TdbBKzKwFix1UlrvFlVnZ/JKCGGpfcsaObamPisEwgUaUrA8+FNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nsrb/uP/UzYJ0of+xwPtNzpFp4zuVTjpn+2Oob52FF+sYFaTeV
	T6upVgLhwnjvimtonMG8x3wZJrIKNGRjdXgcF+N+VRDnb7LJZUagukikzPSyuaPYYjIcMFfU1zX
	ms4j/a6KTLxoiaoWmYjvSeir1iJicBGg1sfjiGMJSexQje1WivY+nwhejYcor0LQ=
X-Gm-Gg: AYBFou1z28o5EbqpL74EDHffNvpbafsQAaY4NUQDiEHocC1ZpxydElPsNJr1YUgPUlu
	lTwg9ukjOeP+EqX0IGrUOsdQ9ZhBR/yQmn25IQqorB946H4sHxZY5damY/yvZyvqCLJLYKS92Vm
	T3OfG/EFfIvpmMr3hKf3kx1uwELrY9STzr5bd2D8GWOziTRKPL98YTTL1+u1ct+W34GxpzY0c74
	K1EiQJ9NJT0Dw2mKdA9O0hAQvLUiflp+qwEz2t2e7MLaf2SmBmFDK/JHcpJi3uuiL2oibMTQCL1
	vEu1D2DHUOPuQQQODz6gnU52quUf5yVOFEAOLGewrB/WOE6wcn5xTznLGbj35+BocZmy3rC3tZV
	wcBB2FgzHRIpgyPsEqc7hlw==
X-Received: by 2002:a05:6102:3710:b0:7a7:326b:688d with SMTP id ada2fe7eead31-7a7326b6d93mr6495464137.2.1790092426344;
        Tue, 22 Sep 2026 08:53:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3710:b0:7a7:326b:688d with SMTP id ada2fe7eead31-7a7326b6d93mr6495425137.2.1790092425877;
        Tue, 22 Sep 2026 08:53:45 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5808dasm107428966b.23.2026.09.22.08.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:53:44 -0700 (PDT)
Message-ID: <578c26c4-a340-4158-aea8-40944a1067c2@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 17:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: shikra-iqs-evk-imx577-camera:
 Add DT overlay for Shikra
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-5-9b9596221cfa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917-shikra-camss-review-v8-5-9b9596221cfa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX/8qeCXdlvKHw
 r9rtK7FWHgpFZOSo7qzpWoOCt0bEzaGIMfHwLDaTGK8TYlakLIj73rkQseRgYZcLnp9zvpcV2sp
 vmCC589C48MkH+W69Lggvwp5dO61tSrJ7UCQpHP7QrVYMUsOlW7hhJhNHcrOKM6EuNAk6IFmosQ
 E82PZ/II2cYQpD5SqiWgocsnDAt0CMZidl16pae6Tx96ps5FXpax29Yu9T0Bsc5a8aenJIxveNV
 fRf1l9lmylNG5SiAvyabXPKnkVm6alezbcgy/1oLegkG6YR2wBgpX3jCoG8HXdqG9saiHG0yHIX
 xqvGb48/XBW4FiczBNxxyo1KlDF8Si79YMc2uK4CSn958cI6rVn8IlwswxWHtUY8r3JWYxCC8PC
 IpFf90GxaIvlTsMpJI1l4Eo8UM5jEHIjEQPUhQ0ij/kG/QdJ9xLnm8Rj4+Nd+a96W3fso+ffNyE
 j0Emwuw3v2y3uXsQAWw==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2a48b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XE-wypd_VeY0GsksmEIA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uz2E7dh11X3tuCwigfCMn_yNVbAl3GoI
X-Proofpoint-GUID: uz2E7dh11X3tuCwigfCMn_yNVbAl3GoI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfXxId+MTL40xUO
 9oJBmn8hmmfrBw1QNCB0kvHX39E5E9KRHVCXwM0jThTeTQ7nPA12spyLevi0KuqL7Fmee4X1baE
 6WngSItshNgepY1k1Ni15jqjCo7XeSw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220231

On 9/17/26 1:41 PM, Nihal Kumar Gupta wrote:
> Shikra IQS is an industrial-grade variant using PM8150 PMIC, requiring
> different CSIPHY and sensor supply rails compared to the retail boards
> (CQM and CQS) which use PM4125.
> 
> Add a dedicated overlay for optional IMX577 integration via CSIPHY1.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

[...]

> +&camss {
> +	vdd-csiphy-1p2-supply = <&pm8150_l11>;
> +	vdd-csiphy-1p8-supply = <&pm8150_l12>;
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			csiphy1_ep: endpoint {
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx577_ep1>;
> +			};
> +		};

Likewise

Konrad
