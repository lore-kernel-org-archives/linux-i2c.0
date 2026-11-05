Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865396;
	b=3HA0v7XYO0/LeMJ9P9TAYHoxhDRF2qQzx31Bru2rCeXVyU2iYqQmtWe8QHWyuQBugahU
	 qMoVEvWMxSWgS+7NGadNW3XRslEVHTmdxX6OrsB+WhJMUjtNAXdCgYkpobYATilioTCrO
	 yAMwEQMt/rR1xzN2pt3ZcLXf50PqfDZROtXYURDOMFgLE3FTcOHUT7Hb3Lat8bMWRavwQ
	 nsEbHxoH2UnaLZcLlw7Aibb/2MoGXHpM05m6b19qYbC9hP2gCGAsjxKNohG+dEjA5aNJ+
	 zXqSAxv/gNrbVVU5ZW6/1vTu+dGrEn22fOLheGgGoj4Qi1+Godd7G+TriGCZctjEfuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z95zJjNEcveUOGv+Ft/bTJHehaUOWuswuWjxqJIJ7rM=;
	b=HVvYifMd0DgV6utk2nuaHoXnjvbUiRSbqbpAert1NCwDZYQWTQWhL3+OGURK5HWEGy6v
	 CAeOQJ5EEXxuAH5nCl7UGeBn/5PUAugkm6RYJ3dfKpPLHkMV2FPn2ozGQaGjc7Ky5npJk
	 vgsyY1gTmctsOBSoPKs7cb2OjanqKXRptJCjGxKhxeRWjAaVGmYzbaMq6dfXuUSpWAJbp
	 NWeW0Qf0zDO3DJDAfYW1i9tk/EyxqTQE/Ia+NVoWCi5OIbVvkjok8PY/LNiaHVUYisPdP
	 173hE67a3ATLX/+KX2spE9Z9G+o1vKqBboYLbeTCyDVXoeacWaHhqyuFNgWIzIxv9lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzXoREhe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WuQIVIwl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D5606A326
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 07:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzXoREhe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WuQIVIwl
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56Tto83073284
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 07:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z95zJjNEcveUOGv+Ft/bTJHehaUOWuswuWjxqJIJ7rM=; b=XzXoREheXEpQRakN
	/q9jPyWh12BhXBC6alrTAsQrOLIp7y4u08x7CBCCwFIKR6POxc73uQE2VS69Oyxe
	TuLUVDgbWPgL5RlJI8k9jdvRM6FA6yUl4X2vKpXUpFI6pKUF7C2yEtLZ99aC9y8+
	Msp0cdsj/hBmInT30he2WKYPebBsOZ8qSN8NPhjGFQCKr/szkHNLfaAmjlTGTHYr
	M0lU9cts9pr8eAuNnrd5ZPT6d188DwcBjdXpy/ggqPSwMNP17dD9Jx0F0W2EHfd2
	cCskNBk1jPTvTHpMhG+fmuFSlDiMz63eCI/22qdciYkr3/6QxP7RxCR4vsnrRvNP
	LkrS0A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq8h02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 07:56:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c84695584so2791076d6.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 23:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793865389; x=1794470189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z95zJjNEcveUOGv+Ft/bTJHehaUOWuswuWjxqJIJ7rM=;
        b=WuQIVIwl7XPYs67KhdygZuhIgct2FJiFTvcbfZVTDEEcy1fMemhrK6NlHlyWypHSCb
         evfJFqaDq/uGGSWwESRXGu5L8OuEKyq0CWHEjReTXvmRdceOoPxRvXrQWmoZqRPLrNeT
         GrOFy4Hb6aa5Ea+DWX3phbKgrkILKZjW9q77GDfEo7fX0xgrHkOIV3r2HKdBJHrSdbrn
         PJj3J1pFbwZ7VO1ubG5QiieYJrv3cFP0hDAdLih1a90NSh5IDwwCPo2h6x8VaXbeq2CK
         8A6M4j+CdPEpMeOUwc9q8finTMh1YzVWHGCNpVWLufXdOjbxKIMFek3rkOH/lkJihX/c
         bB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865389; x=1794470189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z95zJjNEcveUOGv+Ft/bTJHehaUOWuswuWjxqJIJ7rM=;
        b=1uUlt+9cUabEBincMZHQ6dDZV++kB6bhC8CDjkEylLfugMjj24Bha5E9IlVjjKb1TT
         dDiZt7WEr/L7QIW/zxXHBaA7YcUzHzo2E7/7YnKKEcfaNFtVvjebFmykQBRiU6K9bkR4
         HrZvIELnn3VLulSgxHMMK0602BM16i6/bSbEKldsLAsozoixIMK77vw3r75FsHL66GEq
         XwyJmKUONs0X3s8wYQPl/7LtltK1QJ2ncRxkDUNkIklzJuKjfoSy0eaXcBmVR41l2kMx
         bPCJVwNb0gOMwSzWmLdbUQ6hevnz8XDtsvlDP/1ELMkRsnx0q0bgMdHxfDFVBE0PJLff
         R9zw==
