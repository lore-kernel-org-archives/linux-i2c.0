Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF137D121
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804083; cv=none; b=JC8j2myVwb+5yrkvimA18MizGNXa7bxA0LVhfawj0QLf/eZuDaNX2Sppb2eP05DJh/nxxOP0p7AfYTNiE0uKwzgb1t9JheQNUAb2t/k/iERCBIkOnzMs0idSzBNsPzPQKNVwlOF6ET0yeCfmutiFEwNdraFDZ+Cl35+/fFh0oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804083; c=relaxed/simple;
	bh=7bPVFROIqjuLQSAM7RyTDXhIogkJo+mGvCdFs7fGT6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHPjmXbme+OT1fT8ed2946x4oCod1izMY5sg6hmq1YMqQPJ9wQ1/P8T3W3cnUDuL5EEGytUVTkMGPx6IyqXQeexpR9PGxt4G8xrL26kxCml6tZ3atgAMnSgFj+P5dJoa6yz47vkeGJpZ2tG2Z32qUIEOV6FBhY0VMUNA4oK4158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dC+QH+LT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jyb5Pn+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dC+QH+LT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jyb5Pn+V"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9DkEf3567633
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNG7Bb8DBT2b56LvpJ/oDJNSiuHjzgZKwZfV3mCfivg=; b=dC+QH+LTYYkQL2Su
	6x7s+vo2ZIxDN5DuWn7ucyTQaN6GQekF1rMIilHHZamPTNotUXCJx35Dlg9r5+tr
	vgc45cHTjC7h/xGCdYbZX4COFB6C0UBSYXnK0nB0yB8aJ1sk5wTiTgXeMsZVCZAH
	vrX32rvkuX7DD04HsDbueCIEOS7HzGlPKJa3ThIKGhy4ucmlqo1fQrSisWs84wFM
	ii1rKnLrVDHKsylcTJQlTPbGSIi9qLoSpl6Ta5nThv6UPCHzuaLDgBQdHhZCADAY
	uJgjhnT6rz0boaDP93AhnAOHos10evytYXDXvdPMN8ZnpWPPv3URtt/n+w5RM3mA
	X14L2A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg520c2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:54:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486ffba174so972628b3a.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784804073; x=1785408873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNG7Bb8DBT2b56LvpJ/oDJNSiuHjzgZKwZfV3mCfivg=;
        b=Jyb5Pn+VDcu/FVnI70SNUmuYQgBvE5D0mhLaa35DLxPFYRASbBw+EZ22zQwdAPDPmz
         X4Kcl+V7on9pM2tA4Q2gVuPhIxr2Q6/cxy/UOwiFh1fMbjZDCQp3TTpPVo9NiMmeLz74
         9KbNIq+xxpkYdxFc+8zco6s7H9m2/Okq7Qju/MwfsHAu2icdmKCabz1kU15o44mmjaI5
         7b/ExvF/JP5DxEuhOE7AKs6MNDBo8Q7JFRMdVZ228pgQ6dKADq/wB9AKWs6K5egsRI7D
         Rn2whb1uSTdYXOIuxtzl5b8ZyeqAz6wi2gJ00N/uniuxa0GjGqDwDpw2VYbDtvEhJNY1
         5yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804073; x=1785408873;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNG7Bb8DBT2b56LvpJ/oDJNSiuHjzgZKwZfV3mCfivg=;
        b=bHjHcXZJb2VDOi6dxVIsj/fvWbp/lxqSWfn4MPc7DoXPGPrj02Uu1zhE0t2HAKUvvH
         GjnYAIj52oShWfLCxoqzVzQEoT4ybmKsW77kq/g5oYM+Zp0hFTwLTipLv9FFovCss/iP
         l7qKx+0x6NCN97uBvTEX0uRIujFL+yXWiHNECLmxtiXGjFCVQTMXfEhVdmBNn86On6d0
         +buq39IAk62/J+l7eboOzATtZy+jedbsLRK7HDv1mLHDIHe6m+4EAQsi5lcloElUXtdy
         Dx1+ih3yTFvaoHdUPwhx5otAmzvtAPVEwCyz7jlpwFBogp1zHrMOlrSjMejZcF4hX8g0
         1CBA==
