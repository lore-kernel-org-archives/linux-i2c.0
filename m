Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608037;
	b=tR1efZsEDyDSctUE3DeIN1iuDHRQHHNwIBJLMTGiU6ZXjBiK8ClOaM636h7rc/GHPUCY
	 fKRAXlwe6dIXTBOCT/PU+DntoOgZpXfQ291/gPPPWDjv2r0SgIi5IO4rXunoOVbNF94Xl
	 cVimBo/A+Jnup9gqavnvJMalBtVb0X8bGgp39msAE35oe+WNsjyfasfG/Pg6fseE2bH93
	 AF6Kzj0a62wYcM20MlhTtPJdswvCF0bBZn2XIbA2uTjnZx1acWcOlBsnpYfp7GpAYMbSW
	 uNSFOupanCeD1IV98iwOqgF2S/2tsSpPMEdyIavRm1/xVTm5GgZ+GpH0AsjHeOrYWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZGmtiss+37jmH+iF3YqbwmD4+9FY1uTsN9kR+qeAjgg=;
	b=PkVYkYwrO+FpwbSRIeDM7uSu+KMRUU2wO9ZdW6ypCtHHU8lhK7OvIQWmnSmdFBRVKXwR
	 LflbhURLvOOZDJLi3C9bsC1q+m20q9VKDsS0Gm1fawEoT+jrquv5xGt1yMKgIW9fgrPFC
	 F4lZLWDY8U7YmpNJMApQhOuKhnGHiMnltHckSYI2zSvQUueM99U5YWIoyZxJyGb7cLV1w
	 Eoq0JmwE1BH+9+fdxFqenI4EsCWGC8rvpw6m99O1rROZBeZbUQEGvcPw5ODn3evr8+nwt
	 I0OjSWfXt9gztOA9gZ5UXbEO0TfOYMm+KR1WAFJuEjwDXmjHjiG8gUiSDwvkInObBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="c33gkj/k";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4bg1+bK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFD606A327
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c33gkj/k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4bg1+bK
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mR8p4131759
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGmtiss+37jmH+iF3YqbwmD4+9FY1uTsN9kR+qeAjgg=; b=c33gkj/k+xAEBid9
	cfhgRNxHmvmdPnEq4qHSgM9+ksQzj4QTwJXo5Gb3+tuH2AdvABDNf2ReNSrx11BX
	ZvdpJpMdIzJO/r0xRfzYNai16w1ncvLhqanYSJYKEXfleFCzeGyryHkliEifQP+f
	4lXToPQZTfaCwwXbABBr+FvRKF2407zO8Mes+dOLOYb0xY3FJZqTHIwrHpeR6mef
	uX8v6iOwM6zb5T2brTgYzdwdvF9Qh92De+cm2Azq+yPaXKRz/1own6DQ+R9Nno+u
	PSn6w27GkD+e1tWGjtgBcEJMvIHgmKGgwWh3u816mACC7tKBbUwCLZ1hwz3ZBjbU
	oyU99A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhrqpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:00:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a079256596so4082850b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795608035; x=1796212835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGmtiss+37jmH+iF3YqbwmD4+9FY1uTsN9kR+qeAjgg=;
        b=Z4bg1+bKoiLBSPGYI/02nXiyXwma7o1FwX2TX/7rLDWw4ESa0iGmPYPSos3KdSKp+X
         twssW2imtm1CsT+Joy39ublSFABlgBp2P+vEAVYKF9GaE6Ltg5ReIhsCvfTcNAgofgoA
         uHr4sJfSC1IiD7KMsA/ijNMfEzk9qPQhUj2JrBt9jr8LrKXvfvFeLIytLgVvCtDEbvbd
         2qA1N96VzqfluPL4gpr+R8C2UyZBd1F6Hd1cqCL9NRXsP+a5ZDLLfMUgk7yrmK1ZAvGj
         g7u/yO8/eoRid60cUhf5rhhmkEXvUTOMun3wzf6XyDmjzIwngjz0FmJgzkE0zmGBcnhE
         Tsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608035; x=1796212835;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGmtiss+37jmH+iF3YqbwmD4+9FY1uTsN9kR+qeAjgg=;
        b=qEC3QW9A9HdGVIYhy+SehMAEO3IZXKj4tsb3akE1nEkx1nTJH/gsyj3ssbzNX2GuMl
         vXtU99sJZt58eXZATDZ6wJ+oSDwXKknUNq3EgqkYSsNugQnmIWRxKN1WL2LsLrIC/dYW
         oJn16rq7uJ75sk5aBd5aEPhawecODvamjvR5O4Im4GuxcZxzaKSMCDxZm2vciLwcUY8A
         Bu5wCBzcrJ2XKS5UtwukB1Mk+a/mYb3Vi5zfJl25/Vq6qIoaTGkwYwHn2PSZ+WVxT5xB
         MDQ+KJbmrnjW3dfnH7xlf+9z20pT4AIRJMLSRHhocIt8T9UKKw9bxAR5tNwZ5dqjkuGD
         pxfQ==
X-Forwarded-Encrypted: i=1; AL+hErHgv907rNn+auDvZyIOkBoRa8PDmRC9f+zfw/0GlZ5MDTa+GhK4/LSfV1ys1CaDLeFIXXUOwOnytH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZvD0sWNCZvQyFTkt1ii8vveNDh/pxR2UlBd2fa0E5sVGwWKbX
	cPrSvb+Yqq7gHqfFS/xWG72B4LSbeYwNg9q3BEfkqUkoser0g25ssI21v7RRS/deb3efNG82Ng0
	v/FNu07kUAYnUNDGbcETKnKYb27xCkODfzfN+WRpSJq1sA8JfkVmMK+m+fRPfeNk=
