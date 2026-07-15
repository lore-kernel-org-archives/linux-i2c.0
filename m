Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CA43B6D2
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109917; cv=none; b=fUzc33izB7Lxvi456tnjnlYXCUNzJQW18k7t/IGUtQu+AdRAKbBmWi9roOoqhTOK9DR5cjWNVSqrQfWAITDSlh4l2sMdBHm7FOrNuxouR7dRwWuLil8NMFsiMXD3F6A3WA9Ywl840si3bIms7EFBy7whtGG+LHLD4t15Qn6+fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109917; c=relaxed/simple;
	bh=LbNgYcWtJ6EleG0VPELh85DRLTftctcuvjFpUmM5vgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP18Io+NrDuEyksPNNMFZm0AZojeeFLjbh2QUNN/zwL0+HeAUotnzxvTzZbyxoe9PBRifzyFsRmzTu6N7JY65tcRWvY4mekfRBBWO1VFeeMhWJNxotCRykVA/45cWdBZXu1CzNtSZATvNSBbOcNVjS7bal1gcPxdt49o0g1IXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTh5Fnct; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7giyicm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTh5Fnct";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7giyicm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F7mcqm3143232
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=; b=LTh5Fnctn1zN9gfG
	8w2C0QzhlwwmTDvtrld62C9SeZg7nQt0der8k4w6oR3QXAXJ2gY7f/TrCB0wBgLg
	viqWIrHgHdgTZNyKcUzRtKFvkCdPr40oMImVSJ2FJRDcA4SlGqVD8cxFEMVTLWml
	QB62TqHvPtDdkSm+Z/7Jt5Sb9kXqBI/YsQiu8q6CkkSzeY8P1c6zzGWpFhqK1vIG
	JVP9EDwiSJBiMn/J3sjG+QYtfXuKscp0dVLDuBr9ezNaYPEw4iARMonm+sPpXpiI
	9eIoNmosFM9i1aP+sXKITngk2OR1Ptyz4nl0aPhdJYi8r2rJli3Yuvi74IeH7nrI
	/PFa4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe6528gcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:05:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce02cb769so25820675ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784109914; x=1784714714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=;
        b=e7giyicmQ8G1Q2heQ2iesOMMfsoRj5EgHAOKDeTwX6P7Z7VfvI25C4uOLl4DGSezTs
         8PUzGz/U8FH+3QY9ZKsU36ARNrD/QM/e7V6mX3jdNH+katp2ZUmx9wiYRgUyWL7oiMqI
         bYTKq8YbEmzYwdP4Bvdkg+yqKHBNgOl7GINo8MI02pgCvmIkXrYN+3MVx1+xJhqWzYOp
         /h+CERCnVMpgK+ESddU/kLnrxpVRFFSopdl/ycG7f49E+o4tWPMsQP3aP6ZyZckHZKCN
         MZFsez4B7xZ9ZS/PgtgMsVDH96NRrqhBbJ2Nj8c+69ZiySDHVYZhIOxk5MPqmo9bjUnu
         miwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109914; x=1784714714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqzgSP5QBmA9GAEIiwoOdcOIySaSoE/ED4xZMe7OFWM=;
        b=THNYhsoxXZcBob9Hid/e16+dwUxdEVl7KtA71I+oAKpxTSfvcthqVXd6W+WrWU+Smq
         YNB0gUqnboKMBx5kcoCVqy5xhYkbtW9SUNvUELNRVHSU/XvU++3Hnadgmb7wi778htaa
         oRMSkp+kWY8F7pKiyXTMkhjXUAU8TmXxDIT5jQNeH76dxeM3UOZUoNZIhhUfuJQa+7zm
         wxUDzVPLsoUnAK3nvjtytQoPXqMkEFprdVvc+5xYGYmhZYdPKkVFOU7HUcvrjynCY/ix
         9SiIZZwphVjY9HMI/sVdD+u9kzgU980yOk+0iknxfwcG1kcfuxbQjnOwEc1SRBY6edco
         8TMg==
X-Gm-Message-State: AOJu0Yymqr+SNAw/81LS7viV03p93EvH8JIEugjBExDih8d9JoXRrGYt
	cPC9SuSSg7cZ/500ujz1oyJKBobpwLd5V02KB3zh/WCfnYv/7WNN1l/iE46a8GL+qqo2QViucsZ
	LIbqqsHdUxDM8sNIbEEJI/H6EJivGs2G7GtPc5V8fGAC7Mrq7xtpcm22WBxRPhtc=