X-Forwarded-Encrypted: i=1; AHgh+RoUNKpjtdo6rmrKQ9ZTmc+zHBSikdhNOeEYJVghfivyXvP58ui9/Dm4ULpA5Qx6t7/rSbpaqs6bTtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKQWCtNG8FfC4VhtB/tScue8+fGlwXhYS+NHAtg3xQdau6PnX
	DJfP7hUNd4lPd+XTVQC09nY5Z+1wTdWZS9Fz5fhUwtvVTdGIN66XsWGduJCWlx5rwXdZq00nuF6
	PsgUe0Q5uy1a1g14bydZQHuiz5z+fN7i3fE87PJLsEPmevNSb7wUJpO2D33F88aM=
X-Gm-Gg: AR+sD10u8a+Brq3aRw/N6psrH44LOLW1sCUNyKbtmN2xgbv8nXoYekFrNZuWZUwLyv6
	RSJgoRvG80lFnXqfypfQEsCKiDYKILYLpFkJoDDgjvxbpx2TFjDh+JfAAu4j0Zb2t0Mq6vnDp6/
	OWDjK8DgS23DalvwtYq2w0z17xVehDJ56XOPrPPKVARz69/2i2OTocd2p+QxvubQ6hWugZlxydi
	V5/0UKKf/KJ09hZMmrFopXYr9ABKmg05RaVgea45qjcr/1ZiK2dHSnnRyPUZMm0Yqfz2fFsQ3ol
	kyUENEuoXeaIoBLrfWed6GPe0nCWEUArVfpN/9C9/UvO/DChDn3toSFI2tcsciXyAbXm+pa2uel
	3ktDytGCe/TFhmiuO/xv3g9iG5Wds4Y0=
X-Received: by 2002:a05:6a00:950e:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-84e2b7f83f6mr3146206b3a.16.1784804072767;
        Thu, 23 Jul 2026 03:54:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:950e:b0:848:67ca:bfd with SMTP id d2e1a72fcca58-84e2b7f83f6mr3146161b3a.16.1784804072036;
        Thu, 23 Jul 2026 03:54:32 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17262e33sm2906433b3a.14.2026.07.23.03.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:54:31 -0700 (PDT)
Message-ID: <4133bbcb-22e7-41e0-b9f4-affd63df0e38@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 16:24:26 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <933d864d-f0c2-4727-a01d-f564eb854d23@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a61f2e9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=hKlI1_g4CyTrXuPfMs4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwNyBTYWx0ZWRfX+if1KvwyOFOu
 0RJx+jFtfaJNf1kPla4pLteXmM2IalSUrsLctKJO9MrSKQ4HztSVgdL8IAZxmY/Jbck6NjFZBxA
 hG59O1pQTx19lLa1ac/g+in3JdTi8To=
X-Proofpoint-GUID: 8vOtvoDmR1WsVr-oox-gddBmL0n9RaQq
X-Proofpoint-ORIG-GUID: 8vOtvoDmR1WsVr-oox-gddBmL0n9RaQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwNyBTYWx0ZWRfX+TCk3C0nLHxc
 FT+ga7eJovnFwX1Qe2aLuuEY/JU4xDcqSyiQT9GlpYeDJDEKIS4WZwE7VgoffctRDaOrfJOUqc7
 Og354REFbVnyc1qLGEYpMYunOMUi4N4PhQDe9CjaLnGWsptr10Z6QER4NVx0jHmpjaAlIY8kKKT
 kQZsEhz16vWP4/2wsvR5ocdNtADt1Y3zLqUDKuIz4S/mOx4mR2M+fMmvY+tPrb4T6F6CLX52IO4
 ZKF4wxYhSvfIaG8NVp77Lq4iVV+ycIvnMAXIT9Qgoy+4ZVpFae98OkFHpAC8e1WV66+f/Z/s1VC
 dnbKWG1wtQ2mLqsAM5PcoZNloYpdJ/U1XhXCoCrh1kq/8yUb/Pwu6r9L/mC8kQWmT47HguhIeai
 AgIoKojwwx9O4zv+u/fb81rEHHELbemQTr7gi7j5O6KPF53ZOheLTz/VKXS+o6I3hIp6ikBdGMd
 MdtLWk+o0yWQjgBNerQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230107

