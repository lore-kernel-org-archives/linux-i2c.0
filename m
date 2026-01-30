Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0E34FF76
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791701; cv=none; b=XpanlNoId5jJzvPnJRYK53nPINaqZESNG9gxYpTGdSzXJQoX6MvMkl0knnHDtKFvqxziL9SthCdFQeUdqsmJ4ZyGnTc3bdEVhXZKeaiQHHdRvlxNkUqpcPGESkCTQgiAXlSndrNFwfQ1THWaNTqjePvouTqMIMmeezrYEBmAxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791701; c=relaxed/simple;
	bh=N6QuRCuxQl6ImVfAbQh+CsHy+FKWSsDU4kB6BGwOO+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmuSUST2HaDx/daAIcxjqwleBFhHh9DwTZ/9BklrVW/i3Fh8ZMgfRf6mj2iADKneEZn6Sz8brnwzZAwmmZynBZ2EDZwZ+Qo+PU5Onw13dsN3AcwXCVH3gvv1vyEpbYsrQxgJKpGQj6LVaneGN2EySKQ8l+KejCJmgs8JufQD6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W13H4mKm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqgea4eJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W13H4mKm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqgea4eJ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UDxANl2413922
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vbu9QIZOTdKSeS10rf7IDpzd0exUR6tSMgels7gY1iE=; b=W13H4mKm+YYRybe4
	28cW0ei9kIQbI1FAFKjFtYA5qb+3PIkhECUd4HirMCgupeZuK98bzeVDWCYUXCpv
	Mqg5cKDjoG+HVd/ybvSeGTDwedXBfSDj3lgqi8tJJZgA4iXLnvQT7H8MlexuO8Q5
	5D/JKtSS/HzoXaWR+OJz1NtB35lXXEngXDpxe8kGwFPusfwSovD+4r452q2ZLW73
	m9sIliW8HZm9eUrtSbRHCdDxKtNLxqbHSlccLxtAStLk20nrk3Y2fj1Ke4rUK/a3
	csRdkg6BosnhHmkmJrlwfzplCCF0chsu9EaYQwEKK0N2NrB/QXzntbKDAS2huMhQ
	ni9D1g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41hr43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:48:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c61334ba4d3so1370062a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769791697; x=1770396497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbu9QIZOTdKSeS10rf7IDpzd0exUR6tSMgels7gY1iE=;
        b=cqgea4eJYIHSSajnMpQn+g5kFeNhNKo+meLOO4zA+LN2NpAOQ1AWsco+wDRRnBaocs
         OeCZj6QnZvVY27FZudxYVTH8agbQ3TGepwaEvSf4WeHivvFo9lWnY5QgNH32BHBKxKqz
         kYUWwRmXi4qbxSSvgNgDsb5ZcVBki7aoReDJRHJdFrSMFbZJv13oOfVUmnllXYM9/IUh
         N84eqy/VMhQlM92UIti6aGJcTd0lwty6sGlJGJzTesgobH7XgZLBUqklCeKU2hAKZ2tT
         vY1AtiD6z3BcSaouCt1+ty0NYVhZ8q3HshEs3i6Uf/qYCIq9XxKxtkg5Bv8XoymyedbF
         rtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791697; x=1770396497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbu9QIZOTdKSeS10rf7IDpzd0exUR6tSMgels7gY1iE=;
        b=MWhISBc7cZXczayL1uauKUcKtRPmQOcsA5QwNIUvAebe16WKVnW1lAu6N7dU9Mtwyr
         og6mqMY4UlvDgqg1R10XjYZHFmoaC+1zSYzWX07KNjodPAJlc5ohwW57XluHataUNi9k
         s9GQPOIEeYTF1aXrKHHVdBW6onYDUQAQaCcuG6aIok8zI/7MVaWOd/lV+sYow6nW8BFA
         aXQHyY/ywR4oZKjCDnNMWFyz2WA6LDbFEZCkeVVw0TTZoncTFXfsuynRbOTuA0OB0Ct3
         d2CmW7Mhl2SI3WTEbtz1h4cicJvWy7Gf5EO+KEkzHgKTl8grTiicsOtEMi1sz13wnz0P
         +WSA==
X-Forwarded-Encrypted: i=1; AJvYcCVibbWJvNRoxOGYmVV+OfW3MBrSh+CuvPyt0yKnI7b8myd76KJEA43/1y7tdLhsbdX04n4ohVAwcBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX9xnb6yZdtu/OVs2xdyANSZc8NQ3MxV9Qr7+YbEvILvv+eda
	U+cwf2bRSq0uTU2t7PTJvqpsofgw0VleXerThu5GzPIDGhZqBXbohdIWpsUnCoQ2Gx4Pp4TYuQn
	Gxi092rKUELI3fAf7Dk5IFin3+BLS30PAatWdMJYjw0mjV6PO3TMTsFUbT6W/+lY=
