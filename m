Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7635CB6F
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784868158; cv=none; b=oLzwiI9Lva/UNKSTEa9KxXM/XGj5sRkcDtHkfogAde4XcMiuyQpIoNVWmWxaIlCDBCpoXeBoRiukQ189kAHlAPJkt21CpZzjujWtOpa2vLvrAs7bkIU4o5py7MiiPxf0nz9BOzNTx674iBoYPJRNlgOwtyK/Q257YPdKUaPMkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784868158; c=relaxed/simple;
	bh=n1KFEYqvw09G5uzxWwyzES6V1zg/warhcgYsGVn0xOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVx2snA5+8eRJYpsGFXXMdoFYs9+3fC9zprJ7AWtQVCSIi4nGPwLhKsr5ujQ0ETokP00HycEN/ZRsSZ5hksQpwp0dBjUMh4vifkNDENUe5NejeZsoi7kihrpqBpNJ41ZLadnvJf9oWWK1FJUXok2nWdplFA5af16Y27GinzB2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HopyFHqJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jsEWB+p7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HopyFHqJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jsEWB+p7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O2in651610703
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1pz8laA+S9BPO2S13XqwM8yA5GZVaczUsJOdms3VfvU=; b=HopyFHqJ/6QYARcf
	OkRqT4hHe4PQ9idSSP3hLDAszwGmu1K9VqJT2ZVGyZudiF2WsryUVClsuWOAeWYJ
	ZhbRG6vIcSTID6Y0A6Xyc0SBtV/Nz7VSNbc1Uj3CgJY/7eTmUFU8LImkQGAvOz46
	HQLV8nTCpyJ2w8987EkhfRMg/AUfDd7LTzLP9DXMo3SafwD9qbKcDORRQX5PSOF+
	tn3qnnAfhd1s6D/abswpL3/7DLC9JQvuks6I0IEoFb/hFVV51cal4IT2h+CYU52s
	qGb+kDrHRs5op1Cy/YVFGGH9Z6O7zf/RkmxIm/qcRFBmiVJz+FTAIw23a5qnVEVd
	wb9qXw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkjnubjq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:42:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so5770a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784868156; x=1785472956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pz8laA+S9BPO2S13XqwM8yA5GZVaczUsJOdms3VfvU=;
        b=jsEWB+p75EPKM4fI5aIfNYIa6/4aDFOxDKlVSwiC3lOkBsBnBxR2/kyE2hUSndJyy5
         1pMxT3q6mM9lP5P+5g1mvDd7xaKj0hhItXImyClvfKaxmSYH7KI/6NGHWRsFs5M5ZvAP
         CJpzL9093Z0Eafhq1iXl4zmoPG8fORsUy4cYRQhkm3VGh/naXWCGa9VAQkj4S0Njr5MI
         oYb87WEZtLf0k7a9nCD8ByJGS/mYdahdvwK8sEaqyXJ1spLpH0CtaZ1pvJ8K6NeCzPvX
         S6nO2rOeeXAd5Qd+su4m3nxEl31GjlD//4gC03ovYCr4FOYHNTkEUUnzVmi6Fpb4co0m
         B8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784868156; x=1785472956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pz8laA+S9BPO2S13XqwM8yA5GZVaczUsJOdms3VfvU=;
        b=PhlL/OgnGFcolKQht4yBRakXjLBDER+S1Oky650P0Sn20X9mo+vmZKsU0eIF+nzkTI
         KezaszRBgWGgA4weqK996mYe69cRrO7mnwmEygveaAJUkek8HQ6ous6AQP2sAvYNp59V
         zHy1eVGfhDEjnnRHpbg869WXih1l5hstKKnyaiZHXjKogU4e5lGQ6YPV8y6evRMpCZ8n
         PqDzy2V50+pVUCK7mQIcGlWbwhoV1xJX7UJ5pIsgrkogiY3+Xty/aVAPUmdxDys1JC+M
         dlaigtc1wYiHqd7aAGC0e1mL+p0m7DTLn8tqifmoe82ZCxjExgNaQkhsP3in/VGgDPa0
         zXKw==
