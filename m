Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED03E008A
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653269; cv=none; b=NwsLvB+xUaNny5RKT6y2S8jEoSvZYxeHffxp42XAkjT6CxJKVhHbVJvbGott6VZ3Glrr3ijZlCqCKnkdiT5UCx935U7RGpZLMWUm/Af0G1J8iI62Qkqu/38p4mqUXe7hx+JHQGDNzGGu7Qn3SOie16P4wX3bc6CzVp8p6F0IMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653269; c=relaxed/simple;
	bh=nfaG9XQEprlhdU3K9q6D9sngdH/8CmjEdYlEhi+U7+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOAwUAZcsNI8bEq5S1tdlNBSur1Q/z5gDJvUQumE36BNLAI8f+ekjLgVNEO39zvlxAtswzFNazx7sH3tAZlkPtTtpmxuSfQZ7hjFXmy8IoHzFRHytPCoLMBBF+udZse5zIPzahFGor/AlDnADyiubbfJlPK05Vd1D823+xOjARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OdmhmSC0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUw+Gvun; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OdmhmSC0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dUw+Gvun"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg7vk1912746
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 17:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zGD05ffzGvmGRNir2ny5kaWg58qkNh5Jg/HMgLya/oc=; b=OdmhmSC0K3AHmcUx
	7LBBnD5k4HX5FcK83rvSnQfpEJ1GlSV0r4dvMKt1+dLZ/lAUDeVnZfZlJvPesuHp
	CPcbInVJyg9K76nk6QDE3l2K73sPdPuR5Fmz4ZOowgtP0v1lBsI5y0OqL3xtHlJ1
	HrtLHsoe4E/odZZE0TFzakfadWkd9kgMJW4rittWq9AoWTh/Stn4u+36DKx5GceK
	jvYMHElXOoSSEGNHUl470YoN0aVK4l2ElteZ4+dmMnlvDlVoHFrrtUjAqd0Sd6r0
	NCvHvH655Oo1jIGjVjw8v9GbTtHXJhGtNuIrxv/3eBG8juAv7McKUAFOEw2hwfG+
	kk/MqQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1dukmy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 17:01:06 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bbcdd9a269so577572e0c.2
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784653266; x=1785258066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGD05ffzGvmGRNir2ny5kaWg58qkNh5Jg/HMgLya/oc=;
        b=dUw+Gvun8Mqe1AR2/pFy3NkQ6K7IR4+XRP2ulDw+Rh95HVruJ1RJe/mRW8VXsGPhMN
         ph897aMdahLVaOaVxEI1FOiIrb96WSB8UHe8ELitA1BNzopFOJajI6uWgjYUzrZQAEbx
         cAZUn8WmZZoFbGB4aPpCyjYrZw2Er0X1ooB+GEwtFYBKi4nejYdVHxOa+FUkMbowuKjl
         +8lRii7xddHQzYy7oH4/kTrDo+OMwHHYCJ/mFOIj70H5KuYKCNxAbtwEwBojW95yH7iM
         /nXK9Q6Z/LRlvlP2zoyq7icBg8ljA3xykM+erZjo4b3XX92kQaj3VQPupb2o8mpqPwcV
         7cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653266; x=1785258066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGD05ffzGvmGRNir2ny5kaWg58qkNh5Jg/HMgLya/oc=;
        b=qEkJMk1YbCLQpfDR3OtEDPCCf0Hyx98U9wNAldRXRBm52/CFL83+s0KnPxn644bq6v
         7fbVMaCkvyqSgsr1shgxdQWIKD6VnZ9psdW1rfzCBtrRqimfQj2c3+v6CJnx3wb7fZRq
         Z6WkK5ayBkdrFyCvL0xp3NvZYPykS7Z9UAuoLBUu98Sb55UjR0BxC+S5jRwvy4my+OgD
         IHsf78fnwQobXfgFj9YMtifUkIc0rkPgm4cfX5INk0a+9mEiaaUhqF39u6U4Plyhr90I
         /tttbfydKmo/+3n2uuBfh7kvfwOKhHhXv4UO9fm3HanSNHexgSUDDnb1GStC3EsV9I/w
         zPLg==
X-Forwarded-Encrypted: i=1; AHgh+RpncWjD3C1qDakKVt++/zjNrLTWLR/vfnjRkFnbxOfTYskQtMaSMnoPqbFpBqcmy09THK88hu0Htiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThldc7SBDDzGw3KudOdqhcvK6Cu0IKStATiy0QZOt1fLSo9Ro
	+3tghkQ0MvWgZURD1dZ1n6cpVK/bH3uuCyDyAKIemETzGM75fQaSlSCN9Bf0bCSZNZ8Z5ij/diF
	PQzIFwpX5wXicNtU1KvAricvpL3CEN0BsAoP2YcDYFW2vtfAgUmwZCQ/EON2Tbc0=
