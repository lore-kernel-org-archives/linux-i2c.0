Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE337CD4F
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358617; cv=none; b=Aswlks4GOVwN4La55bq+i2BdoCIriCcDs+ToR5SoRURVNEUwm4cox9g98SZaVycj6V8ZuZdaVGA5tUN8wsn9N4vSl1UFkLmRFrGZ0wJgTr01ByMnM413Omme1hamN9g58Sie+BGl8KyikKMCR2yGAUw3VvAUma7H9ttQJPsdt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358617; c=relaxed/simple;
	bh=Z3KAG24ikGctN8+3JXxzF/QjpEQrkx80Kwtm6MVN8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRzwGqar5BzvbyCXwT43naXLFyrX1t1GEDfOnvIdyhnfi9Zgv5aLA/5k93BND7Fn71TIp6LnI/MZfpRr6zB9GYtBPtrPnWAsLafI58IjCJ844Iu0CXIWuFfKEhehP0CtQHl7kqPaT3sAiQqIYW8UY6FfJARTndOxkQnfwCD6RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2KqCiRr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwIjVE/y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2KqCiRr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwIjVE/y"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99nFN3009513
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 10:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=; b=n2KqCiRrOQrxLNGF
	XgBkFgRwHC2u1RPF5a/auykres/jpwRgCdtJtROt6BASxFvKYL+Qfhju5Dz6F6mF
	G+hfxCHv85g3xPYMaJxNlfXoH284Ofwj0oylvJc4GpMK42w4Ykbi3bMFumP3dGVn
	Of3qQ/AuuJXJ24iKJ65BPO3IerbeKQ8W6XZEqt0Y4INWvvdUnzOxXDCSS5NQP9yU
	YQ1/YFvSg+qAsf+bIwNfhsp+QmbuH/pux4UglorAuGH+3KDIOePVZTWhcKI3rWkU
	Bgd5ipAhxEfTGDhgXs+/b86rAa6+H9YyBoLagFfCMGxmomgpsus3+zWqvMYiQ/zc
	cpABdQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr31nqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 10:16:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f9429f49cso8978018b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779358614; x=1779963414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=;
        b=TwIjVE/yZ9Fp+wDulH6B+hWohwEtI6luF53CsaofwIZMWhNc9Ff7bB0Wh1ts+xk5ug
         11kcFURop8LgtLM62/KCkkP2+OR48NgC4/7EZ3mI0Hhji+p3mncfbBqHT0yJjPAfkaWP
         gE4fPD7jJq+uU8n0imS8n8pJZ5IX7YEQuM6Vz9Jl5XvW1NZupkFSXGwnBujMBsQ4bZSk
         cHWtsgbDpUjPa7KDHCGX/QsntwS0H+tFTeoWCJowafiifROitrJkqSDsUQ07JHEpm1rP
         LZOvX8W331tvhX3lTkOL8SKeFSewCcqeXSElWCEOtTgl+SwWzvmdF63UiXIJmTI4MltU
         sMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358614; x=1779963414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e35ASpDbu+JzlJXy6vzQPsFHJsqGdEATPmzNaYDOTrk=;
        b=KifbcB31PrL7kAsK/NTeuAGjUl6quPBRDbOgjhNNS9iffqk5ptLl8+Pyyo8zCudEJ4
         ynPquLxaPAviUB9ttXWaDP/d+XBw38JHyuIfMOaMF0teF+LAemERfALg7Mj8f0mrw8Ag
         dHHFUxjXSZvVUZN2+w+QExjpcVWcmMbxsFDCUo3WITkVq15JJhVkzKdLoULbjyP2bZ/9
         MU9WjL0tT2G7W9Kw/ZYb8NFeomygrZI8osa40HAq8udEYqlOMvhYMBL/HBO56OZkFsRV
         DNoL1ChUutzBFc3cPQlNZIjqY+SogrpnYDFTdTmSZt00eD2zy1xDReh+qfgiTC74R2hg
         5+/A==
X-Gm-Message-State: AOJu0YwaDolafy4OFN4NYOHgi7J4QhJtIhO/ijX5hesosBktLXnSPkHx
	VpVFNZqa2996nm6JRcCFA6OXPsvCB3j6CynGan6k/QN7OvbdEUYhZ7qq4WigbPPUDCdbSYeDH05
	aP9rvKMUJmQdXIOl0CzAivhPVe7TOILne+UqaqYP/nX8WaP84DjnnJppQtZSNs2s=
