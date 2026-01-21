Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAC47B405
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985936; cv=none; b=fpukBL2xKVhgtQEnD912XLHTBd9xD/e6EQ0GPM7t7FPSepkx93NsofE4vUupMIUtPpeRrhUagtwxdukki5tfUkzAoIpkfS8PKC+LpZT6uSgiy9tJuhPlq7Qx9QbxmzLWQm/Ej1uxqTNa6J27sBnLlN+uE/CudMew0UgjYE8Oki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985936; c=relaxed/simple;
	bh=T2usZ8gSTQTfCOB+Rt+2OtkLgup6i3tdElu2GWesta0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7IxHm8ZQOs4SKOaujr/eBhYvvof61ZnPCeoTNIRyZu0VFPbEt79yCmljzxykijjSVOrU2Rj0TqpaOMS7o1ZaQD6ag3iZNmYbcwdcZJlky6xlEr8OAq7d8Sbqo0gWj51RwAAa0KA83u9QxVpq3ye83DGJPNlT5uqjdekaQllZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqMwfvNo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OZwFw9O+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqMwfvNo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZwFw9O+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L4FFto2840460
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JEk0RTuiHDD7n7vffGqoKnhwc3Of48wJVKaL6PKEH0=; b=TqMwfvNosfwrmv4E
	RQv3u0WwOXAA0ArXIBcxew5qui9yzEB3a6kF7rV02pkTYA8WYMMA/r6yAgP6pbGj
	kF2i0pEcCeMwdng5b1dBvge7Aj29lncTrBmJTV84bbNKIHQqFfF8hIAAa4eMVj0D
	xAcLBwvATq54v6sHftAHiX60EjxxopLBDFS5Zf+f6uPT3ZAefXj6BV1C5NgPGnbN
	8oAQDGh4xuVdcjSthlNuIZjbyJeZ3IHLl2zyclc+Nz4NoocckAWfwyyJDNtlcLGI
	FHf9Wg9uYNN4Q5QGwoWjJoeg5NL7GL+4EMbiC5Tcs3k9tSkKzrMBDntIuWi9MD6q
	TW8yTQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqm1s0w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:58:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ea5074935so6116070a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768985933; x=1769590733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JEk0RTuiHDD7n7vffGqoKnhwc3Of48wJVKaL6PKEH0=;
        b=OZwFw9O+kwWNUohpxnPlfHapZgqKVLbdMuVjb4wXKS0lleB5hZ8hCAg7d8+lvD6hNt
         pGmAptlmzuJiz+zgbJ02Rr1OXdm0WOdFBU1MUZM3o4OEO6wrLmuac7lbfo2qD6eR29eP
         BTRVS8jwMaw1GqB13M46hFSXoaDDoez6FLsBhLLMQPFmyCRlYDexFyLG5zomigDKox4O
         gIPGMOk+wQ6zpaXnT1nhdtmI3Qc3QS346IQFTZDQFyLNEdrnqTmjS3z/vnRbicdmDNUt
         C05lBDelNC9PEUfXXRrDmDJedSJ4aafVMQJmYb0XYL6HS0wD7eYqVh+XRrQz62VDQ8on
         d2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768985933; x=1769590733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JEk0RTuiHDD7n7vffGqoKnhwc3Of48wJVKaL6PKEH0=;
        b=wRBFkROkkUhaDIY5O25aTeJXBThtWajbQosUx+ydqmjlfr4TRPAblto72ur6Gupi+f
         m4QTngXfE5XmbKmO15olWtZcR9HjnLcjFtzP32GikhDDd9zVJP8kha8N0TWKrHeqfCPj
         3w18ZF2lz1/t5352E6YqAUfMxNg/ULxjO7ETHxwq7wW0msM6EjVdR6rKHPtPAZDn8B/Q
         7E0TyNLqm2coDFaXb7NKMHAbEbjFfM6rzKHaOa7U1pKrQbPq9aW7f76YR9xcyOz/emEN
         UDv6SjmMEx0s+875uUIuDEsXVhRv5xhKku/dqZv2Jtf2bKiXLrqwiWG2oO1b+BhJL396
         4NdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4CCZ8tmHyCn7fdW3aID1lxJGoQc9Phsqa4y6s0QcViBsREvusPYgrwkPbRW1Hp0QB73MG+plNV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71Z+nSiuzMfSG9dIo55DAoAoMlwDgug+Ufe7bLOG+HEJb/ZW8
	S9RuwmDdwOjVg/al4nncZOor6sW++Usc0NQ7hZCZWaqRl6ASCAsCt4hf1bctPNae7MuqucgalOz
	GLlJoZFL7ZlGxe2pHmnxePuNtxO6K5+7AruMiMPfv2jJehCGpXmo/gbGaGggJcTg=
