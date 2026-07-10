Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDF396588
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673422; cv=none; b=Yg5VK9zeC8fqPb6aKlqE3//ezHVPZdF3BeEc4Wuk7I2RPWIGC/e3HgHoZabkaLORd28ApxUPo9nlYciqKW77UJfNo2wm7G2vJkZ/KpwkD19CJQ/ug0VT1uZpHWcPwLS53wyaGWMU6rJE/2rZDkSKCDyZnTxBJZApBtIyYJnieU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673422; c=relaxed/simple;
	bh=9bWhbND8DyvzDCbaHug3rOhbSdj9QX9W+6SjaKd08CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcjVzot6lyaKW0WJ8AAaXCCJ7VMEzg6KNVwsUG4FJxUjG0iBkF1EhdA/mPuIUbiVJbQXH0Vlaem6tl1ZxXcbt+UKzx66riWQFxNBuAsF7aXXkjnF3ICVJsSgYptWecCMtiwP9MdRbE7L4jlSjoXcx5R8v9LrRSdcGxvvmZYbQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xg42b0g9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/iO/vHA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xg42b0g9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/iO/vHA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dpfl236034
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 08:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0vPVQ1ErU/pGixkPNw1WBsE9kjQFwY0ce2USBSASEqE=; b=Xg42b0g9MUSCQ9s9
	qurkfwSTMG6N35ozQPKaN5u+nbzys08f8XsFv4NIhisNMtn7IcSV0gUsuyb1v13A
	/gtHNuvVFUSE50JwppjGYTR0czD3xR0F3WnsuT64VgQvZUahdJNCf14Q39IJLLBm
	htVWmPmThcCn302tmihCRcdtCYhyl8q244e4BBMfDw78RwVgyOB/HH4/Qw7HmelH
	LVtzEIAzW8OgqQxMOGXsQyH8dzdGQJh5ocqJMvg2od/JmyA+H0o24kFPgau22FYd
	h9lp10hZTxXxxPEgOwj8sDJmK3+TZlRzdZdDZGmqqhsyTUyh8CG+hFZcgv1hj+Q+
	coGAWA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3kn3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 08:50:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so7913465ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783673418; x=1784278218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vPVQ1ErU/pGixkPNw1WBsE9kjQFwY0ce2USBSASEqE=;
        b=c/iO/vHAVgCEb5G5jTabEI4RFw+qXN79sMwjNVY3wbQ7+7cdBFGWLCt3Y06SCJ4w7Y
         SpnVSCR5v/xz4Jxc+JVbNZ+lV+avlNTL3+Feb74k7Cpt1SAxim78RHt634Oca14RoRc0
         zZ30kQ8xf8U1gPXi0zpdIN8COm4MhMJa8vYJRUWXJT7J0/ZKQhSeGiGhaUL+M3Hf9cr7
         p43PI6T63eeGPLxMP4+BpP1mWODflncBz19Ikifv39AZufRjF7UPh/07IJqKi6Fv6ILm
         ZVK26cJdCH3+51YbSpE1be4sZLf6xO2Wr0QxFTbp40LM2MZTkAwaSupPmA4ifbxktOP1
         HGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673418; x=1784278218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vPVQ1ErU/pGixkPNw1WBsE9kjQFwY0ce2USBSASEqE=;
        b=WdFu+LaAMLKGHqLCFVUJh1f+LohgnA4WYLE1/XaYe4LcVDf6Zu7HD/29f4CzRiQoJJ
         tma0ZuI8P+v4soOy4bOC3F/dg9F6p6b/PRAOYseMmKEL87PLgQgH6EZkqpMvWCx4Q+wz
         Km2lRY/aF4ZyJW8e+UFwoDHwkPgUvv5I1bZ7WwsUetPJZOEYUEObfxyCiJhf4BOQ1uTw
         zQT6WHfkYh0idyjpI6Aix6avtcx5hRs5ZSbvgPB9C+FFppkZEVNDwuuXWle7MDb0pZ/r
         i3z+OS/NcUoUGn7dGUxUmeJe3cbUKbFf23gbAHW57JEb/ZtnWn0hbvUvnFYtB9/qK4Nv
         tilg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/iUST41DsaHNsPJWPFhvurf3emo9VU7Wpw+j8yn/6OQih48GJplJ9TyIRCH1fdQT6aNJk1WXwCT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpvzGUw+aN+SvJZCVgCau8rEbWCo9PojNg9ZFD4OxjH6xRcbs
	nmTrKytCqlGpJl8rsVyJi6jZdvdbLohanAXtnRtVuOyX/OFYh5vO9+Jg9c2N5oJEf9k2Fufxbl/
	YorMD8kWyfKabEbsNfHU4u1LN0c5k3Kwpomqd6ScP2xx+EPIr2Y66FZFxt31v3Lg=
