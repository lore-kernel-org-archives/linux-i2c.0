Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51E34BA42
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577092; cv=none; b=J5qLK4TI0cc1l56YqGfufFdTr2YN53k8nZuayu54kxnZAt8RaC8E4qX1VNPiFb+bC5cYS/arUXxUUrWN3R/W1prtZcsh+aepRvLE+2xgS76LARKXH4tI1P7nM4v982Ja9o7lKtCsYiVldcO32XjhtCq7SKeXSt4oiuVk7KMsSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577092; c=relaxed/simple;
	bh=WNJuEus8ck16SJoGo/esVS4JXj9YzA1nQDebh6BcIBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OTxVPNPtXs0l3H1LTPByn/YIW/ex2gpcubtHBb9mIcFFfhhmp/gIdVSAQHVAWrmHRiGXfBwqVzfFtkLPL0MC1wrqichvRo/xxjzVWg7gUuXD54A86W8ogdArH99soaW3WOC84v3VBmNfDkQ/vnM8F1f1pMQ/9MfPYBuxuUShfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Np2snA1/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XoGNZY6T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Np2snA1/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoGNZY6T"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669604hq712305
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 06:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+YIXIY/4ZJpVgegUJNfS3ZfbS4I1oxhM8KfIDXfCtY0=; b=Np2snA1/9/isQ181
	qiD3dLF7ej+WpyHZceM06jh0OpZP5rH+j29q6qQocW61/eoYLQCtTIDMmgWUT0S1
	9AEl6pDxX9JAftxZMZWA4GA5m4pjdiCo5guvIXaeJ3EWSbqoyVrk6xeaXgTkuLXi
	MXLyn2BrnYPhr8Ankiedj7Zg4S4BEO3eSNRwn7hW4VxnFMDLZk5HGU2dPEg3MAXs
	/d60uiqlkVNvWQCqtvYNYWsopZ371RiSji5JtnFoyDhD03fzuzq6UQp2Qne94pA1
	daElkmvwRrlcl12KGFvnYN8xQWFSvKx8X/mJwzjBIJ3J2l7stiZaGJvvjP1yKRun
	aW3Plg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vg6sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 06:04:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso3345100a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577090; x=1784181890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+YIXIY/4ZJpVgegUJNfS3ZfbS4I1oxhM8KfIDXfCtY0=;
        b=XoGNZY6Tro80OL44tgW2tLlJ+pwLQAAZGQxlAkEAQH2GxYgLb1zwm3h5I//TGYHUMq
         QOy5zWTzvReZpRs04iceFcPiRZPaMyl9I/41O+A786LbIKhHWi+8L0RuIbrNKR5gKXIK
         7J256lzRpEk8sdRVWtv0rb8V/Rf96d+jZAbqilk30qer9GXt6MfjijGnHGPrXJqVBFUQ
         Oq6UFXucufOwiswi5VqbMVIzd0Lv1K+sWUJ3n0BCndQA6CbPu78g4IlGufLxTUt+VnyZ
         ojMUcItpGBCUxmP0sdB/cWoczuSWppJFMVLZYVXP+U7LeKQyq15Tuj4aS7CJmc3x7tge
         gIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577090; x=1784181890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YIXIY/4ZJpVgegUJNfS3ZfbS4I1oxhM8KfIDXfCtY0=;
        b=bFnQkqqvXXxa4h/GYJnoBwL1FIK2bHj1BKLOavL4L7Ra9gwpYuUJxkE0EW3CSfkGFk
         gdy3uSsSnvje5YVub1A4YBa9PoqoK1DdDNh7Ir+gF4/PZnwGn1QWuVpLSmduK02QLtX0
         c+C22iErrOnI8EWI6RqMDxjuw0A/LLH7gp4v4jL/fVNI5nTzccB+n31oqvBWHhi6x7wb
         rJJGdHbqQ4FEZnJijPCrZmYzeYuwKHDWlXUG60+Qx41GysyoT5TJ/pxFJ+2DYiVpSCh7
         Kj9D6afBor9EtWl79X//d2Z9b1EZIZeUy8LPpGCVg9jSEpoZHVYUy97rvQq+3xo2Y9Qb
         u6Wg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/VfBXAHCBbepORbkjXR5kMlqBsACAu5Vok7hxVXkHZI0jFu7ody86pbsxEFVihX5wYqVyjeoJHTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/4VrRqpRQPutjYNJzYP/Phg84SxC9JuTYYoDcQTMWVCl1ftd
	PLeKcm+SjIhIKgzZBOIP8n4pr6VOH0ua869GvdyUeBR/FLcIDsHczAjO85x0do2zpz92YQS9u6L
	AoF4mCAyWpafIaSd6ig2XYpPPxSSCfhO7ZP9RH0qOEX5kfy0hHzWU1nbIbcVz3do=