X-Forwarded-Encrypted: i=1; AHgh+RoKVl832JhJmLJEXG/d83u5+Jy+NxpGUYVDSV3wsOaZ+DFggCNKojiDxvf/h2qJaYLNnhEZaySBnAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrr87eO5Qh6nHzS6qDdOCqjEeX6Zvg7oQYUrzHgqh/5er0jzxk
	DUFTgzJwmpAAmzb7fNsafOwnK3xQ9ET3CP+qYI1NQrdoXWdWk7QfPLCuSqnjTMZo8U9A5JT66IR
	o+XjGk+HSQSsWvQzr4UQzPW/K29Y+3ojPr29pFwrbfpPOgN0vOZbOBfdBT47hcKM=
X-Gm-Gg: AR+sD13rmDVAA59HcvB66/x03J2ADA8PcGFA3TcyK/9wl30IBmXCz2StfruC4Zozn8N
	sKu0frwWTIRUPigbe7FQTPS5jHDAD2EpKOQ41JGt1Ha65yapN3rNC8ymxrgE4V7NyIkMm9Q4ksp
	va0SLIJyTC2ghj03VTvXZHQpFeEZwyLvNABHsbMy8tOthnbUVBJP2rdl1sTbGRQDywaqjO3PYi+
	ekj+dEJ0LnvlspHq9ykG0kOaikfwDl0pGuud3bUhlAVCbd932lcHMJjRXUwJvItq7wmnMV/TGct
	Xk6BckfyZGpKEsj/RWdi0aHXTwapg/F5NHMA+VrgZrbqD0KLMbvLdw0/7WJJhfhiQJ2ed7C6Iy4
	n+buhpkksMRU2mVMWX4Cb2xmgXfZYRwY=
X-Received: by 2002:a05:6a21:62c4:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c44b210f22mr6445081637.54.1784868155813;
        Thu, 23 Jul 2026 21:42:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c4:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c44b210f22mr6445061637.54.1784868155227;
        Thu, 23 Jul 2026 21:42:35 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081978sm23370369eec.24.2026.07.23.21.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 21:42:34 -0700 (PDT)
Message-ID: <d8e2519c-4fe8-4db8-94e1-3231000bf51f@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:12:28 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] i2c: qcom-geni: Handle runtime PM disabled state
 during early resume
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, Frank.Li@kernel.org,
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <86828cb8-0e96-48ce-aff4-0f7e59438ad7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zizMQTL7lHNH66DjpEem0rZmH-7d2fQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfX1IN496RL3M1i
 ZinMZs+6V5covcOy+fthQoJ3wLaSdR+CZ6HJIFd2wIl4C3j04GCvBE0wIvVhNLcc7q/NyhWbed+
 lp3sfftd9ph0KMINaR7Y79hK1+dROxQdg448c7Zigxtm8d2zViMH+bOjmyQDX0+vxrdN1AHDn2F
 7bIfJ6YrHCYHH1VCYjaYC6xgdGV4UlKTh0pvr+hIG+Dg55/AHSup6w96hYsLw5qC0iiJSaacgWg
 gYrcVTrpKn/TuU++BeLii6IQnNkwJ0sspO3A2jw5XpshpnPZePhS0HtYXqSprgghy/ksRsEbi+t
 v53so4mUcJ6+RfHOyi/xg05SALtwSl1M6YZYUK2ZzI90JBVMs5IZu4bOth9t56MHOC0agLFSbyA
 PeBjwynAgPV0b7tkiN8a2NfA4d0jRM1NK4FaphSy7FT18s9oSTkYrgjKkn9u0duZ92ObNmnFssQ
 IjQa9ZpsCgzyyJNU7qQ==
X-Authority-Analysis: v=2.4 cv=Een4hvmC c=1 sm=1 tr=0 ts=6a62ed3c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=W_FluUXm2JYo8mKuQuoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfX08v2VU+2mr3k
 2s+lojgnFy34R1uqVKHrDBFMAJoCgxEKx+BTLjJVXKfm/O4MoQZbWFqOyKAhWljQI5HQU0gEkb+
 eDrxtWoaXGuGCudjV8NwgkVycdVp+X0=
X-Proofpoint-GUID: zizMQTL7lHNH66DjpEem0rZmH-7d2fQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240040

Hi

