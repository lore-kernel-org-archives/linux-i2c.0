Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47206568FD6
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095412; cv=none; b=at46JZBSL6utvO5Q0kSGL2gvlVUseIcl60AoqVbAwfZc7Z69fxh0xUG8uaqBWlEPmnSW2NejXqSD9/6LlbdZMd5eOR9WDvuLyq2/Z+XUUyz6i2gT6xUBb9nR4MQG9rcOEwkjH6nQsjxed+qgcoIWrsvO3JyHFmEI++u6h8Nz/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095412; c=relaxed/simple;
	bh=cyZDxf9ZGerneusrYMC+mjKJ3ULjO5mPbl+jTMslt68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foI3fFgERzww1NAIm4omgmk1CuFNyqmx5YlxgEObO5JbCqTZghTkVk02HcUArn/oR0N3tDtRkAyRSTdgh6VAO9Muo4/1KH8XuMIA8mwx8+ALTx72sdYPLs2grYuE6UbdoZGXmGT9z2ZpwhZzPKRtd1etRO7c8NsKKeD3roGHFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k4bweDcG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDWY9xl1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k4bweDcG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDWY9xl1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEiw1P1422833
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 16:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rxzrr4OM/i56NH2eSy1sCOC7KBsVALJwpkrxsZPhavc=; b=k4bweDcGuqiPJPpB
	sdUGlwOc4YHUr1/Glx7IQM1oBInJvRG4k2Qcb76j5lUzyAHYbcdq3Wz5zllqRDSr
	t9TlfLVSdnTwaORIMz9n4FApk6vuy2qWSprcG3b6fTubAlobAMyakP1Loqv55z3q
	zBRzdcp3WCfFL7EXVv6hTQKjj0ZShNz+xrwHvsvpnN470gGctqMz+PNkBHKABE0B
	z3e9X7XVnUu/ZiH00Lf3nWgc24gmqw8syxofIYLBmzmLr2l7uqyqyZ17DOcI43At
	TmuZPPhIkB0Wi9ilDGCCRR/s9R/GhvzL/jnfXys2K5PHZvX4SRKLHZfcVvLW1+Vl
	MfUolQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guqk4st3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 16:43:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so35869a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790095408; x=1790700208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxzrr4OM/i56NH2eSy1sCOC7KBsVALJwpkrxsZPhavc=;
        b=XDWY9xl1dP9XTOiPzKZHVG3YHSTQGUI+c2frF/1MWvIlU2shCsrxtultrrQ+5iL/lU
         /NplyYiVkdUCHp+KDkt8Oo4vEJgRQE8rzscYmfeluXGmGONyGQP0rfh167Et7APAMz6y
         2WyhNIcBMH59NJzQqKt1eUciCI9SqtiiQI9DZY6iXeRpseQx7o/dz4KZOxJTjok1aB9N
         u1PmI6nSChoFKdrgu5b4RS198ZXPzYwKZ7B48pocx5JORUIzTLPhgV+QU03klKDcd/xC
         DW13tu4FlVypKUzT0qaLYi7mFWAAnoOY/ZDTQ4NB8RhYDl5t8phPvzFCLFFtdJ7x2oIi
         6k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790095408; x=1790700208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxzrr4OM/i56NH2eSy1sCOC7KBsVALJwpkrxsZPhavc=;
        b=x5k4LljmZrFmfscOouAUbo82t4NNrS/hk+Bk7iPIHpd+Zi+1ZYHWaYzuPLT/vO8f3Q
         2hoevVE0Nfnq8nAaHKa8RA3WNE8oAbfN43/+1dw8+psmTGaKrjJ/tQDajBWxHk47eYdN
         lUR0IyiUchqeYIA3PI7ZMKhpLT4/xTAelvXbygdXPUmg0z6vL58bEYpATXqDD0BK2a0x
         Y9gVy+apTjW2Wkvt2xTeNjvBGegkCLl8ryub044bbI12MZ0+paE92ltDejhzRVeJW/oN
         pXA4vD6jzd3pOm21lA21Cb1UcjO9fB1wAT/fflI38XxQeZM45Kb6H2fIc5RIhjbZZ5qK
         /fhg==
