Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6A401A3B
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757993; cv=none; b=m3SYBoFntpGN6M/5o7ZZBwqVZ1UggooiwJ9SPjx5W5/mFQohHxnYVaTCxv6w5VG2l5tPIR+TeTRoDkbKw3grNj6GuxSUOKR5IfaS6lw2w0QAyjiHZxlnx0UOh+rnl/6x/zk9kX+sZVfipZVTchw0GbbN9UDzItqN92c48fljXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757993; c=relaxed/simple;
	bh=QPMfb7PH/FW/3fQxDmXCxGhBEzh8VvZFJy2z3YTvdFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuAe2ogfogj4BbjP3pDIi3NgnwY1PLAoApwrPEXFrW0Fnv0AMj41OABSLx4qeJ1jKxTQHln4pSLhZyy3N4WEFCLPnvQCmZpZY+Y7uyWsXiK0IXKTw+ouWrlxRcA5meVLdmV0aAGcrBY1Bh06yoBRzcO8hYJkEKtqrem/7kQgzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7iL76D+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UESNo0K3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7iL76D+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UESNo0K3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673B6D3A3956941
	for <linux-i2c@vger.kernel.org>; Mon, 3 Aug 2026 11:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ANbJ35W2w7wHbP80PHRITYp2hrjcSU+XMTRXmCym8Iw=; b=f7iL76D+hAYHAl7V
	AW0CBa0F6bQ4TqvRP/BpFeSj8BhEaQq1oFwc9DZp0MGlUOatN/9B1fFMqaeI3tE7
	BN0K0BzpwzCkjIc6bZV+kLf6J+ZGgKCXkzhcsT3AWJ77JMRwx8P0kyuf/spgDc7D
	mJcGGabt5wItyYd71rPQ1ZEUxHnjenLT7bsNhfz9Upt90igWRe4oRisKT+Hfi9jT
	3bk9UZ5zvXx7qgjkUoREhgYzcbkhri3JwYTmtdTzSGF8VA+lIBSo2u9holIVaO8c
	p81mBHXQphzSu/5he5b0cpkgFGQDqCETJK8mImZLdlRJiWv0kDd/OIovud2qPUlk
	mRWV1Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvnhb1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 11:53:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38fcaa5f82cso1638702a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785757988; x=1786362788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANbJ35W2w7wHbP80PHRITYp2hrjcSU+XMTRXmCym8Iw=;
        b=UESNo0K31N+ACHGoiGrf9ww/DDmqRStN6rNTw8lWTb5x4zVIha2XCscYc7pLzYMgsn
         w7e7UIZ10ezpnXQEcoGVbGWIUDWtSbKe3g82BR3GzTF5OF+/ShCkJkKL1RFJk7zFMgQJ
         9w75v1HzDCCGpINz6hRU782eRUgv0Sl54ggPXt6ZX64fgvl+RvKyw4vV0+kfsB2XPYAP
         HU6NrzQsy0Fkc/iQieq64TsNTqT8Z89tHgZzUseBMQSkCXyKMa3n15L4oKHs+CBo/rTl
         r3WFQsqMsETrcOfe9Xv57qqxECNFG2ZBH7/78fQTZwkva9owsUHZ0t78CMwF9FVilHwB
         Zp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757988; x=1786362788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANbJ35W2w7wHbP80PHRITYp2hrjcSU+XMTRXmCym8Iw=;
        b=nGMnpSjTxZ+SrrQ4BSDSgJ6LQR7Zuxdeii3N93mgTzoD0To1lsE9jiDfK2cCf7Vu+Q
         fL0z0jHx0rnLcsZLknD+fNxJ9qYbqWOLHCqvRmCd2IoNmkz2TUfE9NHp0UhCShO36pzh
         fWxc11qqSe1lSV+6a4Xi9MELp9DnFpL6KYwWYvASofZma6C7m1FPbhMPRbQE7fJUZHn4
         ejM8FN8mxHvJrRRDUscg70jeESx4uPF5PygSIknSXzURW/abxkXAUdu9QDxhPb8stqWe
         eZCOAzwQ7mbPdZcikBDpvfRoV8Z0/0i6kE3nc2XH8cmtcCf+kA6YQQBDLToZ9PrGl8IR
         e7FQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVxmlcn/zSo/Co2yY6iXmSXrPxnvPQOM4MWWy8mCFmlHAJD2nc9s2BXTR9E/UjnIcYAt+Z70BMXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LJAkAY/S231MtpmSnSXldsHYG+omqdnHIRVaK8KAX6Mwh4vY
	GlSmhMJg42c5Tsfa0t+YRB2KYSRfPO8OmexgFYxH2nND050QR0m1C3sP2Pf5BA/cBjskI0KAsvH
	XIjz+tbA0CNjnD38tbqUUiLePFMD4AazDvqN3Nx2LoSN2axlDiNQjimhLgK1QLGc=