X-Gm-Gg: AfdE7ckBjQPoP+wsBDjNXHQIV/rP7WUUNz8vaDetYDG5jR9VNAAK6gHn+8t4UTBuS0e
	6Ekq3JQq8ud+7BiAUbUufH1xorU5XnBg/THy+nW+4AlIQGlcJizJ76Poxy1xrjNev1/VAbqcZOr
	YfZPsxYinG30AQPqCdqNlMxinOkJ5gAI9BYx/1dlm3y+/F75SttF9gEzj5C2tYJFRu/bWtieXUs
	W8/ihBEc3YYi7iOMM0mpu7cUrCtOMRmVixnDlJkZdEMGX3eKSsRK/MoRhRfoC9pvAoLkWDyWeDk
	LRWtafoJCchqfEnQxb5gSM/tGyZNIXCV8cdj4YbinyNkcvZrwFJLvwULNPP0KLOLtY3y15/MdXX
	h2MJVrEnfiXgIabN+oK+wV5f7gWIggHwrGpJlArVsIffI
X-Received: by 2002:a05:6a21:6115:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c0f0b6fda4mr3080658637.26.1783673418517;
        Fri, 10 Jul 2026 01:50:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:6115:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c0f0b6fda4mr3080616637.26.1783673418002;
        Fri, 10 Jul 2026 01:50:18 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c76dsm38642648c88.3.2026.07.10.01.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 01:50:17 -0700 (PDT)
Message-ID: <76c5567a-cc93-422c-a18f-a32dcb101428@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:20:11 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, troy.mitchell@linux.spacemit.com
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX+vqlB1JrV2Er
 CkMZK7Y3spDvVJ7tZBsxDCTOKj6W51Jx9SbIPN+pSz6E13Y9bBOVDQDrkpREH4myv7Q5t5efrHm
 xF+ZXw4G44H17NmCWO9zVf+uEt/MJy+WOjXW2oT1+YdrO0iJA/xfEoef0Y3HsRSmsSgPdx9GvT5
 vKQM8m8FQxtNbxl+uS07E9vUWI7Xu9ZHXG6HglwSl7h6+cq7anNooP8PblgQtvuD4bwzVMgRBSq
 plvHyroDDP0UTSyJeZF2egWnMT2S08ZVTtdarc7po9oLk8h+Jj1gVIJlVz+3gho5vvX4dyNC4v9
 +neIE65pDmVfMSO6BDJliBDHJOW0/EUmqMUrapSgSxliJp8t/VtoNvU/kshHAutjWoTB1uOY5Ue
 sB4K3osoc4QByEiF0CFs1M8v/6mT83ZM3BwaCZ56cSO5GMKQmI23w/7fHGMRZOweT33F4Kt2nXb
 +XKNDqHtEtA3M4xF8bA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50b24b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=fdZnArvSVwIb3KS3I78A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX09n1EL3+BRbc
 wUoQp0PVK1+jR+OLsTpySoi1Ot71JkL4RlMEBnPE5yMQCKPtw/f2v8seXjybebUFR+UaeWvimct
 5QRs2SyyMEAgDPCvvwxRwGgLhFpUQZ8=
X-Proofpoint-GUID: C_Qhv3yAVlcBGjs0594NNdKlKK-ZSIO6
X-Proofpoint-ORIG-GUID: C_Qhv3yAVlcBGjs0594NNdKlKK-ZSIO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100085



On 7/10/2026 12:51 PM, Pei Xiao wrote:
> When the interrupt status register reads zero, the handler should
> return IRQ_NONE instead of IRQ_HANDLED. What the return value
> actually feeds into is the spurious interrupt accounting in
> note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
note_interrupt() ? You mean to say No interrupt OR invalid interrupt 
here ? I could not understand function name.
> nobody cared" detection, so a stuck interrupt source would never be
> caught.
> 
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> changlog in v2:
> modify gitlog for Modify the incorrect Git commit message to match the reason for the modification.
> ---
>   drivers/i2c/busses/i2c-k1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index c2d090f6ba80..487f23fde725 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -728,7 +728,7 @@ static irqreturn_t spacemit_i2c_irq_handler(int irq, void *devid)
>   
>   	status = readl(i2c->base + SPACEMIT_ISR);
>   	if (!status)
> -		return IRQ_HANDLED;
> +		return IRQ_NONE;
>   
>   	i2c->status = status;
>   

