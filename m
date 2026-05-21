Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37B3C5855
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367203; cv=none; b=X8F8rE3tdTQPiwecvirPpCVQocsFYZ2ZsqvRE0/l6YkbtuUTVerWNGTbsMwcq7JwZ3+JvjSi/LDAtDkExlKqR/0i6KkT/EOp9NJgW5lFkl8qhP3xEJXsAWyIv1DmUrTx0rbMnQeU+MaWSNYOip/MtFVnRTWunje9POXWUCnLEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367203; c=relaxed/simple;
	bh=lE5m9vKNKBhobwgtfEDX9vo4+fc7RBiEF/84RQgcKZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIcn5jYXy6A/rx2dKYwsWaX/35uw2EfUO0j7zfTnRMPAfymVBiTiU+QfRUyje2rZ6P0rGEZO+1xY54KvzrUJ7Fz/63ROuyDeGLiARMkJP6AgYuCwzQVjye/09+AH1fSOdu04EFkoLDeCYZBsxTBwZqnyeogVEt9FhvDeGVmmzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWeVFYMj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=If9iB5Pf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWeVFYMj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="If9iB5Pf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9A6oI3452608
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 12:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=; b=HWeVFYMj4PEPy+2a
	2Hzq4NalWUT/Twjbj35kS7uC1uIFTltZplcQgTb8C39PiRZ5kfNguz37s+q9OpfQ
	q7c7vvosyM6mO5n8mPh2i/DZdu9QL3vvVmPxJOrWYpzWtY8l86vZBUmQndvKwPDL
	mH+pW7LAUPCl3Cc0KXUbSju3987w6uMptiYEUFbtHXQArPcgPwYcCkJ6p3JQJfGZ
	mHUbBUO7N0WFwHuL8EctNwZgIVygHqIuX4H71ghjmi0c07ktAGkL1JKTeavC1MOz
	xwO3mTr5F7YeKwwu7T4wERma+X6dIW6xdcKrfLmQvGAwhtlSYvqE0GgfBlp3Pnp1
	dIbsSQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9y1h8ube-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 12:40:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so65800845ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779367199; x=1779971999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=;
        b=If9iB5PfuWVmvo/IRx5HfY7GapQnJXlyu1VPSxN/RS5Nqk26cY5tVjnqufPIJF3V8l
         51kQg4Oy5Y42R9FZZJ67TGxWg2cjhWrVGVTlr781P8yKlm0wWr/cDu3jAyoCH4Oc5T8v
         Fe+o0goak6olQIy0eHPqjHmF9wx0A29rOhTBZaUKICTV5W9krQ2r1TS77fYj3iKQuPZv
         OEwvt42OwtDP/rwZlgyVi7hZ79FGY18cUnvpWVs/ynKx2Fxx9jQg33UZiDxs150esyvY
         ef0Vqk2PXNUXLiivrXcD34kjAyKt33bTz+H282AFgAz8lObFOuVjQ9T/OC4YoOjVPYdX
         6xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367199; x=1779971999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES2YYruuxFojMvF/pOHGFCJl2UiLVHd+mZIVueL/Tzs=;
        b=AZc8MQoiSoUTwLwcamFx5VzWYAbjg/DfwdkdfL4VdKYXwY/MXGmQYikAYVBobn19Pn
         oakAPwc77iyRUiYC/9IWekcAskd3bJTDvBaI40BBkNc0EkDoPeQxMDMGsfl131f3/GbH
         hhqoD+13Et+XFT3NdGjHa3J/b0MCmPAju8mHkCS3JyVTdF2Pg6a1qt4scl/q9kGGQUaU
         fHEkvxGYHqjpE4LgNTpzOjaCU3/yhq/NbpA9XRbsB7uE7+9p1WXl2dkr5PKyaPhNSawP
         wGPzIV9985TnfMy9R1sZIFYw68HNQlvQIkAjWypxPfo1cDRq4WYQg5nm5udIH5BpGGYO
         vD+A==
X-Gm-Message-State: AOJu0YyaibuFGaVPjhNCASaq0BjiYyUnH1UkQ/McuUx1zKSBla4p6OHZ
	or0m2YWv2QltPWdpGXbyxWee6LbHkXpcrKHY/n3j27mTWRjTcpP8CeAwTFfg8vi1v0A6hA9y9NO
	idn+3eFaJx6E5HN8q1ujZeKaJkIN5b6vIRAt76JUN62mqF4wjN7qN0eoqCux9t0Q=
