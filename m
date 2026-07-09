Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7F3ABD8E
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576198; cv=none; b=mrtJcpqwcK5gKH5OkiLm3Caqg7wwyKtO3bpsD5h3mSlp8/32irExoKGZoF2OYy0hGztxWy5TtBy1JKCVf5pHfVCtSwq2eDZMjcUD5lVq39c5LTyny3WA4sYCtYCOkVEhGD8R7/7HRkxHYvUpyjDNhQyKsHDZuGzPwZGwTsNrMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576198; c=relaxed/simple;
	bh=3N7yfM3uQ1okr5kka4rpaQGPCFucS7dK3w5eGF5hkEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tddBrTEmbD/OmKFloHAm+a8P6nZO9NGg+J3xMUCRGmZutjMXR94krCzQDh72CWPr/hwgdyI//n8gd3lyb81kwHxkjo3ZzOqzmjQTMosAW0ixl3L3DEJT5fpeT1HNl2rzlhqpSvKDcFWY3deLKpLnBjut/IijMRI7X3JFwr54+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cozis1wM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iXOFa1az; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cozis1wM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXOFa1az"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N9LPa002359
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 05:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=; b=cozis1wMS8L2FUgx
	cepcsHXh0axn8p70eC4gXcGvnSVEzEUff/y8/Ky99iBpGK8p90colMWMc2PFfBL0
	tvB6OhzqP1YGXGkh5yaY2umWomva21QRb1TxbT0eIG5ZutGQjMCDKVzGqMKqHUwo
	c0CIFphtqLF9FJj1NgD7XUGojKvPouvnGHRDybeg5YtPhWPS2rMJiU3+xaMOeKSi
	7mAmIr2+1T07vW+v7vQeL+3wgoEXHnL0g/K38b8F9nEMObXIA0MLyvByT9fryZay
	TRKvrdY6auPqCuphQxKQD0YJUYbl9hoOjnoYn7nrtwGIzuoe5A50Gc6PcoMt/XkD
	9LcEwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvt0bf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 05:49:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38112fd8b48so759504a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783576195; x=1784180995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=;
        b=iXOFa1azc4G9UT5elS8z9t4dVStefaMGGxJRUlc2CgE3O3v7PNmmzka3SUsrPMrNOA
         0XbKBXHOG9xvG0Szbw3Y0jNlMxIGjouHg0DEnDo9WGda/CtxDVNc5jGUFq+6Ui6asOrR
         vmGHO6EaHFYJm2kaW6Hou8ON135MzFdGIFOXWugNHBU6N5ykH+IrG2++36whsJ7ewjLz
         QH6MMUMK5l2yFOO9LQPU0OyjFhw+1rrmM4bWQiNsBV+keUU+ZfHqEcoQWBcm5MUk0fRY
         J2+QMz6mHhJpN5A0VHiyguYteBkaDk17aN92+8dpE4r07tMmTEuuejgxkf1mPt0DD7iS
         jO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783576195; x=1784180995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=;
        b=YYT/HltDHDm4uQxINKA6Ie8zpMVSglyXpCwO9dzi/Taq9XdaWU9Nlq3MmwftPA85mV
         hLV+NMibayk4LPCTGoCAJYg7zdhzveZQ1eC3hSXtjTZU1NqP6SS7Ag4nqOGbvuazMcoa
         T2FVZP2QNU1wL+Ucwacshr7MaPfgu9rUhfsNSKtlXXTxxU8rbkpX2xVXAVm+Q83jR+Fc
         3r8Jd0oQz4DOCcXQopQRt2mM08wOpIXRIybpBior6crngsrAlP/gsKt0/JZxGtOjXzJH
         vpEThaBySKDY7UYRkHoR8QzNC0oMkW1Gnhs0cbcFIMtVjAMNwK4pcy2od7heUCLJOZ0F
         9qaQ==
X-Gm-Message-State: AOJu0YzlPixdYjzOWUWf61nrPvltBkIYoQ312aohQBZgkwilyeF9c46g
	InMRdY5gHJzSv1DZ+lDrLF/PaR2TC22LYVJt1UdM5kdBjqZIRqUMJCdWvt8aQLZIfKWFyxr/im6
	8oBO/C4ml3QUVEqnJ4pd1bgKWkbo2B2IgL4S5fF/3TAppCfVoEsKf6oMRH2rL+Zw=
X-Gm-Gg: AfdE7ckqlBSdHZ8SKqRqwdfpMNzDMsXFNKRGb46J4FizShFQL0ts3pSWsGu/DiqjSBj
	zGBZykf+gkNQJ0VWQHSZboexc2dxmumqYXiG2VAaYyattJmKOi8Glx69oygf4FGtYgbA3I/eQly
	g/x0/TWWygH3smZlOJJKubLTZn32psDUrDn0AU8exWWG1k0gz1ie3Kz52vJEB3YZ0VbLcjK9sH6
	e9DhxiZJIAOmmijE8NPpuQp5qbZ/ivXj1Tfkf4CHKhETw9taObLTfRxugvF1tsM6exRxLwbcY0D
	lqSpBtg1aLtkchzX4vIhFqb/76NyPK/jl9DtWctGAtU/8H7jfNhTWAi6Oy3Q2JtC2nxDQn74FRJ
	rLn/9xp8M4JRlorwhkQGh4VexFndpE/vLKhTwQ+PmZiMxPTqUZw==
