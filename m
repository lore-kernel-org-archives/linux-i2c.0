Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0F35DA55
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057620; cv=none; b=u4YNAnCX85c1pxeQe6Mn0NGs31ubTi3FJ1SIiJ42o8O6dW3qiQV96h8rDRF73Tk8ZcMuDPPJZQouPrJe5nMOUpRh2Zczh2hQ4y+EFHjnIj334G4xjlk5XDqVhFchzAGLTl6jDPVsXcbiuV1UUjmJVC/WlWb2vCOgYaSZ/x/TrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057620; c=relaxed/simple;
	bh=MYGsBp177SXwP1uNFA4C7z4gmBzw8qDgDnBpLP9X1zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyfyH0/+tYcg+emi1Vh6OYwGAzdTCl8X8Clvl87oHTb+zp7+jifQnwoLrgqgxWYIXz4dOBqKyJ1yolupASoL/kB00dy0An8g9vwxbxj4klkoQ54Jh+2GRl9Q/WKeSAJtujv7QhamcJSaVqxX6IEOE0r6tCBAcEp3XN0r0aDHB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCVwt2JN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y2wDt4cj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCVwt2JN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2wDt4cj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342fTB2654842
	for <linux-i2c@vger.kernel.org>; Fri, 3 Jul 2026 05:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DpH0aaqLIE2vdp1hKLWk2Yx9KYUV7VWpd2pe6X9GfNw=; b=aCVwt2JNrO6QpRZf
	gQUniY6xrTBYsW+Oqoy5qGDNd2ziX6qFUTEhxX81CfB+R5RRj6O5B/iSIJ3dy2yZ
	dhvSTpy2k4M3pJnoQtiJymB4+nV8dgjSYVcUo8kNVshE0xcn7o8QQw4P2gqRuu2+
	mVXcCSX5gsIpPtE/Mf6re9GEUmKJ5l7TLmvpPdR/gMkTVgHxPP4Gkum+4FWmQ8CQ
	+qemm5YwHAC5JTspgAp8NS4BN4vBHXOWy7iqWWTVmCh/u54oTcpHTf9eoLNCI3O7
	ySM/WaYyo6qovW/sIS1ZUvCouTPkynVzG3PDhh2igRBlpjn+rdwo0aar1zZrLSfA
	FZHsPg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5nprcdpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 05:46:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-380ddac2b02so367741a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 02 Jul 2026 22:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783057617; x=1783662417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpH0aaqLIE2vdp1hKLWk2Yx9KYUV7VWpd2pe6X9GfNw=;
        b=Y2wDt4cj0lpQRhACxBCh+fgEDzndvtH2KRFKmKDv23ISpHDgYZkaqQBPxwn7uiLPY7
         xKqTTGapPItmfH8KtLiam5yTurr+O9+U0UauHwVOZwD5b8GavcvsA+LctW87fClcRx9O
         xAzltm3oBdxzcHK4WMFWeyebModwB3B0hiTi6mNN1HOqXvB50Is5J3FKMUIuj7BnaWZD
         SmM9N1ROOT4WpSwrUzQp9w+wCRhwqfuqcdUZtMMmEYYs/f6fHdqBDaxLhrhhytliWfQp
         T6eDTES82XK4GsrOdQIwx2Wy01a6xuCsrA0lKsTHroHhPDiRCxOOV06Ko5E7eDjFwBUE
         zdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783057617; x=1783662417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpH0aaqLIE2vdp1hKLWk2Yx9KYUV7VWpd2pe6X9GfNw=;
        b=QgMe40NINKe5Dn99PjfeKuqqzkWAmffFQ5aWcbup9HI01wnyMpQHSZ3fTNZzFwk/9B
         n8WcB48hnibk4ORdTXS5eywa7de522lHm2sFCvDunQ3pw1y3/fwBFKwh7ODmscbx6sRT
         nyuP9IeG9nvbXqJoU7cq8hUnU+9oJl2vxWItKViPVpfMd+hADiAjmx80KQOROUr+7upB
         a+bRfhugK9l/Xcp+MFeTeE7ldpAh73wYlDM8PianhwXY+fSAGBNJxbfzGBUB8Bo804QX
         bFdIZgAEznJyQhryPI0aSFx9taPEO16gEOgA4MMYoQmg5FxoTYb/aqMCmcsZH+a4vG1Z
         vcHA==
X-Forwarded-Encrypted: i=1; AHgh+RqlrQSB+Va/TBVA6uyAhf9BOemx4vEiBkYcop9yen/BBl6bjec118d4X1HM1VTDm+YMM+atBZtyaME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpq5rlK6D2VoBEUPohujQIBPVJjEzB/ALKEPASiUlGBkfMFm+j
	6tsPaz+1EimPxQg2ja00+fpOf80Wk+vUKJgnlLzSvhVvkBtV3DYtmz/1jT7ATIZEvxFA3GqZK8y
	gg6y8+YmrW5B2VS7Q/UNBiJfCuB0ZWupjNuRRiL55AZ/FAZ28eBke0fvZhQrdC2E=
X-Gm-Gg: AfdE7ckOgKKTpG1oZ/48ikEZxK5h/fNzWQUvgk6csF9qynPSNUqQzCKscCG+tg8pjOV
	sgLp9jlt9+Kl7068DlLLJemjfcM2NJEFLA30sIautpmGT30COHaJ0p7BLeWhdKn9p8j85+BZTwo
	XEU+JlZYcn9K3Zr/1XN1HGnvGryjjMzzM/uoJXulhn9iIZgZCtqDV4RFt3AGlc5Cx79ymy3Ucml
	FFfUYEaH4pckjlEVMd21QNd9uv0bxqse0FakFKY/MK7uaroqVBGY4JJT2o5bySgsV5IcEM7P/GE
	bbEPkZqhY5oahzM1x6kTXXGoFhSt/sPvDy4MlYMZMCw3GgxiB/07FPf2VQm/rn9kuiEInNxBs23
	UYQjn0Iwyb75AsifwBaIBpH09J7w3MJjs2X6bbn1sZYzh