On 23-07-2026 17:14, Mukesh Savaliya wrote:
>
>
> On 7/23/2026 4:24 PM, Praveen Talari wrote:
>> Hi mukesh
>>
>> On 23-07-2026 15:47, Mukesh Savaliya wrote:
>>> Hi Praveen,
>>>
>>> On 7/23/2026 3:32 PM, Praveen Talari wrote:
>>>> Hi Mukesh
>>>>
>>> [...]
>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/ 
>>>>> busses/i2c-qcom-geni.c
>>>>> index 96dbf04138be..4bc00922cd97 100644
>>>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>>>> @@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter 
>>>>> *adap,
>>>>>       gi2c->err = 0;
>>>>>       reinit_completion(&gi2c->done);
>>>>>       ret = pm_runtime_get_sync(gi2c->se.dev);
>>>>> +    if (ret == -EACCES) {
>>>>> +        dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
>>>>> +        ret = 0;
>>>>
>>>> Here it is clear that pm_runtime_get_sync() is returning -EACCES 
>>>> from the runtime PM framework,
>>>>
>>>> which indicates that the request was rejected before the runtime 
>>>> resume path could enable any resources.
>>>>
>>>>  From the rpm_resume() implementation:
>>>>
>>>> static int rpm_resume(struct device *dev, int rpmflags) 
>>>> __releases(&dev-  >power.lock) __acquires(&dev->power.lock) { [...] 
>>>> repeat: if (dev-  >power.runtime_error) { retval = -EINVAL; } else 
>>>> if (dev-  >power.disable_depth > 0) { [...] else retval = -EACCES; 
>>>> } if (retval) goto out; [...] out: if (parent && 
>>>> !dev->power.irq_safe) { spin_unlock_irq(&dev->power.lock); 
>>>> pm_runtime_put(parent); spin_lock_irq(&dev->power.lock); } 
>>>> trace_rpm_return_int(dev, _THIS_IP_, retval); return retval; }
>>>>
>>>> The -EACCES error is returned when runtime PM is disabled 
>>>> (disable_depth  > 0),
>>>>
>>>> causing the function to exit without invoking the device's runtime 
>>>> resume callback.
>>>>
>>>> As a result, no resource enablement is performed by the PM framework.
>>>>
>>>>
>>>> In your change, the error is effectively converted to ret = 0 and 
>>>> execution continues.
>>>>
>>>> How can we guarantee that the required resources have been enabled 
>>>> in this scenario?
>>>>
>>>> More importantly, where are those resources expected to be enabled 
>>>> if the runtime PM resume path was never executed?
>>>>
>>>
>>> This was answered in V6 already on 7/3 exactly at same place.
>>> Pasting below.
>>>
>>> ==
>>> > Why we are checking specific error code here? Why can't we use the 
>>> below error check directly?
>>> > if get sync itself is failed with pm runtime disabled then why we 
>>> are going ahead by making ret = 0 here? How you will make sure 
>>> resources are enabled?
>>>
>>> This reason is also mentioned in the commit log. we surely get - 
>>> EACCESS as runtime PM is disabled during no_irq resume phase. We 
>>> still need to serve the transfer, hence we need to override it.
>>
>> We should not get it and not go further since you are already enabled 
>> in system_resume_no_irq().
>>
>> I just need to understand why we need to proceed when we get -EACCESS 
>> as runtime PM .
>>
>
> ret = 0 was added because during early system resume, -EACCES from 
> pm_runtime_get_sync() indicates runtime PM is disabled, not that the 
> controller is unusable; treating it as an error would incorrectly 
> reject valid I2C transfers occurring during resume.


What is the purpose of enabling runtime PM during system resume? It is 
not clear how this helps, given that -EACCES can still be returned.


>
> Other than early PM time, we are not going to get -EACESS. So i don't 
> see any case where this will be a problem.
>>>
>>> Review geni_i2c_resume_noirq() to know what all we do to enable 
>>> resources. That's guaranteed and tested with system suspend/resume 
>>> test back to back and PCIe could do i2c transfer successfully.
>>> ==
>>>>
>>>> Thanks,
>>>>
>>>> Praveen Talari
>>>>
>>> Do not keep this thanks/regards here. only leave the comments.
>>>
>>>>> +    }
>>> [...]
>