X-Gm-Gg: AfdE7cnLJiTXoMddNOD4HEMfkXGL9n1yvC65hmNQ0xj1YU+0AYwvAwmP4PJLW6Y9JC+
	qc61ybXVHNv+pmCisIvUXNlGa3ueJ0Sz8+B4gSt/u78ZEQAzjBWwUhtTChjnwjppWkad8UMypD+
	D19UcB15GrNvzyT6y8/oLIshlJO+O0cwOUHanRyBbwBgzmWtE3SrrpMMlTBb4PCT6QsKBxytZDM
	QuaDQrQr6rrRRh698RsfdvZN6/xTB7kiChY49dAyXlBhJbBHuJ144XTN1ByBORqaVlMPJ4fKQCH
	vcaK+UrNE1yPzbR/jeqc9YhowKwMizYwo68TD6rmUxQHbEvRLpmD66q188+nTJMgMNqjLuZUkNr
	shtpWKjD03a4VQ/cGl7hoEBBV/5z3K6xHmXfN1VmW+e0N
X-Received: by 2002:a17:90b:2742:b0:37f:133a:3e02 with SMTP id 98e67ed59e1d1-3893d62c905mr5984417a91.0.1783577089771;
        Wed, 08 Jul 2026 23:04:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2742:b0:37f:133a:3e02 with SMTP id 98e67ed59e1d1-3893d62c905mr5984383a91.0.1783577089287;
        Wed, 08 Jul 2026 23:04:49 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5632235bsm558996a91.15.2026.07.08.23.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 23:04:48 -0700 (PDT)
Message-ID: <54e814c8-c2b7-4414-aeba-469973a30b42@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:34:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260708090552.739789-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708090552.739789-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX1pcvXDrdWO89
 EgfcL2MjeC+EEhVDAU8X5JGRWOFESs+uwYJT1JCcowP1tPOoVdfMOz1ewnYJ/ZX7wSwPOUxkz4b
 HqX1VRIsz/rJ4JF1sax1gKl/GL3Qi7i7evnKlR38kgl5Bwy+3EtDxyHOvaNEAot/QquP+wRkw5E
 ZxbexSd6HCUDLJ58WpwgKeBHDFrJOvZv/i/O1mNoBfEFS8D51+gpcyQ9tJ/Ozpr0JWS8DQ3OkD8
 g+AJZ/hFPNjWND1V18V/OlO6Fpdfbx/oWX+NkmX0Mt/6hXmdRn7pwdxlGXT6C26wDZN7HvFca32
 HRcW7QTl9rUPeh1tDPtrI4ThycflwE2oQrGT2Ar01/PNzeGyKJDrDO3RrsiN2I5FijmGOhI09C2
 4wEN03EEUwtyGzVR1iBmSH28o4BDuC5tgUdNzHj9eETpHQXgFb86+4a6PgViFR5t+hF3vhAVrhp
 bE19xVwJeGF2vZY+J0w==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f3a02 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-WDWT1t3AFrGqDG-RHsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfXwM6KZ74kOiyY
 T7mUPXGesHEEcR30vnqJIH4KScZbPpfuKe2uVufRgkwo7x80ioonfa4edKBJeOkKCWroUCPZZCf
 +ErJArlbrnCfAAyeV+HhD6gh2aUgDe8=
X-Proofpoint-ORIG-GUID: J3GajW6FbN-f6fRrqt0WZM4uH1rkqn57
X-Proofpoint-GUID: J3GajW6FbN-f6fRrqt0WZM4uH1rkqn57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090054


Looks fine to me, Have someone from AMD also Ack'ing this as requested 
by Andy Shevchenko.

On 7/8/2026 2:35 PM, Guangshuo Li wrote:
> The change referenced by the Fixes tag avoids a runtime PM resume during
> probe by powering the ISP domain directly with dev_pm_genpd_resume()
> before calling i2c_dw_probe(). Runtime PM is enabled only after
> i2c_dw_probe() has succeeded.
> 
> However, the i2c_dw_probe() failure path still uses the old runtime PM
> cleanup path. At that point pm_runtime_enable() has not been called yet,
> so pm_runtime_disable() is not paired with any enable. The failure path
> also skips the dev_pm_genpd_suspend() needed to balance the direct
> dev_pm_genpd_resume() call.
> 
> Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
> runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
> on both success and failure paths.
> 
> Fixes: e2f1ada8e089 ("i2c: designware: amdisp: Fix resume-probe race condition issue")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/i2c/busses/i2c-designware-amdisp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