X-Forwarded-Encrypted: i=1; AKwUvBxAaQkDE/f8f96tnFd8FAOgMc9iJCNk0exqplPu0fSjnttB8jzPhTWzAgIkjmCNtiuy69qD8vgE+a8=@vger.kernel.org
X-Gm-Message-State: AFuF++mIsaV9tRlUqI+xvGcQl97d3B9CYOnicnafCCRvR9wceXTZ9QZl
	n0B1VaC2jqPrCEOxVInnYdUd3Z0tslREhM7voU91B3d4xG7h+xiYc/vf5cJHvwaWwhgqhXFlnRM
	f4kcZ6ED4qOBTsU2fttDlE8+naXPxSRRal0N3iOtTGiJ1MY4qmAvOCCjMDDzUHgM=
X-Gm-Gg: AYBFou1qckcMOHRj9Hw+G8FWv/7dp4n/pz/KNe3DQLEnAz0sw/i3t0HpnV1RJV5uxM8
	z+cR1It+B3Df7VaJ1d9vMESzOC865uw6mjmNpFuX7CgMLypTmQ51kU2nEGJIj9QkZ5AFJxy7+mt
	eWqr1l8YckYkeR00hSefdeCJcTDvN9vkuV6TvgYJ42Ll3UpkhAbr7T7cTZHN+YJOOlQW3sj/emz
	/+Y9J6Ycj7ItiuWoYn4OUCvPHY1sOf01hYLd8QyHl0G0friupXy04ynybpa3DrHE6L0tRf+FNo1
	ncN/hEQ7ilKibMpZOW4WLX5uqyK+zbRk5vAR/zDkLd4lYiJoNPb9/Z6D5radeWtHXgtQGR9DXBo
	AYiuHS+Vv70snjad6EdJDuP/aQeg0kJPO
X-Received: by 2002:a17:90b:2681:b0:39e:6c66:cbdd with SMTP id 98e67ed59e1d1-3a07e595817mr23451a91.21.1790095407907;
        Tue, 22 Sep 2026 09:43:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2681:b0:39e:6c66:cbdd with SMTP id 98e67ed59e1d1-3a07e595817mr23429a91.21.1790095407418;
        Tue, 22 Sep 2026 09:43:27 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.233.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cc3600bsm1385719a91.4.2026.09.22.09.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:43:26 -0700 (PDT)
Message-ID: <17df503a-d0e6-44b7-9124-f7e65d0e3ddd@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 22:13:21 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com>
 <9c5acc6f-779c-4191-ad3e-a86370aa2ab0@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <9c5acc6f-779c-4191-ad3e-a86370aa2ab0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NCBTYWx0ZWRfX3oLuMUc9FiAD
 6KQm+R9aDh8fft7ZO8imtZMt/1FZSmOdxne0rUOxwQBwlA5LRaRSaDFEeZA51+d88QcXyxiyFDH
 YYaiuFnqtZmlTW3K9+LUwIKIYEeu8zWyX08Lu3bUVZ0+Dj8Jypfmo1ds16Op0Futl01JfP5d0p2
 a1kKFSy7JbqN82cHLf2uoT30btpK8wCWFtAXq10u0HWM+1Gv3vM7Do3skOEupZ4q8Y78G8ENetd
 WrNSjNtDfKvQwTqazMSES3BRl1xjrgw/YPdNg0eh9KC0N/6752ifAjizmxrahm2Jk6MxMSPChM4
 24oS4M4OcFw/mMYEAw5Q/ZZSHF8WlBDE/G1agUhem+SHWeklo2KM+nO8f/6P5x9r2+fOeiQjyXG
 ljSvZSJkcKjtdtTQZ9pXZ4yykr7tSQ43WSzwLx6voSiBW94k+E5n5aEEmUfLyrMPd+7twK7U+c1
 JE8t1O0z49Ga7k8ONeQ==
