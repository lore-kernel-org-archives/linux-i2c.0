Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F48409283
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801839; cv=none; b=M/A+6Vi9MSVrT8HA30wtTQWcggBhIOETVXinUucJgHCDu7ROhWTDWVXshWee3Reu7H2Dg4FALPv1Ip9Cz29F0IvJfV0625eLV1iIZ4AeXYAeKHIyal3Gh/cj10is0GynNhX9VWJXeU9xq1CJH+vfjB6aBnC1+f5ju8o7MMKJzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801839; c=relaxed/simple;
	bh=mDyxfx/NZz9oNnZFCPreKorg39pfBefeKdll9onCsN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWiz2o3yoUjUyTt5Rxp0QjjIsphGp/w6ZvE1QM+/JnCTUW1aiN7xGRXFkz1cpDDVcPLtposvUcG90cWp+LIkGC11fVFfST9jVirBk8Iw4jgvVfZRx5PV+AZAjoUjxhXzjPKmqc+GMx9aQoiHq7RUY8mFllcuBQmXYqQm2W5S9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdSRW8kq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNzYJELU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdSRW8kq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNzYJELU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qkbc3642784
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzqDP9svjE918lug8DfM2SuGbpL5ftEU4aAYCmv2ZJY=; b=UdSRW8kqefYachFF
	IV9dIp0qf3FYQToOala+OeCf+onFCRSUlJ5m/XLXYV5ewf7tJSnhJfq/y67tJXOF
	wa8YYhjuvkXW/xnvyVvSUrGA25N9s+RZXAjoQ8AVC1DQtI3I3PufosAMj/SXKlga
	p5cWJ8WTFYWjBTYlyWz1gcuhwYgtZnSmogzMy+h/RJS7U2V6fFWWicBHqKgaWBCc
	7S99MKBEB2/7vIUif2yqSTF2gKdBO3Sw7JIkocPzkKqqU1EBihIXwOpgsApXZ6I1
	g3rZx8/esa5F7bi/pfWiFcnoOJoamcfwyy7qYVQVbN91Nd4Gz1gIYBcvJpJK+lN2
	OIpq5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayh9hgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 10:17:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cd01a14e81so8377025ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784801836; x=1785406636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzqDP9svjE918lug8DfM2SuGbpL5ftEU4aAYCmv2ZJY=;
        b=MNzYJELUZwVpTKje6CyyjK2TuQpT9fLyN7jgF4WuvxZG1ucSFbwqmQFdpaGazjXuaM
         A8wsj9zZMTtyP/gj2F88FmD2mabzhbSmC43AlI5+rZ5yUuPDyy5+VChYKkShoC8XLm/w
         Gr6ezY9KbUeoU09UKtvStMzRandlE9/2VbHFcmqyQ0jISj2eXlAO6ckzC9vYx9/rJUom
         rLsYSyvbX8lB3N5qP/bvLZaiBYHM0lwVKx0ZlGkstp+fxDGQq5iGYqx+VjN1MWyzRpyb
         i/7pkql+VYO5P0J012mh20UlEi2OfoRu1JlILwX8CbzL8vwzsY11MWT0kPBN4nXBRLd8
         kZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801836; x=1785406636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzqDP9svjE918lug8DfM2SuGbpL5ftEU4aAYCmv2ZJY=;
        b=e9UPSQDrpnC5tYSH0bx9UyuVZB8SnMFmt6BXMRXofkpvv8O8fFJczg8SGth56fnqDB
         hUSla4Thz69e6LLAnlI1M6ggbvrWlqRtqIfes8T7qMI5VXOX7QnfTXP9Kz+Xb22KESrK
         pabUYV6qNsldEkHjJ6mweRcQX4QSJkwVa8M0Il/PuGp6M5+2ci0bqg926bt12r/FPKhY
         x9bZdJgUXl6uxD3sN/P68MKU0Cb8GKPi5aqFuOr1KVtriDlUldux7/jQrys9Z4Lc4qjx
         bJJr7q5Y3wDtaErUfW31xC01F9RFhtnCHAy25VBeAViFFdzfvNK4BaWw17i3D2x3dpyT
         RzYw==
X-Forwarded-Encrypted: i=1; AHgh+RpinYPFUdad6+yaW+7NQpBAA1DZbY1gAyLWXZl3pqQUdAOPlisxlpTR5fpN0IcNCZtefF+pVHeTn4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5PyK7XXA9ClZzyn+0X5xq2vDEQr/kj5tUwHOByRqTXadodw2
	75W9oesSCvjmQLn0SesyLo7JB1n89n4Y1WpIqaJcMLFqYPHNkYyj//TPSxuh4T8x47uxragom4V
	MfXujyh7+6IxdAMS2Kt9OClBewyu+mH9t6fAPuLWwOnzcMWcBVFg81l3r9zUYkmg=
X-Gm-Gg: AR+sD12srYbjfe2mRPvn1c46nZIZOF5spX1ba2W8r1V8FglY5OligcYGNbL3Ywr8kP8
	YlPMExwtLlEJBa9I9kxNYy/7OkJXDia4lfTvlkJs4kO1RFbyc2SUAMQA6fKsy1xHDOy466vof3+
	duI6wRuvNWaE4WXOyPWFsv8p5hn484AUVYPC/h+4qAaJuTJIJ9+Ad94fFYGJC8KnzHSIrPTYgAa
	H9FQ2rL0GpQ3EqX0xq/vCrBhvtKYAttVLhqxbXgd52IqIaDBkuC0kSVBISLv5i8hIKkObBIT+M6
	FrCLhi/MXphpvMDL1lnqvA/NSBp3Xe3vtyXXtfuJPkBTpwiFcAj8JonXT/gwhGAtiIM6vBiNXiY
	fyE625erfjASXWwOFul/pOVJoKSVgmTEDFBs=
