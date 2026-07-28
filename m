Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99138E5E9
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214623; cv=none; b=Z1ZF5b/VNYhUzfQKt+gCXNftWXPAyvEC2YUCEcy59zxDG70HFoXDilDMx6gOuvfz0kGFw680x/4S8NzhpSV02BrlsftY6nBq6WsldaFQJfmodCraSxbEiNFYSr486smNT4K3eJ5OvqsFgkkuc9N0sdts/7YxajpikE6bOkRs/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214623; c=relaxed/simple;
	bh=hOizCD2I6BSt33P6V69HLMaGu7nCr9thzDudHGWN4es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+bor9yM6Ev+6Q6jqwKDySMHqCgMcbk09ZSSwpxop0uOcjnQgBgY/DZnhtXii9DFutDEtGtmYXtPaty8ZvMc4JCHC7W0Tnnt7nvyvH0EYM5qP/g5OHqLR0AGj3Z2kejV+iqNIClHXdOQrdYr9GWPkTcrxp7IJWt5PuPDNGRPFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mF7IchNz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EGDudPIE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mF7IchNz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGDudPIE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3aXuQ1467095
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 04:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qw7DVRkEEx03oALxXwFUYY32n4E2OOmQdIvTxIEA50s=; b=mF7IchNzUxnpeVVE
	CV3BLuUq58hYR04MpybciSLhDQ7Rm7YdSucWiIRyknCXTNztAHS8Ad8N7VfUZeFN
	cgX4p5sSCp1noY1Qpp2ppcwx6h4HVCxN/YjQ9uid8x2pd+qp3VOv62bfmfLCL5hv
	Pm7YsssKIQ1V9WZ/5iHm2Me0cSYbGBz6WebUnVZuSa/Vj7PcNL97mdPYvbDrd4RE
	GZU++r6DNVZGMr247EGNRwQ4ZQkkQN1PRtkoq5yRFupQO5YO+NgCBPk1/qu2kXen
	ngbtOQ1NbvSt7oXKddCLmp2sZVIkwfQXb9cOSLFkMLuixN2uelV+XCrXWVl57232
	2eojww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbvjdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 04:57:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacf17c7e0so48743685ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785214620; x=1785819420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qw7DVRkEEx03oALxXwFUYY32n4E2OOmQdIvTxIEA50s=;
        b=EGDudPIEGl+iIETjx/8XM0vsjerpW6HTgDmRx/E1H5VyMh5dZtgKgg/PT41BFu5MES
         401zjwcs6/zgNO0HAHycklgdmWJ/x0Go6jfCC04mory11iHOsevz8q3of+mtCUNf/oCi
         6cvFhb0KFGcWy+oSqEZOifnwqlik7Oul6K9KdaltqhcxN5OE8uFtR9OKpds1woFNC2Hc
         JA/ycrQxVPnm6XkFsidv+VdiOia1K0T7nHzH7GTGny5YkV0aIf5uagQXd/UkNFO9BC3+
         0KBcqagrL51MMBJX8XGCHJ7ycvrAlquqGjz3IkVFHrDc+wN1Dq2ySXnRtInHEDddR/P4
         DSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785214620; x=1785819420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qw7DVRkEEx03oALxXwFUYY32n4E2OOmQdIvTxIEA50s=;
        b=VLwwUM0/FUZGyP1fGkCs3Q2o6FNmgyvCBSzqUZLk7jR1HzzpjpdZD/6s7g5G5bZ+SR
         uqrvhec/LXnvc3nIyT9Zv8GMbOcnhBBQNkZQPn98qTz8oaEF1sLfhig+y389f4cv0vrc
         GpP8e59Gcl6s4lhgo1jKyPjaR1Wy3xTpXSnoKvBsRgaQoUHcL8wMeyIC9eMdp20AVjn2
         zwOM1nrmA5AlfHDSWHWYZIs7AQqSK0oR/X2QDKe+mWcHivLGTjHQcceUcEogea7eYPAb
         pFH016Qz+V2ToZYBSL/MaFI5I4hnnnETGp0FJy4yWzOdCN8+rIr9PTqremkSBO7KO4tm
         mPsw==