Hi mukesh

On 23-07-2026 15:47, Mukesh Savaliya wrote:
> Hi Praveen,
>
> On 7/23/2026 3:32 PM, Praveen Talari wrote:
>> Hi Mukesh
>>
> [...]
>
>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>>> b/drivers/i2c/busses/i2c-qcom-geni.c
>>> index 96dbf04138be..4bc00922cd97 100644
>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>> @@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>>>       gi2c->err = 0;
>>>       reinit_completion(&gi2c->done);
>>>       ret = pm_runtime_get_sync(gi2c->se.dev);
>>> +    if (ret == -EACCES) {
>>> +        dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
>>> +        ret = 0;
>>
>> Here it is clear that pm_runtime_get_sync() is returning -EACCES from 
>> the runtime PM framework,
>>
>> which indicates that the request was rejected before the runtime 
>> resume path could enable any resources.
>>
>>  From the rpm_resume() implementation:
>>
>> static int rpm_resume(struct device *dev, int rpmflags) 
>> __releases(&dev-  >power.lock) __acquires(&dev->power.lock) { [...] 
>> repeat: if (dev-  >power.runtime_error) { retval = -EINVAL; } else if 
>> (dev-  >power.disable_depth > 0) { [...] else retval = -EACCES; } if 
>> (retval) goto out; [...] out: if (parent && !dev->power.irq_safe) { 
>> spin_unlock_irq(&dev->power.lock); pm_runtime_put(parent); 
>> spin_lock_irq(&dev->power.lock); } trace_rpm_return_int(dev, 
>> _THIS_IP_, retval); return retval; }
>>
>> The -EACCES error is returned when runtime PM is disabled 
>> (disable_depth  > 0),
>>
>> causing the function to exit without invoking the device's runtime 
>> resume callback.
>>
>> As a result, no resource enablement is performed by the PM framework.
>>
>>
>> In your change, the error is effectively converted to ret = 0 and 
>> execution continues.
>>
>> How can we guarantee that the required resources have been enabled in 
>> this scenario?
>>
>> More importantly, where are those resources expected to be enabled if 
>> the runtime PM resume path was never executed?
>>
>
> This was answered in V6 already on 7/3 exactly at same place.
> Pasting below.
>
> ==
> > Why we are checking specific error code here? Why can't we use the 
> below error check directly?
> > if get sync itself is failed with pm runtime disabled then why we 
> are going ahead by making ret = 0 here? How you will make sure 
> resources are enabled?
>
> This reason is also mentioned in the commit log. we surely get 
> -EACCESS as runtime PM is disabled during no_irq resume phase. We 
> still need to serve the transfer, hence we need to override it.

We should not get it and not go further since you are already enabled in 
system_resume_no_irq().

I just need to understand why we need to proceed when we get -EACCESS as 
runtime PM .

>
> Review geni_i2c_resume_noirq() to know what all we do to enable 
> resources. That's guaranteed and tested with system suspend/resume 
> test back to back and PCIe could do i2c transfer successfully.
> ==
>>
>> Thanks,
>>
>> Praveen Talari
>>
> Do not keep this thanks/regards here. only leave the comments.
>
>>> +    }
> [...]
