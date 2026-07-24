Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D83BADB1
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893904; cv=none; b=pOL2rBGDDW7LxL12JUigob/8Fb7gzu+bdYc390XhkRHTR870HYhXpy1SfBUUW368Cpoi6ey7uGEglCoiHQK/D6mxsaRKRs47fFFm2Fqbp+np9BCZOvhoGE1rmudcEog2W4WeyAK/OhqSPKq4GPKcJSdjl55py5tjj6+7uIRDJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893904; c=relaxed/simple;
	bh=2df76Hq1fxBJkUDL1GqgSU3U597vIsWYXqTyKxN0C7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3mkb0rOyok7RElbRgM7PtBvVsBRfCVwX9+R8FWeYAilNKLhHXYDIbw4Lg1cmW71Q7ayMfUyzWCGo/9w+TXPGYnocjHH+u61rpiYgoENhhhNXZW3J6pOemMYXt2mpdG4CbVtE/PbzVWjyC4Z7mE8Rkdejue8ZUcrA8YJnkP8U4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hjpa91iB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfBh87BA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hjpa91iB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfBh87BA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADeJo2629873
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lpZOZUVSR3UDklXHUMfaZKPc+pQ708EZRHqKjSg4d6A=; b=Hjpa91iBL8e3pFrr
	g029iHhLQj2k3izfJVS8ER4xIWYUqIaxiNzQZ2q+Gmso2VC7axTnmiB4P0tCtfbd
	FIBtvy1h5Jnv7YwYqsylfwp9MS4OOi59PwQTSd36MjCGX4d2hoj6fFkiWBxQaD+V
	aMV6CoBb+noE97ydqmw69S+WxsKlOsi8LdZD9c5soAKWq1rb4IuBD/eyDy4AmNF6
	79yJdWOF72n5B7ZPQDdBiAksux7ra0JESZ4jYzDr9Gza/Nd2Ig45TLJ82sUGfzzQ
	QxNDvMNa5PPxYRHuWx5EZWumD8q6NVRMXDCi622EyI5UU2CoEQACybNZGTVS9UT5
	/Oej9g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm1em9fm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:51:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cea6a46766so6584905ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784893902; x=1785498702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpZOZUVSR3UDklXHUMfaZKPc+pQ708EZRHqKjSg4d6A=;
        b=dfBh87BApXooVKPurjXIuNvRQqjGza2XJrq0l2QljUieTaKp/3LQpJ9GvCM1u8w2XU
         8bWIrZwP33E6M2FFLqU5yvnZHjgLm4rhSe5NZhXBCFDwLxCXhqz7WFy9qhTkAxCvh+ja
         vSn9TSS+K+7PVI8jXbTPzHGg8mGWBUwBSswH6VSS3uIijmUet83gTshOw6DGYUcggrMM
         pyGMXIa5Kt0985Nk/J52Q93+9ytHjE/GSe2Mui94qzlBNcio/mYudrK5DSjceb0/Xdqk
         ZilgG7a500gZHd7+wKyjMbQ3S2c2DZZfKcncP8ek+7/PLDp0xMANJfc/ttxJY8xdiVwz
         Lhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893902; x=1785498702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpZOZUVSR3UDklXHUMfaZKPc+pQ708EZRHqKjSg4d6A=;
        b=WjTPMkma0fTeZlrvTFZuT3OvtbjMe5R1R/zw8eDQRdM01X++6jfzzwe8yMlrwkW8NJ
         JudKw5C2FJizQEDE4k16iH3ohyKz5sP6Vdadd2flsylcT/0MR6Nx+DmiTRpEr0gq+ubj
         gTdOG8vfeqDbBSA0J636DD/m7Xjwra7x1lbsXxk2uzI5a1lVOMJ8t0ctZlWKBI+K+AB+
         yPZE1s66/WR4T1NDinYL0ZNnY3yuWwmOZ9mFOEE+X+O/PwLNX07oNlvepzBvqPexqB7G
         RKpYxebeLHGvSCL6/0ezZRX2wXht/RmJTm3Lprga5gtT8lIOAPdN8JTMQ9f4bWXfR1JW
         994Q==
X-Gm-Message-State: AOJu0Yy4/BkgITGYvQtGLfCHr3SCYHQWKWSOdAEfiroo41sTmP8EW99l
	Dts5XV+XuLxPW5ImZhPDjrKa86pRMC0u3Vx8t3R0fTnZqfKJtqRiNXlmxAvic/iI/vDQHXTnybZ
	K7IQT0gAGyHqR6zzGlLmWBaaRvvp+L3N/apoF/q2SkxMkSaFNP7IUwu/E4GqHalg=
X-Gm-Gg: AR+sD11ktG2tDqPA0e1yNVySGa3Yz55IJJPbs/93lm9ZKyJ7ClB4/90zwsjKY34CCe6
	L5RfC46MfsSji6AtgCi7c2cpaNANfQKN2o5CJvRvDNaVBhOVlST5uBbzXCu4LWfSU+n4t504Tgn
	IifuXIOdhqd/bHuCOHrdlZm8lNLVz689ji5+bk4JKkWS9lamj96lsjnJSs7hNklyjQTplvTF14+
	eRuBOROgGJ1qCQ5B9mGJ9IlTm17NWmSsqI0VXMhV0MRJbze8rrc8ieGuNGtaWTywamyh9k+8dNa
	hEy7EyC8NVIgR7/OtKj+SYYRfO+TnINwKnwEBoPpfo5Ouv/FuFPvloYNjYSl/ULZ5WIiRTRAmAe
	27N/aa6U7FYCztEJujTBzchSg2seM/pLn
