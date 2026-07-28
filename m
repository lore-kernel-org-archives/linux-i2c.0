Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93849420472
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233708; cv=none; b=WOe3zTu0PqOHGBflSIDEF7HLYDYEtdU/OBO5AtiUtqzX+8c4sqFzzK5M47ElphPxzTmrHBgWIDFt1fkhntQBk+z7Cq0/FWe0KZzK6kWrMZUoGadUg6wfP+zzK9xcuXLmwSBBt5XUcdf517RKGYt4xZ0r3sOsxbTwo7/Dl7PZk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233708; c=relaxed/simple;
	bh=MMmeuxILIP+TAdSL+HmgIqFdpj+gmOWW38hJ1+E4IBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StywLjvb6gJkSUkoiKSWNA70CXmZQd7LmWa1FaqdD5L6AG9QVnjQ7WeP0bdNzIgdaJSTafucUC2SFgT+6zfu8+azoMxRCYdv2YSxuOmDXgB4d/FEsot/PYpCqZ1S0iCR12WVWJd3CX73+btsHEhE1TM6RB+w23+KJVdM1YjRzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8y5Nkfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mi73dijC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8y5Nkfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mi73dijC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82Gw22144859
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 10:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0hLbfdy5mgjgFCzYatzKmlRtop8Ya/eJckf6yBTaIw=; b=C8y5Nkfp254qpf60
	4x3RqPMyxvx0inCaro3dT2qVZJEQqZcDbOG1/aLK75ptIBG0D6kuEIGRPFTMxbw+
	qs70Cp85rEZ2eFmgJM66XuyOkneca7pGinjbsDBfZEFNm3/58ew7OkFb1Z1v4tdf
	qIhJjmlZYc/MptbPLpXmV8Qd/igoSDokXrDS/s0bXdGTtis0wlEx/DZ8BEoABhrB
	fC38g9VRNWAHw9iPxKo75+ogsRriQooTS0qPzedYYvxOsn02JznoPxRPktb3T1gh
	N3DR7MUekdHAJY5FjWd4asX8ARiIJq0EgWbgODB+iqkxpUpuGujAy1Uw4UtB4Yv2
	iyUMAg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19henk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 10:15:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486ffba174so5930415b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785233704; x=1785838504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0hLbfdy5mgjgFCzYatzKmlRtop8Ya/eJckf6yBTaIw=;
        b=Mi73dijCbs81F7ueGvNNBe89ncPEidxPAHcoRYRrzg5bDW6OwzS8w3jK4Hg9ZFMfP5
         ggrA4i16eP6cwE++mnCwmne10CtBhq2OMorL6SSddpEyzbMfob2epUeXzJ/TYWZSjK9Z
         87kxDPDkCEjD1Mtjd1tTnMCf2pgCndJsOUjaqjQW4pmrEUY3XuAesU2Je1aZ2vi3k/uW
         sc6RB4KsRA3SEoEwKLQZjuzlVAG69cXEeWGV1N+yhWeqjwJgZDDMz9VPt7IVPb0ck8YI
         w5OlfLBduPZn3/kkjBeB/cc7T9IeWwt7c9d9CSOkt7SI51HwCNod7pFPiNg0Gy+k8dlv
         /u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785233704; x=1785838504;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0hLbfdy5mgjgFCzYatzKmlRtop8Ya/eJckf6yBTaIw=;
        b=nDfssH1lxEmKyRspAkuwGaY4chU2p5THhrH1h3pPRjXhJSBWxNRrwC9iips1OOF3fr
         srJGoLu+tQKskBA5BfVXzVxZ37RsdzNl31TR71z6DnnXWex1Q58n6dtY4ef/zAClP2Tr
         ibHMpbvmVpJMPG87TLepEne1lgf2AlOIjHnkpEacCrAGIpMwVEZnW/1qIyyD4tmUiQhU
         y98aXOHXuV25dnuSJShPv/GBPafERShPROnyNyRTKVWvEkA8GOUSkV/t8v5Hp2Pte1mW
         EqxnKSUZwl7RFdS2WRYRHnnEt4zHBSiBYCxKz4wcEwJ7LVofA7flQFNbaUgscdrZF2x3
         6Crg==
X-Forwarded-Encrypted: i=1; AHgh+RrzlDXUPUXsrPy711cEIXKajq6FoZ9014Og2vDVvHRbILCd5JT+PcEZKl/653kgYmmgoLNWINlUwfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwYnu2kza8WOqk/BaAUjQFXYwUtp3Vpj62klBl0CP2ZOTksqK
	WD2I+mm3dhnFtNNxiwfasEY39MK4y+LUnKi5NbGC+ATiSgsKwIBk8q3Q5IuIKpjuR1XIVI/Nw+9
	WIkvRKVQCrL/nd1Lb07K1G3IPepgfkqaOe3iRcKoiR0VQ5QbIcjh3kTE9Lmpj/oo=
X-Gm-Gg: AR+sD10BlCayWxomV+4M/bahsot/UWm2XRNB0uP4u3AQ/tbkQ3eUjmf4+luqQpum6pS
	YLvK/UPO2SjXKiPzJV/dDv8FUeRbxO/pvPRF3i+I7g+bxLEIWoXdfzmL37CA72W4MZZsy5eQMeZ
	R3O6vLoMhM25a5sbwhQYACeFOaK5gjWHkYpxwaquAudeA8oaCm1hNT2SSxdT7erWQVfz3zC5acA
	vDN3SOK68NSl2kXlmldlmmlQVlN07bY3pmwt3FHpFMA0OaOFg3gHNFznfAKs0oo9o1K+7KTXvjh
	i3FDHz5ECBIYQCUX2WaMBWpxvf0f8LjfrK9sTh1QZnsAGstbwExWmDi8cdl5nGYcgWBLuc+00yp
	WV1Fw5QVIWAQVL6krBM7lcRx76bvQSmtDYQ==