X-Gm-Gg: Acq92OFz2fqaB4t5XzsLA5XuFgwNv+WYEWGI2BvTHqWqSitkux2QfW58Tx0iVHZIGDh
	10UGFplxG1tzVA/BlXvEd7ZhOAaMk+bdpWtvbkDYysVl8QvQ6EGLwxqJ3RRI+D4G5IAcJiuAQ71
	qI1baq+zpbwno4pm3TWS4Uf61WZcPHpXTRJ6vt8jdBSiCB8IHts4TiGt6+832G9TyhJiz4OECUz
	vSV49KA59HaaK7LmjZFEwjrC+EqzFmpR/GN76lOORGpD0K57ZBkfp3mjvwJ/Z1AfpJ064PNG7Ce
	pGwDICNE8jz7wvI2QslZW9xs9Bza0fdrK+OM05DMaQsOu0DiyNIdpDr8drUIloItG2F3u3YdHRM
	3VxX2+k5TwAdT7Nw/3UTLXGRTI1HrWCucOQDEcC6isn2nBmGkGUyacaFY
X-Received: by 2002:a17:902:fc50:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2bea2641874mr28014335ad.14.1779367199273;
        Thu, 21 May 2026 05:39:59 -0700 (PDT)
X-Received: by 2002:a17:902:fc50:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2bea2641874mr28013965ad.14.1779367198767;
        Thu, 21 May 2026 05:39:58 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9289e05sm10418955ad.27.2026.05.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:39:58 -0700 (PDT)
Message-ID: <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:09:56 +0530
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
 <22af0378-a3c9-4403-a0ee-da794847f41d@oss.qualcomm.com>
 <AM0PR04MB6802FE8B0E0BEF8CDA6DAD5EE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <ab96c900-9c77-455a-88f1-b6d8d8e4ff78@oss.qualcomm.com>
 <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68024A0FAF0637726C08B87BE80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dU7UnoAQBAIP4XPzF6OmKM7oGPhAgNOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX6StBq74dxNIw
 4r9OQRBVhYLzuu+wyzncbpicVLfenmA4ewsvrsT4BEdgJfdSIyqU/kYf/58X+zpTXYYsBJ9+QHs
 8lJmrvFMoBq9dsY4jCog0oWCxZKJtNSVEwzh1ynAKaIQwKa0KpEkzNBUchkMbXechVHvsVsCTdI
 QIT1Grg0eD9zDJ/Wm5RlD24PKR0RY2Felu9rvNgvmCsm4E+ZUjXi0azy9wW607rPQ9MxQHR/2zq
 +hel+Bh+zDoQJAEwCJYGQq8fDx32X+RD4V/BWDIPUAz8Ki10S834/hROFaXphvMIoTS26/ixBGt
 ESYeqNC9zq3SnhBs/kStidUXQMleC2r5GS7Lewa/BibPDxDRtCcSX4e9HoPoMs7AQ3Ga255vARI
 DmH/TN8d/TnAW+2K6vMtV//QDAsxGXAi+8iqSnyNXuXQAAQdCE1iQkcFHPt5HY30szxBva99Pyg
 sy6zs0TSY0ze/McFMug==
X-Authority-Analysis: v=2.4 cv=YfyNIQRf c=1 sm=1 tr=0 ts=6a0efd20 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=2tUGZl6TGnhxom4q2uIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: dU7UnoAQBAIP4XPzF6OmKM7oGPhAgNOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126



