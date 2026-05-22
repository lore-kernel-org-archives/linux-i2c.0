Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAD377567
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434423; cv=none; b=LjPyHOsigsZ+V9/UGFswW3IT+5esCHsuEem0fvkYffFGXCDOtduEGWrj3xebzzJqwGwRtk1G5kW1Y7Re278/xO5toJ2BcYtqsoKOqYAA7ckratcwnnrqYJr8nTSyxM5fM27uYS9XmAhTDG2OFntqU0WUmKbI6X3MJfnwXy5Pyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434423; c=relaxed/simple;
	bh=/tvkinZc6kam6AsYNY4KzQ46LaHAeu6Sx70rjikUnw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksD+7kODiW3VRZJK3R3eidXjocX04Z8RdtthUeM211Gk9tHDd5+ZkA3LGVfV37K0yKxuk5KxK5FMKA8oOBD05TeXL4yEY3MzKlSn2tzK87gdlLlMazMhf7c5kecN0IGlMEPm5wJlyOCrVcwgvj1YRdnDj/gOVLYxBFxHUaNG8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fj1Gj80Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8fWyW/S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fj1Gj80Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8fWyW/S"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M41lVZ3005101
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 07:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=; b=fj1Gj80Zd3Xzg5Hy
	6VXT9nMwdgI19YGqTzLas9P9tZk1JGBbxWrNJ/3HIfD/2girwPx9+K9lQAT3ZxAT
	+1TELcUT7UuI1pxxwiut3okMvTCTN+Vtcgk1g8iokVtcEw02lB6ETE1Y9SUr6y6K
	Bc8FrTeczZQdIv1duxQO+W4+m/hKVlEbIHJnn6jHzP5BiOo6rIzbCwFW7CQi81P6
	+UP08ZawsbgiOPTQJF2EbBzkUeGQkwvOsyyQ5wrExDDiYcNguf4vpLFacCN7hqxl
	TcNz+vpsqDAPR8CJlLmQdUqChISoXFKKJM9EHViTgQfYSdInlh7pF1LvmNUxaOJJ
	ytDjdw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt8kxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 07:20:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c828cee4fcdso3479773a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 22 May 2026 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779434421; x=1780039221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=;
        b=i8fWyW/SVg8zM0H1egM7Dk19N6/g6s7FmWY/Z9IAoY7J1r26MLVd+GitDrcgvXZj3d
         07pmeK+fuQ7DsPys5e43a01VTeCZZQy4Jw/Mi+sgJHZc6FzPUXAb1m8bcwl9E9CYzgSM
         jIRf99nQGyDwB2QEt8ezZ1ieR5adEXdr0j+zfkIuhUO8o9KaSqqGrMaEvD4cl7/HHUhi
         eF/SNRF0gTyMXBVDj8+DKjfhsqCp/bMcskDEbtqwUkmvSGFutetGu2vojvreCoMaIVwm
         GL6h1gd7Bsl4Yp+lhneh/Gv2jn3vfIxtTwy7Iqr6KOUxfs77+tuddydY0ntHCh5YxFIz
         Xa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779434421; x=1780039221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeKU9U0zySWMyeUkl9tHBC4BKI1WPZa36dC/DO/ULkE=;
        b=OelsVwMOQL0NjMlbtdbZL8G+wQIoaQL5pLr7tn8Qmz22d5XmwZePmqiu79YiWwYDCJ
         US8e1IclZy4fzjUw2FRfzucL8XnWiMDxqzcZkfsL+7+QGY778Jm2SBvW6JPXkXmnsTF/
         OqUS/N59I3rYNWxfcmvId/v7BQjSjF+NtxlHbxZEYA4pHJeFXunBsJZyXB1Re3bDGisn
         jTt8hwT9ajSbQ43Z9I2LHQmH5ybU36PbqUQ6nZb9sPvVoq3nrGsmjL7IcfkD2twzKLSn
         V7/1pV3xPmOo1oPtzGnbCDzqzJ3m10fX5oBqATt0rRXuWHTY9wGaALMOq/B6bTCcYmTR
         B9Mg==