X-Gm-Gg: AZFdTZcOkn5lnN3EUjQi4v8WRd45ifNkjzrEA/VlUqcfovPGPEsT+ffYYeAc643/uU2
	MRiD9FlDRNVpHozBkjRvqIbT5Kdv2Nb3iYU6LxLo11upeqyuWN4ZrUJVbF8Ux3+PyvOAe3J+Q7B
	P64iC3Bx6CktJIwuZrl4RNt+ix/57z4cGDlkUcxlsUbQBNhJkRdU2RdOTYWiOPj+1iN7swqM0b5
	C9d4/7BmB5rBK8hHgji3eFB0QMSUXs4JR9V2f+XT/gT3etykkgOjp09DPcOfgekKI5gMe+0RxY2
	whp5LgvXtrQbrRZKyQ4T2G279rJkmuPDPfC8QodYKhjYFmmGp/BDW0mPaOSWWmR1nkLRBnLaDsd
	GC2D7CCKD5Mcl7rzUybJFnQck6zUtrvjZOYw8Zu67jE1u35DVYz9WHQ1Sxu8GAixFpStFrOhx7o
	j9+w==
X-Received: by 2002:a05:6a00:1817:b0:8a0:5f63:5521 with SMTP id d2e1a72fcca58-8c8792bef60mr15376387b3a.8.1795608034735;
        Wed, 25 Nov 2026 04:00:34 -0800 (PST)
X-Received: by 2002:a05:6a00:1817:b0:8a0:5f63:5521 with SMTP id d2e1a72fcca58-8c8792bef60mr15376338b3a.8.1795608034103;
        Wed, 25 Nov 2026 04:00:34 -0800 (PST)
Received: from [10.206.111.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8707792e8sm9045190b3a.7.2026.11.25.04.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:00:33 -0800 (PST)
Message-ID: <e93eee16-df8d-4d49-ae56-3e6ba9c31167@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 17:30:26 +0530
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
Subject: Re: [PATCH v5 3/3] phy: qcom-mipi-csi2: Add Hawi support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
References: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
 <20261125-hawi-maili-camss-v5-3-1483b7f68dce@oss.qualcomm.com>
 <15cde6af-0b9f-4a0f-9d21-4e5ca9107a67@oss.qualcomm.com>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <15cde6af-0b9f-4a0f-9d21-4e5ca9107a67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06cde3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zU3wpra9rdAe81a_7icA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: CcU2vya2_PYznEJN4aa8JMXXRJ4HZerT
X-Proofpoint-ORIG-GUID: CcU2vya2_PYznEJN4aa8JMXXRJ4HZerT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX4jc0fMBqsKOi
 yjh8Q/kJJzhjsZ4eCRLnooV8B/B2MgEFQod0pujbIox7DAGEZdn9Gtt2Scgq2lwq+1WTzzRy0mE
 54hZu1DyVDUUfMfIqIjmA5qIlkjAJbk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX7XBIhVnZJGg1
 FVHPcAqWW9Z1ocrb+GHr4w57Rw9HL3R9Wib8tuxGdOwspVjyDk1WAIn/Bzo1RUVXfTFlXA529CV
 91VZwH+icn43I1OxTpEZS9uAPhVTG2zQ+ZAm5/IbfFQ5X+gNaYVIOqpBRvsHTKg0tMGS2DjjnG1
 wH1MmdOnIjFuNC6uoDx9ZvFR+Xm2udKcUcuyodqGJKk4c+Vj7ZWl73ZZRUAL3nZk0Fxv/s+GQ6D
 Qass5t2yH07AZvXNLZ2Mvy0mYXIGiyERRvcQkOud8Assv5k1++2fIZueqJxC5A/T72qEW/zz8kC
 Q9fCcqWNPU5vO9xYnjaoobIU++UVGs215hiF8hI4DRAk90gXnnFkH8BoiSyP8PbCZSG6BxqIAe5
 PCtjzQxxnOSbidR73M/T0+pfMNH3lKy4Rpj1Q6qtpSApkwNd/jRFiZwLZaMny9zTFT26GrFGczk
 aGeQOzCsBGV6N++C10w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250047

Hi Konrad,

On 25-11-2026 16:23, Konrad Dybcio wrote:
>> diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>> index ed40934d67eaeba0c6ac7ac75324ac6292fe7d9e..5d91303e0df2e8c5bca3ea8fa2bb831429a8f1ff 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>> @@ -162,6 +162,126 @@ mipi_csi2phy_lane_regs lane_regs_x1e80100[] = {
>>  	{.reg_addr = 0x0c64, .reg_data = 0x7f, .param_type = CSIPHY_SKEW_CAL},
>>  };
>>  
>> +/* 2nm 2PH 2p5Gbps 4 lane DPHY mode, Kaanapali table with data-lane CTRL0 0x8c */
> nit: 2ph and DPHY are synonymous, if you rename the struct to something
> like lane_regs_hawi_dphy, we no longer need this comment.
ACK

> 
> As for the override, if its meaning is well-known (the difference is bit1
> being set or not), we can add some sort of a booelan override instead of
> duplicating the table, maybe
This is not a boolean difference. Bit 7 enables PGM delay in both
values. The difference is the programmed delay value:
X1E uses 0x0e, Hawi uses 0x0c.

Since this may vary with other PHY tuning values, I would keep the
SoC-specific table.

-- 
Regards,
Nihal Kumar Gupta