X-Received: by 2002:a17:903:46c6:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2cfa6a51b56mr29011765ad.2.1784801835675;
        Thu, 23 Jul 2026 03:17:15 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2cfa6a51b56mr29011245ad.2.1784801835131;
        Thu, 23 Jul 2026 03:17:15 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b7c9dsm30151915ad.83.2026.07.23.03.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:17:14 -0700 (PDT)
Message-ID: <933d864d-f0c2-4727-a01d-f564eb854d23@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 15:47:08 +0530
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
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <9cf5b5ab-c418-4b0d-8b2f-b888a64db0f0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a61ea2c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7hCvE-jUh320BGmwNlAA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: o56ERBi4gwUTT4-_LACH7BWHEdVs4FqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwMSBTYWx0ZWRfX45urIrX5NfWT
 o2lzJ60nqenQtO6BFsG75XH+sbNvPqpS5B/HcEZbKQu1R9Ysz3O/iz1BLXIl2OFAqu+Gjq88Yg9
 oBPVFRxVjnfXJqqxgI4lRBpBAqB8RFZxOlVtTIzcaThnkQoL7lRnc/AePIaieeLjsH1ZjHBCCNP
 ihAoChqBeJDxwfYT7aefoIrfK/FncZ5btV7DMgQMIlvuvi2sNR/dA0LTzK9aTQfaeIarv+gCcY+
 jhkXrMegQ5fUqt93hv+/6GwxlQyFu349YnAcKD1JeIafs4rb9jLg4wbY6lEIfD1EdOejnDqaJod
 2euKPxaPHPF6cqd5sc/SDEFRP/OnD8aB9Eed+mLeMruVW8AhPoP279V7ea2Q9rHYEwvgLKvS5nW
 vNQxnOz0coRi3Pj2eq91DrXEQnwBMGrt8Y3JIS8fvkAVI4UAqYKU2BNDhqN40ZgF53H7wAR7GfK
 upqvva7Fa7JsQ8O8MIA==
X-Proofpoint-GUID: o56ERBi4gwUTT4-_LACH7BWHEdVs4FqH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwMSBTYWx0ZWRfXzRXdNMWiwq8p
 j4G5I353G5pHzEYksKli/4mDw2IZzXt2C989Z5iLIgCi1wwBL/ls+E2E/Iq9QnEgPiGhD4QpHEF
 3nXwm4E0x81h2IkcfQCLeFzZoqsbTOM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230101

Hi Praveen,

On 7/23/2026 3:32 PM, Praveen Talari wrote:
> Hi Mukesh
> 
[...]

>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 96dbf04138be..4bc00922cd97 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>>   	gi2c->err = 0;
>>   	reinit_completion(&gi2c->done);
>>   	ret = pm_runtime_get_sync(gi2c->se.dev);
>> +	if (ret == -EACCES) {
>> +		dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
>> +		ret = 0;
> 
> Here it is clear that pm_runtime_get_sync() is returning -EACCES from 
> the runtime PM framework,
> 
> which indicates that the request was rejected before the runtime resume 
> path could enable any resources.
> 
>  From the rpm_resume() implementation:
> 
> static int rpm_resume(struct device *dev, int rpmflags) __releases(&dev- 
>  >power.lock) __acquires(&dev->power.lock) { [...] repeat: if (dev- 
>  >power.runtime_error) { retval = -EINVAL; } else if (dev- 
>  >power.disable_depth > 0) { [...] else retval = -EACCES; } if (retval) 
> goto out; [...] out: if (parent && !dev->power.irq_safe) 
> { spin_unlock_irq(&dev->power.lock); pm_runtime_put(parent); 
> spin_lock_irq(&dev->power.lock); } trace_rpm_return_int(dev, _THIS_IP_, 
> retval); return retval; }
> 
> The -EACCES error is returned when runtime PM is disabled (disable_depth 
>  > 0),
> 
> causing the function to exit without invoking the device's runtime 
> resume callback.
> 
> As a result, no resource enablement is performed by the PM framework.
> 
> 
> In your change, the error is effectively converted to ret = 0 and 
> execution continues.
> 
> How can we guarantee that the required resources have been enabled in 
> this scenario?
> 
> More importantly, where are those resources expected to be enabled if 
> the runtime PM resume path was never executed?
> 

This was answered in V6 already on 7/3 exactly at same place.
Pasting below.

==
 > Why we are checking specific error code here? Why can't we use the 
below error check directly?
 > if get sync itself is failed with pm runtime disabled then why we are 
going ahead by making ret = 0 here? How you will make sure resources are 
enabled?

This reason is also mentioned in the commit log. we surely get -EACCESS 
as runtime PM is disabled during no_irq resume phase. We still need to 
serve the transfer, hence we need to override it.

Review geni_i2c_resume_noirq() to know what all we do to enable 
resources. That's guaranteed and tested with system suspend/resume test 
back to back and PCIe could do i2c transfer successfully.
==
> 
> Thanks,
> 
> Praveen Talari
> 
Do not keep this thanks/regards here. only leave the comments.

>> +	}
[...]