X-Gm-Gg: AZuq6aKD52qxsyU5+8Bz2BSGZ6PygFH/8YEgzAF7ZZywoviDmhSDL4MDrb3pS7ACt1c
	btAnugiflap7QKY7MotvIT9jRIJQTR72aEPSYTQpvUJRGXghhfeK5pLiV9OXuYCLJAd9ZWbzL86
	brARsJlHbgcLh0fKJAc9MjNMKrmccvFpQ097rM25/CTrsZUyaKx95scX6p8+bQhpRg4tLCel3yv
	QAjh/qxAhY0MuFQE7te85Itr6ruI1qs6/1p6g2ZnyJN1JwFS2JaHX88pXSMBAfUWehpwmAxfjWM
	rhHvuYRSUwhU3C7yRypP3Yt+l5vi9vGtJkS211LAPD5VfVKKRl0adVmJ57W5N4sM3HXwgwaZq5V
	empbO8zYmvNmgu+TboiYydfqTv/OQ9XmNb9pOJzWJQA==
X-Received: by 2002:a05:6a21:a96:b0:37e:4319:d7c8 with SMTP id adf61e73a8af0-38e00da269emr14536307637.75.1768985933284;
        Wed, 21 Jan 2026 00:58:53 -0800 (PST)
X-Received: by 2002:a05:6a21:a96:b0:37e:4319:d7c8 with SMTP id adf61e73a8af0-38e00da269emr14536290637.75.1768985932769;
        Wed, 21 Jan 2026 00:58:52 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10be07fsm14428100b3a.20.2026.01.21.00.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 00:58:52 -0800 (PST)
Message-ID: <e28195f4-e73e-4c02-bfb7-850bf3eabffc@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 14:28:46 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3NCBTYWx0ZWRfX/VnV9ENwElFn
 NOtP2cVf1zFBgB79+TbJo/WnWhJap6Ptx6a7nvtGF+2zVU2DOsd0g2UbyPelSPvN2kJFZfGBChv
 JuQYnGBlu54SVkQWAEdQ9nFNOjnknaeLnd3DnWmchgg9soG13LFXvSHwzr5gcO8W3iqr1nVLql3
 kjjNJzixXjsorDzVFEhiR1ZHPz8d6VQUCgPcwh45BDhAOyXJ8xtKuqNyuojnByPlb2FWPqiTkXL
 Mwo/DYkRI5q+73aMZGT7GKA9FkzxNPgTduIghxGoW6HaiR2y83eyb5eGMyFnaSPRHq/0Lqv8rec
 yXXA1fKAE3g7qezyRNvKfsafNMawk8N5xNQo1wBqXzzaCLvCDgrmCaGObkFYKOJXhLIL/MR7ltE
 F51yD5C9ONCXtXmTndWc+EHKY95vWHf8CQqwFvMHrxy6AzKJuS+sWCrr8XpWKA40hSYkk98Ql45
 OV+9hD9HgYzxpyFw6ig==
X-Proofpoint-ORIG-GUID: tvsfE6WlE99-oUMD44zOFgM1-F_QIl9T
X-Authority-Analysis: v=2.4 cv=dtnWylg4 c=1 sm=1 tr=0 ts=6970954e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zVePdD6VyHPybfqkj0gA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: tvsfE6WlE99-oUMD44zOFgM1-F_QIl9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210074

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

On 1/12/2026 4:17 PM, Praveen Talari wrote:
> To manage GENI serial engine resources during runtime power management,
> drivers currently need to call functions for ICC, clock, and
> SE resource operations in both suspend and resume paths, resulting in
> code duplication across drivers.
> 
> The new geni_se_resources_activate() and geni_se_resources_deactivate()
> helper APIs addresses this issue by providing a streamlined method to
> enable or disable all resources based, thereby eliminating redundancy
> across drivers.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> Bjorn:
> - Remove geni_se_resources_state() API.
> - Used geni_se_resources_activate() and geni_se_resources_deactivate()
>   to enable/disable resources.
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a4b13022e508..b0a18e3d57d9 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
>  	disable_irq(gi2c->irq);
> -	ret = geni_se_resources_off(&gi2c->se);
> +
> +	ret = geni_se_resources_deactivate(&gi2c->se);
>  	if (ret) {
>  		enable_irq(gi2c->irq);
>  		return ret;
> -
> -	} else {
> -		gi2c->suspended = 1;
>  	}
>  
> -	clk_disable_unprepare(gi2c->core_clk);
> -
> -	return geni_icc_disable(&gi2c->se);
> +	gi2c->suspended = 1;
> +	return ret;
>  }
>  
>  static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
> @@ -1179,28 +1176,13 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  	int ret;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
> -	ret = geni_icc_enable(&gi2c->se);
> +	ret = geni_se_resources_activate(&gi2c->se);
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_prepare_enable(gi2c->core_clk);
> -	if (ret)
> -		goto out_icc_disable;
> -
> -	ret = geni_se_resources_on(&gi2c->se);
> -	if (ret)
> -		goto out_clk_disable;
> -
>  	enable_irq(gi2c->irq);
>  	gi2c->suspended = 0;
>  
> -	return 0;
> -
> -out_clk_disable:
> -	clk_disable_unprepare(gi2c->core_clk);
> -out_icc_disable:
> -	geni_icc_disable(&gi2c->se);
> -
>  	return ret;
>  }
>  