X-Received: by 2002:a17:903:2c9:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2cfa71cff69mr90800005ad.47.1784893901818;
        Fri, 24 Jul 2026 04:51:41 -0700 (PDT)
X-Received: by 2002:a17:903:2c9:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2cfa71cff69mr90799645ad.47.1784893901291;
        Fri, 24 Jul 2026 04:51:41 -0700 (PDT)
Received: from [10.217.218.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f35027dsm50225835ad.69.2026.07.24.04.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 04:51:40 -0700 (PDT)
Message-ID: <6427bc6f-c7a7-4b9f-bfda-be45233be874@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:21:37 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-2-671261b05c61@oss.qualcomm.com>
 <2b025902-8879-4426-bc81-484fd9553aa2@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <2b025902-8879-4426-bc81-484fd9553aa2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwOCBTYWx0ZWRfXzC0Axx4MI34K
 e8Fni+wbx0Y7rmVaToWIgGlSE/zZHhBgJh62EsCuEwcsT2nIOBiUM21Is9FLocUHzgQ7PBbLqhk
 qGN3hF2YfYOSvn0mHf1H/El2UOB30+k=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a6351ce cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=nXjxGClAYc_vj5dcU8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: oyDOt5CfeVTRmdT2Ia0UFQAg0lcBZoaM
X-Proofpoint-GUID: oyDOt5CfeVTRmdT2Ia0UFQAg0lcBZoaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwOCBTYWx0ZWRfX9mtFMfn9ZUDK
 a8sxEYBXOuDi/Jcljq7huPhloy72/jzLLytm9jU4FvO89PsBxvJhpRVliY5X6h5xnF0kwLTQqrE
 /IkE1qw9Xt5s9gXiprkpfYPliPu6EGzYoPwtOpmgPvTcHM9RZJwfu6QrvXo0KPhst+MpYhSXcD2
 aRi2r2ljhY7qACTKx7yRqNpZKSOZOLWcaJZe52xRJ9CTl9431W90a3hQkaNgIG8U1uiQrG1JGWz
 RbuJEWNf1eOuOUUSkq5Wg5gMaoJTnAM9YXekrmXwRo5jnkehAKyxavOXA9N4LL4R39WsReyfNcb
 7+dVCrTnu5x4l2uI5lLC2V2SE7aihKkjX747OZaQao3VKR+JBgI1BgkJpAsfAMNpL6X8+1w9p4X
 uOWXVj76rQLnPJP39pIlIVnnhoxgrzncyDpX/sUp59eIQ7CNxJsSWUYonbE+u0boRDMgnGmLlaJ
 jAk9AepoWDE5LYc+3Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240108



On 7/22/2026 10:56 AM, Mukesh Savaliya wrote:
> 
> 
> On 7/20/2026 5:11 PM, Aniket Randive wrote:
> [...]
> 
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 37 ++++++++++++++++++++++++++++ 
>> +--------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index 96dbf04138be..d6fab3aa8468 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -74,9 +74,14 @@ enum geni_i2c_err_code {
>>   #define PACKING_BYTES_PW    4
>>   #define ABORT_TIMEOUT        HZ
>> -#define XFER_TIMEOUT        HZ
>>   #define RST_TIMEOUT        HZ
>> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
>> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT    10
>> +
>> +/* 300ms floor: budget for clock stretching; slave may hold SCL low 
>> indefinitely */
>> +#define I2C_TIMEOUT_MIN_USEC        300000
>> +
> Let other expert suggest if pass from DTSI or hardcode here. because 
> this let all other controller drivers to make change. I request to 
> conclude on discussion, i kept my point in earlier patch.

Sure, let's wait for comments from other reviewers (Wolfram, Dmitry, 
Andi) before concluding the discussion.

I have already shared my concerns in the previous thread regarding 
keeping this policy in the core versus allowing controller-specific 
configuration.

Thanks,
Aniket

>>   struct geni_i2c_desc {
>>       bool no_dma_support;
>>       unsigned int tx_fifo_depth;
>> @@ -471,7 +476,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>       }
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
>> +               I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
>> +    time_left = wait_for_completion_timeout(&gi2c->done, gi2c- 
>> >adap.timeout);
>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>> @@ -513,7 +520,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>           writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
>> +               I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
> Expect some discussion or conclusion from other experts if need to hard 
> code these coefficient or pass from DTSI. if core can read like existing 
> i2c_parse_fw_timings(), it would become generic to every i2c adapter 
> driver.

Agreed. This likely needs input from the maintainers before we finalize 
the approach.

Thanks,
Aniket

>> +    time_left = wait_for_completion_timeout(&gi2c->done, gi2c- 
>> >adap.timeout);
>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>>   [...]

