Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BB330B2C
	for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423579; cv=none; b=eEWjHIfVR4Lg54466SJ4BZEUUoWDWaEhJAbQQ9Rk67YTQn67t8knCEYpHD35oBFeQHfOZsEphQlDSo06CHa9FYXvtnJypGqEjY7NV7APubnQbolWf0kea4uLAQUD17OIvIYcRMEF/cSvvDjKfWTnR7YWKPh+5Hrrr+e3eVmqcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423579; c=relaxed/simple;
	bh=eWAdrV6TAtui1MJq3ZE1m/+gDAFZQQwdZF81DH6TaDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIQ/CCPGomP/VQpo5r57RwtbXNKyLJZSD6usZVKjuTlc5p+6yXrUTINNITlKTANRTGQeNp1ZCzdIDeqCoM/SmyrddQdiy2TGAldIYIHq1f6inX5nOzYr5BqEYX3WFyKo2G8+D9Wl+P0QSEF3eVoQkvmHsyUiOfzQ+M/YYIVBGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULxdXg8G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i0DC6o7G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULxdXg8G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0DC6o7G"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q90XOS899362
	for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JnGQa+VppXSpGH8Db51uvFUmO5TW2cub0y3XamdlXbo=; b=ULxdXg8GOuwlgBJL
	TgivDwLrLmZGDQj6b7363AGK+1t5pNEoyeTBAP87E7bO8F2CRgksn+JM4V6iF9cB
	TedXI5UGCAgtChJkpTvInxkibW3S4B9oS0ie3qbqr/9ZPIBNoFfHFVPBH0gEVNJv
	psl+3qIqHyDB1Cq2MC2Jml1UuRptrNf+O8xs0i8PvvpOaIG8OMNVZRvzoLG+7WNE
	by8je9iU5ZEYXN7AOcZwUAzF5w0ZE5onMXRLIA3zWu1cENk2NCxJqQKBeunQF5eH
	WWqv+SowYjxeCAV/9/TqfcRCP/sVgmS7djm+h6GeMps28Y84192T5UWZr4/Hw4Z5
	oeFgOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f4726-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 10:32:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6de73fab8so134484285a.3
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769423576; x=1770028376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnGQa+VppXSpGH8Db51uvFUmO5TW2cub0y3XamdlXbo=;
        b=i0DC6o7Gv3QuE4zW7J0iXqYQhrM5/Pc/wVemT9IA8LVftVgfrGQ7AAjeCJfVzxcmCg
         vxfYa7qHjdicuZes1UxS5cZm6CwnD1Zzh+w+gr/kUxqgZLw003lFel3ErFTluQ8hgho8
         sblioBU8ehzBp0froR+WxrfneOsSDbPOFJHK4KCbSCRovN+RIVvHOnL9D4DJw6FKiQm4
         KqtiwOsHYlYmp5WKPFYlkSTIfsgWjMHAKG5HyvL6CTBOWioiIA0vacKqnLERopnvxhHZ
         4DeA0KEA5vsnnFzGtluXP2+0IkUQvX+5DzA/Nt5VTAXDgDtqVwDtDFuM+Vtvc3JIRqTB
         mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423576; x=1770028376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnGQa+VppXSpGH8Db51uvFUmO5TW2cub0y3XamdlXbo=;
        b=OYvdk1PXkEKIh/suIcKhDQFYxgv2cDKIlsQDrfglHwAb/Qc4zoPHrIpZyLqLURmBM0
         MsudY5mF4jyFMYo5Gs19Ndi6KnI7Ys0tf8kTrHEYexjskXnrrGU2yyJGOhXzv+OBVP3S
         yXXooObQmVnfKG1HvCSA2V1gE+FKaYiks/LN+tSHp/GHP/PB0YdFD0MHReNTImwYjkt/
         byLrJUfkEbMQC+1KbYu+DZppFGYE0NCj7+HvgO7VllNeZLzr6O/kKbZ3ZwoUsBdpv0HI
         xu6rm30U/MuNSSLscEBt1yJODSnwrVUMsEl4fN7Mp+80QCDLF/a4IUX8uf1EASAy99rS
         dIxA==
X-Gm-Message-State: AOJu0YzX8emOms8yBtnpiuCVT94Gx/MRtvS7CDuVG1srsadJ3a0qtfeR
	+9onsdKORmboX4CRBQkKRXnEjZKOqj6A2dC1t2TSPIZAZGGiRxigdwFuErHIYNlzuvmSwuoHTMW
	iCGFI2AlkJy6bBvBimuCL3ezHl6X8s1ic9p5n5qJTF/sWK/4toRWtClgNLBTnnJg=
