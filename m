Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAC1CB31D
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349216; cv=none; b=cnZP86PcK5Zk97PAlz0Vquacz6rl5mk7E/iWH9bZ9rYTtG7G4VwOJE4QYmlvUqJMfq8+Bf7HTsLesPMfmDBGYYv2twHOkzHd4CMs5e1JKQUY9EVeF0UReSczqgD3knFMvFNZUO4gQlOUJtu0cW4Ep2ljQGGmFWRlfLfgJa1xt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349216; c=relaxed/simple;
	bh=mnp0hDUMzsfuD8bK3qz6ZH9GHD+w1suz58/r0pz4j0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FteLthYwX1CLtG37LKg1I3Z35TbxxvixpSMWhyZ9u/7KMQuMYStZE1SdAjl8EqYBQcjuNi8s/Q9JtFMKF62ypt2zicRLpIo/arqgzqAUQmKVlQIvVNDvdP8oCg8/vrPQ3FcLJYBZViyTG8dvg3fo7GLCCpB4fUQtYxgsjfJxT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdgJ7aKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K7hKTzeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdgJ7aKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7hKTzeU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6EwHh1798618
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 07:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=; b=EdgJ7aKe0dbx0o9S
	oswDIcris1MmJIdTlkWGyqwXmEyMm/3+tcV0c8RVBba2keOATX6VY1IK7+RhInKX
	68T0EmvjiVGxca3xv3eZLnruWsOkpD8IaTEebkgqbmb2gJI/DRPlOxka8RpPltRx
	kn8eJOm2v7YhxVfCX/7nVahcBv8XmSQASVDC8Jdk7bun1eBRHu6UII+Q/SfmIIJm
	8tuT2Hf/2AdyVCxdYCK2dUIiLdAFLLUI7zI7M/IyZCV/KH68mC0Z5T9NjJgCdK/m
	g0dbgmfs1x/0/vVsQxUAqDxXjW0K/cZ8PgWFUtvkpejH2LFhWivsL+vAMPCwqp7z
	gqQU3A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu3sse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 07:40:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so9262946b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779349214; x=1779954014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=;
        b=K7hKTzeUefitX8Niim8JrJK3puF/pQ7MiQHQyCdu7F3jp3CdNxH986I88wTBCt9osI
         N36s3uP6RIXeWvokNLenBFtKNiKJKyCDHVclAlHGpRRF2DuQ2f7TLmVixzOY+APyc2aL
         yk1bxMxrTYYoRudED3yVz6+YuyCoupo9zzwo3TXXVXJJ4NIvPeKtCRLF7GMwMAhNBgnx
         CAkEbeDhI/uafbMYA2JKZlzm9pHxJs+3v7Is/pnj0e5vbypY+LISK+HKnUr3LcXBLhHw
         dqXGi8bLJEBEJJ+MgKcM4I4JgiyJwnQkkKVZnEd+LXR2TuR98/JqTmmjLO1iWRnk8zxe
         cDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779349214; x=1779954014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJVuFDQsF4Iwfpmap+pWFBw4cYfM0g67R2E4BQtznhI=;
        b=BihFm/pg73X27raBpSvpQVpgT4KgxMnKyOXvxaCTAaLRV/ydJF1/IVjJ8alUzpoBES
         DhdCIoi1VePoMmkIZbUujmyqQdasYqNfrg4Jiynv+BCPnIvZ5+B71/cZRJcDol0xC13I
         VAVyKsT2ZW/rnZ77oleZPBPE75L3CWBHL5Y6XLwtHzZD6NAJSUiTYACv+8IoQNNtPYZa
         N7Rbm/VMfGDVlE/PdV1jiXMw92hjMgYEPlWhF4H9y/CQptmVwSbDOzRwzv+qQXdafAVx
         idk3hSf5FYvkRVy64waSX8+G61MymYpebk42uUXvd0LCa4mvBvo/DYiI34wgdd8Giesn
         wOtg==
X-Gm-Message-State: AOJu0Yxw9mlIdzL2pBwBu5oJerOd2crmNZdzH7SzPrrn7caxXubwL3HC
	otOqqEuuKX08nEVOKCUiju0dRIvS77af2Iwfmyumm+4G1Mk3OKlI2A780lhKUFS/m9B3AKdGHMe
	e96yXKhG/Q5uSYirBCfB6afykUeXa9/RZ43zXpiAVIpPIL7+mprGDRK2eAwYYzes=