X-Forwarded-Encrypted: i=1; AHgh+RpLmlMkzLp3EeF0waMl9Y92ccHsXTDn949SlawfF7Fujo9AKRnzDZUn6gtaigab7Oi2GqqntgN8DX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDmv7Bv0wV2/pP+e8sR/GKdedsSZDHos8UkbUpcnKjvtzj8XK
	1Cqj3Etm4sByT2Jn6FeU17O3UyplceaspQzKp26N9rTAI26+uaBcIR7eHTBrNoxb81SS+4KOQpL
	dutNBtv2MuZUErf7Q7nOJqFtRWMbqXn5kTQ4EHbpHA6cTY4txZ6zHc+KyXT47WEwj+8seKsA=
X-Gm-Gg: AR+sD13DEHZ+7kvTPEisui88CFQfqp90pKPxErToIabDuo1VDRA0bApDTRsFY01dEwx
	Qdxs3cgzsupuOy9dFXEROZd3FK7cd4+/j3EIM3X3OpUxhDxakNEPSGzz9URkeEv3c32816zy3LG
	nmfEQYLOcBn7QaldEBIs8M2JvuP41kI29LLTTSKX3FeTFXO1IntZRjkjeazA/lUsrFu42jIdSF8
	cYJefUxf76XpoQ/ovyauPr8Tl8zO+ncFweNrdyQdMpxAuNMp1OHK6W1jhG5P6WKXqBY4gY+Tp3r
	aL1BrQIlw+z2/8XoNpKORvcH0Ti5N7LBd5K/Z+F/OQO00UQToIG+1+olNKV2LsGtwaMZxzmPqsu
	LYPu2g8Sk6FeYsvokSG74/OH+xQb3oYk7mQ==
X-Received: by 2002:a05:6a21:1645:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3c8aafb4adbmr1134445637.7.1785214620564;
        Mon, 27 Jul 2026 21:57:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:1645:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3c8aafb4adbmr1134423637.7.1785214620119;
        Mon, 27 Jul 2026 21:57:00 -0700 (PDT)
Received: from [10.217.219.72] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66ca388sm4050781a12.28.2026.07.27.21.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 21:56:59 -0700 (PDT)
Message-ID: <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:26:55 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c6wKefhie-AnyYAwK3Zvi324dUwI4IB1
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a68369d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VvBNldowPlQVTM_YT94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX8VSo4K3+PDUa
 PlC5P06cX1Eafu2cYhagD2GEfvSjY3LnaFJv0LXOkDj04oFyj3OEpaX+yvMgW5oVrcJPLnevgSH
 pkXZqLLQED3aj/dcAa35c2yQbwnSkUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX+V9wR3KKyI2A
 7MmtJzXbRd8z5oNu/1EgQiyc6aehFVg+JvkVx8WRI7DFA2BcSTxO+Z9TicNvDD/6Wc3/9cGmdDH
 1SkUqhltWjVMpHuOIbe7NJazv3AKARB4nGj1wnNW01fzIw7kRvt3hk+qXi/XIShDek6GUSYrlvV
 xppjITcXxhxhskvNhbjy4eqdOaMRahTTtewFWU8dEzzFL4coZAmA4GyP6XIZSjCD+AbSU/CZ4KN
 oflb7V/xPmfGFK3PmUYAzLOtuWXJ0x3aFyLRnvmzgZUKfSwVkByxEcFkCWR495BwQ1PUw7R8HET
 8cdvj8ciz4YqIl5jfrgacxInZblD3mab3Fo0hD+5TEXgPAM0JhAo5786dKcRMdsuNZMx/wk3IwY
 gTe6GbATBX099OAW3UTTqH4Mg8WDNHxFiciMFIDsgyOuDlEhAeXgH4z0W+yxpuj39+t+kFd8Wbb
 sMWqGCPPeJBtVrVZYiw==
X-Proofpoint-GUID: c6wKefhie-AnyYAwK3Zvi324dUwI4IB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280043

Thanks Andi !