X-Gm-Gg: AZuq6aKcbN8bkFYvMKXFdguJqaNXunKzE95auZ3diOE/nTIvzNJmTCZfXel10Or8BDy
	MRL3iwAzYN+FosvC+J9iwl3XTS6rOir/jNFm+zzDarMziDWzV7Wvgn7BoTLltuINY6wEIdL4dq5
	3GH+kjwwY9VNe8eg2gHaM7wQW67A3tbmJ+BxALab/hHl1aaRL7ELX6QnASa8ahgxusLq4YZx8Ag
	p2L/+n7bYranwAP016Vz3nmDB9BAzxQVt+ldBDo78BihhyLPAERdk1WXfO1ANrN06ULFbiZS8qn
	RNQ3fiRQCrL7kfOvvkygq1klKehZ/JTqUkGfyo6+3QxcBdku6aau3aLgdkYl0I3gubJ0nVNs8+7
	BOf8h4lCrSd+x+3Q2AjGHAXDGs4Ro8+bQcqoyGmpduOW+ycJ5+jxIrOI9WrEe/lhagyo=
X-Received: by 2002:a05:620a:2588:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6f95790c0mr358654085a.1.1769423575897;
        Mon, 26 Jan 2026 02:32:55 -0800 (PST)
X-Received: by 2002:a05:620a:2588:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6f95790c0mr358637685a.1.1769423570661;
        Mon, 26 Jan 2026 02:32:50 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7d7d89sm606513966b.68.2026.01.26.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:32:49 -0800 (PST)
Message-ID: <291206cc-85e7-4251-9507-5848f721a708@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 11:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
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
 <e0e6f248-3d82-4b0c-9ee2-4a655b7bbbfd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e0e6f248-3d82-4b0c-9ee2-4a655b7bbbfd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=697742d8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=qa14B8Bdw_gfn3ERDOEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _vDseYQRL6XkV2fzj5i5wQRd-DYz6Tvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5MCBTYWx0ZWRfX1C4dqbt11sSG
 FI+FSyi36YN0ftUs1kZqKBN3tmx6Rnm+UPb0a49+tdteWJPkq0liH/oAXIT4S8oagfsnyLqFb9r
 rIp0qYbFIi2XMhJWEb3dq5oZAQY3X8MLqJ22Cr/R9HhbehDo+RtRk09WBJx4cavlQldazXiqe4X
 mALFyB//zI4XTUPC/KjSbhXdfhyc5DolH4/3A/q4SGbB5Buu1S8KVSsh5oaTamjag9+5aYYmyj/
 9clP2uMNUMLZ8wIW0kkIH03BkEQK6wCG1jIs/M+L8WtHHG1oB7jtzh5pYuPmcCabzH68e6ayMa5
 vnBgbqrw+p+v1L5kMmyY18fwZdEZxkqCsUR7yn6K09a19mwjs8ZIvEMtk/mK42OFKgVrLOT4qZk
 NDG/qlkME7VPpEjwu1A93lp3KFllBk5THG2v+uk8QHhpFh8+AKac6jX7vChNHBsl8t2yR60pY/h
 LkqxHEKhfLpmzgjyjsg==
X-Proofpoint-ORIG-GUID: _vDseYQRL6XkV2fzj5i5wQRd-DYz6Tvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260090

On 1/23/26 3:30 AM, Wenmeng Liu wrote:
> Hi Konrad,
> 
> On 1/22/2026 9:44 PM, Konrad Dybcio wrote:
>> On 1/22/26 11:48 AM, Wenmeng Liu wrote:
>>> Enable IMX577 via CCI on Taloss EVK Core Kit.
>>>
>>> The Talos EVK board does not include a camera sensor
>>> by default, this DTSO has enabled the Arducam 12.3MP
>>> IMX577 Mini Camera Module on the CSI-1 interface.
>>>
>>> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +&cci_i2c1 {
>>> +    #address-cells = <1>;
>>> +    #size-cells = <0>;
>>> +
>>> +    camera@1a {
>>> +        compatible = "sony,imx577";
>>> +        reg = <0x1a>;
>>> +
>>> +        reset-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>>
>> Let's define the pin settings for the reset pin too, otherwise lgtm
> 
> The reset pin on the Talos EVK board is different from the default. Do you recommend that I define the reset pin's pinctrl in the Talos EVK board's DTS?

Certianly not in the SoC DTSI

The other question is whether to put it in the board or mezz DTS(O)

I think the latter makes more sense, as presumably a different mezz
could use it for different purposes

Konrad
