Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3D407CE1
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502641; cv=none; b=iQ7JuTUyp8sRGgTyH65kxjxYvE+5kfFsFq0ztC6V94P92neAZVMm2HLDcGl04mJEOc4Ogrk0vYrybsu7iKEbCATlQjzRKkUgEJwv2wscRrA7GPsJsZa0Lm/zx/iJi9vABnI0IZGaiOcawcuAG6RIZo0ZRJHmMa5rwwarVZa8Q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502641; c=relaxed/simple;
	bh=ONkwmV6ub6lfKBz26viIu7l0+ueDxgeYreLvBi5E8/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwsGpPQyQDtyn3Te4fCRXh7Ag07hhCxR1NduTu+WY9CYQqyioBT84dVbJs7XDrEk090+3x7HOv8neRmNnKCQjHzjv2QOFZ/sPoXm1y45gJFBgFNvN/ey6cDo+glSPef2TKk/itEBUJv9QHMwI/Q3rA3mvf6W9wvSXyQ7j9HvPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=alZFlZxT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UmVk/758; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="alZFlZxT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmVk/758"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889EKr2231141
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 09:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rp/FhuP3BSFOGIgr5F8osPYl1guJ7ugYOygLj83qoRo=; b=alZFlZxToy5Nazbs
	r9pfAq9z/ycoKCy275cQjs7Kkx+W7Gl+/lIMM+Y3vMC8cLUdqDp/0+pqMKwM1zI6
	e/3NiKmnOPMGhhq5ETS9jx7DwFMi5JUmMwbUIrPmaDWBDaJZhoh1wwzdE+GM4r2s
	NyeJbzOIVX8r6imCUMcxh94H4bi/BiB0UGfHsPd2WZYqU2ZkwzZ67JMYaS/1AnCl
	e9H9DyjuxgAarkMsYnmlRbGmSFvaa/2RbnylNTxuh7Qe3fhkrrgsj4mMNmncuyZJ
	GoTaZB8nYO+n9kwqNufQjVfuswUAcO2544L5d1igsSjcYvL5koMUXVr2TsckoM2v
	hmrjmw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5ur11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 09:23:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8478a1ec69fso954982b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783502638; x=1784107438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rp/FhuP3BSFOGIgr5F8osPYl1guJ7ugYOygLj83qoRo=;
        b=UmVk/7588SWXNr1AmyVw2NUtmMXddzWy11nK4/AyrhxLeMm1MIGhm6n/2YjnLDNRY/
         hHPg05bgnT/OdfA18zqaNSa7tvqbQKNUlm/55WOEpOf5GAJXblpGhK1bybkCkZoNPXeZ
         WPkM5wmdmOLy0ZRoAwllvCvvAgtk9VZM7OcSy0r4rUwkXVdqppBpc3bwoDE+npVSf2zN
         ewRPZrgWym3+hZPY8zp8j2XB9Lx2wI0ALSkNOjap0Ay7hJa5GgZ11cucdEVL0QGoGhUx
         HvmG5oI0CDmzlXpCK9QEUd6n/3/JJvalaF5mfz/hl/ZUrWY45YCNoLShE0jUA6JpVsLy
         +ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502638; x=1784107438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rp/FhuP3BSFOGIgr5F8osPYl1guJ7ugYOygLj83qoRo=;
        b=e0FnwjNxu1NdmfzzGR9OxhBi046fIinsvmCeQq33VfegLoroVz0CdoiJdsFk0UBVVa
         kL32OmJCEeT8nB6awtDtoyPzMMkp4LuCezVx/Zipmt0/dOc5+pzme5gl+9x1tTn3UTk6
         +ye6tdHH1G7RFbYLko0BIwGeh1TfbxOylALOhezTity6bNqItFZShFtm/XcnZ0geDTxK
         nGC350YliWerD7uDqcku/6m4wlgJunhXuVE7/CaEATuWW2XDA1FJtB+sgQhMRwZ4HmKK
         M/9gwwYkAvoHkVofBux5QoFFlf52aD6rClQ581mF80KaO06ny7LtsmKY9u5Ajw4vv93/
         0dYg==
X-Forwarded-Encrypted: i=1; AHgh+RqcrKqkAro1stJUmlNB4Uk9RyAXzBZmWcQ4y9RJJmNL4WrggI5/oehj123cT0tvWjBMwGhqDMkwAdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOYDKqV1qdE3j93ssRmuM1qnkjEGf1V6FqozuuNKz6DNNjmps
	oUCDx5v1F4OgWqEHTOOhyM9zwP8u33+aUaVsiTA2AkWQIGRCLc/G7gvv9XrpTRTED7QJoDDxRqQ
	PcSPQMgnJ6urkyNHQT1ss+bwUKNTNeI+r1ly0kJvCu/0aND6vwDFpGLjvnTrdj9KdDJnkiRU=
