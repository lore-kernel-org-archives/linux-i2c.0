Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702680;
	b=MEF75+3IsR3Csx6eoa9P+Gq3efdOBzwQhEq1YB/V2uKSnwHp4CdXzE4qWFu/gLJUNEIL
	 OnHCt4AwBMCuENEWo6c+UXyn19MZWkcSXedjrOA69tTDkDjAHFZmSYIEx9LwR7Wzi04s2
	 2x+qhRK0t9i8AFy0t2ynJyg5r0EUQ0cE6mAo3WiIc96uKCYYYOrAWKc3pk0E0fI8DTBqc
	 UrlwJ5fVLxmLwVE2hK8MM0i/yfLLzfOc4kKBhiaE7AxCW4Ut9EpSvmJp4ppAWTykrLwGo
	 FGBi/KXAoMnqyuQZcNUtj3y26JoeWWBbrQ/6dIXtUguXtkg7lpCTKUbLrmdKGatsmxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702680;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1OUMpP78XK0QBfxNlzG054RC9Nn7KQKdmJG3l5IpB0I=;
	b=i0o+jGRzCm9TqgncyR0lor7P/HiNUMDbi6MjNa9+rwSTfkniNaTMso/RpwD6uiVhb1OO
	 PYjkQgXznhhRSt4vRM5zslADpr7UvKdlaYewhUPhl8plgpHTSKDlgzuiMjTDv72+1pnSn
	 hN2tC16U+eYvUNkfnwLlvFwka0xbjv3wmTvyH8TNFSpmi3moBPGHPyaUVoJqbflDgnVcH
	 IaohVZAIBCpzbftQRMcc9QjNzIriWCvRh8IL2snLSEgpI/admHQuQKuXWPmEvWuftrl9J
	 MUHUoTTyQx0jAPW1AgHvD9E1r3HeC11qYhr5TKHKnfi3uuR7byVEtt9umY9uMUiF1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dv+1M6Y8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eZhsBkh9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F358606C583
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 10:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F358606C583
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dv+1M6Y8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eZhsBkh9
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AA3lV3577874
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 10:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1OUMpP78XK0QBfxNlzG054RC9Nn7KQKdmJG3l5IpB0I=; b=Dv+1M6Y8oPnp7pGN
	xv3vplmWBRqQZoDov8Gmv2RcoelY6YFKXuIQxjoWRLHxQRybtILGIRPc+TDLzPo9
	YSMSmuBamhxMjvRv1vKDlgpZ9nrfE/X2yvp5+iGFXNl/K/etC+Yu+Rl5FaEQc0Lo
	WV/Ksj/5fDSwIL1boFCAc1jMP7JdmtHzO5Z9pYdz/Gq7b7s7VXF04zaFXLCNJ21j
	euEuz74Gi0UYeH2Lu5V1F3mFLh4mtS7Qq/XjpgZdx6n15FEiVnAmZMc2y5kx2hXi
	9Ex4s7e6uPtpOqwjZ8TMpXbb3/5LhhFlRIsQAHFnCr6hl7eI3kily02PSEvrpHTN
	A2Kg0w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76d9qm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 10:44:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso5540886a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793702679; x=1794307479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OUMpP78XK0QBfxNlzG054RC9Nn7KQKdmJG3l5IpB0I=;
        b=eZhsBkh9pZcqiCmMX9B0WtgvFwwrhbXfZBU6W3cpqriBZ6tLVpPSkmOIVSO+5x5w/2
         rEAOEfMAu1vObsDVgXv8h8QZuBcYLq3U799TUROlLQufMEf4ang7fgVc2OzHXBg6d2/q
         XFWAe8Bmcp1edRP5EnoWmWIPDzZ1Pt2hiz0hjLOnD7+tKHrZxoOFf9pgd/p8DbvHQ8wb
         Iy3iunDJBcC0UNK4fmlT5uLB1O121YVAhFvwelnhFOTgbbieXQ3fiM1vs2yqNEmvYJXF
         Gv7ztZ6xGZq7Z61RCMEFU8uNXKZ4tkEChKNZFdjhcaaRSVTyqIsMr2gqrsNJv0juJmK9
         as5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702679; x=1794307479;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OUMpP78XK0QBfxNlzG054RC9Nn7KQKdmJG3l5IpB0I=;
        b=R6fHT53zOZrs8BHcJC0sHYICcjkS+ms3frztQZwuNVdbxzut4B5J/y6lmF59MDMBZu
         qQc7dXTe2xB/sInkN48lroQX0xWytPCA8viPEWA3bkD9lrasyCh/1CviIWYP5ZJCCOQn
         RHvoOZP5InaaIWLKE3tvls8qgnJeGasBRmG8oFZc79Vg6QhDAI6quphMqvlNfl5dbhRE
         JIzOJNKUANvqS2O/xwgIwKuwmt29C4J/VEjVgBGkUHUG35WRLGRti+h6v3NjphWFuwLr
         zHZGA8kkyPeJ6Gpjk+w495DmwvwMNgzFAOvzbH/0EVplhvfTxaTSi2OyF7ERdCTkwnOO
         8c/A==