X-Proofpoint-GUID: HPH4ZcVL7Fie6BQ9ZqCxn9SCm4L7oeb5
X-Proofpoint-ORIG-GUID: HPH4ZcVL7Fie6BQ9ZqCxn9SCm4L7oeb5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NCBTYWx0ZWRfX/yn8Z0imhJEf
 50qaduXfiN3ImvZ1QuaRUFxSl/qlcLms92+BMruQAM1yRwa07lsVRvbwyL0/GETgb+8Np7m9KEy
 V4LGFXun4lkN7mZh81deJXSWk41/IFk=
X-Authority-Analysis: v=2.4 cv=XrVvqlF9 c=1 sm=1 tr=0 ts=6ab2b031 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=o9TCyQ+7hPaS30giwOcRIg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=vRfu3LOeS0ZZhPwgmuoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220244



On 9/21/2026 2:44 PM, Mukesh Savaliya wrote:
> 
> 
> On 8/28/2026 3:59 PM, Viken Dadhaniya wrote:
> 
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 658636c1ee0e..a83297b5fb0a 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -82,6 +82,9 @@ enum geni_i2c_err_code {
>>   #define XFER_TIMEOUT        HZ
>>   #define RST_TIMEOUT        HZ
>>   +#define GENI_SE_CLK_32MHZ    (32 * HZ_PER_MHZ)
>> +#define GENI_SE_CLK_19P2MHZ    19200000UL
>> +
>>   struct geni_i2c_desc {
>>       bool no_dma_support;
>>       unsigned int tx_fifo_depth;
>> @@ -127,6 +130,7 @@ struct geni_i2c_dev {
>>       spinlock_t lock;
>>       u32 clk_freq_out;
>>       const struct geni_i2c_clk_fld *clk_fld;
>> +    u32 clk_idx;
>>       void *dma_buf;
>>       size_t xfer_len;
>>       dma_addr_t dma_addr;
>> @@ -197,19 +201,42 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>>   {
>>       const struct geni_i2c_clk_fld *itr;
>> +    unsigned long res_freq;
>>   -    if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
>> +    /*
>> +     * Counter tables are calibrated for a specific source clock frequency
> Minor: Frequency counter tables> +     * and are not valid for any multiple of it (e.g. 64 MHz, 128 MHz).

Updated in v2.

>> +     * Use exact=true and verify res_freq matches req_freq literally to
>> +     * reject harmonics: a 64 MHz clock that divides evenly to 32 MHz
>> +     * would pass exact matching but produce double the intended I2C
>> +     * frequency with these counter values.
>> +     */
>> +    if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
>> +                    &gi2c->clk_idx, &res_freq, true) &&
>> +        res_freq == GENI_SE_CLK_32MHZ) {
>>           itr = geni_i2c_clk_map_32mhz;
>> -    else
>> +    } else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
>> +                       &gi2c->clk_idx, &res_freq, true) &&
>> +           res_freq == GENI_SE_CLK_19P2MHZ) {
>>           itr = geni_i2c_clk_map_19p2mhz;
>> +    } else {
>> +        dev_err(gi2c->se.dev,
>> +            "Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
>> +        return -EINVAL;
>> +    }
>>         while (itr->clk_freq_out != 0) {
>>           if (itr->clk_freq_out == gi2c->clk_freq_out) {
>>               gi2c->clk_fld = itr;
>> +            dev_dbg(gi2c->se.dev,
>> +                "I2C clk selected: freq: %u Hz, clk_idx: %u\n",
>> +                gi2c->clk_freq_out, gi2c->clk_idx);
>>               return 0;
>>           }
>>           itr++;
>>       }
>> +
>> +    dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);
> 
> add a line space before return>       return -EINVAL;

Added in v2.

>>   }
>>   
> 
> With above taken cared, rest all looks good.
> 