X-Gm-Gg: Acq92OFDayE4/SjNSD/r6EBPZ/IqTrD808igM0q1gRRcjthxzpDVpXVoPLHMS3V75+H
	GLopXfDBuYQNTRhFnDnhgGpIo3S7E7K2dFboM9ummmc/f6NTJz4ZIrud6GiCeJiBYI0vchfI8Th
	oDRvEebRDU/IKSRFRuiSQox5pLv/+7Q2x4zZmysiS/GmdhxaqwRhpyjE6zG5LVTIVdmITlz8G0/
	pguFy3zTu2SA00GVwLHuHYyGEoTXdcs9ndTE0vELJ0QssqEHyPo5MAEBT6LZ3udF3Sd50CRrdgs
	fV2MEWOQGnm038z/3deu93K3MboDKecCYIQW9pVKbVelyrOYWlFKv6/CyZhkACbCn5UIzQ9iyEy
	bu2htOrSN1avUljiy5h+Id2AagOD4iWzIkz1yzF2xDHY6IqMCbUxAIOeb
X-Received: by 2002:a05:6a00:330c:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-8414ae6e041mr2501842b3a.33.1779358614182;
        Thu, 21 May 2026 03:16:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:330c:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-8414ae6e041mr2501811b3a.33.1779358613617;
        Thu, 21 May 2026 03:16:53 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e3d6a7sm997070b3a.55.2026.05.21.03.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:16:53 -0700 (PDT)
Message-ID: <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
Date: Thu, 21 May 2026 15:46:47 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
        Frank Li
 <frank.li@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Carlos Song
 <carlos.song@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
 <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
 <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68027798D1B07FD63AEC5F23E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eZiCbkqjBHGCZR-hwJO4M8hfqIZBPwss
X-Proofpoint-ORIG-GUID: eZiCbkqjBHGCZR-hwJO4M8hfqIZBPwss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwMiBTYWx0ZWRfXxAg/uF8PIHqx
 WtJC6nSKiTKbXD5p32gR4K60ezHBLFZKm/23PZYQFGZIt/9F7LQWCG2hRuccXeWmIXmV3ZdfF5z
 LMhh7OgKhcQnkfnfBgDa7kYsvpx3U0o/DmUc0qgqEwWsZHwIfO+ElopEvqp7Jr/r++TTzGiFxKD
 Lzi82nqDYoXBeYj6TFmPpKb2sYIYk9eM0aOifRsmFu3SA0X8COs4PgrBZCWmN+kAMnT+AQM6m7m
 ZagZxv2534TKKZQVYHVm4EXNvEJOsHhYuPhPb+mlpEPQtgMQ2gr7zgjgRVWBhW+m87hgT/jfkIc
 TB4fA/I1T0+sX55Wmdhw2CC8W+DMxRO/Ty4Nv+p6OGEbo+Y6vtQp1tq1YX+/y575GtE8fh5BXI+
 qix3S8Sm0mF8h5yt/921I15va5LJA+x5NMNrngSOd/srlby2UzkJhZlRH2ab2facIvRyeCNTi7U
 4G/uxOQsOXvj1aHpKzg==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0edb97 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=_EeEMxcBAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=yJUUZN2m8lq9mbh6i7kA:9 a=QEXdDO2ut3YA:10
 a=czjwGCTIUPoA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=ST-jHhOKWsTCqRlWije3:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210102

Thanks Carlos !

On 5/21/2026 1:57 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 3:40 PM
>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; o.rempel@pengutronix.de;
>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
>> down
>>
>> [You don't often get email from mukesh.savaliya@oss.qualcomm.com. Learn
>> why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi Carlos,
>>
>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>> From: Carlos Song <carlos.song@nxp.com>
>>>
>>> Mark the I2C adapter as suspended during system suspend to block
>>> further transfers, and resume it on system resume. This prevents
>>> potential hangs when the hardware is powered down but clients still attempt
>> I2C transfers.
>>>
what was the reason of this hang ? I was thinking you don't have 
interrupts working when client requested transfer but adapter was 
suspended. Please correct me if wrong.

And it would be good to mention the actual problem and why/how it occurred.
>> Code changes looks fine to me but have comment on commit log.
>>
>> It seems, you are adding support of _noirq() callbacks to allow transfers during
>> suspend/resume noirq phase of PM.
>>
>> Would it make sense if you can write "Replace system PM callbacks with noirq
>> PM callbacks" OR "Allow transfers during _noirq phase of the PM ops" instead of
>> "mark I2C adapter when hardware is powered down" ?
>>
> 
> Hi,
> 
> Thank you for your comments!
> 
> But this patch is added is not for support noirq PM callback or transfer in noirq phase.
> 
Okay, may be actual problem description can help me.
> In fact, this fix is to mark the I2C adapter as suspended during system noirq suspend to block further
> transfers, and resume it on system noirq resume. This is to prohibit I2C device calling the I2C controller
> after the system noirq suspend and before noirq resume, because at this time the I2C instance is powered
> off or the clock is disabled ... So I want to keep current commit. How do you think?
completely Makes sense. Please help add how this problem occurred and 
why ? So the change/fix will be good to understand against it.
> 
> Carlos Song


