Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA7400990
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138883; cv=none; b=MSLO7rffebFzpEby1zpWbxurKqFMpp8fBo68L5Qp1W9VHeTy54sKHuEnN6BWt1YJYs6ydNL25vwSp+Zhac5bI3UFqWVfVidU79rj1fVEtIBBGM4P7BXIzXhlHJzI9xAEiAjg/K2mx8aVK9oUItMwOlqym943vCZG7Sf2pLmBxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138883; c=relaxed/simple;
	bh=yk81vj59l2TmlXH4K+qJfCYvv46f+EWu/61vbJd9hyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBQmBFhOPUad0muuBDYKSFjHR+EsUFDK0wkCOwYJQ/gT38EXxKxmC6lYIaMZ6Qe28E8JpNTq5W7xK+WCAdQS5GBuVKCY0N7TwsxDJxq62FaEQhT1rR4ZDlPBEY2PEHmL9hLfg7Chk4ciactZ3W2S1+ccULoGB/hw7B/oe9lnyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QG0j9kE3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tw8t6DjS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QG0j9kE3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tw8t6DjS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FHB9nl252977
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=; b=QG0j9kE3UmnyuZrj
	W4iQ2dWKlxRnnw7FTXVk2auEnp72Uh/2ZGA7lk+BSspZMU9zm3WrT/ImHx2b8B7Y
	3DIqBChIsZ4wLPCDPt7vlBstlYgPQ92bHFz2DE6WMvu+CjSHC+4Wefiet5iXdimU
	IecgsAb5JcNUPZ6qtZHd42Dziqs8+bbRSTje/tFYlUTrUcVyT9XSVxl9gD/7U6P4
	+foflPMir01mHnNwF0Z7SvNCvMl+MbFWHXUUCmws+IvDp/MNr/uLotWBpsbfR5RE
	PWxt5v10JHpNiwo4ZoJrDM/+3GZoh2VNu8Xpue+/w+jcwHGgfW0ptv8/5WGufR8p
	Cfp7Ow==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe652anx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 18:07:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so2059768a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784138876; x=1784743676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=;
        b=Tw8t6DjSMoybh9Wpox6SBhtbG/9qtHkZkszaQDUR1Q/oTKB+5ot8sXEJjheCJCGCFS
         vuWQ4REBvD+ml9vqInvJJoo1CDnfEeyqoWg48mJoD4vzanKDVfDZzWuTwySrbOgoV5e+
         4w1qw5BQTdrOB9h04xyj5pDhkbi1hBzSJf9HEkSohsWdD9esGm5b75yGEh3K36HAMvLX
         uNa6F2HSV563QJhOVBwmP1246wDrUktRBfLr2qpUCtBwWFR28PEcSrkExbP2h4/+Nho/
         lveN5Chrioy6axsEqifvHA6j6QAI/2BiI23lLpVzdoqgw2cxLcJ0xvBiJQgyPI8fROy5
         yDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138876; x=1784743676;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=;
        b=Za3Cgs3HRmzn5k8Mz5ZoyP66ZoDIkDGRfzyISCMmRGtBVztcjWSCx+srReGuM6w+ah
         0VZHojjQysPCrjrnkJe/OHXWpIV1JG3bn6e8JWedCdi6XCCmQ/rcFA2mRrxrqA/SJeXI
         ojxb0W13BOchH1k8qAZftEA3Si+UjPbncdT6bNlQxks4DIjxsv7WRkajXsqEpNcdccYF
         X3UNUHKBJGsl+W2Sy1N5FZzfudtr1NdXUYJ1A2UtK3ibI6Z7dpjcmr0Nvbs2jCY/bEzq
         AtvkI1eQSruEsciEBFzC02FlWF9/oCraQYVbvVwHZ2qXM1eB0MuINwq7O6n3zbqz3z9T
         SoTA==
X-Forwarded-Encrypted: i=1; AHgh+RrO8qdrin5ega6FIRJZo9LRuLOtBDFCwEdghhngFdnXfTivZyVwEqp9CX2t98Kdb3h8R7FxhuFs/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD92s4A+Um9JuhraX9c32mt3PIEQwxMosvg6jpX5nnCBStCpVU
	3E5cOZ/xpzt0gbjFlg6BOYIRYkmwwHiDHFesv+BibSYZqaxuwjfsru0k01Q5AupMY+GhYxMqHqI
	HcRjKNbPzP/dbcMBpH1zdn9VXjnH8KS+XBYwUMq2Y+kihoi8kjag31OeWqJMEHsY=