X-Gm-Gg: AR+sD11oPtQlg8Zvv2WgQ/GBBrquhdLlIyOEvIRX0xF1FSqqlvtHU0+gqKZdeTiq40Q
	Kj7ZPGPNxK28CimRokerhEnV5UmPH78L7CxOuZYcftZP1Y23IKw4FHk4kX3u8Y9rDR2YZmf7PVp
	JxZMsRVecwaPUiP5ElNaqFCYzg6pc+1Nxy7+nZgd2m0CkJ2f6afZ/zZCsYl2cKuJGHbFLNKDsxs
	+WuhTq9HrEGzCTczcIyib747bL2uQXw28zZG5noQfCg2zWvcQiYxG4hWYWuC0YOaHpNkW+du9o1
	Iqbpql1DhqnBWLzx+cL8nr6PXm/fE2IaI1udQ+q+6aBUjaeM2wWIfu65Pb3zzX2R1H8dlG35udC
	BQEqasi3/FCo2ys0AeJeeT+26
X-Received: by 2002:a05:6102:3fa8:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-74abc21db84mr714198137.3.1784653265801;
        Tue, 21 Jul 2026 10:01:05 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa8:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-74abc21db84mr714165137.3.1784653265258;
        Tue, 21 Jul 2026 10:01:05 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34bad7e9sm69547a12.13.2026.07.21.10.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:01:03 -0700 (PDT)
Message-ID: <1a4155a5-14f6-410c-907c-b2cd8d311bfe@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 19:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-3-5eae78700da8@oss.qualcomm.com>
 <7fa30af8-884f-4302-ba88-92720bc741eb@oss.qualcomm.com>
 <CAFEp6-3Zd9Rg0h3v5FGT_RoJiXg8qYNbyCmdx-tO16p8nyBuZQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3Zd9Rg0h3v5FGT_RoJiXg8qYNbyCmdx-tO16p8nyBuZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O8u3I0vvxyB0G1pegMtnpTu8x_eFm2F-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfX3xKR43sNG1Cd
 XCxTB+9u04P6yy2rpFknaNZhFSpG/ehjxRC8EzZK2C6ODEDTtrMW2//DdakdngY19zMWFgSteOd
 I2N4QatQfulHYw9gF3uUHvtCKUwNysn6GyVC6FiK/I6mCYviOpyuJhqD8kjiBfZADVF00fRzTng
 l6u26nu6I0YTwf0pZ2Ds/1OvyB879kp8RsA3msCir3k86u4FvTYBd9boF8Qc4mDn8xkOYz4tSv0
 VgM0wbtzD5a9bHOHrTY2eaoXWxYU01CmjK27J8BVLfVH+QlgaL+cTcELm+MOyNP7Y1ytz0WzW2j
 03bHqAIGQCxYmGhQsziQJAfcfhdJU3QuY9v/qRk3urO8wtJaGfY9seLTXIexY+xYaV/GWDxUYe6
 FLELifU7xWTCmy20+NPY7oWfy6TXVyHf1lwnHeyedxi8u9HkiNbLOwoUCVWoj40IGnyPdN2hMrF
 ZGXVu+wTOo+8obNtZkg==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5fa5d2 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hrhF-SS1B2tw-unXrEcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: O8u3I0vvxyB0G1pegMtnpTu8x_eFm2F-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE3OSBTYWx0ZWRfX1GCKBi3aZw9N
 6cXA5NyxoZadS2cBWRS2Ifv0EGWXozYGO5/rmjFKy36F/kvdZxZPxwZMI+owV56UMIX3fjCtvkO
 cSKTjFFlfcDlwWkLjAZdgNC2k5Ehwm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210179

On 7/21/26 5:41 PM, Loic Poulain wrote:
> Hi Konrad,
> 
> On Tue, Jul 21, 2026 at 5:07 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 7/21/26 4:58 PM, Loic Poulain wrote:
>>> The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
>>> and were calibrated for a specific clock rate per hardware variant. If
>>> the clock is running at a different rate the I2C timings will be wrong,
>>> potentially violating the I2C specification.
>>>
>>> Rather than just warning about a mismatch, actively set the clock to the
>>> expected rate at probe time. Warn if the rate could not be applied so the
>>> user is informed that timings may be incorrect.
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---

[...]

>>> +     cci_clk = devm_clk_get(dev, "cci");
>>> +     if (IS_ERR(cci_clk))
>>> +             return dev_err_probe(dev, PTR_ERR(cci_clk), "failed to get CCI clock\n");
>>> +
>>> +     clk_set_rate(cci_clk, cci->data->cci_clk_rate);
>>> +     if (clk_get_rate(cci_clk) != cci->data->cci_clk_rate)
>>> +             dev_warn(dev, "CCI clock is not at expected %lu Hz\n",
>>> +                      cci->data->cci_clk_rate);
>>
>> This needs to go through OPP.
>>
>> Feel free to take over and refresh:
>>
>> https://lore.kernel.org/linux-arm-msm/20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com/
> 
> Sorry for missing your series earlier. I still think we need this
> series to restore the expected clock rate information in the driver
> and enforce it at probe time, right now the timing tables are
> calibrated for a specific frequency and the driver has no way to
> verify or correct what it gets.

What I'm saying is that you need to call dev_pm_opp_set_rate()
anyway, clk_set_rate() doesn't take into account the required
OPPs for a frequency, and those are very low, but non-zero for
CCI. Unfortunately that comes with the added headache of
maintaining an OPP table for each target anyway..

Konrad