X-Received: by 2002:a17:90b:55cd:b0:381:fa5:521f with SMTP id 98e67ed59e1d1-3810fa55836mr3819861a91.3.1783057616760;
        Thu, 02 Jul 2026 22:46:56 -0700 (PDT)
X-Received: by 2002:a17:90b:55cd:b0:381:fa5:521f with SMTP id 98e67ed59e1d1-3810fa55836mr3819836a91.3.1783057616187;
        Thu, 02 Jul 2026 22:46:56 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm16955180eec.2.2026.07.02.22.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 22:46:55 -0700 (PDT)
Message-ID: <b72f1900-972b-43a4-bfbd-5c85b6fab08d@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:16:51 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i2c: i2c-qcom-geni: serve transfers during early
 resume
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>, andi.shyti@kernel.org,
        viken.dadhaniya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorande@oss.qualcomm.com
Cc: konrad.dybcio@oss.qualcomm.com
References: <20260629134140.755193-1-mukesh.savaliya@oss.qualcomm.com>
 <3777cef8-c90a-4c7a-9b71-c563e8d56f2e@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <3777cef8-c90a-4c7a-9b71-c563e8d56f2e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NW4GnAnnsiYctpWKBHWcDgqf895-u1kS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfX3N0jdCWh7/y2
 uPHuVlhvkDwj8njJm6bxyofa6bqQ3gDG+c09xFNrVMC81jirUr/WxpBlDdAaN4cr9vkAjrIrGJ6
 K4ym5QoJP3BG+ByIavfd6lIc0REeV3c=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a474cd1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=qYV2nPpu_1DESmPDX6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: NW4GnAnnsiYctpWKBHWcDgqf895-u1kS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1MiBTYWx0ZWRfX2UFR9LAuwTBe
 h56YyQIZIxtaFqKQPM986CmM7aJ/v1YC9jbu1XnBm5d+TXqdvHvkowTGB3lEyI6KDr5CDJgw62i
 aAhHk/o6dtlumo/f3OLYSDFCPTzrnO0pIXp1RV4yUZHHGVqIgV7om2lB9oVCBhSrsXh8WXxlNfD
 kE4GNpQbZxK9IPTYF1+cJXx3tfa4k7D8+iFhikoiA+d/kE3tuX4c8UjmxZqH0OT7+GlhKplEewn
 lsJZC4JgsLrc7HyamY+HxBhzAOCE79OyD774j3IaQ3TKUsuy1kJsoZuMkC8FXBJKEDqLLgcDQks
 YxZvUpItIdxsGBxRNvkNndN15svIrwGI2VZrXXSuAoTC8ZUgE2BzpgiUt5ELdgbjlgZCiSpnQbJ
 29sFBWtvQ3vBlQfaRukMEHvKjkctJx8hf6NDZnhDbnf+zXZn18CR2BiJTNcYUIYIfFYix9xPAJR
 mSXKF339nkYMec0YN4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030052

Thanks Aniket for the review !

On 7/3/2026 10:21 AM, Aniket RANDIVE wrote:
> 
> 
> On 6/29/2026 7:11 PM, Mukesh Kumar Savaliya wrote:
[...]

>> index d2f5055b0b10..d56b36bd1d26 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -913,6 +913,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>>       gi2c->err = 0;
>>       reinit_completion(&gi2c->done);
>>       ret = pm_runtime_get_sync(gi2c->se.dev);
>> +    if (ret == -EACCES) {
>> +        dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
>> +        ret = 0;
>> +    }
> 
> Why we are checking specific error code here? Why can't we use the below 
> error check directly?
> if get sync itself is failed with pm runtime disabled then why we are 
> going ahead by making ret = 0 here? How you will make sure resources are 
> enabled?

This reason is also mentioned in the commit log. we surely get -EACCESS 
as runtime PM is disabled during no_irq resume phase. We still need to 
serve the transfer, hence we need to override it.

Review geni_i2c_resume_noirq() to know what all we do to enable 
resources. That's guaranteed and tested with system suspend/resume test 
back to back and PCIe could do i2c transfer successfully.

> 
>>       if (ret < 0) {
>>           dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
>>           pm_runtime_put_noidle(gi2c->se.dev);
>> @@ -1045,7 +1049,8 @@ static int geni_i2c_probe(struct platform_device 
>> *pdev)
>>       platform_set_drvdata(pdev, gi2c);
>>       /* Keep interrupts disabled initially to allow for low-power 
>> modes */
>> -    ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
>> +    ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq,
>> +                   IRQF_NO_AUTOEN | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
>>                      dev_name(dev), gi2c);
>>       if (ret)
>>           return dev_err_probe(dev, ret,
>> @@ -1257,7 +1262,12 @@ static int __maybe_unused 
>> geni_i2c_resume_noirq(struct device *dev)
>>       if (ret)
>>           return ret;
>> +    /* Enforced disable_depth = 0 to actually enable runtime PM 
>> during noirq phase */
>> +    if (!pm_runtime_enabled(dev))
>> +        pm_runtime_enable(dev);
> 
> Here we are enabling the pm runtime so where we are disabling it?
> 
when system goes to suspend, runtime PM gets disabled. Since we are in 
early resume and runtime PM is still disabled, we need to enable it.
>> +
>>       i2c_mark_adapter_resumed(&gi2c->adap);
>> +
>>       return 0;
>>   }
> 

