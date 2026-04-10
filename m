Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882D35E55D
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816208; cv=none; b=ERGM0StHYLxSjuQz27Qso+Y4Z0ujDX0D4rDT8FHJnEocvQRDfkzAYF0tj30M7zwQqJp5H+uUXRf2G0yPm/HjhHFT6WzDVhZ9yi7iOg3DmEUIAqR34Q6ayGV83HNvg/ZJ3HON+iLYAdurTcNWBV8QvsRO1NnSbMr0E4mNsJ6dJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816208; c=relaxed/simple;
	bh=tK+6dhkESyt0FrN38dVAeRjm5dFErjPyTdH2KYDm+Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ8+k3xocNtLEAtz6qpyUbSmOsFlpsan8YRUISdrIxNGNkdSdhLFWAn2RCvD/6Y25r+q890EzPe3/MWuifGQ4brhoQuVn5KXtDh6P1MKUP9ffD5Vb4nT90qUuzHog8YqvmgBeI1SFMP6NUzPHMCRMhD9N/XJO9SeAvhEPjMblNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWzGM3WQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4pby/NM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWzGM3WQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4pby/NM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA65mN017527
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=; b=LWzGM3WQFiAU6RJR
	tY+utxEjkSbrUkh+oCfMPUEip3mr5IU5MUs9rvy+Q0Sweo8DjNPzls4lw5jA0vMe
	AV/mfjWUPxuvkuSKqCu1n4NV9f2wWLcABtvwqc8uGeqbmxht7jsb2V3M5QQglWHD
	oiKk8oTKd5hNQLNzL02ZNHytIfs5TF3uzjTGpp3anltCrvaGhbXDH59ofMADu/0D
	wykL2rzD/2ucsx4sGjEsIE69Bv1nDK20oaNRsJ1Tw/nhapoBSmwLkSnhnV7E7IDd
	6ZgwC7caIvvorbU8qrlp/rkjfdh6VFkCsoaHZuvHrsUMOFfe3UN83C+KG2Y+bu9l
	CWw8yQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5j01qb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 10:16:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d9278587bso2023841a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775816205; x=1776421005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=;
        b=a4pby/NMK5z5KUm77pb1zWdxoZkpsWNPg9TciaMl0qK2KHt+lNnIpKvr5cEEEUMIAF
         6rSq8M55aAEqOMqrRJ5gvX/Qyk8jqP3AmVMwQ6R+ozIxt7aIkXls1YRceWsJFYsbV/jt
         hfUFWgH+PPQjJ/jtVf3FSWLaZN0QJSd7DSDqJyMEcWXflitokc9qhlDleGPFkWkSgVUv
         VBp/KuaVE3t7YX0SpY3Pq8zAvyplnCeVA1nK8fa8SctoaY/Ay/sjITslifmpwfq/JY33
         O9hFtTV+gebGi4btoYB5q+iinXdEmsiN+A20ME0XNvWlL6UlCp7PEXvvWLj8fW2fAr1n
         JOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816205; x=1776421005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWLLA9vRgMxLzH+R7T6INqv0GkwFLsTjR10pSbI4x0k=;
        b=dv1aCe4LCQqFBFYWYecRGvBSD54IvFRea1dA5tMkC3aU4o0TRzq1l8/y4AoCkTwVDR
         zhhIp/MX7oPAPgjS3juIRMQm4snF1xdbiW9YjAuB1Hub5tHfTI3zkyN+nE6qQHbj3aLA
         ASO1vn9Va6/4vJ6zJqHzX9Vq0w7Y6dNur9p8P3YiqGSRGo1ir6bB4ZpCrEsSHBnAIVOU
         fPdSZLgIYwaiaQjoBl6MSiEE1r+I9kKzvPMK8t/VjaI0Hl6UL2IW+xwHGWvyP8NJpCP6
         veFcBb2QFnIdo9O3gIP2PQmF+ftlVNYQ/lsmIYUqTbDCvfr4IcE8IAarDQ1O3YvB7SXn
         UlqA==
X-Gm-Message-State: AOJu0YyFn5mUGXFZIdlEjJtQxDn5UGKcj5FGe/roZwXrS5HSdjOtA0hl
	qYgstgtpumKtCHDLJV9/NgPoIHks3SZGQb2Nd4nm+H3lnjJreXYHQBRKgb3Tn4r54c/k+wOHudP
	Keoo2vI9f/oesInodB6ip118o72BLqKbUQBn4Ug6easXODJs7xmCn7A+Uzaq5CV4=
X-Gm-Gg: AeBDiesfXBQjjyYd7ikntZ82mrSJoMVYdgfUpduX0fNEG+qyhLL/UPhvaD+7LbXf7Ly
	EQYzMOCwJ5WMoM3vdiR0bWW3siOstIeJ5/RrgTQOdr8bM/aJsO4J01t50qTl+G/dbE0gUHykB0j
	vNHZ6hLZC2NOM6E9z1ab4PDvo86TmzdUDwWFxi6s/LTDOmvvJDHuv8VPZC8XQOlI1W8JXqs9orN
	Hs6CrfzL+PMrYfsz0wN742I3LqT+gP4zajzS2EQ1F8mip2X6OHIFHoZBtvBTtXrWDKtUdjzC2dX
	4K3XKQc2ttrd8K1dvUA61XibA5yA0MfanTw5pe8D4u70ZMro1CZ6kTO4v6EGyzlPaelMf9OnLpK
	vPvi3aTpXzVI2TNZnakJNQlE06tPBM42gp8osfSjS6ZzDuMD/OuSUIXw=
