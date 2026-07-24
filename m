Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23D402B9E
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894175; cv=none; b=N9xdiz3tkpS2q7K4Z0uRPcTJUGHL3aOxzcPiE43s85ocT9PQubbE/vucWGTQtzaISuJ56s7MIoLlhiNfI+J/TBtd7eSwojXNN4tLlEHKjliCzflKDrDp6BCmZCzZ16nogUy9p2XzaTZq9eFGPqkUseeYMBDRjhQsacO6t4riIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894175; c=relaxed/simple;
	bh=z9lFTn32Qc43wkSOIQTlmrTywIBYvKWuzcjZ7S38Z98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0bO1OvGjijvydE1IEz/JJ2ZFFC/QQx4Qkk+KWQM+TfTtdnn+I/+Z5zsHsRaloGqdQe7OjJ44zI+PPRhGmF1DAsz+5YySOuzW/Ux7Ik4RR809UptoU6kWLMiMp6Q2akGMtj3YgI8fpTkN2WCDOb8Z+uku4DK0/3lOOdGSjupA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIysdfK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HU/dxerR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIysdfK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HU/dxerR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADnhD3032036
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4FZCLWX2ZlTuYRJjs7RINJ3Ro3/TskrzAG3MYdafhbU=; b=XIysdfK3kruzDMiB
	KljiOD6Lv5g2bJWfdDjv7P7wq2pRQFu8NgvpZNiDbeQlEjAkb8++Tw0BH0h9SziF
	YH6fmRRJZ41ZaWqrP6mZOEM2hb0J+EJ6VEnLZ8EXLo6kWRdgPIBFZ61jgXfpNLuX
	HQxjtv5QMiyeSGMj1td7TuAQGLRa0MWOqVVJdRX3/FANPvjJXeMp3rjku+G4cfkM
	fHf97TWcTl98XTw7srmLh2fdDF+A4hzQ444D5lhVM/GblZnpUMxoglcrRtbEak7G
	BLeOQQr2tvH+7aDe0fdFWDcYrXLD8lhs5XUrOx+JSYZ1g+KmanJcoI8wK4QgZI3l
	C/ORZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0bkyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:56:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dff6253so14481755ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784894171; x=1785498971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FZCLWX2ZlTuYRJjs7RINJ3Ro3/TskrzAG3MYdafhbU=;
        b=HU/dxerRVx440Tp7FGYDY2i+vmkr85ZVK8WbZtsDclb1VoJGd/l7JhkYkLxOcl+Non
         jyAAJNUlRyVuNFwAkpHwHKfyoNx/iFMS4nAWGkEfg+pnNWRYXQzhbq34CNS75sqPmj0P
         o1qD422dQ8KvM9y/k8TRRD89MO7v8de48Z1LQcTBkkJWSK0Nya8G1eQy5JJFDe9Iy/Wb
         /jYPZTXU9estAO2Sf8cdEGFHsBSI7zfDB40nysKoz/ap0gmCWu4priwP6qtUcB/gMl3p
         9qlPMkTplUY6vcOAoEJywkbKKiwyOG6Nc6o3GeqbknGzz8xnDqN31wSoVq+NVBTyDBXy
         V/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784894171; x=1785498971;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FZCLWX2ZlTuYRJjs7RINJ3Ro3/TskrzAG3MYdafhbU=;
        b=nQ/2dcaYCd+D2zgIzjOMXTiWgJKsYWg4YazXYe35E+k9OhgO4BKvVEhPfTeGCULJTi
         Zbjx/KX+wYVLobUVooLOiltUZcJ8GcwnDfZitR/cwJP0CPi3O086WA75kbTYWLbNK+uz
         egpRHwBKEeUz6rKqMWQ4d03MCXrqb8OF5e7SM+ZvOj4lYntHem+UwnL8CjM8jbaT97KR
         LEWcZflrEgbZ9LbFjyG61ejK1OynsxWnv4fdjOu2W0KvqzEmcnMnVOEgumSraWY+OwbP
         EyaGYsCHaNyDtPBCmmL9ipU+5FIluzandoBKSiUBtSbVwUjMKjQO9CZ0H3KHk2UUziNN
         yczQ==
X-Gm-Message-State: AOJu0YyeymNlzotEmPZQS8UUzQaxD5PewNDFUGAwb8GlxXFHxht3GpUE
	iNW23MdX3JOMIwNtLfhdan9DW0kv8S2YmlvkixcoRnrvJi6RZyHy5xWig4mWrzXrbSuMZIL/525
	HZRM6ujwTDMvhkvLqAlH5A2NXmkcDsTCsVd4foq+Dmw9UQYFvNMjBu/dZk7HUntg=
X-Gm-Gg: AR+sD110YM0cWsX0TdIA2/hE/SZRrmLOXKL80681VPoHrTpw2FEvdI8Wkx7XtO6/wQK
	7BAHr0xaODTzBZcObsk7I5bUW1ITNx3QMqpxHgdGoA//gl14bu6PsDKQJZtQ/9BGnV53L20nI7d
	7YS0u75lP0AxTg95CBX+JqrgEs0t4hRhPwG8FgHtzxQaN+h/fc2OxwNDLsKqBG/wyEQNzJ68BYd
	uur4J8wCq+BmXHQAj33UeKupyH7eTa5vsf1ivWmtq45T4gfgYl49/GHfov+l7EdKRziZCYJKzYa
	PMCaDuJqNqnLmi+YUxqRSq+YeChMrxPdWDXCgAX9qiemdx8IrSbiRrCEiKyheYJFQjNR+RuI1TN
	GCgIV7WQ2AFM6ce93G8pVS2QptRJBHRIt