On 7/28/2026 2:12 AM, Andi Shyti wrote:
> Hi Mukesh,
> 
> thanks for the nice discussion!
> 
> On Mon, Jul 27, 2026 at 09:45:23AM +0530, Mukesh Savaliya wrote:
>> On 7/27/2026 1:41 AM, Andi Shyti wrote:
>>> On Mon, Jul 20, 2026 at 05:11:19PM +0530, Aniket Randive wrote:
>>>> The transfer timeout for an I2C controller should reflect the actual
>>>> message length and bus frequency rather than a static 1-second value.
>>>> A static timeout causes unnecessary delays on error paths for short
>>>> messages, and may be insufficient for very long transfers.
>>>>
>>>> Add i2c_update_timeout() to i2c-core which computes a transfer-specific
>>>> timeout and stores it directly in the standard adap->timeout field.  The
>>>> formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
>>>> bus frequency.  The caller supplies a safety multiplier and a minimum
>>>> floor so that each driver retains full control over its timing policy
>>>> without those values becoming public API.
>>>>
>>>> Storing the result in adap->timeout makes it visible to all consumers of
>>>> that field, including the arbitration-loss retry loop in __i2c_transfer().
>>>
>>> this patch does not take into account a timeout set by userspace
>>> through the I2C_TIMEOUT ioctl. That value would be silently
>>> overwritten by the driver.
>>>
>>
>> Can we make timeout handling a kernel responsibility and avoid placing this
>> burden on userspace ? Every userspace client already accesses the bus
>> through the adapter/core layer, so the kernel has full visibility into
>> factors such as bus frequency, transfer size, and controller characteristics
>> to compute a sensible default timeout.
>>
>> Also, if both a userspace provided timeout and a kernel-calculated timeout
>> are specified, which one should win? Having two independent timeout
>> mechanisms could easily lead to ambiguity and inconsistent behavior.
> 
> There is no explicit policy for this today, and I am not against
> a driver selecting a timeout according to its own requirements.
> 
> However, once userspace explicitly sets I2C_TIMEOUT, I would
> expect that value to take precedence. Otherwise, the ioctl
> succeeds but the value can later be silently overwritten by
> the driver.
> 
>>>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>>>
>>> ...
>>>
>>>> +/**
>>
>> [...]
>>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
>>>
>>> I'm wondering whether changing the adapter timeout from the I2C
>>> core is the right approach.
>>>
>>> Perhaps i2c_update_timeout() could return the calculated value
>>> instead, but then  do not see much value in exposing such a small
>>> calculation through the I2C core.
>>>
>>> I know you were advised to move this into the core, but it does
>>> not seem particularly useful there and, as it stands, it looks
>>> somewhat controversial.
>>>
>>> Unless there is another good reason for keeping it in the core,
>>> I would drop this helper and keep the calculation in the driver.
>>>
>>
>> There may not always be a userspace application available to configure the
>> timeout.
> 

Agree.

> That is fine. I do not expect userspace to configure the timeout
> during normal operation. The ioctl is mostly useful for
> debugging
> 
> The driver can still provide its own default when userspace has
> not selected one.
> 

yes, agree.

>> My suggestion was that the I²C core could derive the timeout based on the
>> bus frequency, transfer length, and a reasonable safety margin. This would
>> provide a generic solution that works across all clients without requiring
>> userspace involvement.
> 
> Is there a standard formula which works for every I2C controller?
> 

My thinking was that we are trying to derive a timeout for transfer 
completion, so the transfer length and bus frequency should already give
us the theoretical on-the-wire transfer time.

For example, the transfer time could be estimated from the number of its 
transferred, including protocol overhead, and then converted into a 
timeout value:

bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);

On top of that, we could add a fixed margin to account for interrupt and
system scheduling latency before converting the result to jiffies.

The exact margin is open for discussion. I was considering something on
the order of a few hundred milliseconds (e.g. 500 ms), but perhaps that
is still too optimistic on some systems?

Alternatively, the core could provide a calculated baseline timeout
(transfer time + fixed margin) and allow userspace to add an optional
extra offset when needed. That way the default behavior remains 
automatic and works for most clients, while systems with unusual latency
requirements can still increase the timeout without every userspace 
client having to determine an appropriate value itself.

Do you see cases where a transfer-time-based timeout with a generous
system-latency margin would still be insufficient?

> The timeout may depend on controller specific behaviour, hardware
> limitations, clock stretching, FIFO handling and whether the
> driver uses interrupts or polling. A calculation based only on
> the transfer length and bus frequency does not seem generic
> enough to cover all of that.
> 
>> To account for variations in system load, we could optionally expose a DT
>> property for an offset or scaling coefficient to tune the computed timeout.
>> Even with such tuning, I believe this approach would be significantly better
>> than the current fixed 1-second (HZ) timeout.
> 
> I do not think a safety margin or scaling coefficient belongs in
> devicetree. Devicetree should describe the hardware, not a
> software timeout policy.
> 
> If a controller has a real hardware timeout parameter, that can
> be described by the DT. Otherwise, I think the timeout policy
> should remain in the driver.
> 

Fully agree, this DT property option is not valid unless its controller 
implemented.

> Thanks,
> Andi
> 
>>> Thanks,
>>> Andi
>>>
>>>> +
>>

