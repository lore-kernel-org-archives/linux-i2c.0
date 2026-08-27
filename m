Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EA434E5F
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858802; cv=none; b=BtsjwSzAeGYGkjIMe5ZuhLV7EZZ/41+/6/ZOYFNteIiwt1elkKBPkPQDw33lKrhkV4HUsHrSG/Y+zIeoHogcFQy6u4avnWipiEzBQO2P8EYwDmgDYedkFBDfp4ibdM4e54S4ILEeKOTI8aW5crgxczp56eNZp9tMOSBVunfD6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858802; c=relaxed/simple;
	bh=cvcmLjI7+Lm650KUaOK60qAcwKubSHECRDPNtyPRiSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHkEQi68jPkKSQRvfA5OMdA973KP98bZj9KTo41rH7Ck07rJFXqpQ72lLckwFtAGtjhVU9JaI8HbLkhzOCkCq4zj36LvsOFu9PyBNeh1/uBaKRsiOZg9hg0Dx3tdbpupQRsfApDBcqgPrl0beCukiQ5G/7kE9q3QKQe/WisPVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bsjoBU+v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMg0vtAr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bsjoBU+v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMg0vtAr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RJME85236501
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 19:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HdusM4nn6P63GToOQBHwn7pPb8nxGiunoqhm5Xs9Agw=; b=bsjoBU+vTcic2jZj
	OIoGFhIF2feOhXLuvwFs+PNP2VDqQj6AV/moAA37wkriclnpiHIIp53/qFgFQBSV
	DWgycdt1POFENlFbfdLSB2b0hOOGddcbOw1YifWUDMurekVSaMaeTalDAVJh0AN4
	yamCk0+P4u0/fjLQxnEk9HIh/L32caMOBDmsGOYqBbE2++NtCWWVdQR/Rm23rm3Y
	zAUavkuIPWJ6zQE8r8Rjq1//XgUYawq0bEegLiL+ywplTL3Bnf5Dr18rwfN1Axe5
	WXxrPLH1qTzq83b7EJ3YWOBxnNgE6BVcCqYc8J+EHRyTLJYODMwpnBZoOVGMFQGy
	VCImYg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjg5f9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 19:26:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso109427a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787858799; x=1788463599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdusM4nn6P63GToOQBHwn7pPb8nxGiunoqhm5Xs9Agw=;
        b=BMg0vtAr3aT2mKhwyr9UhTxq3C4zNdFM6oZZEILV3IBsNxKwfr0Ibf87h7omidaou5
         dFsKA5fmh+tabC6WJJoEGuVcQG6t2REVoI48B7XDSoIQueJWFBDfAvySNQwkpCmMfC4D
         kSORByqjSgnlaHJVC/ogZSKux5aRPEPHkg3E1e8TNzI1BUH4nhrxf09R9IvQgaiNwRu1
         +9xSun4YtSBQQlmyRAmhJHqBfL0vTwIgkPkyjSpn4uTq5W6wR4jmYUdyIJs13ezHHZeZ
         H8JQWSNlZxeG9RnRt2M4LQQN3szYyoVD4sV4Pnw5ZXj+/BJWav36/rVZ9U6/K3g7By2U
         l3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858799; x=1788463599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdusM4nn6P63GToOQBHwn7pPb8nxGiunoqhm5Xs9Agw=;
        b=DB6SB/mLBv3xLsUz8H3Lni4fwKvY/8Ijc14y8vb7Jkjm3sROWC0Kg9EtIJRApKesR/
         XANbraOaH2sm6+u3pws5RZmkFQFMsY2sJg1ZuMqshRFy02LSzbi/NnoGvBCZ567Qm5mc
         Ru2tNkXI753rAYu8w9ObHlQKEDVAOgKvM7Ufo4KeGQci3Ot/NSQpl81ZRwbUhjSXik/t
         xt92OFpXTdL7oylOlTUrPipBrMmEq16vmYF+eVVu96abnaQxmYrdLqFvMLZSq2mis7/M
         c4rleMPehEfpf8PrX3iwPCtWOUhZ5FLnqjLY7zKzQ5Vo5oeXcPPegn6BHlEnBQ6RFVO+
         CjWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrK3sGVnQojoFpFtf3cMh50OyUf8dHvqtQ+z58zR/uIYW25QqwgGXa2XiVC6VoxJn8bzJwnQSn2UcY=@vger.kernel.org
X-Gm-Message-State: AFuF++miHc3ToDMIcMfMGsXyL9AH2CejoDirdnc6qZARUx2h4pN4WADR
	ZEMzKZAYtRqDWot4At5WJ9ZWcJipI8ui0wPnxXdkVzf/o+yF3hPkch+12wsYmmFrF/6zHWL3YCJ
	IsnMJfh0ubZRWubxtjTV2slR6hwEzMgKk/LPgiz110RpXFCuSYiPjrORX9H+nDLk=