X-Gm-Gg: Acq92OHebhrvtSYGDYYExQ/z0sfXO0hcXL7eINpbGal1gMlK0e4EZlEB0NMsmIG4mmr
	JtmFpRrnpuml0jXX7O5ZzXLSkn9E7Y/0oOt6hYAiSfU1Mna4E3KEJ4+YbYhQn7yHNawUAKZcXMD
	7L9z8iuB8Njog5Hts2Y4i3BzB46K/mrofpEnz2rhMRHfbOjuCNBNNyzH7VMozGMNMTow5mJJb6J
	SSWArGz0jevYFGGvhxdm1twLviWgYy+Ewid/nzWPgcSa8PBOHKVDmqcXEodiw+RPe12cg2Vks2J
	t5xAfB19bdg9tr2Ni/o+sLj0MHWIegoDG7Pe5yIHReniL9GmQkX7idUOMcgvNTzeAxNiU5nEOYx
	Y/TjA//0CUHnbKk62w+SlK4JauEWjajcq9wlD+74zr2CZAIBfAKVfYNn/W9hqxXvTCrk=
X-Received: by 2002:a05:6a00:4006:b0:827:2a07:231d with SMTP id d2e1a72fcca58-8414acdeba9mr2010677b3a.17.1779349214178;
        Thu, 21 May 2026 00:40:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4006:b0:827:2a07:231d with SMTP id d2e1a72fcca58-8414acdeba9mr2010643b3a.17.1779349213557;
        Thu, 21 May 2026 00:40:13 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e22f1esm477039b3a.47.2026.05.21.00.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 00:40:13 -0700 (PDT)
Message-ID: <4979e748-ce4e-4244-8906-e22a1e6472e7@oss.qualcomm.com>
Date: Thu, 21 May 2026 13:10:07 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered
 down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>, o.rempel@pengutronix.de,
        kernel@pengutronix.de, andi.shyti@kernel.org, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
        haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3MyBTYWx0ZWRfX/coZ4+fMSvLF
 yVJ9kFgkzRjH5+//DXjpbnMxyalREpQUdTGgmG+CDwOWYAk0iesXVyEBVI7WlNZldUpFcAmEE0O
 zaoaeywYQa9KA52LGzw7q+P4O07m0dR42QsV0zAoexmh9uhwBJDWjbvYBmSZ9Cd24gf1oUVD49e
 pN952KKPIlpTLWFtFmlC8kpaP2nTvMa7AvICY867CsQYssYp2xIbf72Luag7xmegHfOUirFNnsQ
 mb62gAWK+b2Zn9f4zIBobMKSYaZ+DLpNqVvmXBiJnPsrckjdSDE40T/imWUIRgsGBDXGtpofSpG
 godlnkhmxTb7oOptKbHs47Gr9wnVhyzezuDTGmYIdgkKdBEeZud4T++o4WlZCoF7nXx3RChmwil
 k5Q4TXHZ6ejJIkVLVpDTKnrGmQFXdiPUIAy75JClybUzZQKDEIKAn8X2ogqq7IFNfVEyrLAIIox
 g1QCtn6L2QKsv7IRsQQ==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0eb6de cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=KOk9-1IoVFRPxriqIuUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: dgtEo24srkeg3bPthPmmO1z_HKucJMVO
X-Proofpoint-ORIG-GUID: dgtEo24srkeg3bPthPmmO1z_HKucJMVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210073

Hi Carlos,

On 5/20/2026 3:45 PM, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Mark the I2C adapter as suspended during system suspend to block further
> transfers, and resume it on system resume. This prevents potential hangs
> when the hardware is powered down but clients still attempt I2C transfers.
> 
Code changes looks fine to me but have comment on commit log.

It seems, you are adding support of _noirq() callbacks to allow 
transfers during suspend/resume noirq phase of PM.

Would it make sense if you can write "Replace system PM callbacks with 
noirq PM callbacks" OR "Allow transfers during _noirq phase of the PM 
ops" instead of "mark I2C adapter when hardware is powered down" ?

> Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for v3:
>    - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
>      safe suspend in i2c slave mode.
> Change for v2:
>    - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
>      to prevent potential deadlock if a transfer is active during suspend.
>    - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
>      fails.
> ---

[...]