X-Gm-Message-State: AOJu0Yx/ZNss4QuXjhr4UyDHN+HNsv28x/aVeQqez0zy768plMrg5LQw
	Gx6NHXusmCDaiSR1MqCPeHvsyETEdTDmd382IJ7zXzufrOrbLfuvMc0KBH4o5nDY30JFLcmrse7
	19Z1ubZwSCXhqAt5uOPxS/PhV2dh5V3Zf635b+R74brGxxmlVPANFWXcLzgAqXf0=
X-Gm-Gg: Acq92OEVQdKEJR1vy//bCalE4iXQ8fq5wTEGi4Zlsh+HvZmODpo9OkwuXRLIzvskDzV
	fq/oqE7x6IQN5qulWdvCCZTgM7t4JC3aTIyds7a/butzvhdrrqq38isRexxFXAkVT0juhHHysNv
	DcFl0VRGCTq8HS9bKee2t/UCfbqiYEer7Aa4utrVPsLCvsVoR88M56zOa/WVrPVdQr/ia9fqX14
	Q1yTgosHD2vOUhgMfbs5qXkgJYNbk7U3Il2dZ5rPkq2jkoqUDHxC022lqiVRvxi2PRzeKwdjE+D
	+JH355KwOu6wtLTyCvyrmFUvjksaIHjeiOsHJ6R4l8UjJ9dek85mQb1Bg4J72Rg+WoPdUUk5uKH
	3lv+wd34LK4lGxhJZjQqW/xi9dW9LeK02s01hiu/B+482HnqgASQ0kMSh
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d68d:9e83 with SMTP id adf61e73a8af0-3b328c0f502mr2643991637.5.1779434420636;
        Fri, 22 May 2026 00:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d68d:9e83 with SMTP id adf61e73a8af0-3b328c0f502mr2643961637.5.1779434420115;
        Fri, 22 May 2026 00:20:20 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205616bdsm707529a12.23.2026.05.22.00.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 00:20:19 -0700 (PDT)
Message-ID: <a0941899-bf27-4551-b23d-37d7f99a3519@oss.qualcomm.com>
Date: Fri, 22 May 2026 12:50:14 +0530
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
 <315029cc-f04c-4dad-a746-f5d3e7245cdc@oss.qualcomm.com>
 <AM0PR04MB68026A6412B8F844D1324B92E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <AM0PR04MB68026A6412B8F844D1324B92E80E2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a1003b5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=2UpP72-WgONIwjLJxC0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3MSBTYWx0ZWRfX7SeWVRJ+neS3
 7ze0BGaGIXIS0nxV1waJrokQA6Af88h3U2JEmicFtRi0P72EyRv2kdlavaklzo2vny+CT2k+iIg
 Cp27IdKNDRBer40aGK+Z6nU19Ud2tZ3vEZhMc5fNMoq3N+MMqYkufB27Dyv91GqF32byHw+vFF1
 FIKRyKNFTdAjXBdRomU9LBQU0bRjFJhn6x84qR8GfyIVe90gDW7PqJ9xNKxgZDdKsST2X91oBO/
 inoc9/cBNJmVV+EqZyK3dLX+OM+JUpeZL+IdJczFzM9SxW65eUs+1Zv2vH15YOWAbOv7UQwKxQN
 td4y1ln3b0S1aukaHj0mZ9HE3taQvenEf2BCqbhdBr48m173PUCdkCEg1igcO6UKDPLiO+4RyQh
 hzEs6mSEjKwpxS/aUPSDLoPKEdFyJf8ICrdIWxA6zl/wvNewQE0CJv/T9QeKrasJ4/Ca+VfaPrq
 EnBHhSaA5Ld7BKgq83A==
