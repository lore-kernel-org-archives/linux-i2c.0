Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA8391850
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926331; cv=none; b=Gx7BiZOXsze3LdOL9+x78wSxkL8Gb7P17e3MM73ewoF+5JQQK25rrxbNkEYiQ/56eWcwrHFr4PYw099w40st0R8K6z0pt+3pYvXtn71bBeL2ms0EmkIq+/VAaAG2aUSWUH/h3g50V4sUWmATRRa5tC5lcmahYMGdEyyrvCbTQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926331; c=relaxed/simple;
	bh=gWV3fzYIKy638nnFL+aGAA+Vnwp/Cq6LplVvhwhWW54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPFgcBvm9+JTYgcTy5uXrf6Zc7ODN9UfbiPc2zq6Qi2fACKTo+KdcGsqHYitC9kpq3CsD2hLD9to7z+yfsecN9jp/Z1ypFXBfjhIqGlBwHkUAFT4yaHzmms3kEGyR4TZXarbsl9zqjM/E7WExJoWh3Ch/9axdLlCt9T8zmo7AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxNcyON/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iv6pbP0O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxNcyON/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iv6pbP0O"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3YWdr1587801
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=; b=GxNcyON/n5MqQMqq
	g5sf4Wx/rlKiz5v9jZwCVZ3gmrtmnVvwKAzkNRLsPOp1Ox4MbY23+PBRT8PStLyN
	irIgC39jopHa4FqHLnrL6X4aubHTBBQG9Z+vInHMQoQk+OkwEJ3lEi/kyseQit0L
	gj//BfxuxAt5LpQuzB3yUvAUP3sUW41s4i5CVfYGjJDkE4/vyiaxdJTn8q3RsPzL
	xrMakEP1VIsVk0JSFEBouyg1nrlqArcVKggEJkceIMTTSAQX23CYsn4v/pH62ktZ
	g65HlxdYYc31XJW4vyRoh73JyuwK8OX0VsYTMHAylMlshyrIGpFBF1+ddZm/4zdv
	FiGGqw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq2gf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so11670919a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776926328; x=1777531128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=;
        b=Iv6pbP0OqFLyUrSPo4fIOygqUNMKIpjbntxgDT0L1yxWZqY1Mi7K+M7NvCstDz7OUf
         Rc7kXsI7HHfN8wP9Y5tnROcfMBJqgnGuXIp87i5uY03fwK5aZXeW3YCNMiUZDt/lD7vC
         aEqb/6OEz2dbyj0Adzhaws0r/+FUoyuyqmRiWnwlJuVF/DhkGqJgXWbyAa0pmCvVxrMW
         Qhc60NMZKZAZ4ibXPbjzXeJfRVLpIqZZEdYb2pIhu1Yo0Cops0Y2QmBCejN/NDysbASa
         B9bU880bo0L/7bf5dYyg84JKXBoIcDRuctKP4nFD8U9SMsZcaaAz/bk+zzwzPghnKuI0
         e7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926328; x=1777531128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=;
        b=TNX6WbHH+A0/uxM2CuR0lOh7IOla+qpMuu2/OuV/njn4eU6M0wrxQENuP7PTUymtxz
         kyklQDItLWUsT4GYxegdQZAfoI34zFmw1b2yL8v2ct34Id00LYZZVXVONT60W2jjoy5W
         pBaJszdzefqtNVUveZnK/Hy35WpPc5PDp1yG77A31XWsoWrreqkVzkV3PTlq3ELYk/O0
         RP/cVzNv/RmVs/PsV1HpaLYh8ak3ZiQrgLYgGhaZhXRjC9GqjVasu1db0hqw3QwPH4v+
         fcX/pH3HS2OfOqQPT77K+SxBbFFAFoFDWC9ft1mlMd2Jekg2tsxpcG4Mj5xJrTtRu0Xh
         CLHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bzD9y0u8vxRCDJXZ6YLUQ8lCRx/p3SWyfg2V/5CvK4wyjihAYLP5F5cbkb7e+9fjFd5qr3oxLmII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRJCjilDybQtwJBu61ekkPUFxgquxjpvVn+iAzzHd/hBdTES9
	BJknR9S1SNRKCAKJQJyRb/xUy3miT59ZD3gPuSS87HNo8vvemiPTfrHdfJiyFqQhrFty8mVsc1+
	4ymfjPY8GhgFTkUPc4LjrRR/xDGRrQcKgUje8BZLaYhn5CsZ9+TE4Plw29HECcfc=
