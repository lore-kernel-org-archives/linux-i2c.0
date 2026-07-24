Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2E35A384
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784874946; cv=none; b=nBxSyUpH9J97az17GqB0VQAAxzqaLKnCy/+f9x0E1YJnVOXIBke6Zs12lCmR9ePatue3VhJI3mH/FVd5EqBfyh9XL3lrbYYmy61r5dDv1w3b5SkmqujwbNDnCCaZ4hgS+FApMpVM5ufjZp+TaKKj6axrjHhz/rpkxAiI4lCFIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784874946; c=relaxed/simple;
	bh=aCGK6NCLP/4RGrsbFj36kh2RLRjfEULuqyY/Nksle78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q67Q+2l6rO3hWSlGLofRaPeVOPH4UH+qeYOB027vwilzTioXltK6WTlj51E6/fgloFoHiOwZyu8zkteH6oDh4ZZHnUCTFBmBgKlTG5k+NrXOoBv1YhtOSWZil1AWN54Pr6t7FkVMH0KLmFVWb6DnJZQHECARFYkthJ+Nlog7aak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTB02pz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQ2IM/3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTB02pz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQ2IM/3P"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4li7k1869814
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 06:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXvRVpGIXinsiEwb7oebK1+4Q/yukygDdFnhG4wS/H4=; b=PTB02pz46ECkIy+d
	/GrOpdzJhr82CFbEN88hQVpeWPJHMietarKk1Xa2B831CLG/DUlFsX80Q0/gZKCY
	ARpa6s6oMWU7JJy4JpEW2zqT3Zhj9MmlsoaVgfsE8PQbV9NcpFPJYrmEsPxZ2+Pa
	FDjjSjy4sQmteq13vbY1qct7zd9jomH9nMYvc0moECqYPsvLZc7utTPWrvCMezip
	hk6iSDWgrv3FJrhbunj8896ObcUUuJ+fZbcyceBiUwjQ6ngOgso2uJJIxfqEWa11
	3eeuh7m5Cxf16wEFzpXuKjRpWPKklSHjtRb+78vRqTjhIfbVrnm/nDqCC31MYkgu
	fPXMDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8ffy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 06:35:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso98433a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784874942; x=1785479742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXvRVpGIXinsiEwb7oebK1+4Q/yukygDdFnhG4wS/H4=;
        b=KQ2IM/3Pzy8H7ZRqoh+HBCJixvnG4nKsSMHW8HGKcLRDvJqyIKZ1aPFPiHfgpvbqaQ
         8Y0CgYj+xByzLj0Iz17BDNEGCghGtw3N0iNoClTZybOL+rmsU8iJHoY0F9TIqhS/DmVi
         PZ7xMiwtK/f41DIUZJ50o/UiOGdZi/KajsI2Ni6K+AUgpHO1FZ1dpoBzPKvPpA/wK/1y
         3FwSIB0d7+M8Yj4iaFB05rQrU9KN4ae8bup3popv1YDw8cC3djUV05Uj8mbIH6duet/V
         MQDUAIq3ovlHHhLTskDdIQfN5lVnns3YvnKVzX2aF/rb/MeIDR6YAOu1Y2+AyGrmuSA2
         usEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784874942; x=1785479742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXvRVpGIXinsiEwb7oebK1+4Q/yukygDdFnhG4wS/H4=;
        b=q+Lyk6CDw52uqFJAYVugXZBHAfFijXKneLwZPyJglGwTm0tYBcOpQlUXlfl0xFnnSf
         2xezYNMYI7O303OOuoFYGGkGjES9g0QB5MWcsCyL9ZgAL9Y2K7c8IaRJtnMacP/DK08X
         2gA705byEXNTjVUB5dDZQcvHzPg9DA0eizsKYmGHuH3spt5dd17ipOOswkNUBrxv3zB6
         hzRNUeLDcYH2iwjzY281DvURsb9AcdoBS6W/yKH4icaOvjPLkJv9uAyqq8hR8gVs69Lh
         zWI0ztsA5muphci8Ai+9ftLfNn5dSTVt22yO4m0gkl6wizC6SdoHV8pOM12HtrWyztJS
         BiTw==
X-Forwarded-Encrypted: i=1; AHgh+RqV6gxQnDvPFlu3F6+PPkAOAlDK8zEf1Po99hz9FADM00PZgy+j6Ah3bkEc+aPpoBwyCnyZ+bWYweE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGwPwyAJ4D79V0kq7DHVO4JHWll3El5Rk5DHfHY6EJst4mU6a
	DXpe0avo7S+wznInlWu5NBIVNtztJHxo2RUjRY7+wdTRU0PrFRnUYCAMP80VpaPd73M20EKif7j
	ZaXex6EFRohHLB4S6m1McHYJGNnCotf4i1rjnsFng+Uj7Fk41KlfFLJkBKLvGXvkrATEHptY=
