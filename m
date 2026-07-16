Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA02412270
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205733; cv=none; b=oAzVGLwgVTKO8bLAe1BmjR+7Ea0xTCQMM7jWROXp9q4lvCVDH77uSL7n3qEv54d86K+RHelYF27JPXpoXX4xywfTWdV/IGk/1Qvd6a0HZ3HxdLBz6LpyqHlmEkrHowk1KSY80z/i6ND7SIsKndqxGc8pNg08Y0Jndc6bAF620kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205733; c=relaxed/simple;
	bh=aZjkUe1c55qeNoGRtdIQ8tMN4RZ/ApDiNCpm9RMNjTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEkbgSGTdltXdG2HQp/oVjVzoRmhra24VYKzcq3hpnFxq8VVbaBoP6N7LfKuXZBcOkR6jD2eyRXjzul9Ge+jNEfgXwK84mwkAGxI/omGR+hr0BV4qZomasi+GywKcLRVtc/+rqGMUUNzyQBz8iIT74UDIvTL7NHxEeHkXN4C+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sc6oB/ym; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IKMxmzU6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sc6oB/ym";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IKMxmzU6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBjBTh2506769
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UYlz6Mik5/sZA3dGlhiKFDmqJjZEM76yBtlXFsw/ze4=; b=Sc6oB/ymyLzsoFOZ
	7w7deN6jYSkeazoBRke2QxbYKBTYlt2IXVzdXdlbEFqrsxhckRCwm3POZLJwoaCx
	v3FzEFUHXZ8nE68GhMaMIneieMhX9Wr3mjATIjGH2uKb0rgcdbABpcTbs0pkUD5o
	4pmpEFMiphd8OBkQCPOAJgwEz9kxp8wAQv4XtLEUOMZduvXTvks2mIwWyoEdQTF8
	t5C9NU62GWelUujS9WW7skAm0FvWyKZ4rcLfSi597Wjsl8LAP5RhP23+EQ3G49EG
	BBPAfNeSCoDlgchXMpGHznbErgCMfW3DUYI/jyQu7fpRx3JvGBxvK2f6xz1506Uj
	gCppGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvbtj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:42:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so87070005ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784205728; x=1784810528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYlz6Mik5/sZA3dGlhiKFDmqJjZEM76yBtlXFsw/ze4=;
        b=IKMxmzU6/2PDBakxWwjUQ425JhHhOvcBIqVWDZvDLvk15mKUU3mTI/36V6gDBkKU2O
         B8ltHAJ12f8YuX9qJuPspRcxCc+yCKNCsJ71gNQkv6RrOelL/LfGxyQm+OkzAajS9Hxl
         +eUu7DRuMyx9jTAA+CjJb7jtPElXTRUofMLRxQnibPOCbwlo7iXSO8kYn+zhuj5N6GnX
         5KVpGzVv0WBD0YWM3e4O+4CoEbSlZV5JRdnapMVrpymeW845pAiSHxwxefUXNwL+N1XN
         47jYmar+xUVrLoGA4RkSYfNwhk63sitrQpPB4nsK8kQwKJp39Adkbyo3URSmkxLQ92qG
         33Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205728; x=1784810528;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYlz6Mik5/sZA3dGlhiKFDmqJjZEM76yBtlXFsw/ze4=;
        b=IM6ujBEQMmapjsKdBGCQUr5A132m/iscrSqRO/gT7s2N6W3NPXzEsy6xVM4eFFOsNG
         U50ha3K68YWroLbHZaM7IrMdE3E9yC+0y9DStjWywW8KssmJk3bLdOGlrgNSm8wMafgW
         BM2Zx939kOYUqF0woePYVSRtoHXl0pH82/JJ4+K08xQB37WFjf4uo7FbhNPnysCE0KpZ
         7DSXdD8UiNIxLOgarzUuujUPw2nxdcjSTq2Jgf2BmRIMb4vRwD7GlNXQh80l2fgIQBT/
         DAOCdNewER4rhCx3yKg/VXGNa2C562AOc9hVAp/0SMboZ2eMV6kTY/mRaQyYT4NjmBTB
         GrRQ==
X-Forwarded-Encrypted: i=1; AHgh+RruAbZd3YfHDqW/lcKn/iXBeKKystog01FLNFeg0nkvuMhuFOoUX/KqKsI3XEqlUJRAGl6Jds+A9tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOdIoa8PmS+ndUGWEvv5oY9bXi4e4qwWYVElehIr5A8mffV6o
	5qBmsuIB2YjVxUkTAzQjXWeiUDqWv9z00eZrN5K81BaiaM6BwGCTwgPuGZWXqMk0lUmFT8sbtWV
	DSKRkMXS7ghf7x1QoFebEime7sPy0X6jyx0Z0sQxdxwVv/lrf8Qcn4MZeqUdz4kU=