X-Gm-Gg: AeBDiesaM08YTi/VLtuKoRcczTV2pEWLD0dghoINOgzhv5wpAtst94D2AXmjMSTWICF
	0HxqDhTela7iAsFFiAgjUmvloQ2WMoglUXqPjgLlqBj9izckV+CX5ts3BsLU+YYf2QYBPsXRM3d
	zSyfia1EWAv3em5ROlV5PKVc5xYzdr1wdUK+7P0XToBShH9nYv8euNMVvEYs63EhoWFJTZbjcjE
	3krqA09H9g/DC0jjI/wSfWr4mZW9PseHImiF5JKCWuMbQQ+WPb8JwshaXATztChOW5p1/8jOaE7
	6OWPh3owa5RRIOnLuZRqAD2Hrt1/kp8eqdF1FrbV9dSkmbr4zWkO4ZsZmuBK0JNj2xFh516Rj0H
	c0HhGbPR4VMqzcbvOKTxvTfeLfcnXtqAv6e0jXj8Wlaqjfb8H3eaqGmKncVHyvr0w30c=
X-Received: by 2002:a17:90b:2244:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-361404a6b1bmr26676593a91.26.1776926327572;
        Wed, 22 Apr 2026 23:38:47 -0700 (PDT)
X-Received: by 2002:a17:90b:2244:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-361404a6b1bmr26676545a91.26.1776926327109;
        Wed, 22 Apr 2026 23:38:47 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7ab7sm24264844a91.10.2026.04.22.23.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:38:46 -0700 (PDT)
Message-ID: <3b99fdf3-3822-4c75-84a9-2371bea24beb@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:08:39 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
 <20260331114742.2896317-5-mukesh.savaliya@oss.qualcomm.com>
 <52685536-6b77-497b-aa48-621a82da2a0e@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <52685536-6b77-497b-aa48-621a82da2a0e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA2MCBTYWx0ZWRfX4CvKs1RuEnJC
 LnL1Ta1dVEra3fkZ5aSzMRDktwVJMr8JHyQgRtqhCCqoA5fe96bPnR0HO7MdCSnELIigijV5Fst
 dRfP/3N/p7lP5V0jTQgthHVhrGE3c14osU4bGuyiga3wbJCQK3qDRcADaUWaNEg4U5Un8D5cQGA
 LpfKIlxT2bWa691z/SHQzzGlBTar5OpEImXgxeW+kOlUa+9SmWVcuvle0GpMCh4HKL+ZaNsLOfo
 H48TvIsssjfzgeZZBGw8rWx27pESFJt4JUICqUSPzIjHfa6wQ39BdsX5mW01suOmMIr39RJmTSE
 LZfgSH6dfzM7efaQbeZGE2Twu4nAet0GvhRKWo+4MQONe07UJZu+9aKwLzv9PJ6tcGm2SdWgrn8
 brO0iJyT/gtmUqdiZovMj9VHQHzbnTTzbfT/4BMHxWUSmtF1CagNlkDLyR83DDtzwV6RGay08KK
 Oe0JEgREMAx8uu5OeyA==
X-Proofpoint-ORIG-GUID: udnnR51RsKFjyWMWXXr0DFdyZhTgOykg
X-Proofpoint-GUID: udnnR51RsKFjyWMWXXr0DFdyZhTgOykg
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e9be78 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=PLbU5tYRtHHGnyVtiekA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230060

Thanks Konrad for the review !

On 4/1/2026 3:51 PM, Konrad Dybcio wrote:
> On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
>> Some platforms use a QUP-based I2C controller in a configuration where the
>> controller is shared with another system processor. In this setup the
>> operating system must not assume exclusive ownership of the controller or
>> its associated pins.
>>
>> Add support for enabling multi-owner operation when DeviceTree specifies
>> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
>> shared so the common GENI resource handling avoids selecting the "sleep"
>> pinctrl state, which could disrupt transfers initiated by the other
>> processor.
>>
>> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
>> driver by setting a single lock_action selector per message, emitting lock
>> before the first message and unlock after the last message (handling the
>> single-message case as well). This serializes access to the shared
>> controller without requiring message-position flags to be passed into the
>> DMA engine layer.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
>> +		/*
>> +		 * Multi-owner controller configuration: the controller may be
>> +		 * used by another system processor. Mark the SE as shared so
>> +		 * common GENI resource handling can avoid pin state changes
>> +		 * that would disrupt the other user.
>> +		 */
> 
> I don't find this comment very useful given we have kerneldoc for that
> property and the behavior you described impacts another file
> 
Makes sense, will remove this comment in the next patch upload.
> [...]
> 
>> +		if (gi2c->se.multi_owner)
>> +			dev_err_probe(dev, -EINVAL, "I2C sharing not supported in non GSI mode\n");
> 
> return dev_err_probe()
> 
Done, Thanks !
> Konrad
> 