X-Received: by 2002:a17:90b:4fc9:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-35e42815bccmr2699517a91.15.1775816205346;
        Fri, 10 Apr 2026 03:16:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc9:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-35e42815bccmr2699460a91.15.1775816204836;
        Fri, 10 Apr 2026 03:16:44 -0700 (PDT)
Received: from [10.217.218.160] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42e4517fsm984703a91.4.2026.04.10.03.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 03:16:44 -0700 (PDT)
Message-ID: <587ea315-9cc2-4ac8-919d-fe34b076f63f@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 15:46:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260403084135.1300931-1-aniket.randive@oss.qualcomm.com>
 <818da0cf-06e8-4a26-955b-67a3d5392e91@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <818da0cf-06e8-4a26-955b-67a3d5392e91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K04jHXX8cmMtwtnQrHqrm4GX0gteriC-
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=69d8ce0e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=v7GTtkQuv75T_6NhELgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: K04jHXX8cmMtwtnQrHqrm4GX0gteriC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX6p5Q18WwmNae
 xTbzarhIFbx/shNteBNi4+K1FGlk9rVT0IbjAxbRjC7kri0+LDJ9LjXXMmWxCCuUk/k2h2F9YuQ
 HUdE8Enj/jHKUJanbT4iUNVuJIvfXkcA1791uWqfJObCxvMvoNum80LHRzuoW38w1qZu+7kn9YJ
 Vohiz0xm6nVu5Jt+Ij0jOJhQknMANvyF3ONHOJk6MvxoWY9pCg0LWU7nK5qevFN1QU466lC2VRv
 NAOUKGlaOr2u15RuJyFtTHIx8EfahyS2i1l/1VYRylUgsJYENtNVf0vs6kiaqwwwO3npG013bov
 OIJS5kQySOgrpz5xSuz3wIb44oPwpEhGq4QHH1Tb9OflNSseV2B8+0OTbb5JnxdldUAwca/XuJQ
 ksX7j+xgJkvHzpACTWu5ZCOXtqZj72dilRf4oKL4tN9iiGByfK5+lAy0vfOoc/cAB1qV0N5vfMJ
 GX66sUYB50a5ZyQo08A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100095



On 4/6/2026 10:08 AM, Mukesh Savaliya wrote:
> 
> 
> On 4/3/2026 2:11 PM, Aniket Randive wrote:
>> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
>> descriptor (TRE) on the TX channel when handling a single read message.
>> This results in an unintended write phase being issued on the I2C bus,
>> even though a read transaction does not require any TX data.
>>
>> For a single-byte read, the correct hardware sequence consists of the
>> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
>> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
>> mapping on the TX channel, and may lead to incorrect bus behavior.
>>
>> Update the transfer logic to avoid programming a TX DMA TRE for single
>> read messages in GPI mode.
>>
>> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>> Changes in v3:
>>    - Added comment in the driver for better readability and changed the
>>      position of 'skip_dma' label to allow dma engine configuration.
>>
>> Changes in v2:
>>    - Updated the commit message.
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index a4acb78fafb6..78b92db7c7fd 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, 
>> struct i2c_msg msgs[],
>>   {
>>       struct gpi_i2c_config *peripheral;
>>       unsigned int flags;
>> -    void *dma_buf;
>> -    dma_addr_t addr;
>> +    void *dma_buf = NULL;
>> +    dma_addr_t addr = 0;
>>       enum dma_data_direction map_dirn;
>>       enum dma_transfer_direction dma_dirn;
>>       struct dma_async_tx_descriptor *desc;
>> @@ -639,6 +639,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>       gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
>>       msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
>> +    /* Skip TX DMA map for I2C_WRITE operation to avoid unintended 
>> write cycle */
> Seems you are missing writing important point - For read message ?
> Important is to clarity what's the condition we are handling, Skipping 
> something is anyway clear from goto skip_dma.

Sure, will add more description in comment for better understanding.
-Aniket

>> +    if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
>> +        peripheral->multi_msg = true;
>> +        goto skip_dma;
>> +    }
>> +
>>       dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
>>       if (!dma_buf) {
>>           ret = -ENOMEM;
>> @@ -658,6 +664,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, 
>> struct i2c_msg msgs[],
>>           goto out;
>>       }
>> +skip_dma:
> Better name - skip_tx_dma_map ?

Sure. I will change it.
-Aniket

>>       if (gi2c->is_tx_multi_desc_xfer) {
>>           flags = DMA_CTRL_ACK;
>> @@ -740,9 +747,12 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>       return 0;
>>   err_config:
>> -    dma_unmap_single(gi2c->se.dev->parent, addr,
>> -             msgs[msg_idx].len, map_dirn);
>> -    i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>> +    /* Avoid DMA unmap as the write operation skipped DMA mapping */
>> +    if (dma_buf) {
>> +        dma_unmap_single(gi2c->se.dev->parent, addr,
>> +                 msgs[msg_idx].len, map_dirn);
>> +        i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>> +    }
>>   out:
>>       gi2c->err = ret;
> 