On 5/21/2026 5:32 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 7:14 PM
>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; Mukesh Savaliya
>> <mukesh.savaliya@oss.qualcomm.com>; o.rempel@pengutronix.de;
>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
>> down
>>
>>
>> On 5/21/2026 4:21 PM, Carlos Song (OSS) wrote:
>>
>> [...]
>>
>>>>>> -----Original Message-----
>>>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>>>> Sent: Thursday, May 21, 2026 3:40 PM
>>>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>;
>>>>>> o.rempel@pengutronix.de; kernel@pengutronix.de;
>>>>>> andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>>>>>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>>>>>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>>>> stable@vger.kernel.org
>>>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is
>>>>>> powered down
>>>>>>
>>>>>> Hi Carlos,
>>>>>>
>>>>>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>>>>>> From: Carlos Song <carlos.song@nxp.com>
>>>>>>>
>>>>>>> Mark the I2C adapter as suspended during system suspend to block
>>>>>>> further transfers, and resume it on system resume. This prevents
>>>>>>> potential hangs when the hardware is powered down but clients
>>>>>>> still attempt
>>>>>> I2C transfers.
>>>>>>>
>>>> what was the reason of this hang ? I was thinking you don't have
>>>> interrupts working when client requested transfer but adapter was
>>>> suspended. Please correct me if wrong.
>>>>
>>>> And it would be good to mention the actual problem and why/how it
>> occurred.
>>>>>> Code changes looks fine to me but have comment on commit log.
>>>>>>
>>>>>> It seems, you are adding support of _noirq() callbacks to allow
>>>>>> transfers during suspend/resume noirq phase of PM.
>>>>>>
>>>>>> Would it make sense if you can write "Replace system PM callbacks
>>>>>> with noirq PM callbacks" OR "Allow transfers during _noirq phase of
>>>>>> the PM ops" instead of "mark I2C adapter when hardware is powered
>>>> down" ?
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Thank you for your comments!
>>>>>
>>>>> But this patch is added is not for support noirq PM callback or
>>>>> transfer in noirq
>>>> phase.
>>>>>
>>>> Okay, may be actual problem description can help me.
>>>>> In fact, this fix is to mark the I2C adapter as suspended during
>>>>> system noirq suspend to block further transfers, and resume it on
>>>>> system noirq resume. This is to prohibit I2C device calling the I2C
>>>>> controller after the system noirq suspend and before noirq resume,
>>>>> because at
>>>> this time the I2C instance is powered off or the clock is disabled
>>>> ... So I want to keep current commit. How do you think?
>>>> completely Makes sense. Please help add how this problem occurred and
>> why ?
>>>> So the change/fix will be good to understand against it.
>>>
>>> Hi,
>>>
>>> In some I.MX platform, some I2C devices will keep a work queue all
>>> time, the work queue will trigger I2C xfer every once in a while, but the work
>> queue shouldn't be free in system suspend.
>>>
>>
>> work queue has transfers queued even if system is suspended ? IMO, the client
>> i2c devices should not let system go to suspend.
>>
> 
> Hi Mukesh,
> 
> Thank you for the detailed discussion.
> 
> Yes, I totally agree that I2C client drivers should ideally stop
> issuing transfers when the system is suspending.
> 
> However, in practice there are many different I2C clients, and not all
> of them strictly adhere to this requirement. Some clients may still
> trigger transfers through workqueues or deferred contexts during the
> suspend/resume window.
> 
> Therefore, adding this protection at the I2C controller side helps to
> avoid unexpected accesses when the hardware resources are unavailable,
> making the system more robust.
> 

Agreed !

>>> Within a very short time window, possibly from noirq_suspend to the
>>> system actually being suspended, or possibly from the system starting
>>> to resume to before noirq_resume, this work queue will trigger an I2C
>>> transfer, and at this time the I2C controller's clk and pinctrl have
>>> not yet been restored, reading and
>>
>> Right, this kind of explains the problem to me. I think you are trying to serve
>> i2c transfers when your resources(clk, pinctrl) are not turned ON and also
>> interrupt remains disabled. And that's why you need to add
>> _noir() PM callbacks supports along with IRQF_NO_SUSPEND |
>> IRQF_EARLY_RESUME flags.
>>
>>> writing I2C registers causes the system to hang. This patch make all
>>> I2C operations are performed in a safe hardware state.
>>>
>>> Is it better if I add these comment to patch commit log?
>>>>>
>> if my latest comments makes sense against the issue, you may write
>> accordingly. if i am wrong, then your explanation makes sense. Cause of the
>> hang needs to be clearly mention int the commit log in your next patch.
>>
> 
> Based on our discussion, I have updated the commit log as below:
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>    - noirq_suspend and full suspend
>    - resume start and noirq_resume

- noirq_resume and resume start [Just opposite ?]

> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Does this look good to you?
>
Looks good, Thanks !

>>>>
>>>
> 