X-Forwarded-Encrypted: i=1; AKwUvBy9PNepUzb/+rQzFXw9M0gi5oYzDSL1OZpR4mgqPXUYwM0v7IGzIOVybJUw0grb+66yJkl5bFANf6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lp6nMU9eBgWxF8kfID91rhxLJYUB3IbPFbdUgq9TnGCVnEsN/
	GMTGdJv/EARINZLzhe5zQEH9hgpiGfiwXUvoTsFQwS83wgI8UPLYcDUDXy5QbC4AWvCVkohuKpd
	EDTbOKfYjQuboQbr5YS2lovMv+X+eJk+zkzZ7gfCB1fT12Zi2+lGhih/ACQhILz4=
X-Gm-Gg: AYBFou2BJ8ucYOLdvQ/RUD9TM3Rju+F2ZAZDkeR+IHIUqnW7HAq5Xu/yvriAil8Rnxb
	mwP1miebvCGeWpbHWCKk+1Cn9Kf37BdJcZgJU32S+L3UYUnPSZWwHlhP931ux3SYXAACh0/DaOJ
	7jC2i0f6/VuW/svlbEZFCuEWZPMHfW8ts0IzmUdsQ3JBKu8WXzOy7U2iGgjuG81gvfS1TQl5zsA
	VHeijIYKs6zl8FVSMRL3TT7g6jdkGfBpbHXrzwQL2ndrRYE0HonOf6aVT33AkSiPfOYjixJD7hi
	CrGVuMLfHdyYW+F6Gi+GKqDwtHbpSVcXqjcQL+8N779Y1f1R9UDpmXV+Mk9LVcVEhUpnXrBgaOh
	WBgxfw1SR2YbEObNRfOHYoZkD5pb/qVZ/11GaoxsY8s7ICqpeI2UE6zMoLYVbNnLjbQZs
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr389914796d6.4.1793865388940;
        Wed, 04 Nov 2026 23:56:28 -0800 (PST)
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr389914496d6.4.1793865388480;
        Wed, 04 Nov 2026 23:56:28 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41e0fasm150506566b.19.2026.11.04.23.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 23:56:27 -0800 (PST)
Message-ID: <d4814d85-cb8a-4079-8bfa-3a2c6267d158@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 08:56:25 +0100
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
Subject: Re: [PATCH] i2c: qup: Release DMA channels if interconnect lookup
 fails
To: Yige Jiang <yigejiang86@gmail.com>, linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <rc-review-20261105-vc-48-dbf6a486c74f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rc-review-20261105-vc-48-dbf6a486c74f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX/ClePf8ze747
 +UubmMo8sglR4fNGBFWlPckAlfNNpp2ZvyUCNuluwrjsHajC4xhFI1yzsefWJywWfhw1/cJ07Z/
 /HErM50JGekzVY/RqJSypJvDmWpVq8CMPDeYEppuJGfSl3EmYa7P/yNrVTJF9SllkoeiMwsfbb0
 Knjm5HGqc42wAefLuyyG+UQvy/YDs80XqHPjQgBzW5y4sP0i+c0V0ivRmpeQpo4TiZxe5Q16Lyu
 l0RhQUkPlagTq0mfI/RUZK9bSIEHWnBObV2KiuAhhRN2IkDwXscH1vu+4vAOFVj3BhJuHRSeJnI
 zmxR8DvTE1/z+QfsnlQEiP4tY0/SspWLWeqqocPqEj20ogzSN8xVA0z8VW3DeDFYxW/01qSXw26
 R9mx802SF+0zx+UwQaMM62sYQh9FYmObQO5ps+/oweDSdth5UW0f5r93+lnTw3dNbN7lldo6IDS
 /f/1DYIga0V4D6zbE3Q==
X-Proofpoint-ORIG-GUID: 0xbCZDcekjmrAtHNsl7Ed-FFe5M4Osri
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX29qoJSXdM4Uo
 uMDnhcEJPBmUd0QzjHJqtDFLA1gjfV86/24iVSdZEufUc7gJe6uKOlhm7smK7ayZP3vrSdDOosg
 gLzCHxVexM+9Q7gsYHIROYsPf0fZJ8k=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec36ad cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=0RPhLGylvT0nOadtWzkA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 0xbCZDcekjmrAtHNsl7Ed-FFe5M4Osri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050031

On 11/5/26 8:42 AM, Yige Jiang wrote:
> qup_i2c_probe() acquires both BAM DMA channels before getting its
> interconnect path. If devm_of_icc_get() fails, the direct return
> skips fail_dma and leaks both channels, including when probe is
> deferred. A later probe can no longer acquire those channels.
> 
> Keep the reported error code and jump to fail_dma to release the
> channels. This avoids the clock and MMIO cleanup, which have not
> been initialized at this point.
> 
> Fixes: d4f35233a634 ("i2c: qup: Vote for interconnect bandwidth to DRAM")
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---

Can se use  devm_dma_request_chan() instead?

Konrad