X-Gm-Gg: AfdE7clpoPRNZvbO9+C3MMQL4gKcwLeFRGNAuyBlk5LuIfPrgJthdVBPMq74S22Rhry
	p5GhNChK+hlDMvn1Z2RPxNXr8jgbI5KVugfBhmHBLEO4iMlemmvgajH5XHva3nA46HztUoH4bZX
	98pcir0IbWFiNLhn5Q1+60VrtRmdqFTi3pREfellRa7Wf+zqOse1ziqGLCykKVp8O5QTSbRJPI+
	zyXgJeSUfV5F99sNYu2YfY4YHbajgppZXwtcYVqwzXIY6EcOqFmdL8heiKDIYRChgdBZrw3ybTZ
	Eo/i9wjCtU129+4kJ+I0u7/zPX+xBNN2aPQX2uveT7vy7L5IjWFPk2oEMOHJQk+VjnBZErbyp8V
	AB82I+ti8p7WNNvVz+oLokLGBjETGsybW0Af/xwPRWoo=
X-Received: by 2002:a17:902:d98b:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2ce9e5a55c5mr162929125ad.2.1784109914149;
        Wed, 15 Jul 2026 03:05:14 -0700 (PDT)
X-Received: by 2002:a17:902:d98b:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2ce9e5a55c5mr162928845ad.2.1784109913683;
        Wed, 15 Jul 2026 03:05:13 -0700 (PDT)
Received: from [10.217.218.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm130823715ad.57.2026.07.15.03.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 03:05:13 -0700 (PDT)
Message-ID: <54c99b8d-158d-476a-b965-bf2f64b16237@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 15:35:07 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
 <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA5OCBTYWx0ZWRfX6gOrlqtOdcvr
 pqz6qXLQ02R5GmGOhr62GI148ftN69I0gQrv24LbhhwZTKwSbjZVX8rYQr/pEk+C7sEx85PyTyh
 xM8K7zgwX5ZSETIE9Jk4zeEAJm6y4J7Zv5iA8j7Zz0xSz2w8zp6qNqh2ad8BZPn6/up8pgckBOV
 qmmdXJrfDVLU91J3W1M53TMNfuANZrhSFASNN3WDIJGTi7lXzDRZDAUu4TpacCTmR5aicJYdE3d
 MygUrFNeYFsw01MBWotgn0PY4uUx84j/qggL0o2nz792d3e9/hPa1yJsVCMdRNMRAAoOf9g4ajJ
 3RVuHB1b1ruBnLHflNjsJjxwr0na+XAKM0kEcrlPVP+TO8iwIY6FQ9DNgVrhz/gpN77+8Y4+A7n
 rMI0kExPj0754ydniBqnp222tdopgquz7+vjiwBhgf8bYrJ2PjIOKImfEwC8t9vxQMr+EaD2Let
 Jzen+X2jOMImrzIVkbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA5OCBTYWx0ZWRfXw6SOu4LWbXUr
 lAgOloLPqWPmTtzuRkA7yZ/ovgzo//0cLHiJ7F4PlkGjb7tLaswKvq7GiomEHxwsA9FXaXk/Tr5
 wMS492hMjPmW0ik5c9F3598rZTay78k=
X-Authority-Analysis: v=2.4 cv=bKcm5v+Z c=1 sm=1 tr=0 ts=6a575b5a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=z_QR8a_bo-jD1fP4SgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: tauVXbPzCbef3MKlzrpA4RkOhZii1BGM
X-Proofpoint-GUID: tauVXbPzCbef3MKlzrpA4RkOhZii1BGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150098



On 7/15/2026 9:36 AM, Mukesh Savaliya wrote:
> Hi Aniket, Thanks for addressing previous comments.
> 
> On 7/10/2026 9:40 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time. Add a 300ms
>> floor to budget for I2C clock stretching, where a slave may hold SCL
>> low indefinitely during internal processing. This detects real hangs
> not only internal processing but it may go bad holding SCL low 
> indefinitely.
>> 3x faster than the old 1s static timeout.
> Meaning, in such case/scenario, don't need to wait till fixes timeout.
> I guess, 3x faster is relative to the 1 sec, but for larger data and 
> slower frequency it may not be 3x. Hence, correct it accordingly.

I will update the commit message in next patch.
Thanks,
Aniket

>>
>> For GPI multi-descriptor transfers, use the maximum message length across
>> all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>
>> Changes in v4:
>>   - As per konrad suggestion used mult_frac() for bit_usec to avoid 
>> intermediate
> Do not keep space before starting, directly start with "- As per....."

Ok. I will take care of this in next patch.
Thanks,
Aniket

>>    overflow on 32-bit targets.
>>   - Updated the commit message and added a driver comment explaining the
>>     rationale for the 0.3-second minimum timeout floor value.
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index 96dbf04138be..c5c3adc8ec77 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -74,9 +74,13 @@ enum geni_i2c_err_code {
>>   #define PACKING_BYTES_PW    4
>>   #define ABORT_TIMEOUT        HZ
>> -#define XFER_TIMEOUT        HZ
>>   #define RST_TIMEOUT        HZ
>> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
>> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT    10
> Add a line space to make it look clean
>> +/* 300ms floor: budget for clock stretching; slave may hold SCL low 
>> indefinitely */
> Already explained in commit log, can remove second part.
> 
>> +#define I2C_TIMEOUT_MIN_USEC        300000
>> +
> [...]