X-Gm-Gg: AR+sD123Wjf9uv2yxsld7ntAPfaa1a+5L4ZScyi5DasowGVLfRnQT56pfFqx22ubI8w
	apPlD065QmIUnAjFw9w/kHIeEXf5ka7B8VAKgq7w0DXpNWu5AJ8g1s2qog2AGeX/RxnvvPG+7Rz
	40WHpr8/XcYvmNkC/40Ou3fLVnlBJIH1FX/u4PwyJbeuzlGAFiCw9dW8yfkHcPm0v0519xeoMKw
	G5qu0OvScz4iQD5YQ/SLaZH5AGlkX9ZyKgOD2aUIsfeG4zTRk1IpaK+L1Gy0A4U11FYAJUs6vc1
	yKk8Yrj9E483FvDT+2TlFkm9QbLt4y/XCaM3a1HABabp7FRx6Qvj2kHkr3B84WJ4x4JXMq55i9E
	3dRoF+uIFmx+JHDi4qnm6rSrYhl2yks73Qqd8w8L9SsInTZc1m9h9ncUzqJpnbcITENz0eDgmuQ
	==
X-Received: by 2002:a17:90b:3907:b0:38e:584f:2515 with SMTP id 98e67ed59e1d1-38fbc58dfc0mr9241448a91.37.1785757988497;
        Mon, 03 Aug 2026 04:53:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3907:b0:38e:584f:2515 with SMTP id 98e67ed59e1d1-38fbc58dfc0mr9241426a91.37.1785757987987;
        Mon, 03 Aug 2026 04:53:07 -0700 (PDT)
