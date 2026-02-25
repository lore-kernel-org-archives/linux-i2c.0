Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA033D3CE6
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029726; cv=none; b=Kl04AiKvGAAe6LsyP1JcrUAE71gqic/QX3yzLER7uE+H4IaIU7aSWGprJeBE5brCyrMWhxpu9B+Y9OsmfNThnzUreVYCG0IAsD99lb1o5BkmimGuauuu+6VokILicHn3qTN/0pBSaPt4MydI4gQBvi+GArUfbLyLIvhHtsPfGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029726; c=relaxed/simple;
	bh=AULsyK6QnjWs4F4LCW08KjpiOXM6EU826reVsXkv+Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEl6yHjLiKS8evoLaqrQ46Kj1QfKjebKCnCVKkMPnH9VJILSU6XyzgyzP1xKvJcKNGUFdYoMsFKLhb+jiI6ySuyR2NtDUVz8/kENePXQkJVkTTnBlaruUR/lXb5Jote++01tELxLy77MGaUCDbtxDCAc02Vzcyffe6tcZWymV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWOISrIl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brYC2NBQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWOISrIl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brYC2NBQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PB3QMc1512005
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQmCtuOcHIia8KQum6i+PSa+8224BgJXHMjC5fyWebQ=; b=KWOISrIlUVSyrFWa
	QTRCag2nm+6GjYlPMM1upa1ZeWYHl2BqYM74aQ6cyhr4I8aVmNJGFuMv+d8ORH0S
	77XGdHumt5ycaN3ZuWl5M6y6IhESbsxxeW5tmSMh2RmVVubR0uhhBNsoDsU64Ey5
	tRZVaMSggTLOi3x/i+5FVf+57XV6dsC11Tdn+FyjhUYKVayEl+t90HQMYQ2wHAqk
	fraFIwRjHW4nBRQ/9T45cN/FWKwxcYonCf7dGp102/23LF3i7h85bwT87XWcTDmO
	MRRUmH+ZHk0KnSlsCi4ZmkY/AlLuEyAzlcvgIPPJc6Q0FZ3LzMaOCvyj8IrY1q+1
	IjYR3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf0gw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:28:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb50dfd542so613104085a.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 06:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772029721; x=1772634521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQmCtuOcHIia8KQum6i+PSa+8224BgJXHMjC5fyWebQ=;
        b=brYC2NBQD74Fu8FCvgi8muF2+RxORVhFsoh5EAoomqzhaUmchyJC2fyrxDqj/RNgkP
         fnEr1U4OSiQEFjCkHJxXXHEWjUuLmlWmWoerMQTfHIj9ahm0DDTpmFUIALC0PT0dREyG
         UTC9T46WgOlLNDQrmz7K48no+Ni2SH+O5yN7uX/Q0fXbOw3Pz+yUHz9LWTR/VslNhUcD
         pUvB0gkf6TseUsnfiXqUx1H40et8WiZEB5xW4a5gzPyOWY9EWFf+zPTlXbN+LmxfgM9t
         YoQ/6Z5mw5pJzvx6SDLwXArBKj+mmfUDPSqEuNB7rmgPrF09rH6is9RIGoeJyFMT4ut2
         Q4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772029721; x=1772634521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQmCtuOcHIia8KQum6i+PSa+8224BgJXHMjC5fyWebQ=;
        b=nfYorzG/djxKwKxRWogOI/A3nQDnVSftiXB4tt79X9PwMcsnXLeztWiZR3X1+ZrgpH
         oo6OCoeBVwX8lrLCY2qPqEFRP7sa7uNolkvVXFWXAGOPYm3u32NYjsO1ZRMOsJaTqR/o
         9cl+5G9ViztVYx3PQKQZFX1J66BELRplpzdMxA3zfs2wltWnv1Xy5urrqTj8hlbqgh8J
         OITMt35S5wRryavlCyyGdmM2FEB3jSqaFltnBjD0a4+3nmqYi1+77gIHYXcozeIv+xru
         7eAFNv7zCU/lJixrHrdUmOV91Lqe/lEjqNpJLGZto2xfUZJb/IhnSvcC/UHhNbXrV4Qv
         1/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVejSDZaM8LzflewiL/vz/7oKK5pvqqm+tEp2NMbmrA5n6GVXPe+f6dBElPgZAvtyzwIQj9rtMNV/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKb13XGLGaitZpXgpv0xVsf1vrh9/hTJxreKez9UgkGDpO0jC9
	X/cl4wyBWourD+q3H1xXHmRC8qaO60/iKMSKmvjGmkSyp8545M8f0Zipfid0NSJc3Ar2dnywNjg
	syZl7B7ievYcv4R8uTQr276/wmvHOILd9ZiJ0Fzkc19P4R6xJWND1Zc169uOiHc0=
