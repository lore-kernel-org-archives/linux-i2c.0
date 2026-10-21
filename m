Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579367;
	b=btamqbTZJRgByt31e4SVGh4LyLnWY4rEzHicngwKRYN7ouv8LsXRNg2qrFVOBW+WRem1
	 g1spBXAgGwQeK+czYxRiUU2A2m14NK8XeLs2nM+zumAuqD53DCzKS0Utkw7Qjv+8B0mIc
	 sBLXpKkBPbRLU+SGxLfI+tZgvLowPnIZYuxHyXtrhAUf0L2aTLflgRt3JiCTBye00ezuK
	 nBb0cyFXm7R147bIvxEqDZILQJjwXjgFmXjFRMdK3HkpsM6lNVRFvtFj1LJyBme/rfxBu
	 9XjwxAswmZcQG/GBBatwIC8QocAhGqHqTfjFJn+myEIyE7uS0GbgRtKUs5sKolpW0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579367;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cDr4z92Vg2vGjbMP4QfEv5oW9ZFER0bgpZkmEeJldKQ=;
	b=m4ZExdPorZ+qm8sCC5atLxhYNTA5KxFEw8jxPwGtATZp/E21oESQkRKtr/m76M47vgcO
	 ESlZ8hW8MekiFICC6wru7xyJxBxfi1O2lhVf7m/Q9nUtZkKaVSMnQ39l5iDpcqUtt3PHg
	 H1dcxv7CUaJPLR3zxSaxtzXUCC5JQybUwDMy1uOZ9l3go5OtJCZdsBEkoeJk7nNlDZPCp
	 KhMeFEmTV+s6X1XW1uBmJhed7vyHW9wsn5Z0u8Uj6AjXSzi6vENCsN95IThVaUHy0ia36
	 WzObwN22eQeo2IG7ai3ocXuDrTIx1uFmzjYNcs7wHmqRz1QbYD/4pH5qWjFyZstHzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZBI3eGB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mg2fqjNu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DD606A326
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZBI3eGB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mg2fqjNu
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5jZ13449628
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cDr4z92Vg2vGjbMP4QfEv5oW9ZFER0bgpZkmEeJldKQ=; b=MZBI3eGBJ/uhGQ41
	SaQnds05VkpHjBzXDoJgOgh/0+HHDJYGFE8yIw1x98wpssQk8b9P4m6t3b4JhckQ
	iOAD8Nnzyp8/y8oGiv8VlgeENkedwh1Ko85bB1rPboQczRTDW632HRMXlUcBst0A
	LVveZZANXMyKPPC31TjtTwJZ6yRiJ9kNoaDOGQWat5tHtqbnK3i4Xeta7okO8jNN
	jjAQqo4cA4CgIXIUwy5M53tHUJMLCeRi+3fAchfqzF5+6/6srUeaFwkMyq6JLX8Z
	wU0snWaxXoqddtFnPX9pM/ofCvEHSM3zHY9DO44iMIMsrUxs270lvip2NKII9tkU
	uvAtHA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9baxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:42:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a04d1cb2so1776456d6.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792579365; x=1793184165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDr4z92Vg2vGjbMP4QfEv5oW9ZFER0bgpZkmEeJldKQ=;
        b=Mg2fqjNu1BmiDurDg4s9bQXCEHeyVq+tlqQrZkHT2OqtqN1ywxTViNNlIzPbU+xS8J
         B/A8enbsgENsbWFDK7Y9G2WC0LkPTChPcgKrmKo8j2utnbyRXsbnCiLpzyAhGjDi2vcJ
         B+VFRuLi37zR5CWW+amgyteZNhgI+AdaLrKpwqLw4ztwv/G7UGqR61ku+4OELXL2xCRN
         7oD/osMno+4dPk3FEw4p7Nw5JRSEFK8IZz8Na31eyJESyP3udssWD+VunFJ9396IGpKn
         qvEiSnu9qcAlbi5bbMI/2Ig0Zi2y7VCb8RZ7BbecJ5mUWoat1u4eNl9OVka2cyPPnyNz
         DmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579365; x=1793184165;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDr4z92Vg2vGjbMP4QfEv5oW9ZFER0bgpZkmEeJldKQ=;
        b=p31pVmSY7bqIWwluwyeA2q1VzShPH4xSXiOR/kpC5FVz0cqwDcrpWHj9VfTnPcf22w
         93V2D5Of1Oyr4dWDPpACCpyr8FuvDHmwrDqwGTX1Ni4vYNZHG/wPKDgc1YpnJW2JvIim
         kQJhA+BKoBH3ClTW59GpAUAHLX+Q+b8v7vA3DwHeiIGpelZfty03nebAhHAF7KsOV29y
         GfvcLalBFz+92ZXfiHzkhU/nI6zU7hV2UNo4JcI+vlZIO+KUSbNn/KTOuWzGGAvyFjK6
         8jvvjUxTydiV3JANPuEj5zDZGBjBUKvuv5+QUuPCjoWvrVk0/Dz5hVmVlrj1C2KVYUJp
         b3BA==
