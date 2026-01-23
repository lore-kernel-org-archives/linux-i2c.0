Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301E352959
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135449; cv=none; b=I3IvgBD8Jb7r0BtNdCsToxdA0u9xHrdIDK7tM2k2bFB8jz7EubrWh8ApirIy42cDmtrY7JrGjF+H1a3FGEGP3Y/rdWrZJzcDrMRfjn+x675Wx9EPugyI3TNLgslNNA1aowpmO8W8jDDG/DvPqtsth0YV75HLrvLEz73kMrPIvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135449; c=relaxed/simple;
	bh=TB1IK3oxKC4Pvn5NMkqqLOWwLoygWYshus/E1Z/h6SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azg4cnbQnz1GMEcdVASMjpmaJqQQHndBBsOEqF1SSL4Ol17tpI+df4tl/Km5cUNB+ahbajQaC3iJhbblkETKEe0WuofZwR6sEbTbf8tPmTn4T5QZzd6jvQUtMkKDVeaTwiWzGzGIPl/bSckmhP2Tas0C8l1Oj5ZbnJleHpLRvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoFjCCue; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kjIW0Q+6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoFjCCue";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kjIW0Q+6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MK7Vkh3503291
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6aeWGzMxBIh6hKBnzi2b6uZexZzjIgGrfHofmca0u00=; b=NoFjCCueJEZgaVON
	oTYHY1xKusFZTAAGOfDvHh1T89z90P/vVKRwm2GTje2RPIicO6FGSUsoIMCnlfx5
	2RcDG+k7xgfdpNu0S5ePAd5svYiLbkI86pytAD2+HRqMzJ3LGhOKexJ0rhJlVx26
	+EtJMyIvPBjizO1lA9tUvy6rstRp3YhKMPSc4IA94nYfPOAv/h/wayDMUUtO74hl
	d7mRiYJrRskOFtB1LsItq1Qt5qB+UQcQFjg/jknO6j5MTvq0hJBEj0iykgWJIQV+
	htRWlDjT/vqQG0q9TjA8RS6vNB3qy9mDqypOOVH5cv/p0t9QtBtpXm1E+qan6+n+
	uKT6qw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bus9815y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:30:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502f0627494so32104211cf.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769135414; x=1769740214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aeWGzMxBIh6hKBnzi2b6uZexZzjIgGrfHofmca0u00=;
        b=kjIW0Q+6iIHqSj7jc6XzMpshl1ugnnQtAWeeJUhZEetQNR//snqeSLI5nOTTIEhi1/
         0qx00kLUDt00aMNJPgLO9QU1MYQRjNu66JDb7SDCr1AdW2hQMcR0Fch0HOX040Url76m
         /ciX7wb1YxbyD/qc4A/M/flwInlq1k7G1gx+ANVnxFCqN9OQe2mV3GPDTF8udbS3L6Kw
         6TPSr0dpCj7L99cK04iKdvwBHN375KrHbivXgKihLEqtatUBx/TlAWKAZ3PUqtupt2Pp
         pT90B/zF5q8jtQh+H5FkTgKhZA6otHmPEyZXXvn4/Kg/PCMM3z5ORaXGSSOSKlKkebd6
         Qbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769135414; x=1769740214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeWGzMxBIh6hKBnzi2b6uZexZzjIgGrfHofmca0u00=;
        b=QFwobstJgvJDrVJOwsG7loRKHIb+snp/ElOJrqHKkD9ckEb9Yl1CkG1gZZeGoz42NT
         b+fPiF7eMfIewtE7audHOJG8GXQFPiZ7patzU9TW+F5YxwmVWku+DiZZuegM7JzSoeF5
         BaXU9/0DwqkICQmXTjewqwrp6sr4Qvy5u9Yp2b2ClKgN7dpUa8Y4N4NMxbOBc1VoKL4m
         2wotFDjcNhvb3pKk/BPkWzQYKri1aXPJDOo2csDm2f3Stg48VyU6MSobuASebYfFR16D
         +vJsl2ppTLnIz1m95DZprtGd6HowwhzePj1Q0q+6jCuVEnWuyC4iBaFw0Cq1+X6cX6Js
         NDIQ==
X-Gm-Message-State: AOJu0Yym/3ZsCqmGurqXjRBAtVS6scbzad4e9ZHODtCmFJMCd9j0IEzf
	HI3SzG4xmb0YHuVLZUt7GzRxDgP8steF12IhmjscCrRGlbH4IrWrNvV0hNkGnY/v+5vhwLc/4h9
	h4yG8De8uLTutdBx6++bZmqdOAC1wjZxXvOd9Te/eWaS45WMuO72e8HvxyGUSpXI=