X-Received: by 2002:a17:90b:2c90:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-3893d2429bdmr5476198a91.0.1783576195295;
        Wed, 08 Jul 2026 22:49:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2c90:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-3893d2429bdmr5476176a91.0.1783576194794;
        Wed, 08 Jul 2026 22:49:54 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55a47286sm562981a91.10.2026.07.08.22.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:49:54 -0700 (PDT)
Message-ID: <734537a8-7ece-4d2e-8e72-d090d4788b22@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:19:47 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX1htQyQSteUpe
 eVPaKA5tZg4SL0nSrFAdofmBgdhOSc70S1eLDNF6Mu0Ln7+MyiWw7hBFMhG/XGLZQ7sp6PCIwhD
 blKV23nDM1tW41YSFL/Hdk73Z262yUI=
X-Proofpoint-GUID: XXMt_cIdAylyBa2grzWFReV36uZ_Mz5f
X-Proofpoint-ORIG-GUID: XXMt_cIdAylyBa2grzWFReV36uZ_Mz5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX8IxmnnA9F4wb
 lysCHSz3Dh6A3mKtZ1Rq3q1nmyQMNx1YapbG8h/niTjP3vI0O1JsoNmo1m0sang619unoGmHsdC
 jbzy947417/eJYEmjOumad00pHKNU/4GJsxhccnX2KsWcJoy/oZjHAz7izob/uL1v/qTBVnr4tv
 w4/7PT5rknR57z8LgbgDzpdOb5gYkILu96DuSndPWEp5JxrVgTP/ywKYdvhZu6lJ/AQqzr6j4am
 aMzUJwYFLiSxL6Y1n3bp+q0ngRnw5sCAW6UxOQOJibRnEfeHKgLVHiYyAZuXwLCf6/hrmA5GBXv
 6GpNNhEQIIAfM2402lxG9REBO6c+LYZ2EOFfnGaciiLdDAjKJwR0Vhm4K6WwVn755255XBktdOA
 0IqNZ0p9ylOGjP009foP2e3zeeYtkNnPaTkQaTZCDkGPTECdCy3u49mNv/ZihBX8evQu+mIWLMb
 RJrHe/6LBEhpBEr3V1A==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f3684 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=QsZEBUMWvTWtZ6nCauIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090052

Thanks Mukesh for the review.

On 7/7/2026 5:37 PM, Mukesh Savaliya wrote:
> 
> 
> On 7/5/2026 7:27 PM, Aniket Randive wrote:
> [...]
> 
>>   static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   {
>>       struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>> @@ -471,7 +484,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>       }
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(gi2c, len));
> Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an 
> arg ?

Yes. we can add extra variable. I though to avoid extra variable.

>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>> @@ -513,7 +526,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>           writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(gi2c, len));
>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>> @@ -591,7 +604,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct 
>> geni_i2c_dev *gi2c, struct i2c_
>>    * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message 
>> transfer timeout
>>    * @dev: Pointer to the corresponding dev node
>>    * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
>> - * @transfer_timeout_msecs: Timeout value in milliseconds
>> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies
>>    * @transfer_comp: Completion object of the transfer
>>    *
>>    * This function waits for the completion of each processed transfer 
>> messages
>> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct 
>> geni_i2c_dev *gi2c, struct i2c_
>>    */
>>   static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>>                              struct geni_i2c_gpi_multi_desc_xfer 
>> *multi_xfer,
>> -                           u32 transfer_timeout_msecs,
>> +                           unsigned long timeout_jiffies,
>>                              struct completion *transfer_comp)
>>   {
>>       int i;
>> @@ -612,7 +625,7 @@ static int 
>> geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>>           if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
>>               time_left = wait_for_completion_timeout(transfer_comp,
>> -                                transfer_timeout_msecs);
>> +                                timeout_jiffies);
>>               if (!time_left) {
>>                   dev_err(dev, "%s: Transfer timeout\n", __func__);
>>                   return -ETIMEDOUT;
>> @@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>           dma_async_issue_pending(gi2c->tx_c);
>>           if ((msg_idx == (gi2c->num_msgs - 1)) || flags & 
>> DMA_PREP_INTERRUPT) {
>> +            size_t max_len = 0;
>> +            int j;
>> +
>> +            for (j = 0; j < gi2c->num_msgs; j++)
>> +                max_len = max_t(size_t, max_len, msgs[j].len);
>> +
>>               ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c- 
>> >se.dev, gi2c_gpi_xfer,
>> -                                      XFER_TIMEOUT, &gi2c->done);
>> +                                      geni_i2c_xfer_timeout(
>> +                                      gi2c, max_len), &gi2c->done);
> Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an 
> arg ?
>>               if (ret) {
>>                   dev_err(gi2c->se.dev,
>>                       "I2C multi write msg transfer timeout: %d\n",
>> @@ -852,7 +872,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[], i
>>           if (!gi2c->is_tx_multi_desc_xfer) {
>>               dma_async_issue_pending(gi2c->tx_c);
>> -            time_left = wait_for_completion_timeout(&gi2c->done, 
>> XFER_TIMEOUT);
>> +            time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(
>> +                                gi2c, msgs[i].len));
>>               if (!time_left) {
>>                   dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
>>                   gi2c->err = -ETIMEDOUT;
> 