X-Gm-Gg: AZuq6aKU33DIiwLnU0bXGiQYI4/6jEgLSfkY7eAsRjZRCzE6Q0rYXN6mRT6hmyYZbP2
	ulWKvHFA+2dkodkiA7wzopIoi/bxJnjiupcAfbEFVml63ci/sBtGNgiB5fw8m4o8OzMHoNgfVEr
	Mh8uBVtLDdauYFtPNImtcmVvKkXCyqsnsu8K6cARMdf3h8rgI/69t8wC08nXN6o0MzS0vNBeWV6
	rulB/f9SRiKOnCDHsG/EBv+lhK1FPeAkctuN6P0JJJIolKxWS7DCaKWFTm5dCj+zZgHcl+ZItK5
	7Q0bajfDHlLGHUV+qc4HtKJQFZ8vwNvf/cHAgHPs1qwlDov3FNWvdMENwvhDcd8TkUThCDLW4UD
	QT44tezothEahXrzk9M5x+94StOP8My6q5AVvTnHE
X-Received: by 2002:a05:6a21:3296:b0:352:3695:fa64 with SMTP id adf61e73a8af0-392e0108c53mr3428379637.37.1769791696998;
        Fri, 30 Jan 2026 08:48:16 -0800 (PST)
X-Received: by 2002:a05:6a21:3296:b0:352:3695:fa64 with SMTP id adf61e73a8af0-392e0108c53mr3428338637.37.1769791696400;
        Fri, 30 Jan 2026 08:48:16 -0800 (PST)
Received: from [192.168.1.7] ([49.204.111.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642487f1f5sm8558392a12.0.2026.01.30.08.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:48:16 -0800 (PST)
Message-ID: <e887a7b5-d2ed-435a-9961-5a64b0494351@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] i2c: qcom-geni: Use resources helper APIs in
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
 <ce78b376-b581-4053-aa23-4f41ea0d140a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ce78b376-b581-4053-aa23-4f41ea0d140a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IcdVS1SQBqVcOk11QsIdTjujGkLhUpYJ
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697ce0d2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=10aD+GSAjGS7IfLbEAHBKg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7loHADMVyoySppEGI2kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: IcdVS1SQBqVcOk11QsIdTjujGkLhUpYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOCBTYWx0ZWRfXxA0a07wVvlYh
 O3xck2u2sSLKzg16TPnOMe/wl++gQywP5fMvWeAYVuRACrVVnUiV+MEQUanUjmH8R1kRZsJ5ZJW
 cVCIdGKhmj/s4mevBKN1E/jtH04dCX+hk0dZFeQgK/e/55dkUsta5qCI+pUxtrzCWRoAKuVWWeY
 aPCRf9hJoZW4JhUA+3MFApCYC4IEwYH37uz95Pv6XnJQVfz6jcHPS2Q5/1gUiNaspyUEp15i5sJ
 BkGFPEraiYR8z0bFN4qIjZMA9b1QAfgacQx3N5dkMWioW/7SFocaIo0uMvO6rioBm94KEWbhCkD
 EfYfts4Iefp7h4Nro6/BVGizkvwWJMCWbxZPWTtzCBjVvqFW37V7oSiTw6NA2AhC7aVeYYB8d99
 0Oo5p9yNf14E011O9EuSg7KU06f0mrAXHKBZbNpjtMiKLpfDRT9YBTnMN6xGA4efdyCH1s5AQRO
 EfK657+z6y7YdHuAwXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300138

Hi Konrad,

On 1/30/2026 5:35 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
>> To manage GENI serial engine resources during runtime power management,
>> drivers currently need to call functions for ICC, clock, and
>> SE resource operations in both suspend and resume paths, resulting in
>> code duplication across drivers.
>>
>> The new geni_se_resources_activate() and geni_se_resources_deactivate()
>> helper APIs addresses this issue by providing a streamlined method to
>> enable or disable all resources based, thereby eliminating redundancy
>> across drivers.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v1->v2:
>> Bjorn:
>> - Remove geni_se_resources_state() API.
>> - Used geni_se_resources_activate() and geni_se_resources_deactivate()
>>    to enable/disable resources.
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
>>   1 file changed, 5 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index a4b13022e508..b0a18e3d57d9 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>>   
>>   	disable_irq(gi2c->irq);
>> -	ret = geni_se_resources_off(&gi2c->se);
>> +
>> +	ret = geni_se_resources_deactivate(&gi2c->se);
> 
> This calls dev_pm_opp_set_rate(se->dev, 0), dropping the performance state

This does not apply to I²C, since I²C lacks an OPP table, so the 
callback is only relevant for SPI and UART. All the refactored APIs were 
added as generic interfaces shared across I²C, SPI, and UART.

Thanks,
Praveen Talari

> vote, but the other function doesn't have a counterpart to bring it back
> 
> Konrad