X-Proofpoint-GUID: KLtUjbTbbL9HzVBZAFldQ9Qll0jw3Rsf
X-Proofpoint-ORIG-GUID: KLtUjbTbbL9HzVBZAFldQ9Qll0jw3Rsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220071

Thanks Carlos !

On 5/21/2026 8:19 PM, Carlos Song (OSS) wrote:
> 
> 
>> -----Original Message-----
>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> Sent: Thursday, May 21, 2026 8:40 PM
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
>>
>> On 5/21/2026 5:32 PM, Carlos Song (OSS) wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>> Sent: Thursday, May 21, 2026 7:14 PM
>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>; Mukesh Savaliya
>>>> <mukesh.savaliya@oss.qualcomm.com>; o.rempel@pengutronix.de;
>>>> kernel@pengutronix.de; andi.shyti@kernel.org; Frank Li
>>>> <frank.li@nxp.com>; s.hauer@pengutronix.de; festevam@gmail.com;
>>>> Carlos Song <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>>>> stable@vger.kernel.org
>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is
>>>> powered down
>>>>
>>>>
>>>> On 5/21/2026 4:21 PM, Carlos Song (OSS) wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>>>>>>> Sent: Thursday, May 21, 2026 3:40 PM
>>>>>>>> To: Carlos Song (OSS) <carlos.song@oss.nxp.com>;
>>>>>>>> o.rempel@pengutronix.de; kernel@pengutronix.de;
>>>>>>>> andi.shyti@kernel.org; Frank Li <frank.li@nxp.com>;
>>>>>>>> s.hauer@pengutronix.de; festevam@gmail.com; Carlos Song
>>>>>>>> <carlos.song@nxp.com>; Bough Chen <haibo.chen@nxp.com>
>>>>>>>> Cc: linux-i2c@vger.kernel.org; imx@lists.linux.dev;
>>>>>>>> linux-arm-kernel@lists.infradead.org;
>>>>>>>> linux-kernel@vger.kernel.org; stable@vger.kernel.org
>>>>>>>> Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware
>>>>>>>> is powered down
>>>>>>>>
>>>>>>>> Hi Carlos,
>>>>>>>>
>>>>>>>> On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
>>>>>>>>> From: Carlos Song <carlos.song@nxp.com>
>>>>>>>>>
>>>>>>>>> Mark the I2C adapter as suspended during system suspend to block
>>>>>>>>> further transfers, and resume it on system resume. This prevents
>>>>>>>>> potential hangs when the hardware is powered down but clients
>>>>>>>>> still attempt
>>>>>>>> I2C transfers.
>>>>>>>>>
>>>>>> what was the reason of this hang ? I was thinking you don't have
>>>>>> interrupts working when client requested transfer but adapter was
>>>>>> suspended. Please correct me if wrong.
>>>>>>
>>>>>> And it would be good to mention the actual problem and why/how it
>>>> occurred.
>>>>>>>> Code changes looks fine to me but have comment on commit log.
>>>>>>>>
>>>>>>>> It seems, you are adding support of _noirq() callbacks to allow
>>>>>>>> transfers during suspend/resume noirq phase of PM.
>>>>>>>>
>>>>>>>> Would it make sense if you can write "Replace system PM callbacks
>>>>>>>> with noirq PM callbacks" OR "Allow transfers during _noirq phase
>>>>>>>> of the PM ops" instead of "mark I2C adapter when hardware is
>>>>>>>> powered
>>>>>> down" ?
>>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Thank you for your comments!
>>>>>>>
>>>>>>> But this patch is added is not for support noirq PM callback or
>>>>>>> transfer in noirq
>>>>>> phase.
>>>>>>>
>>>>>> Okay, may be actual problem description can help me.
>>>>>>> In fact, this fix is to mark the I2C adapter as suspended during
>>>>>>> system noirq suspend to block further transfers, and resume it on
>>>>>>> system noirq resume. This is to prohibit I2C device calling the
>>>>>>> I2C controller after the system noirq suspend and before noirq
>>>>>>> resume, because at
>>>>>> this time the I2C instance is powered off or the clock is disabled
>>>>>> ... So I want to keep current commit. How do you think?
>>>>>> completely Makes sense. Please help add how this problem occurred
>>>>>> and
>>>> why ?
>>>>>> So the change/fix will be good to understand against it.
>>>>>
>>>>> Hi,
>>>>>
>>>>> In some I.MX platform, some I2C devices will keep a work queue all
>>>>> time, the work queue will trigger I2C xfer every once in a while,
>>>>> but the work
>>>> queue shouldn't be free in system suspend.
>>>>>
>>>>
>>>> work queue has transfers queued even if system is suspended ? IMO,
>>>> the client i2c devices should not let system go to suspend.
>>>>
>>>
>>> Hi Mukesh,
>>>
>>> Thank you for the detailed discussion.
>>>
>>> Yes, I totally agree that I2C client drivers should ideally stop
>>> issuing transfers when the system is suspending.
>>>
>>> However, in practice there are many different I2C clients, and not all
>>> of them strictly adhere to this requirement. Some clients may still
>>> trigger transfers through workqueues or deferred contexts during the
>>> suspend/resume window.
>>>
>>> Therefore, adding this protection at the I2C controller side helps to
>>> avoid unexpected accesses when the hardware resources are unavailable,
>>> making the system more robust.
>>>
>>
>> Agreed !
>>
>>>>> Within a very short time window, possibly from noirq_suspend to the
>>>>> system actually being suspended, or possibly from the system
>>>>> starting to resume to before noirq_resume, this work queue will
>>>>> trigger an I2C transfer, and at this time the I2C controller's clk
>>>>> and pinctrl have not yet been restored, reading and
>>>>
>>>> Right, this kind of explains the problem to me. I think you are
>>>> trying to serve i2c transfers when your resources(clk, pinctrl) are
>>>> not turned ON and also interrupt remains disabled. And that's why you
>>>> need to add
>>>> _noir() PM callbacks supports along with IRQF_NO_SUSPEND |
>>>> IRQF_EARLY_RESUME flags.
>>>>
>>>>> writing I2C registers causes the system to hang. This patch make all
>>>>> I2C operations are performed in a safe hardware state.
>>>>>
>>>>> Is it better if I add these comment to patch commit log?
>>>>>>>
>>>> if my latest comments makes sense against the issue, you may write
>>>> accordingly. if i am wrong, then your explanation makes sense. Cause
>>>> of the hang needs to be clearly mention int the commit log in your next
>> patch.
>>>>
>>>
>>> Based on our discussion, I have updated the commit log as below:
>>>
>>> On some i.MX platforms, certain I2C client drivers keep a periodic
>>> workqueue which continues to trigger I2C transfers.
>>>
>>> During system suspend/resume, there exists a time window between:
>>>     - noirq_suspend and full suspend
>>>     - resume start and noirq_resume
>>
>> - noirq_resume and resume start [Just opposite ?]
>>
> 
> Sorry, the expression is ambiguous.
> 
> I will update the commit log to:
> 
> During system suspend/resume, there exists a time window between:
>    - suspend_noirq and the system entering suspend
>    - the system starting to resume and resume_noirq
> 
> Does this look good to you?
Yes, looks good.
> 
>>>
>>> In this window, the I2C controller resources such as clock and pinctrl
>>> may already be disabled or not yet restored.
>>>
>>> If a workqueue triggers an I2C transfer in this period, the driver
>>> attempts to access I2C registers while the hardware resources are
>>> unavailable, which may lead to system hang.
>>>
>>> Mark the I2C adapter as suspended during noirq suspend and block new
>>> transfers until resume, ensuring that I2C transfers are only issued
>>> when hardware resources are available.
>>>
>>> Does this look good to you?
>>>
>> Looks good, Thanks !
>>
>>>>>>
>>>>>
>>>
> 