X-Gm-Gg: AZuq6aLkFW9OMA9AQ9pokbnhX2kjB/lAm12HKwI8I8AYhzuK3WuYW4s1rdTNVMEbtha
	RPCin6NuWhq4SVtpEshmtBc7x6M+Piu8hPHLZoW5zCOgP1fdB4tKzc8c9KwDos+arOwi1GdAuap
	L3Y0DOH0WQ1hzpQuTS73es2zA1OoMyK3eNAjGWnxnextDGI3OVbgw2iKHRQaYWXlzGxpSo7MRsu
	7JcYjQ16ypGmyMYOOe+988nAa6+FaCCnyxrE6E3z2RCVdYao8iey6Zfi3J+jCs8LjZ11ivkZDX+
	bOJ8kdRcpuZO19KVL0BvtPab/DbOHOwnDPP3dGtdWa6PepMM2Q/nJPT2+WHpO/j6mjOXZ2gzLcK
	fU7QC0O+8FQj2MWpOn0JWC1jBPa3/nnvldHtR5ReMkKDCKZIM6owL1xAmtsW7VPcvbRcZ3IfXYg
	==
X-Received: by 2002:a05:622a:10f:b0:501:4236:5474 with SMTP id d75a77b69052e-502f77653ebmr23040661cf.28.1769135413660;
        Thu, 22 Jan 2026 18:30:13 -0800 (PST)
X-Received: by 2002:a05:622a:10f:b0:501:4236:5474 with SMTP id d75a77b69052e-502f77653ebmr23040251cf.28.1769135413099;
        Thu, 22 Jan 2026 18:30:13 -0800 (PST)
Received: from [10.111.171.243] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ed650bsm7054291cf.11.2026.01.22.18.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:30:12 -0800 (PST)
Message-ID: <e0e6f248-3d82-4b0c-9ee2-4a655b7bbbfd@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 10:30:02 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com>
 <20260122-sm6150_evk-v5-5-039b170450a3@oss.qualcomm.com>
 <825c3e7c-469a-4d69-b298-18f2edf72ea4@oss.qualcomm.com>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <825c3e7c-469a-4d69-b298-18f2edf72ea4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDAxNSBTYWx0ZWRfX0z2tHUATmsHe
 UwY+NJlXVK6AihqE5ZNpSYK84AL74ybGSjnZ1/Q2JP2NHbGzM4hUIOuT8ULHiPyBPpxsO+HWQxy
 BjoKf/liNweI+i7VDs9eNHxrOAp4n1rRURRcqjp6pCJ6PThH0D72eqzR+CixPRujgZEvfOMJMba
 Ub5uWa6lWS2rV3kQQ7/fU9Bdh6rMutCl3zcIZ2rSmvnqPgm+YVY2VB0dynfa2Cx+De9RETOyhVb
 VFRQXkyXIjYKXLnoaQlL+ZtSNX4elInB2sp1DnPEAN8qneSYrurdkwAtF9UdZ2QP9LIpyTAUZQ7
 Fjfye5w64hSXmym5ghcVlBl57Cl7XGhBsbaZ23Hklg+rX2LLUtNVmAnxj60ejmrdOb+57F1Orid
 O5G5ox1xH5cXZR7tzGnFeZ9s4ig2je85qHMj0UcxGExyoBa/nconxZiuejW/uyefTncT/+dhoD8
 JSh+8LB0kjMCg+Xaw8Q==
X-Authority-Analysis: v=2.4 cv=JuX8bc4C c=1 sm=1 tr=0 ts=6972dd3f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=yKNFHEXJphivSBQIcCoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: n5Kz5RVsuDAZ9iRcWBkyoeTvjaIJnXQD
X-Proofpoint-ORIG-GUID: n5Kz5RVsuDAZ9iRcWBkyoeTvjaIJnXQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230015

Hi Konrad,

On 1/22/2026 9:44 PM, Konrad Dybcio wrote:
> On 1/22/26 11:48 AM, Wenmeng Liu wrote:
>> Enable IMX577 via CCI on Taloss EVK Core Kit.
>>
>> The Talos EVK board does not include a camera sensor
>> by default, this DTSO has enabled the Arducam 12.3MP
>> IMX577 Mini Camera Module on the CSI-1 interface.
>>
>> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +&cci_i2c1 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	camera@1a {
>> +		compatible = "sony,imx577";
>> +		reg = <0x1a>;
>> +
>> +		reset-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
> 
> Let's define the pin settings for the reset pin too, otherwise lgtm

The reset pin on the Talos EVK board is different from the default. Do 
you recommend that I define the reset pin's pinctrl in the Talos EVK 
board's DTS?

Thanks,
Wenmeng