X-Forwarded-Encrypted: i=1; AKwUvBx8Eg3NCRybKpELvdo2xkYfaGn/6OLpzqSP1HdtlHa+xv0t5tePKcCqKlkMG3eZ0dMai8nOu80MueA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kIhcX5PDKNrUnW4ioAyuBgu9bCAj3EVQBS7yS1eCJ7T+3V1qh
	mqHUiGmMnH6ISx4N4VJTX7OH9xTPmDdqJ7qvRFmEnnk9zaERGAca3Rh+8PxUpORT8EAfdAlUVWw
	NfFYXkJ73N2j84B2m4AL5x/hGQ3yPboZRiLcbnxCXkWxgG5mi8/h0QoY3NioEtIM=
X-Gm-Gg: AYBFou1W4jitOvvR9dYDmR5zN3ObW1LiIbzwwreVUvS3CU3NaLsILYgvtYy0FrmxdV6
	lBYNZThgV1BLOCc3xmVjUXawH3BJwk/nzMlNzJITQ7QInZTMsLV5ZTkv364/a5sWOVwd7BkvHu/
	LS4Qz+Crx1UMkxA7U4QSQ80dL2IDZmxKk4SWxZXiDmQzarURUVSENHkFQpS+/JQeTJYCQFu69Gq
	JNuxWkJpOJlgkXcBWrNSBF7gGg7hJZh6FQgdEcMbStLlcs1TrGmFmJ7qg0rRWgY6HdYV6T6/utN
	eG7rxKBW5qmtFlg5D3pZ2dC5Uts5EZXorRzhb3JmbalTOu9njl1yDDey4b5/wHYhfh0bHYwqiTU
	0rFuC3INliMFvRjzLFRrQ/k1MeCfqmC+jS2UMc33UfWQvjZyCtjIUDIE3k2S21Q/YsHZBxEv+wI
	1jad5zig==
X-Received: by 2002:a17:90b:3b85:b0:3ab:188b:c5b1 with SMTP id 98e67ed59e1d1-3ae897e4182mr10616881a91.56.1793702678739;
        Tue, 03 Nov 2026 02:44:38 -0800 (PST)
X-Received: by 2002:a17:90b:3b85:b0:3ab:188b:c5b1 with SMTP id 98e67ed59e1d1-3ae897e4182mr10616857a91.56.1793702678102;
        Tue, 03 Nov 2026 02:44:38 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm3905297a91.7.2026.11.03.02.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:44:37 -0800 (PST)
Message-ID: <2ed54730-75bf-4368-9391-5452d0a31fa9@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:14:32 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9bb17 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ljc_7vWThQ_RCqSD0EwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX45dd2vVu+H37
 LRw85pzV9h2dol0bmJB2/zjoxpx72NI0b/qNgVfds6t378yPyy0RBfD8eTDxBbOu7JamFzz8q2o
 uVqiZacP/RAnRNDezva9wS2iIYKc06I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MiBTYWx0ZWRfX0iQluPIhQmwP
 y0zL1Vg6bd3NXn8OsV/D2xC8oUnGG9VNPCmz99YdBmCDMgPA1nMucZZBBVGvhb58TeSq/zrdn6c
 QLTIRNZFu2tipdZr0pUlSJ7HXe734a7+Q5zGR6SnxTqtpw3Wp4gLjYXfcr/hCo4q3XQPGsYVHag
 DSOWDonhperNFXhU92EyR889sQGFdwmyNWu9XLtW5WkwrDVma3FvWrPA4aVduVsJxOfvKSMUFe1
 zzYjYhvqlYJWJJxdnviFaoJOYsBg0CUt8/2bH6Ma4bdlQB7aNNC2/X2Ht6tmZg76lJ8mhpBCRgr
 SH9v12bujOswYhl2PIgq3+yIVhjUJhsRftIcNhrBRafxVNBgoQeXwq0VAe+7OJUtLtWmGEU8vDU
 jBokW5aVBlqW7XojJ4CUu7hxApdMyUbA87mF/8gDyl/89Xal27HgijJqfJxWohxJgHDGUosLYmo
 l64jNiMzYfgSwcweaMw==
X-Proofpoint-GUID: ByGEi1GLAyOKkktiSjq3tvzWPNtgzbWH
X-Proofpoint-ORIG-GUID: ByGEi1GLAyOKkktiSjq3tvzWPNtgzbWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030042



On 11/3/2026 2:26 PM, Aniket Randive wrote:
> I2C transfers in GPI DMA mode can fail with -EIO when a target holds
> SDA low, leaving the bus stuck and preventing subsequent transactions.
> The GPI completion callback reports a NACK and a genuine bus error
> alike as -EIO, and the existing recovery path switches the SE to FIFO
> mode which is not valid in GPI DMA mode.
> 
> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
> opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
> trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
> SDA and SCL are already released. Extend the recovery callback to dispatch
> through the GPI DMA path when gi2c->gpi_mode is set.
> 
> Use the adapter timeout for GPI recovery commands, and preserve the DMA
> configuration error code when GPI setup fails.
> 
> Stop recovery on a GPI command timeout and report DMA termination
> failures. Do not issue another command or override the timeout with a
> bus-idle result, since DMA cleanup may not have completed successfully.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 107 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c

[...]

> @@ -1356,10 +1439,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (!gi2c->gpi_mode) {
> -		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
> -		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
> -	}
> +	gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
> +	gi2c->adap.bus_recovery_info = &gi2c->rinfo;

I guess one more time this. Why patch 2 is adding and patch 3 is 
removing the change ? keep it clean way.
>   
>   	ret = i2c_add_adapter(&gi2c->adap);
>   	if (ret) {
> 