X-Gm-Gg: AR+sD13Zr9FevVu1yL+4sRQ7PbvyNYLseJ70onHcd/8nwkpXSu3oQqX7NIXBNep90eH
	iZ4qicEbRdBHW8RbnrNs5OK7z68TjzT9Kc2MoRUeE34y2Z9DQpCxUuY+gaB6Jy9bEPd/XSwuYFl
	EpuocU8GhdVvsbCu+CBz9L8ACZyMcnGSG0t5u/JK7wQAI38UBmkRhh73+4fM7Zr7K9ecBb40E+I
	snhn+gIjRv3/X9+YvlXvkMhrg1aOQGYnrzOxaCABTVN0hCiYtf7W8p+WAznVnmNKjx7C5N0oH+D
	wUFGFv9UiE3C7bmS9UiNdJexarRV3oGIKAbCmDdoa1/dSKjWWCgsCPYLwAts8kvjPQcU0RliWaR
	Fcef3Ss/U4HXxq9FxWeULlazDjLnxJwwsBDI=
X-Received: by 2002:a17:90b:3e85:b0:38e:581:3fcb with SMTP id 98e67ed59e1d1-38ec6aa5420mr5964495a91.34.1784874942157;
        Thu, 23 Jul 2026 23:35:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3e85:b0:38e:581:3fcb with SMTP id 98e67ed59e1d1-38ec6aa5420mr5964478a91.34.1784874941669;
        Thu, 23 Jul 2026 23:35:41 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f058118f2sm457720a91.1.2026.07.23.23.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 23:35:41 -0700 (PDT)
Message-ID: <510c0d23-f2ef-4f1b-aaae-a7f3c90c24c9@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:05:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] i2c: qcom-geni: Handle runtime PM disabled state
 during early resume
To: Praveen Talari <praveen.talari@oss.qualcomm.com>, Frank.Li@kernel.org,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, quic_jseerapu@quicinc.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Aniket Randive <aniketrandive@oss.qualcomm.com>
References: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
 <20260709134623.1724212-2-mukesh.savaliya@oss.qualcomm.com>
 <9cf5b5ab-c418-4b0d-8b2f-b888a64db0f0@oss.qualcomm.com>
 <933d864d-f0c2-4727-a01d-f564eb854d23@oss.qualcomm.com>
 <4133bbcb-22e7-41e0-b9f4-affd63df0e38@oss.qualcomm.com>
 <86828cb8-0e96-48ce-aff4-0f7e59438ad7@oss.qualcomm.com>
 <d8e2519c-4fe8-4db8-94e1-3231000bf51f@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <d8e2519c-4fe8-4db8-94e1-3231000bf51f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NyBTYWx0ZWRfX11qNlTL+y0H8
 0vGbKTWBQQYyT56iXH8dg1kv25rES7xjkZK0t6KFZpvN2PHtSZ7ujG2gSAdv5PY9lJsVU40vHCT
 ujuO3vfrvgAXLN7r1GYQrmrONZj8zUMtxvC1FYi391mkx3fYEMaIO26x4YICZQK6eUvEpGC+XMb
 lpDNxTiXoLar4O+5otqRcC+3sx+FBU8XQk4a08/8ENnWbLotArDVQ0czRsZp/Femdzm4noQc55T
 dopwDhcKGtPYG0OD+BWGmMLOJe+bfBTIF0bgs6QgVzyaOUwE1TNg5CyuDHeTbWD+sOIxEzd9hwE
 LwMLU5SovOFAku8UcllKux2A5m1sLvGyrqRFLfl7bdXfBfH3W3nZseEK3LknJNPRySeMFXHezZN
 FeDN0I1Gji6n6b7/e43pz2THiP2mYT1qls7lxL3oGAAsxgQqsqOS1wKpy61z5wt7+rNGBf5V1c6
 JiHidnZ0WMnLFQM3AQQ==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a6307bf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=76OpH07uMroPmmeGx-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: INmYZLsox1FONHvIhKyUDfGdD1qzazl4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NyBTYWx0ZWRfX0L2Q6SITA0p7
 3MhDBeDkc/rmYU+0y3la7gT467v3YJ+FCGwP/zl9zifhFkH+qZrOgyyNzeyZneC2M/n5EqJ4n0B
 AunY0sywLwRHM/3zkgzUyoRD1lID/Mk=
X-Proofpoint-GUID: INmYZLsox1FONHvIhKyUDfGdD1qzazl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240057