X-Gm-Gg: AR+sD11d5Vv2+ZBmE6NLSfDREoijCtO08bQVCFN4Q0bhd2+BddvPmsUtZsGODaKCtPb
	pylhVUWYOHLBzml4f0mbJZ5xp/rS28Y7PSSb1xENS22Trh3SHXPqz4bVM362Ddlm6oN2wJN/4Os
	qCoXGoU5PMrGf3VkafH0QfHlCyl5JOn25tu8gG7DTh5oSNEfAK930plCrcJs57pee/MggK7+V+J
	qlDldiklwobQ+fgbcaUDxL8OpSbmIKH++Sw1lAppjgeINMI3Oa0m6f0f2BzYROrHfTvoMMAz9hd
	dbDGgB67t9AVqIHQ8vD7fPvLjMPu2ZDcLIUvbnLneK4mYBsBQKuTs5wlSYzEEHC1Fs+zzThOTIS
	xWgTUkmuXgtcEd8g0QmE0hcz00jGMrT+fdw==
X-Received: by 2002:a05:6a20:244f:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3d26839c4b1mr2269326637.16.1787858799253;
        Thu, 27 Aug 2026 12:26:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:244f:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3d26839c4b1mr2269265637.16.1787858798802;
        Thu, 27 Aug 2026 12:26:38 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.229.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm33313437eec.5.2026.08.27.12.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 12:26:38 -0700 (PDT)
Message-ID: <613960df-3d3d-445f-9533-57257eb5099b@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 00:56:33 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i2c: Add I2C High-Speed mode support for qcom-geni
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vE3Z96WD7ihni_xK_RRzU3RS7pSWPNZA
X-Proofpoint-ORIG-GUID: vE3Z96WD7ihni_xK_RRzU3RS7pSWPNZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE2NCBTYWx0ZWRfXyobD0ZXy5rxE
 7j1Oiv882glOYl+g4S9hdCtpEsmYPCJ53ySNyjBTjWaMdWOLhdPtD3Tqwlbc9SeKfSViesox55x
 uekXmNbc4UB9Ib82rwxl9jvaEGjHGErkykelKSJUKFhgcztMTQTKA/qoIXW21LFhei1Z9fofXQ2
 vbITveZIF42BxvuDywl3kerGm4VdC5nXx+z/XXa/lKcShRlx3XofrxB2ROaEhY4kV0ccvUtckx7
 gBFdlG7oC7yzKBkuQ6dG6Dx/T1KMigyLJSYEUQVUqUL2shIZRMAmk3qDCtEMbS4STyy3Unfer+U
 BLERMDiKixvqPaL3RThmLK89ksHgAg1O1vNwoL16MK8OxVwEzyWJQmGJO7g/vwuPqReNiJ34vOq
 V93FmexadjF+PMNC0fab4zMNIBZYCvB2VAKQXBXl1YVYftKGoHXlFP302ueb86EQQDb+FQqvX/e
 h7bpIyns4O3SGEDhl7g==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a908f70 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=n+669z1BX7WhZ/F6bI95gA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PWE_YMljOzt1LMCm500A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE2NCBTYWx0ZWRfX8iV+Ew+K7OEs
 RSpg1o5qdIDTvM9Bt/ndY++syh3UTBzpq3yWUha/3ZaKymcEMgi4wO6dM6sAkp6PZL6mna6Xo6W
 8unYp8oXoNrtqQaV25WuJZSRSAR/fWw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270164



On 8/24/2026 4:55 PM, Jyothi Kumar Seerapu wrote:
> Add I2C High-Speed (HS) mode support for the Qualcomm GENI I2C
> controller, detecting HS mode requests based on a 3.4 MHz bus
> frequency.

what's the detecting here ? HS mode itself is 3.4 MHz freq.
may be you be you can start with current support freq modes and not 
supported.>
> I2C HS mode is supported by the underlying QUP hardware starting with
> QUPv3 core version 4.3 (per the GENI/QUP Hardware Programming Guide).
> This series adds the driver support to detect that capability and
is this detect things repeating ?> enable HS-mode transfers on SoCs 
whose QUP core version meets that
> requirement, rather than tying HS mode to any specific peripheral.
> 
> Patch 1 (dmaengine: qcom-gpi) is for GPI DMA transfers and adds
> a CONFIG1 TRE to the GPI DMA engine to convey HS-specific timing
> parameters (tcycle_cnt/tlow_cnt) to the hardware.
> 
Patch 1 is to convey config parameters for HS mode in GPI DMA tranfser.

> Patch 2 (i2c: qcom-geni) handles FIFO/SE-DMA transfers; It configures
> the GENI controller's source clock and timing accordingly, and adds
> the HS-specific FIFO/SE-DMA opcodes and master-code preamble needed
> to switch the bus from Fast Mode Plus to HS speed.
> 

Like above just say high level in short, individual patch will add more 
details in its commit log.

> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> ---
> Jyothi Kumar Seerapu (2):
>        dmaengine: qcom-gpi: Add I2C High-Speed mode configuration support
>        i2c: qcom-geni: Add support for I2C High-Speed mode
> 
>   drivers/dma/qcom/gpi.c             |  54 +++++++++++++--
>   drivers/i2c/busses/i2c-qcom-geni.c | 133 +++++++++++++++++++++++++++++++++----
>   include/linux/dma/qcom-gpi-dma.h   |  28 +++++++-
>   3 files changed, 196 insertions(+), 19 deletions(-)
> ---
> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
> change-id: 20260821-i2c-hs-408768509865
> 
> Best regards,
> --
> Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 

