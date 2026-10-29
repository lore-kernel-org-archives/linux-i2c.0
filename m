Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252186;
	b=0d1dIi1JsqkbMvEDvq3FfrrX9rsPUJFfW64B0ZF+5Y0u72vCvKWJZt1AueQw1eneI8jM
	 LK7t1KLNcP+4Jn2EfQ6133ThRda9xwVS1RKdMlrCn54Gsny3OPINQpV7g7RRAY6eEnkzv
	 EN/eTbCuBun+Nx4d11p2ovqm1dLIqD5L6X8/KRijFhjxvxkrm93dhNHOSCzVH8+1qURcD
	 KNUbQ8+oyozbBtLQP2z1MYaRO9tLTkXOc4cxmdgXoJJixonUNcp5ohFX1teg9NK6r2UJR
	 ba3b4/6XPL85cM0R+tDcA0lHi3uJcZoG/XhCbpy4TSFf/kXdR3pJoEGAddSbpqIJROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252186;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=;
	b=SGt1qGRq/g/AfK37JfgvGyZ4FOz8KteU+DZmffnPr0YkznwPnpQKg2qPKxVaizfVdMTx
	 TjhJHD5MKtiYUCJ6BMIxsoeHQPT7nQ2lfB5Tz03QgKAnn752mFoDONKmIncUnjhcQbO1u
	 j+7mMYt8lw4xovTgM0CZ7NMM1d+pT33z5HcsHJT9NQZGbvjdRrp7XDTQKlxZ6kt8Wb6Tw
	 g6cqz7BNNtnE80aNHmXsYOJ3RH50e4M3lOrb0sKT2VU7HiENS/GLhstqQFZyOr+YzNjMO
	 BthtM8FlJPt0KTjDj0gYDSki/zGqwZhwnurSCpbmKB8H4nnPD/tcg9e35W8H/19AHeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLVwEfMa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="MA/TZZpq";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACB606A31D
	for <linux-i2c@vger.kernel.org>; Thu, 29 Oct 2026 05:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1ACB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLVwEfMa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MA/TZZpq
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5H6Iu3282385
	for <linux-i2c@vger.kernel.org>; Thu, 29 Oct 2026 05:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=; b=TLVwEfMakAs6PB4Q
	p9p3OujGCJ2pTjhJYLMjThVakBXfVBcBUHHCy1THoDddEqOJesE7CN69fBoFkeIa
	utLbGQEOhzG8uZ18aQ5WuHjbypBgkh7lXRrHJaaZmDLdn77jgBRLjgLerz2JLRlI
	BnzmvcYd3dqFJRetHukHfuFeI7HvFWnwxKJ51DquEo4e4/oQEX77A0JDHnMvCmyP
	67ax6qNdZ0JQ9tZDSJnabSUsWjMgFgudUjvr41SrhSb95Jhj5tKytWUAJTEgZRRR
	46RTKsEfwE8pRGfqUCJKkiKts9vtglLOHFc6ALYxOqNeXL9nFYNwlZtg3IuCxgOa
	6ulRog==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpt1wk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 29 Oct 2026 05:36:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so977408a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793252184; x=1793856984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=;
        b=MA/TZZpqTudMbtbdd74dbNcHJ3IUJh1o/PXKrfM9TFxKGOA/iqq1M4eOR/4Ozmh4nS
         2RleXoaWFFz2Z8lHt/Gcp7PgtsRRhV20BWrERgduQTuTdKE8b49C0QzDR+JySJXPWvUq
         HlXgmoxSleYGrBq24NM7EAlUL4r/f46sY4MyE2hv/hW6T+ETFYxWnOYnkvU3WPsxToRt
         2KwKTiI4LuJF3CaZwASBxYtaptdI+2srKoccAtCH8vG6oWlXr8BCzVURocTPYFVVmmkp
         2r9B/ZNcDbIaefCW/5Di445Qdz10ii0V2yN5QYG7oaGYrTqcdmg5fHMJXQHTMtClU1Hh
         yunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252184; x=1793856984;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rrk0DoqOXK6wTcBk254IiD4um5GCM7sPdSiLC3uULQ=;
        b=MXF+6FTeMvfDgDytNjykpk8DUg0aSyooAfCSdnjebOcnSxvtRYksqjNOdDoqZ29Q2d
         dEE3T6fiSfWmxGN8niecUtRqJP7fjzPNpVVr+iyvSvTkZEdhs7GQiHgt/CRKs22/QJli
         DmWvtaAXxNcyNFu1cA/fNDMrnFZ6luLI5cWcfpQEcrG87LSJSJq8B8o0oXAJmT0QtkVq
         rJ1HwJdCSBsOkWu79oDMN3d2L7GH+Jf2WcSqXd7rVrT9Ye36RrNnJBdAW9LAPQtaPq/W
         1EDC/HaS4hlNQj8Apa+4NfdnqFLYpJla3n1fBMgzO7XV7anJId3bT96FosANDzAlzT91
         o5RA==