X-Gm-Gg: AfdE7cmZLGYSUhwcI57u0qxXDaXsV3J6aggKLHSWfqHIb7Z3ylqQ+T9u6NI47tsEtfN
	NawW5r8VGgM+BrF8Kw31h0Hb5gDPT2bP0lGfy4XWp1GfHpslznIP4tPh72TCKH7bNm51D19/aW4
	Fv6RHl9yd8XSQNmGFrKbhmyZX4GxM3luzn5HWhmO0BPWfkrK6cVQ2rK3a8DzpwzFHTcxKGJBkE6
	jOv4bxEZ/VJSD74XofvDHcMA4eTkBWrH+EN1rgUnvHAA4VkhnJPBSUrvPEIdrmXusOmVm3GktYN
	iiwunUk6ovHz2wjgYjUA3m6sYQDsCJvHJ6QT1Eg1k6gHhXn3QtzqgMXXjoRqaMeK/EVtHObfy7K
	S0E12p0VuSPVsdfZnFEu0r9TukNCaBEACLA==
X-Received: by 2002:a05:6300:6698:b0:3c3:9df8:2eed with SMTP id adf61e73a8af0-3c39df84eb6mr364386637.31.1784205727729;
        Thu, 16 Jul 2026 05:42:07 -0700 (PDT)
X-Received: by 2002:a05:6300:6698:b0:3c3:9df8:2eed with SMTP id adf61e73a8af0-3c39df84eb6mr364351637.31.1784205727287;
        Thu, 16 Jul 2026 05:42:07 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c10dcsm13466080eec.23.2026.07.16.05.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 05:42:06 -0700 (PDT)
Message-ID: <e0628cc0-b754-446c-9992-77561eb1e65a@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:11:57 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] dt-bindings: i2c: qcom,i2c-geni: Document
 multi-owner controller support
To: Bjorn Andersson <andersson@kernel.org>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>
 <alhIzHVf8_RXNY4l@baldur>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <alhIzHVf8_RXNY4l@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a58d1a0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=OlrBKP18NtReKxGUJ9moaA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gVzQGNjsJTxi2T7I5nMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMCBTYWx0ZWRfX5tjQoatVStvs
 RclaJ+Lk/OKzWC0QVC99uK99AgjwJQpXbU7Ok7HMbDqIYM3FUpci8ijhQ9R6bTBm8rdq/+kGDgj
 McPTTdg8OOosbW81d92/jrqxSpLkhWr95MbMhU05eu4mA3G0kT9Z1zSNIDPVoY0A/7YT1DjEGop
 woLJGvTUEc8iYrKzMkhqqLwCLzYBGacYeRFhkdTTKYD5XvzMekL7iMYvFzfYup44Pj34+U2g6x0
 GblTOYL2uKZbpsYrCclDwDauL24IBHteQRF0r38CG0BNmNdJnmer2oSnogwv6+CJ93kQM2rfb47
 gUI3JhqOnO1mzYWpKRcIFPlw95s+ORE4QJ5+YTnhXBgpzbP4i/IklGow9zarZ3JiMBvE6byFNDW
 PvUIUWt9fJYF7QqxuYfoBQBu+StCV59bzjPjP8QVyzITKCoXsbaSx/I5YE4T1j9DvO1jOmOVVAo
 GkY5PQYz72+Hu5UI4Zw==
X-Proofpoint-GUID: DP43En0zS7uWfjt0ph2JE4NK5i3bms6C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMCBTYWx0ZWRfX0spnqZSZVLsX
 bghe4pwMXiOD5GzJ2/PPcpLbj1+A265fYeU8AifXkXiqLvSQGAAHTkPV/WSI/UVd2hpUkJML4Do
 +nhSgY/ePg2CZNaen0CbrOacJ0gJ/Xk=
X-Proofpoint-ORIG-GUID: DP43En0zS7uWfjt0ph2JE4NK5i3bms6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160130



On 7/16/2026 8:44 AM, Bjorn Andersson wrote:
[...]

>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>> @@ -60,6 +60,22 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>   
>> +  qcom,qup-multi-owner:
>> +    type: boolean
>> +    description:
>> +      Indicates that the QUP-based controller is shared with one or more
>> +      other system processors and must not be assumed to have exclusive
>> +      ownership by the operating system.
>> +
>> +      The associated GPIOs must not be reconfigured into a sleep state
>> +      during runtime suspend, as doing so may disrupt transactions
>> +      initiated by another owner of the controller.
> 
> I think this should be made even clearer that this defined a requirement
> on the operating system. I also think that "sleep state" is a misnomer,
> it's not the sleep state as such that is the problem (what happens if I
> define a sleep state with functional settings, or what happens if I
> define an "idle" state?)
Agree, only mentioning of sleep state may misguide. Rather, will make it 
reverse, what you have pointed below.
> 
> One way to handle this would be to declare that only "default" state is
> allowed, when this property is specified.
> 
> If we still want this, I think it should be rephrased something like:
> 
> """
> When this option is present the Operating System must ignore any
> non-default pinctrl state configuration, as reconfiguring the associated
> pins might disrupt transactions initiated by another owner of the
> controller.
> """
> 
Thanks for clarity ! Will update in next patch. Let me finalize Patch 2 
with alignment to DMA.
> Regards,
> Bjorn
> 
>> +
>> +      Each owner is responsible for maintaining any resource votes
>> +      required for operation of the shared controller (for example clocks,
>> +      power domains, interconnect bandwidth, or other platform-specific
>> +      resources)
>> +
>>     reg:
>>       maxItems: 1
>>   
>> -- 
>> 2.43.0
>>

