Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148D2F12A1
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222709; cv=none; b=BeZ9t3TwlYLLnekOn9OcYcC5VBfny68ecnPCF2ojFFR5UwRU5m3DnnFEkMUhzSb+fYS5E0d6GPzgwMwFzlb9j2Q5FJnEmOfcYSvVeXMdRYWoPecKP5wQVZW7Wt75Q9p6KCJdpvsI5K+lOOxfzb+EgKz3GyinWGV06ULJRFrcn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222709; c=relaxed/simple;
	bh=Z8BUtmy4vYqnP2Sl5b6PxGQmlvFe0zk8gqNCmj62HYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Avj1EkaHMJBaggUp/8L/Xb5vUDlgktnb9DuNM03Qr/Ii5+jZlFqV4is7nYi+06Ds1vU44sDn905ixRjiUT7qOSUEY5ivQQ5t4KhIFYYum3S6ghdpAPW5kVuMt3GR+YbCW+Mge/fzsw96EOi+1R2BAnx/d4Dq7Ct8Sy40KqjVWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q0ee8ae5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JLSFdkcp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q0ee8ae5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JLSFdkcp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIOiQ787510
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 16:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WjYc5v8giEANpBvp2Y4mcpR13v9pfhNpJMCgPZbtUk0=; b=Q0ee8ae50UtoqGGa
	R2v6W1rJPrLg3l4sWL1wctkXamo5+He8/EYxl73ihR4oqW8GS8cuwanl2J3cLHrH
	N52+KD/StqvyYs21ddSYnOKXxxkmOB2dYAXZR/vfChOj9FNqBRh8x6ByxxSpB7r+
	m0OMNXS1XRgQsICz5IrUrfS1fG8UDBdR7WKQKVaXcBSjieDpSKMQYyXvqi+aKOLa
	toTy/PeH1RfwmacIMWa4lyNbKZAvQCNOXtqa1MwtnZ8pUnf8VfOzJmf48DAxOjpY
	3vwF09WGDY6MzIbRNkBXkeL9bt0PzkeNFmN3T9Inff+MHcpqMvvVZzqBEGPxBtQW
	fN0Gew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43uxh8cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 16:31:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso6498138a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222708; x=1770827508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjYc5v8giEANpBvp2Y4mcpR13v9pfhNpJMCgPZbtUk0=;
        b=JLSFdkcpMIxSafbZ9ccKuJeL1FP29F4s9XHWVoK1Svq9ZXr7a2NWN49nYVD/ASHXH9
         L3Htf38MwBR59BEVssB9NEZ3lRIpl8J/9+GwYWqPiwK9VXrfeKlw27HZCsf1feiJhy+O
         87W9ZmR0qHBBcwi8jFMN3OVQcPcttq1X3qYmyejhljavzhnuPNNlHOmr/phdURyAuWBC
         eAJHma6eqMa/wtDnEGlHSVcD3VONcfLucuByB0uuLnRMZCg6mMUeZxkogSfjTGLo+iJ2
         JlX/r1zrWvFyndXKS4BHjVNdpHfvN4G96DJqmXgzUp4TaMwOeUvrPBUv78XKbslE1tlB
         9axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222708; x=1770827508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjYc5v8giEANpBvp2Y4mcpR13v9pfhNpJMCgPZbtUk0=;
        b=EHf0nOVJuez6XRrwGF9hTEfKZfQa+258wBk1qlYaOGlSG32LKBmy24iXSYbn2zy2lI
         Xyt4ruZBYlaHla3CnwQTg7LueqIgD7DD4FEUXIhw/AwkLZOIgnrvfHQm0l1eRs547iDx
         DqJqBhsp8L7xV2+N9xRAD15ESlasAii+vknWkMSCnTQnP0ipVLXIJ7wvEDp1W1scOwcD
         uD8JfogiRZPHB4f0rk3GUz1/PCoPjXzX0K6FYxJMfUJ5O4PKiBsuCjsop/IXKkfLPdLo
         Icswg6ewOfUYh5hJ9s59n64LgiIJjSNU8zRDeZums8CLZxxJDXSIzy6MxV4Sa2m1R7Ob
         184Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8lGUeQWx/7nOafmZ+NC09haGcc4Js+9rf1h3jDXC4zl4xQJxmGUhrSEVm9V84+w2eyt/+6Za2YRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgI3i9+ftwQ2Z7GN6YpPONoUV6cneKFnpG5/XhEAMYN8X9Qww
	vCwcDr1hEX4ZR5gZ59kUKz+Sw59OCzovXkec1RtJJI9DWSdDz9I4asBKYY+4MzoZE2lzmrAvAzO
	ntpKULR4Ot4+OBt7B4CkFOjuNFmF4KVolYL9CQc8hWwzOfzMgSz9SZQX7Phdoazs=