X-Received: by 2002:a05:6a00:10d0:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84e9325b4famr1835436b3a.25.1785233704089;
        Tue, 28 Jul 2026 03:15:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d0:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84e9325b4famr1835405b3a.25.1785233703606;
        Tue, 28 Jul 2026 03:15:03 -0700 (PDT)
Received: from [10.217.219.72] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532590bdsm4210071b3a.3.2026.07.28.03.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:15:02 -0700 (PDT)
Message-ID: <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 15:44:58 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
 <amh5l4Yvwemws6Cx@shikoro>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <amh5l4Yvwemws6Cx@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a688129 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=QebkMiaCAiKBxjCz028A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4OSBTYWx0ZWRfX2VjJNIlJeSN2
 2g/svOGlSnwDBicW6U9fXV9FpBvZtJb59K8vakAMQFJd/52m6j2jFx2Doaf0mudSw6lr7S1SVtU
 4nLFTusnxiBqBIbGSuVYoHlG3ZeLrliitRw0AFzIxJG6jgR1buJKk3tcLuzigKtuqU3NveHHk6X
 KxW+KbPXdB+5Y1YE/1WyIAnMRbQ9417UjTP/GU887fvDyKZXY2CgkBr6sBgVsMDVBTxB+Tg/HYH
 443hP8S8b9cIqh6JoVvbZ8BM+0RfQ113nxZV9TWQPa5MlvmI0UjgULv8HVp/Xpr2Cy+MSsT7aRn
 IAkkhNGVhAb+1NclwDx7lrYfDdf+mkDdeUlJCP37bLSBZ2fVDVGsZXK+MmgR4xIliFvn34dBJ6k
 cOQjWZib5g2lF/vd9DmHhVJXAluo3Zsl9J5/0/bdg1CeVf7lXP9uxRsSayBcoSheZS6+OajGSYV
 lwezRhm9Be10MwpKIkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4OSBTYWx0ZWRfX7oHaPjh5rYFa
 tYbDnExz0XONKhuXcx1FKPwrAgFm84Y4lGHk6izZuVU9fjqpiFgq6NjnkL1E4RadTqsUi7flpxV
 6RD8JoNpF8f8S6/J6fLza06CggYlMiU=
X-Proofpoint-GUID: yLYSUY2Aw6maT1lPJzdcAyzm_N03oi4b
X-Proofpoint-ORIG-GUID: yLYSUY2Aw6maT1lPJzdcAyzm_N03oi4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280089

Thanks a lot Wolfram !

On 7/28/2026 3:12 PM, Wolfram Sang wrote:
> Hi,
> 
>> My thinking was that we are trying to derive a timeout for transfer
>> completion, so the transfer length and bus frequency should already give
>> us the theoretical on-the-wire transfer time.
> 
> With my experience in all these years with I2C, this is exactly true. It
> is a _theoretical_ value, and the practical value is at least board(!)
> dependant. It may also depend on the environment in other cases. So, the
> theoretical value may supply a minimum but IMO this doesn't help.
> Because we want a precise value, but we don't know it.
> 
I agree that the precise timeout is platform dependent and cannot be 
derived exactly from the transfer parameters alone. My intention is not 
to determine the perfect value, but rather to provide a reasonable 
kernel-side default for cases where no timeout has been configured 
explicitly.

Since kernel-space clients have no generic mechanism to tune adapter 
timeouts on a per-system basis, deriving a baseline from the transfer 
length and bus frequency, combined with a conservative margin, seems 
preferable to relying solely on a fixed constant.

I am also suggesting let userspace add something on top of this if the 
core derived final timeout is not sufficient.

>> On top of that, we could add a fixed margin to account for interrupt and
>> system scheduling latency before converting the result to jiffies.
>>
>> The exact margin is open for discussion. I was considering something on
>> the order of a few hundred milliseconds (e.g. 500 ms), but perhaps that
>> is still too optimistic on some systems?
> 
> See, you simply cannot know. So, why not leaving it to those who do know
> for their system?
> 

This is an option for userspace. Should we expose device attributes for 
kernel space ? if no, then there has to be some calculated value with 
reasonable offset.

>> Alternatively, the core could provide a calculated baseline timeout
>> (transfer time + fixed margin) and allow userspace to add an optional
>> extra offset when needed. That way the default behavior remains automatic
>> and works for most clients, while systems with unusual latency
>> requirements can still increase the timeout without every userspace client
>> having to determine an appropriate value itself.
> 
> We already have a mechanism for userspace to set a timeout.
> 

Yes, and I fully support keeping I2C_TIMEOUT as the mechanism for 
userspace adjustment. What I am proposing is complementary rather than a 
replacement. The core could calculate a baseline timeout from the 
transfer characteristics and apply a conservative margin, while 
I2C_TIMEOUT would remain available for systems that require additional 
headroom beyond the default calculation.

>> Do you see cases where a transfer-time-based timeout with a generous
>> system-latency margin would still be insufficient?
> 
> Regressions. You could time out too early on boards which worked before.
> 

That is a valid concern. My assumption is that any calculated timeout 
would include a sufficiently conservative margin, based on measurements 
across a range of systems, so that existing working platforms would not 
regress. If a platform still requires significantly larger values due to 
exceptional latency characteristics, I would expect that requirement to 
be addressed through the existing timeout override mechanism rather than 
by forcing every client to use a large fixed timeout.

Looking further for common approach to be finalized considering both 
userspace, kernel space.

> Happy hacking,
> 
>     Wolfram
> 