X-Received: by 2002:a17:902:e810:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2cfd70df94amr2289305ad.7.1784894170657;
        Fri, 24 Jul 2026 04:56:10 -0700 (PDT)
X-Received: by 2002:a17:902:e810:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2cfd70df94amr2289115ad.7.1784894170214;
        Fri, 24 Jul 2026 04:56:10 -0700 (PDT)
Received: from [10.217.218.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa38c1sm51344745ad.8.2026.07.24.04.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 04:56:09 -0700 (PDT)
Message-ID: <23edc4b0-c5cc-4c54-91ed-a7bea945e680@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:26:06 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <e1e38c71-5f79-406e-821c-ce37904102ba@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <e1e38c71-5f79-406e-821c-ce37904102ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dJ2LEILroi0tYA1PF46jZTcafSGEOxwE
X-Proofpoint-GUID: dJ2LEILroi0tYA1PF46jZTcafSGEOxwE
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a6352db cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Y4WXMNEb7aBAyCZDk4MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwOCBTYWx0ZWRfX+/tq6aHOJ2xG
 oZ+XDNHo2sv+wV1YirSDILyynwZ0EQxqJEF9YQrdl80aWXlJ2D0vTuOXx8n40y3ouc4RoWik79a
 Ujz1Au2GNKn1+XSt1WDmNPZm8TRCOi5y2kYoP7WN+PgI3dOsUd2/pNvIhR2hq30MFCtnA8vifsc
 A+f0XRPTcUL7bdNxqD81KkN3l+RUxjWq1H1bSLMWppz7r+lW/OH0cAy9a3Kv2RVHh2u02JrWwLp
 qImME+CRDO7Ohi7oQkFTLPocw3NJKdsZq7Q+OyMW8ouuoUwLeAZmeB551ipm5aMvNtjM1lUdUDG
 bT9ruTa2xjDd/OJqoglPvuXQkMKsegShZrxlX13dAHqHM/s/AbHKHtjo9bzpIMVuNGI8jDOtgEi
 fggV0C4QHOXdKYIatSeRYTN5sxgJSkZU84MqxLUaJh7TrBiYKaaiXw6nFCbtQR7KrWiSW53YUps
 xroZbL+6Qt+ske9sB1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwOCBTYWx0ZWRfX7Y+op4Cn4B8s
 x7TT3ZI/JewmcqIWBuRStPsokl1rBlQrTMkt9+H6Ka7S/YyYpWs9oL4H+TNBgnXfUrH0fKgx+g6
 hisDzwmtOVpm0gr/CptyU0n8cSH5fa0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240108



On 7/22/2026 10:55 AM, Mukesh Savaliya wrote:
> 
> 
> On 7/20/2026 5:11 PM, Aniket Randive wrote:
>> The I2C core and most controller drivers use a static 1-second timeout
>> for all transfers regardless of message length or bus frequency.  This
>> causes unnecessarily long delays on error paths for short transfers, and
>> may be tight for very long transfers at low bus frequencies.
>>
> OR can be more than 1 sec for big transfer at low frequency. Hence 
> better to make it generic saying depends on data length and frequency 
> which you have mentioned. So limit it that.
>> This series introduces a generic helper in i2c-core that computes a
> generic helper function

I will update the comment.

Thanks,
Aniket

>> transfer-specific timeout and stores it in the standard adap->timeout
>> field, making the dynamic value visible to the core retry loop in
>> __i2c_transfer() as well as to the driver's own wait sites.
>>
>> The helper accepts a safety coefficient and a minimum floor as parameters
> what's the policy to accept ? i think should explain here.
> read from dtsi or hard coded ?

Agreed.
The policy is still being discussed (hard-coded vs driver-supplied vs DT 
based values). Once we converge on an approach with the other reviewers 
and maintainers, I'll update the commit message to reflect the final 
decision and rationale.

Thanks,
Aniket

>> so each driver retains control over its own timing policy without those
>> values becoming public API.
>>
>> The second patch converts the Qualcomm GENI I2C controller to use this
>> helper.  The 10x safety margin over the theoretical wire time and the
>> 300ms minimum floor (to budget for clock stretching) remain private to
>> the qcom-geni driver.
> geni i2c driver

I will update the comment.

Thanks,
Aniket

>>
>> Changes in v6:
>> - Split into two patches: core helper + driver consumer
>> - Moved timeout calculation to i2c-core as i2c_update_timeout(), which
>>    writes directly into adap->timeout so all consumers of that field
>>    (including the __i2c_transfer() retry loop) benefit automatically
> please Add suggested-by: dmitry guzman < >
> Also add reviewer into to/cc list specifically.

I will add the tag in next patch.

Thanks,
Aniket

>> - Driver supplies safety coefficient and minimum floor as parameters,
>>    keeping I2C_TIMEOUT_SAFETY_COEFFICIENT and I2C_TIMEOUT_MIN_USEC
>>    internal to i2c-qcom-geni.c
>> - Compute timeout once per batch in geni_i2c_xfer() using max message
>>    length, all internal wait sites read adap->timeout directly
>>
>> Link: https://lore.kernel.org/r/20260715101805.3615166-1- 
>> aniket.randive@oss.qualcomm.com
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
> 
> [...]
>>
> 