X-Gm-Gg: ATEYQzyZOu1ybWc3NrDmFCWSzpDV8Og0qKfV0JYay6MCrPSF9j4h4dvnDhE9euZY4AR
	7/PScJuH4xFAZpnicYIoGKkwDaHpxZFa12FXXK4xcNzm8kRU5TXQ3irkQZk7Bi5lYv0vTMXp8OO
	BQJdpdPGWp59MmR1HEzA0sz7kevrWxz4Arpi2WcP41BGkInzfpBrqFeUDxmoMap5/dDsoEgcGTA
	GrkZpZYsV6LsxjdyGJn14XjgWCi7dYBdSTFpYBQlIk8HObkdixibx4miFH74NV/gGnKwrWgq5rt
	AZEpoCBSerEBXfd/CerZdQ5Vcz+Ah59UJsecUre0qmZUT064CYbWqijnsamBjbeQRr6q0StvmPQ
	LBlQZoKleDUhaQ6EsY1LaGLVWT9BUAVzaH49rd6KF1wfc/QzZzDwYbpy1BHpESr+NMVmuDLwiaf
	xGDaU=
X-Received: by 2002:a05:620a:400d:b0:8c5:3892:a554 with SMTP id af79cd13be357-8cb8c9dffcdmr1658341085a.3.1772029721086;
        Wed, 25 Feb 2026 06:28:41 -0800 (PST)
X-Received: by 2002:a05:620a:400d:b0:8c5:3892:a554 with SMTP id af79cd13be357-8cb8c9dffcdmr1658336885a.3.1772029720467;
        Wed, 25 Feb 2026 06:28:40 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9a077asm4444053a12.4.2026.02.25.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:28:38 -0800 (PST)
Message-ID: <0b969abe-d9ce-4a87-be61-212a1b8cc8a9@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 15:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] soc: qcom: geni-se: Introduce helper APIs for
 performance control
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-8-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-8-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Iz0InaiuDS8rkedcKmQMnCfRYiLH6Kef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzOCBTYWx0ZWRfX11Cy2bltDg8r
 hzFKuk5WeeaoCQMeVnR/GI0JaGQrLa4OapmbtONBOPqxMRvH6iRo3MK4xY8Ddc/z6Nu7Yv5NkvY
 Id7yc5kbhnBmDXsoahN0d+cDaGW4ahzwBDJ06bS/38zcIf3S7nKTYpBG3HhNnpVnQddfDvPcrCa
 hmRYrBezhws/6/9YXDimpltd0W5m0OJ4SEMClmJxDI1oUoGQCG6yzX01nrddwYKbyAb8VAWrYLX
 mJiKWRSoJlxQCIsah0ErKnu5EXcGcr+zqvZQnDub6BswUx00mNzZYlpHdHqn3P2gduvK+MqzFzQ
 1pSeBHNQC38VDucJR9O+KyPC+4d4k7zxqKIPlJHEV5+5Z/QBeBjDkMoI4zzXvceCJnld1F4cyD/
 HZZiWkOYPW60sdkjdH3oeXLfXAOohWuNmsfbySDCYjtY1CemFeU988wDR2uEmA3qohWA8+gyMd2
 UKbgIyQcBLGcxBKQaVg==
X-Proofpoint-GUID: Iz0InaiuDS8rkedcKmQMnCfRYiLH6Kef
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699f0719 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_nBXEjQIeNtNfcHD0-QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250138

On 2/6/26 6:41 PM, Praveen Talari wrote:
> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
> manage performance levels and operating points directly. This resulting
> in code duplication across drivers. such as configuring a specific level
> or find and apply an OPP based on a clock frequency.
> 
> Introduce two new helper APIs, geni_se_set_perf_level() and
> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
> method for the GENI Serial Engine (SE) drivers to find and set the OPP
> based on the desired performance level, thereby eliminating redundancy.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +/**
> + * geni_se_set_perf_level() - Set performance level for GENI SE.
> + * @se: Pointer to the struct geni_se instance.
> + * @level: The desired performance level.
> + *
> + * Sets the performance level by directly calling dev_pm_opp_set_level
> + * on the performance device associated with the SE.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
> +{
> +	return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
> +}

My only remaining concern with this patch is this export - on v3 you
mentioned that it'd be used in the UART driver (which currently does
more or less the same thing, open-coded) - are we unable to leverage
dev_pm_opp_set_rate there too? i.e. are the OPP tables produced by the
SCMI servers not populating the rate field for UART specifically?

Konrad