On 7/24/2026 10:12 AM, Praveen Talari wrote:
> Hi
> 
> On 23-07-2026 17:14, Mukesh Savaliya wrote:
>>
>>
>> On 7/23/2026 4:24 PM, Praveen Talari wrote:
>>> Hi mukesh
>>>
>>> On 23-07-2026 15:47, Mukesh Savaliya wrote:
>>>> Hi Praveen,
>>>>
>>>> On 7/23/2026 3:32 PM, Praveen Talari wrote:
>>>>> Hi Mukesh
>>>>>
>>>> [...]
>>>>
>>>>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/ 
>>>>>> busses/i2c-qcom-geni.c
>>>>>> index 96dbf04138be..4bc00922cd97 100644
>>>>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>>>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>>>>> @@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter 
>>>>>> *adap,
>>>>>>       gi2c->err = 0;
>>>>>>       reinit_completion(&gi2c->done);
>>>>>>       ret = pm_runtime_get_sync(gi2c->se.dev);
>>>>>> +    if (ret == -EACCES) {
>>>>>> +        dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
>>>>>> +        ret = 0;
>>>>>
>>>>> Here it is clear that pm_runtime_get_sync() is returning -EACCES 
>>>>> from the runtime PM framework,
>>>>>
>>>>> which indicates that the request was rejected before the runtime 
>>>>> resume path could enable any resources.
>>>>>
>>>>>  From the rpm_resume() implementation:
>>>>>
>>>>> static int rpm_resume(struct device *dev, int rpmflags) 
>>>>> __releases(&dev-  >power.lock) __acquires(&dev->power.lock) { [...] 
>>>>> repeat: if (dev-  >power.runtime_error) { retval = -EINVAL; } else 
>>>>> if (dev-  >power.disable_depth > 0) { [...] else retval = - 
>>>>> EACCES; } if (retval) goto out; [...] out: if (parent && !dev- 
>>>>> >power.irq_safe) { spin_unlock_irq(&dev->power.lock); 
>>>>> pm_runtime_put(parent); spin_lock_irq(&dev->power.lock); } 
>>>>> trace_rpm_return_int(dev, _THIS_IP_, retval); return retval; }
>>>>>
>>>>> The -EACCES error is returned when runtime PM is disabled 
>>>>> (disable_depth  > 0),
>>>>>
>>>>> causing the function to exit without invoking the device's runtime 
>>>>> resume callback.
>>>>>
>>>>> As a result, no resource enablement is performed by the PM framework.
>>>>>
>>>>>
>>>>> In your change, the error is effectively converted to ret = 0 and 
>>>>> execution continues.
>>>>>
>>>>> How can we guarantee that the required resources have been enabled 
>>>>> in this scenario?
>>>>>
>>>>> More importantly, where are those resources expected to be enabled 
>>>>> if the runtime PM resume path was never executed?
>>>>>
>>>>
>>>> This was answered in V6 already on 7/3 exactly at same place.
>>>> Pasting below.
>>>>
>>>> ==
>>>> > Why we are checking specific error code here? Why can't we use the 
>>>> below error check directly?
>>>> > if get sync itself is failed with pm runtime disabled then why we 
>>>> are going ahead by making ret = 0 here? How you will make sure 
>>>> resources are enabled?
>>>>
>>>> This reason is also mentioned in the commit log. we surely get - 
>>>> EACCESS as runtime PM is disabled during no_irq resume phase. We 
>>>> still need to serve the transfer, hence we need to override it.
>>>
>>> We should not get it and not go further since you are already enabled 
>>> in system_resume_no_irq().
>>>
>>> I just need to understand why we need to proceed when we get -EACCESS 
>>> as runtime PM .
>>>
>>
>> ret = 0 was added because during early system resume, -EACCES from 
>> pm_runtime_get_sync() indicates runtime PM is disabled, not that the 
>> controller is unusable; treating it as an error would incorrectly 
>> reject valid I2C transfers occurring during resume.
> 
> 
> What is the purpose of enabling runtime PM during system resume? It is 
> not clear how this helps, given that -EACCES can still be returned.
> 

I think you didn't get noirq_resume() change. if you review code, we do 
force_resume(), but that doesn't invoke transfer time runtime_resume() 
via pm_*_get_sync() call because device has runtime PM disabled.

Hence we need to call pm_runtime_enable(). In my testing, have seen that 
driver returning with -EACCESS if not overridden with ret = 0. That's 
the whole point. We need force resume and transfer to serve early resume 
transfer. Usecase demands this transfer without failure.

> 
>>
>> Other than early PM time, we are not going to get -EACESS. So i don't 
>> see any case where this will be a problem.
>>>>
>>>> Review geni_i2c_resume_noirq() to know what all we do to enable 
>>>> resources. That's guaranteed and tested with system suspend/resume 
>>>> test back to back and PCIe could do i2c transfer successfully.
>>>> ==
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Praveen Talari
>>>>>
>>>> Do not keep this thanks/regards here. only leave the comments.
>>>>
>>>>>> +    }
>>>> [...]
>>