X-Gm-Message-State: AFq9FYIt3yWUj0PImt1YzOHDwDNAp0QVsb+cEiFMlmJNEeCThnnSrc0R
	TMMNK4GIROwEedUIeRM/gRw0R8ktUfE9VrWrHduIQLp3MLL8SrLNpqbHgduLTSDIHbociy5a+Kt
	dsn0pEtgC8EqI071W5+rApPqpoB+ZnQs23MmFSJMBRcVldcU7PhEzZp4UtAEaPQI=
X-Gm-Gg: AYBFou2wS1aM4eg2rrPP//6dym00zBJU7GElkgW313VAUPvYi2xbDhf86k/iSFZzrrF
	y7ikrNBJA1ntCqyb91eKfNHRESgO9QYLUqjvek8qE3ac4bdjHe7DW8UVYrBRgpAmD1svBRssDPq
	pcZ+SCdU0rCSy945OiU1kP+5m9iWVXB5Ht99lsTa3A7NRzxh71BY/u6vhHnghBjT/bF22WpSd4F
	SQL88c0Zb3QRuPncIEsfUKECDPVhQKD/t/3P28YN1DE0J0CTWYafQJz5h0TARRXDCMeJpmMbRcL
	eYcdqLzqxVROSLtkl+1QwUWDc6suPM0extBlWM8KtUPVIv0R8sfF2Dsv9usQsRFiGSqCh0vBFfH
	V+XqOsNIkI81DsEwg1dWL0w==
X-Received: by 2002:a05:622a:1aa5:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5369b5536dfmr27587791cf.2.1792579365043;
        Wed, 21 Oct 2026 03:42:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa5:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5369b5536dfmr27587491cf.2.1792579364515;
        Wed, 21 Oct 2026 03:42:44 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678faa5b0sm64563866b.37.2026.10.21.03.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:42:43 -0700 (PDT)
Message-ID: <4cf59328-843a-40f4-bb9b-8fc5b9fcd574@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:42:41 +0200
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
Subject: Re: [PATCH v3 3/7] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-3-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-3-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfX9G5G/nXHHQE5
 IKdEmiBj9ZW9/tsvxKyiY7VM4CR7ncj0urQhf4EcQeC4wOXWgZCU43xakBwnIJOc6tj56/aIK0g
 UQfDCcBlIF52mv1reVFr5nuzJ+JgZmY=
X-Proofpoint-GUID: 2QuEysiMOtPsQAPNJAsxdlq43CU6MizV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfXy1ZqHBMCp/xM
 encTo7wGCp4ZST4CyXxBTGzsSU94aXD6Myt+iEiFY/m1aDmF7M67wh6XgvwfblYZke4c+Jl44PQ
 9m3vA0m9eYoN93iHckYhn31sVbvbu1ZaqfWg1sZIxMnJFX1vjs5CvO8iL+fGenhOIAgYLrCTLtw
 m0WEBjXjOJs6ZhvAYFaztNry73bshBJZ0roUoMDy+ZdlX/jkHZMaMpEUOzSkDZs13BUz6bPUrTU
 Agc3yYKKehhAGrgmOWA7BsLpXoRWL1mcMrIdmQiwQgOBGMAeg8HuztPF7eRgpWdc+0jilNU8yTp
 D0ch+b0IJS/jkSiTCL6NEsDwHP66+CUKBdNgYj87f7ueM6ckfkN6vbrrAkL4UOVJheqnFHwBxgG
 0YD0M6lZ+0V580X0TkWz7hQV14IQp5FJ/tFcyLf9xbuwdRavDutgqtH5E9EEpB9d7Pa4WBOpxOZ
 amqcePLw1xAyun/ktVw==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad89725 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NORypjkHWnF_li2zo8gA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 2QuEysiMOtPsQAPNJAsxdlq43CU6MizV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210042

On 10/16/26 10:00 AM, Loic Poulain wrote:
> In theory, every SoC integrating a CCI revision that differs from
> an existing one should introduce a dedicated compatible string.
> In practice, most CCI instances still fall back to the msm8996
> compat (v1.4.0), one of the oldest supported versions. In order
> to take advantage of capabilities introduced in later versions,
> such as larger queues (v1.6.0) or threshold IRQ support (v1.7.0),
> we need to properly distinguish the different variants.
> 
> Replace the static per-compatible cci_data definitions with a
> version-sorted capability table keyed by (hw_major, hw_minor).
> During probe, read CCI hardware revision register and select
> the newest capability entry whose version is less than or equal
> to the detected hardware revision. This allows revisions to
> automatically inherit the closest supported capability set
> without requiring additional compatible strings.
> 
> Several compatibles that currently fall back to the msm8996
> configuration (e.g. sdm845, sm8250 and sm8450) will now resolve
> to the corresponding capability tier, gaining access to their
> larger queue sizes instead of the conservative msm8996 defaults.
> 
> - v1.2.x CCI increase I2C write payload + burst write support
> - v1.6.x CCI has increased queue sizes (64,16) -> (128,32)
> - v1.7.x CCI introduces threshold IRQs (leveraged later)
> - v1.10.x CCI increase queue 0 size (128) -> (1024)
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