X-Gm-Gg: AZuq6aIDwFGiRKn7uEqxBovXCuIErV6eqtHTwVul3QCx2UnJZDahgtpWKm3XXEQ0C36
	/WgE8n+yFp1RuP9y/qdg2xD3LahFG5BUV3tO9KrhfS2ZtN7Y80mzEggdcTfs+kDIIY6dFfKhTik
	QPvujbkU2ogXYFIyiwf0smtjErvtT8KG/A5YMZO7L37oPb6lg7wEPEp1wGw2n4SOoJDsmzHlK2Z
	g27Rg9RPNatKc0TW7EfU1hmSjZzN6iCGsWkrn6oMMMLygVNd4Pa88TN4Ltw9b1qJ0naAot/bLvM
	v30QY6Y/jMsFr3qlVIUb4XM32KEzRNKJn8qEEPe51Os54YBywClCfDF/wyxwLcNxo+8vM1RDSYO
	UDabjw3vc74lSEHvw6PKYFTlsbL159K00AcPpl3BP
X-Received: by 2002:a17:90b:534e:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-3548722b3cfmr2875498a91.34.1770222707817;
        Wed, 04 Feb 2026 08:31:47 -0800 (PST)
X-Received: by 2002:a17:90b:534e:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-3548722b3cfmr2875456a91.34.1770222707189;
        Wed, 04 Feb 2026 08:31:47 -0800 (PST)
Received: from [192.168.1.4] ([49.204.107.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860bef61sm3266726a91.3.2026.02.04.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:31:46 -0800 (PST)
Message-ID: <b52729a3-4d14-40cc-b426-7bdec5dbfde8@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 22:01:39 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
 <7733eac7-8158-40f8-8887-44e458d33e9b@oss.qualcomm.com>
 <3466212b-802c-4ea3-8661-794da34c6c3e@oss.qualcomm.com>
 <34ecaa11-0d2c-4981-ba5d-4d3d46e41dbc@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <34ecaa11-0d2c-4981-ba5d-4d3d46e41dbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=StqdKfO0 c=1 sm=1 tr=0 ts=69837474 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JMgISmeAsz0pT9/O8qDBbw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=SbYDc_ivveej1R-7gkAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 5oomI5l4a73vUBdYsjBzEb1U024hTUX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfXwWiy8UsUQZtK
 LB2ig3PdCCozR3UzZG+Yz1OckP7dYZd/QqEaT46vfqx7PWQzppFOHWzXtWE5qMmalJVoHfEwbSL
 CLu2Kj2THa+JX+d+MM0joKbrTzo3h55MT6uiPKW7vYZ8RQMHAyiLMxh+XM02mvlrULHhuzcJyTh
 HTLDdvWXgRxFM7vEGgJTDZPjpDDRYdz32CI+3VLwjS8nDGRj8WD4wIrj/mXJAw3Eixo+JF7lwBS
 v0jkO93WKJ6OsBnexCOV4u0rWgjk4tGTo9VoWdUj0isgMoHrfuGup4I5+2UmL7DJbTsXP4G9HXG
 6wfvmkc2+WAB/P3jSl87i5jEDvpTvzvJ9eJDpeOGYcKuj5ciodGQkyDVuta2LAyzaS3l5mI7cet
 eORpaIupYTuN3t9WoQBCOIhQp7j9N519G+FiX5JDn1oid0/PZUoLapthf1K9P1atVvpWDK93oHo
 cTI6eMtMdOFDBS+4Jsg==
X-Proofpoint-ORIG-GUID: 5oomI5l4a73vUBdYsjBzEb1U024hTUX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040126

Hi Konrad,

On 2/4/2026 7:14 PM, Konrad Dybcio wrote:
> On 2/4/26 6:06 AM, Praveen Talari wrote:
>> Hi Konrad,
>>
>> On 2/3/2026 6:18 PM, Konrad Dybcio wrote:
>>> On 2/2/26 7:09 PM, Praveen Talari wrote:
>>>> To manage GENI serial engine resources during runtime power management,
>>>> drivers currently need to call functions for ICC, clock, and
>>>> SE resource operations in both suspend and resume paths, resulting in
>>>> code duplication across drivers.
>>>>
>>>> The new geni_se_resources_activate() and geni_se_resources_deactivate()
>>>> helper APIs addresses this issue by providing a streamlined method to
>>>> enable or disable all resources based, thereby eliminating redundancy
>>>> across drivers.
>>>>
>>>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>
>>>>        disable_irq(gi2c->irq);
>>>> -    ret = geni_se_resources_off(&gi2c->se);
>>>> +
>>>> +    ret = geni_se_resources_deactivate(&gi2c->se);
>>>>        if (ret) {
>>>>            enable_irq(gi2c->irq);
>>>>            return ret;
>>>> -
>>>> -    } else {
>>>> -        gi2c->suspended = 1;
>>>>        }
>>>>    -    clk_disable_unprepare(gi2c->core_clk);
>>>
>>> I believe you can give gi2c->core_clk and desc->has_core_clk the boot
>>> with this patch since they're no longer referenced anywhere
>>
>> Sorry i didn't get you. Please share more on this.
> 
> I think you can remove these fields from i2c-qcom-geni.c as they seem
> unused now
Got it. will update in next version.

Thanks,
Praveen Talari
> 
> Konrad