X-Gm-Gg: AfdE7cm7gXfWjvwp9a07guFukkHyga97lNu1ICrPBikRQa33oId3kMYp+njPk2mLkk1
	SMQrzdcame/me65+Hc2S1ZqXzc06F0S4PMsBSoZHSRtZuHCIMoOoqQkG8gcWJBTknUePOVnyEsJ
	y/WpbKbEXtaEzLI/gotRdJFwc7/E1hwEi9dXrQffKafDZiMu/9v7ZEhZp4XOpAfZVcXvORUINSp
	oRKrN9VFEpBoARr7AwEQHTR6RqH55Qe9R01SFQ2ySydlXhu/4xn9PTs6jK+BpVJarKbQYjy6Diw
	a6tAfBNNl/CWCovrSn+mphHaXI33YYaXzQ4Z7bg0x8/HdViT7lsWAiAsdobdPTPg8rDiyGe68ZW
	s6k5kWM1ool1D8N99VFyxj84XZexAh6CHLftqKUPr5btY
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id adf61e73a8af0-3c110b35019mr19226587637.74.1784138875482;
        Wed, 15 Jul 2026 11:07:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id adf61e73a8af0-3c110b35019mr19226551637.74.1784138874931;
        Wed, 15 Jul 2026 11:07:54 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd432f1cesm5187074c88.11.2026.07.15.11.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 11:07:54 -0700 (PDT)
Message-ID: <312315da-699f-48c6-8331-6dce3abb899c@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 23:37:48 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
 <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4MCBTYWx0ZWRfXwT2UJt1R5sss
 nNfpxUUHmR2UaI+4/Ar6hoRbldPbyi+ik4Ke795v2IHAjM4ldr3dutBWFM6TtUqvIx/02b/ccPo
 opq2zflkrvBog8ROGSG0YxnJixylNndVz4sglQNdT/l0bilYHMbtZQRn2hQTzCpsAFQ9nvPIUI4
 xszmXMq4V4O2waQ1M5fQ6TbghGTGapwTHaisW7lvYpuGo+2UwgAI/VNRCTwdX7SRJBwc75ylvTn
 BQZTzk8gtez8gbPQmzTRrNUARrLt1ao293t1OsFihlOrUaq1yrm7uckz50I9FarfOJkzP9hs1cx
 Va0P6ct/2y4hC/VaoPlzmQJbi2Z3oQQz2S9vF8zHHLm8uTllmq7kbOQearibhBCiD7TfXdaBExn
 d8lcYWJq2SRPuH4WmumjkAEHuP/g57b5qzXeP4uObomIwGkUxNtyzcby2XkES7FYniYzboA9mBe
 V11adpkVGha60u3efww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4MCBTYWx0ZWRfX8UUylT3veTnt
 u0dXrT48y2phlvOsCTh+GkT0d3OX0wqACPYfx0wMC9rL9Ws1VZD19TLajkq8iZ06hg1iuChz/8l
 znqbzRNWjUnLKQlksOZ62CaxJVhTUf8=
X-Authority-Analysis: v=2.4 cv=bKcm5v+Z c=1 sm=1 tr=0 ts=6a57cc7c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=OlrBKP18NtReKxGUJ9moaA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SU41Sc21RSR5G0VrqPMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: r533x7w0LbBpCVW48BIuLjbEK7UjeOUL
X-Proofpoint-GUID: r533x7w0LbBpCVW48BIuLjbEK7UjeOUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150180



On 7/15/2026 5:15 PM, Dmitry Guzman wrote:
> On Wed, 15 Jul 2026 15:48:05 +0530
> Aniket Randive <aniket.randive@oss.qualcomm.com> wrote:
> 
>> This replaces the fixed 1-second timeout with a transfer-specific
>> timeout while preserving sufficient margin for software overheads and
>> bus-level delays.
>>
> 
> The dynamic timeout may be useful for any I2C bus controller, not only
> for qcom-geni. Structure i2c_adapter already has field "timeout". Isn't
This is good, thanks for pointing. For geni driver, please review 
gi2c->adap.timeout (client->adapter->timeout) can be used and you may 
explore retries also in case you want to retry.
> it worth to move the timeout calculation to i2c-core, so that the core
> updates the timeout field in i2c_adapter structure, and the controller
> driver just uses this value, instead of duplicating the calculation in
> every driver that will use this feature?
> 
> Also, such parameters as I2C_TIMEOUT_SAFETY_COEFFICIENT and
> I2C_TIMEOUT_MIN_USEC may be configurable by user (for example, in
> device tree) for more flexibility.
> 
I think it's good to keep it within driver, not to expose as 
configurable. This would keep changing per user/system load, but ideal 
timing is theoretical + some offset, hence can be better managed by driver.

> Best regards,