Received: from ?IPV6:2401:4900:35ff:d6c2:a5e8:b0b6:83b9:a3fe? ([2401:4900:35ff:d6c2:a5e8:b0b6:83b9:a3fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b999cdsm2008994a91.3.2026.08.03.04.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:53:07 -0700 (PDT)
Message-ID: <9dcc47cd-2470-45b2-9106-51d4636cf60e@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 17:22:59 +0530
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
 <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
 <amoaEGX8Q4zwHF2i@shikoro>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <amoaEGX8Q4zwHF2i@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a708125 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=dTr6nt17rhk5w4SCxJcA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: NCgq_J3Ce-SMA6S7bY4bOvOhRj4KFBKW
X-Proofpoint-ORIG-GUID: NCgq_J3Ce-SMA6S7bY4bOvOhRj4KFBKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNiBTYWx0ZWRfX1YbytJHNtUER
 7oEgOo6PR/l1Lq7YJnSLVzSvusb1iZlnVXUysB/4K4bcjz42PqpBNDeWu9ZY1tqCvmbNQIw7ns9
 ndEjm84OG/jhLKYgkCMOrZIPZTIJ06bANl05RipJKYo7pUJJbqCtMkR6AcCDVP4om08gRzWv0cG
 +ByU0X3uRVA4rvPNct02W25Hsk2YV2rXxbtH64bX7R98hGGDmkwoWpeADJSdF04ckbmmQMSUTBk
 Jxfr7kDUwLSinQ3GzQBBCwAZTkdVSF2sdVZHD2hdFEohk6QifnFll7Zpsx1Q7L4lfxyq+juce8c
 MAabHTgK/kyZNiYuQFZvh/DOKJrtF5KqQ2P0ydUZ/KVCfR/C6Ndmf5/1r2FlF5XQ32kguUxghUP
 bHBfSPOs4tcbE5BGaZueBNIsjZF22dtc09pQIw/yu7MfAiic84gvIdBDgTDuSKlVlghY6fVxLne
 5lh4VkP1HRefTpN0wDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNiBTYWx0ZWRfX9ODaulA2SMRm
 jtnL4H47OrDc7mEuGz/ygCu/WG2d8e164xC90PIKYYAcS4MpAu1GLlGz5Nm0bB1IcqUKTv3Cnvc
 70sdkpC0tWmGnA9i8rQ6uLc5N8Mrh0c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030106



On 7/29/2026 8:49 PM, Wolfram Sang wrote:
> Hi,
> 
>> I agree that the precise timeout is platform dependent and cannot be derived
>> exactly from the transfer parameters alone. My intention is not to determine
>> the perfect value, but rather to provide a reasonable kernel-side default
>> for cases where no timeout has been configured explicitly.
> 
> We have that already. From the I2C core:
> 
> 1572         /* Set default timeout to 1 second if not already set */
> 1573         if (adap->timeout == 0)
> 1574                 adap->timeout = HZ;
> 
> This may not meet your definition of 'reasonable', though, I understand
> that. But you need to be aware that you immediately enter
> regression-area if you change this behaviour.
> 
Yes, 1HZ it's not reasonable for smaller transfers. Agree too that 
changing this may cause regression to few others.

>> Since kernel-space clients have no generic mechanism to tune adapter
>> timeouts on a per-system basis, deriving a baseline from the transfer length
> 
> This would be easy to add. We could introduce
> i2c_client_request_timeout_margin(client, desired_timeout) or something alike
> with basically doing:
> 
>    client->adapter->timeout = max(client->adapter->timeout, desired_timeout);
> 
> Or? Then we would get the theoretical value of a client. Which is maybe
> exceeded by the board specific timeout set by the board designer. It
> gets tricky, though, with userspace. Who has precedence then?
> 

Thinking to give precedence to user space here in such case. if no 
userspace setting timeout, then default will continue with core set timeout.

>> I am also suggesting let userspace add something on top of this if the core
>> derived final timeout is not sufficient.
> 
> Why can't userspace set an absolute value like now?
> 

So, does it mean user space can override kernel/core calculated timeout 
? if yes, i agree to this idea.

>>
>> This is an option for userspace. Should we expose device attributes for
>> kernel space ?
> 
> See above. adap->timeout is easily accessible.
> 
>> Yes, and I fully support keeping I2C_TIMEOUT as the mechanism for userspace
>> adjustment. What I am proposing is complementary rather than a replacement.
>> The core could calculate a baseline timeout from the transfer
>> characteristics and apply a conservative margin, while I2C_TIMEOUT would
>> remain available for systems that require additional headroom beyond the
>> default calculation.
> 
> If you have two ways of setting a timeout, people might get confused.
> 

In that case, let's decide if userspace configured timeout wins. If not 
set by user, then set calculated timeout by core layer.

I was thinking, user space may not always set the timeout but core layer 
will always need some timeout value based on formulae aniket has kept.

>>>> Do you see cases where a transfer-time-based timeout with a generous
>>>> system-latency margin would still be insufficient?
>>>
>>> Regressions. You could time out too early on boards which worked before.
>>
>> That is a valid concern. My assumption is that any calculated timeout would
>> include a sufficiently conservative margin, based on measurements across a
>> range of systems, so that existing working platforms would not regress.
> 
> You simply cannot guarantee this.
> 

Understood now, it may cause regression.

>> platform still requires significantly larger values due to exceptional
>> latency characteristics, I would expect that requirement to be addressed
>> through the existing timeout override mechanism rather than by forcing every
>> client to use a large fixed timeout.
> 
> The only way to deal with this is 'opt_in', not 'opt_out'. If you want
> to provide different defaults than the existing ones, I think you should
> make this available via a kernel config option, so somebody has to make
> an active decision "I want that and I know it can regress".
> 
> I am still not convinced this is all worth the hazzle, but let's keep
> discussing...
> 

This looks like a reasonable compromise to discuss and converge on. A 
polished version:

1. Userspace-configured timeout takes precedence over any timeout 
configured by the kernel.
2. When userspace does not configure a timeout, the kernel-computed 
timeout is used.
3. To avoid regressions, introduce a Kconfig option for formula-based 
timeout calculation:
	A. If the Kconfig option is enabled, derive the timeout using
            the proposed formula-based approach.
	B. If the Kconfig option is disabled, retain the existing
            default timeout behavior (currently 1 second) to preserve
            backward compatibility.


> Happy hacking,
> 
>     Wolfram
> 