X-Gm-Gg: AfdE7cmIw4i1XmIOpm82yEYlhSHqwBrRdhfHh6O6W5FGcyVZ0R4E+ZxEFVcIGcO/FHj
	qdRVL79uk6y1mtQVz2+ddoZ4jiNy5+a6sH2N2/ZB0VekFEIy6qCdgjlGucrqzfVjGKtbIL7yx0g
	BZLyW2IFlL+qKJerYs6JETMHPIwAaQ9u7B4uaTL83ebWZ7OxkCEgp+IeaSRD0e8+7VN8LN7Zw/Z
	jSYlIJsOsFCEH7DCiscORhvVmxy6F/SkzyhJVY0+TF/QG4eX1mHhjUK3fV7+hWMPtE5YHwEcl1y
	wX9gRfe8Xk0mJa81Ewe2l/2Nky+Z9gsnXwklS94jiKXhM7HQFxEkQnCZr2U8AH4taWsz3fhz2bu
	Hj1XatGt5+zZcLDf4dKn0zWw1shgjdRZt/oRDeXj+nQ==
X-Received: by 2002:a05:6a00:6f0f:b0:848:4d1a:9554 with SMTP id d2e1a72fcca58-8484d1a9805mr155965b3a.38.1783502637627;
        Wed, 08 Jul 2026 02:23:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:6f0f:b0:848:4d1a:9554 with SMTP id d2e1a72fcca58-8484d1a9805mr155938b3a.38.1783502637009;
        Wed, 08 Jul 2026 02:23:57 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm6870170b3a.60.2026.07.08.02.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 02:23:56 -0700 (PDT)
Message-ID: <5d206010-a35e-460d-9b11-7dbaa8a56add@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 14:53:52 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: qcom-geni: use dedicated completions for abort
 and reset events
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
 <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-2-dd8f841f36a2@oss.qualcomm.com>
 <6167cdea-50d0-4319-9f4d-1f1b349600df@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <6167cdea-50d0-4319-9f4d-1f1b349600df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QayiDt0i9hsLaRjfUkLqBdBnBbYEBkq_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5MCBTYWx0ZWRfX8TpiynFhs3NI
 iqFx4b0iDS8q8/nGGj+3j7hTcCWJtE8QXQNyip4v2suY6nbodwT+Pm2asTsKgiOs9mT7OfSR1NR
 zy4eY7QxzvQbVkhcL9c9mw3iJN3jh3E=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4e172e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KqGaXZP3fpkHBQvqf4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: QayiDt0i9hsLaRjfUkLqBdBnBbYEBkq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5MCBTYWx0ZWRfX9IMfPL/JrVd+
 Gxw3kqX1V7rYbCS7Uz5D2yKg9RQvGZFv1oplgU0NDQmz3tVV2H+tDHTSlOPe9rtm8a0vv76RzC0
 smtyoP7EkUxUeRT8zeJn0qcHkX/Zhax/qAeA7dGNlWc2xRC5j3QRUVC8gqbFYmrNw8s6N3228qf
 elwoLaejShscqmyIYEVogMRcfSxOZpo3UwgkrzYCWMdkd+ezsNS8c0zFGhsCPB0iVuhRAchifkk
 ni9aJ86WOW536wU9KSn7gn/XtojxsnD7pUD4/uz0yzmuE5jdevZSFaVrUXH1HiMVnejUVnsQRlT
 KDrDwpdt4ORrtaw2VKvdJy4ngp04OaEGbzzWCuMdH+jLRdsShNNSxni1IWJYyOBkFzLVKl0RDCp
 E877RoO1eOiwYKHlr9Ss67XEfp111rBs3m9jngf/paSrYbE8X9As2J1r0vvFJXuLKRffnftoxHN
 1pzo20EsdT8GtE6DFnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080090

Hi Mukesh,

On 08-07-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 7/8/2026 11:45 AM, Praveen Talari wrote:
>> The driver uses the shared gi2c->done completion for transfer, abort,
> shared => common completion event for transfer, abort and DMA reset
Sure.
>> and DMA reset operations. This allows unrelated completion events to
>> prematurely wake abort and reset waiters, leading to incorrect
>> synchronization.
> Aren't they in sequence i.e. one after another ?

If the IRQ is triggered late, it can impact the subsequent transfer 
because gi2c->done may be cleared before the delayed interrupt is handled.

>>
>> Introduce dedicated completions for abort, TX reset, and RX reset
>> operations, and signal them only from their respective interrupt
>> events. This removes the dependency on shared completion state and
>> eliminates the abort_done flag-based synchronization.
>>
>> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 54 
>> +++++++++++++++++++-------------------
>>   1 file changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 15403edb355a..9490aee4928c 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -113,7 +113,10 @@ struct geni_i2c_dev {
>>       int err;
>>       struct i2c_adapter adap;
>>       struct completion done;
>> +    struct completion abort_done;
>>       struct completion cancel_done;
>> +    struct completion tx_reset_done;
>> +    struct completion rx_reset_done;
> tx or rx, any one would be running. Not both right ?
> if so, i suggest to keep common dma_reset_done.

As explained above, there is a possibility that a delayed IRQ may occur 
while another reset operation is still in progress, potentially 
affecting the reset sequence.

Thanks,

Praveen Talari

>>       struct i2c_msg *cur;
>>       int cur_wr;
>>       int cur_rd;
>> @@ -127,7 +130,6 @@ struct geni_i2c_dev {
> [..]
>