X-Forwarded-Encrypted: i=1; AKwUvBykCfMJw11Mh+ryqBAhV+KxyX8SUJGA+l7FYS0nUeTzgtuhzK3O0Tc9ztRg6HmFLS0UTCQDmDDtG2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsAaIW47fNYCNG3aL4Qi6leM9wUimO0TnAKQlIVLHVsO0xFLbc
	Mi5pZHlXLCKiOJqRy3osZm0w+vD3o06KSURgsGX9i+gjSyhFd2kZRo3q19nZDcaR4qMvflG/tyE
	VjvuUMKXUaSrtyvmsEYVHKyczHXAFLrGqCj3bnRW6BtnpRwV3o+JY1OuMLn6hCm0=
X-Gm-Gg: AYBFou3IQFAvnk1HiZpma/QQY0jMp2/+56RECAMtb3HtxZvIQLB/P5lNS91AmJwo/Ax
	nvhrBARdOBUeo21KeOIMSiydzEBNQQqhvuezA67dDQt57CZTGVmfGVN6BMBmJDdAIQzHukLBFwv
	+/HU/0Ygppmxn81cdHPkgqr1QvzXvBQoewyBa1SExUwZT5b1pLxXmwMre5fLDColyuAzxtlqeUs
	ppNKc9RUa2eBdd2SoQwcivvdLyZr67t0HyIy362myuZ6/WEWMmR8UEj03Gl4VheGQi+TvSlF+zk
	H/7FRpd1hkEr1HMdJoRSP35ckF82XqRzC65VGXW3ZvGdDJ655VGL8IPdRxThITEsJli96+2qKz5
	VYIfNc+lk7ZOxX2CJV3oWnd2GWXd1ZmuctsyEM6rHG19EqxjMrYNfKp3lZ1vNyFmzt2sE0KIXSy
	OPboSSuA==
X-Received: by 2002:a17:903:380b:b0:2e9:9c65:1aff with SMTP id d9443c01a7336-2eb0041ee21mr40133585ad.45.1793252183672;
        Wed, 28 Oct 2026 22:36:23 -0700 (PDT)
X-Received: by 2002:a17:903:380b:b0:2e9:9c65:1aff with SMTP id d9443c01a7336-2eb0041ee21mr40133445ad.45.1793252183141;
        Wed, 28 Oct 2026 22:36:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c3d17csm29267465ad.53.2026.10.28.22.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 22:36:22 -0700 (PDT)
Message-ID: <84e53a4b-5ea1-430c-90ce-09d98948c8de@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:06:17 +0530
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
Subject: Re: [PATCH] i2c: qcom-geni: fix double free of the DMA bounce buffer
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Akash Asthana
 <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-i2c@vger.kernel.org>,
        "open list:QUALCOMM I2C QCOM GENI DRIVER" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linux-media@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linaro-mm-sig@lists.linaro.org>
References: <20261028153353.69651-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261028153353.69651-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX3Eaa1twluP7+
 YDiG/1Z4fCSZHe9mFKV/CTL9x0+kviybYLH4Zh6FzapyLoZ+jKbG+wU/wRvNIKfzPGk93jJxQ1u
 3QAcDccQ1UByTMK/qWVxARHOpjy+RNskc9n6kS9EMoUn+p7B8wkbZIqfaxuXLP4ROnfx4Kwly2a
 8tZ8NSi9hElFqhjilA3Q2J9/sgCjG2308XOyQPlkon4jIDMZLGo19RcJcWc1NDXCaVDwUPLc5l+
 6/wKkUM0RWY1i27y3Fng+74bEe2Arh9J/u78KBTknBN7XZevFsPIiipXMIoRU5gOTsU+J3g8ccr
 0mR4zAIVlHXUvshu+Ew7htuYXfDN6/Ric3uFzSeErrxCua7a/tT+2VoeSJQEQeCK5Zh4vRvAXIG
 9lkB5Dst4l2q4hpUVDlJ+gnnkhpbKeGAC9Z+mlo3h2KLXInPmMAHp7LA94NevYZKc0cq1bCfV6r
 RjjeylH3GoA6DaFCWrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX3ROKvCgYiud2
 +GSyba8euheVycXGHoLkinhIhcLutcxeM7trBdMqVyzxgLFWFH+076+iEwUCFQBZVcaahbG7V6a
 XHhKqcfbXLJPND8W2D3BPshDQCJPVhw=
X-Proofpoint-ORIG-GUID: qMv_QLxnU81qyJZb-zeEbFkB5pKTMK-x
X-Proofpoint-GUID: qMv_QLxnU81qyJZb-zeEbFkB5pKTMK-x
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae2db58 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5U0EVFohHyNS2EaXvY4A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290021



On 10/28/2026 9:03 PM, Thomas Fourier wrote:
> geni_i2c_{rx,tx}_msg_cleanup() release gi2c->dma_buf through
> i2c_put_dma_safe_msg_buf(), which kfree()s the bounce buffer when the
> message buffer is not DMA safe, but leave the pointer set. gi2c->dma_buf
> is only updated when the DMA setup in geni_i2c_{rx,tx}_one_msg()
> succeeds. If the setup fails for a later message, the function clears
> only its local copy, so the cleanup helper sees the stale pointer from
> the previous transfer, unmaps it again and frees it a second time.
> 
> Clear gi2c->dma_buf once it has been released.
> 
> This bug was found statically and compile-tested only.
> 
> Fixes: 357ee8841d0b ("i2c: qcom-geni: Store DMA mapping data in geni_i2c_dev struct")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
