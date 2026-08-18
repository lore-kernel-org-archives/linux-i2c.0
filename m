Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597C42A7A8
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054827; cv=none; b=ZBznUcFeHUNqBoRyfffIWwjxsGNRmMlmyWlr/MJIHliFyF5qRSWxaJRtxQF2Ci16paKYNF7H7PVyBS+sTCSrsbSiTBWQjh1EH5mcYBTJny10Y1pSlQ065eLx/ZjASLHOTAZcP6jZj+idHmaicbRFrSyUbKHBfkZNsUGQTCyxwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054827; c=relaxed/simple;
	bh=LGO/+6Cezyup7KaOKLSsUxzn5CewZlWao1nmvpqLgoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkGe1OaQm+i7GDdTfo4JSD0a2AOeFIFpf4aiO1Ty701uNTpx5N+FuQx+xAAdTSBRrMnhsBBCXXg4QQiFUQK5TR7+FtD9nt6E6jA8Ac2B9SIqVmeZJ1eAo2OYhfTKI/QdYfLAwVCeqwrhAZLfYEEqWdzM5iq/3GD0K2zUdICL54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ijd3EcAV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBU27nkg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ijd3EcAV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBU27nkg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABXjT919466
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LGO/+6Cezyup7KaOKLSsUxzn5CewZlWao1nmvpqLgoc=; b=ijd3EcAVH+unD7mG
	NlQzITd+wfwJ+YfQNenPH59K1wHo7zxJygCdITAsHp3T8dGpKUnXaMVQuKCcr15h
	mWcpP3hqiWSexP4UMiLCcokYDTGlzv/kmxOewYZ464CuDfakbVFNttI5A3cvtePp
	i2bsDam5QiN5ku/TjNSMIdAQE8s2WzH89dtud+bHIMiz2bp97Z2KUHoMZU99zf4z
	OABm4sRaIBYepSH3C/Ma/wPkJ7wRDDldBNfK1A9rE4GqTo86xpeSv5U+KiQ1FZSl
	tjdiAR/U2XCcDfFRkzZymxn/WSjIxwHp54mMXeYW6rxLXlvuzoBH74Y9f0LbR//5
	vm5eWw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb18eyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:03 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97bf9109ba9so5855241.2
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787054823; x=1787659623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGO/+6Cezyup7KaOKLSsUxzn5CewZlWao1nmvpqLgoc=;
        b=LBU27nkgzVyfloWNq/au4hS/rM/5AogKOYbM4pt25bPIJUD6HPACsF2eKquzrT8xN1
         mYizq+wRjKDZ825Vs7g92IMxkxI0N23nE0K5vxOOMEdAgrYjmV8VwPJaKUXvmwKTJkx2
         8leDMQkLe8RaOQufRcvrsTyyR55mmz/uC+Swn5CmMuxPO94Ov2Ou+cc1FTzYHyi6Lgfq
         9Xy9joRVMibUgVf1FMvrxXm+XwtF/Bxw91fc5RVPqNCsDRWo5OHgrkkOa5fcnadwJnln
         aSUzbZpwC7n+Cp3O0xKmhDN+zVziMYns22DUFYovWcz118JXL2HHMKbXgERZjVZPDv2m
         B+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054823; x=1787659623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGO/+6Cezyup7KaOKLSsUxzn5CewZlWao1nmvpqLgoc=;
        b=jMKu022RR29BlT/UQR2cbEpUGkssLtbeNMgaPO1N509sVICNF3OoZv3VMxT/rK83Rb
         qcbrcuUyUKnp0iU30lmaP5p9GYo1ihYOsu4X77BWOvAksi3ZQmIrQdfLa+gZE0vnfCHU
         +WLREIDH3j6gDIqmvX4inzeUzM3SqIPdUNGz8uF8q6m4iAfKH8NdMc5U9Z09IXvaKSG9
         AD1X4jFeW/YrbWfWN9LGBGHXLSbl2erqfufy7/vUhAWiwM++aVFqXj5nKQFnttuGA3WW
         Lu+Fs3PqLjZUXFNF6a0aHqxeqe9sHsy0SIecSJXbchcLUL5fqUHdKAnhqMSVKPQANGsf
         k5Gw==
X-Gm-Message-State: AOJu0YxuM4KX1fmdVsNywf0OAljrZ9j1fKCvwpwyFaDOvxWwmVTRoSVG
	m5YtYyhgHupzRrmV1xj0V5eaoQgY9n2XmGXue0XhHFdgjm/2RxSsCHBZ8LbpCqDZD99PBPmRq5R
	OLlm0CNoYUmS5m83rGLv6F+vRVcXljOotP9qT6L6/1GMUBY+0L3p1d+vF+egDK8YYyuo2LtM=
X-Gm-Gg: AR+sD115sZL86qvSt7jWtXxemGtC123nUBZ3g99cEykG6J24GfiG9MzCiCvpVQi17SA
	k1DZkKoCsOt2RHygivk119xkhQP695KZtu6bP+1Y1+On3v91YNroMxhHw/n+oiHXLqTh7nqB9MU
	y6hlbYF8oOlLAkSXB1mqJJG+oEo7dfvhjsj22KmgmySaxKb+KtOvyfFx2gEwSxocZ5emphev8+A
	1R6UpoJZyyFlhP3fI2vCNLDgUfuf5DIRHT2BFegfibHdFb9oGEzXv3N5X5Qc3cb1c/K65AmyLDa
	Ij3pJpGBASBm9JljQNGsFrsAzfQfjIzoF9rbQhtb0gsZHJlzdyopnkwIU4rKX/LBoiYnnXvdOsM
	ygWvbbXSpDnmtcYVix/QS7Flr
X-Received: by 2002:a05:6102:5091:b0:72f:6669:286a with SMTP id ada2fe7eead31-76f2c540eb2mr2350105137.2.1787054822841;
        Tue, 18 Aug 2026 05:07:02 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:72f:6669:286a with SMTP id ada2fe7eead31-76f2c540eb2mr2350089137.2.1787054822392;
        Tue, 18 Aug 2026 05:07:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b74059sm144679166b.38.2026.08.18.05.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 05:07:01 -0700 (PDT)
Message-ID: <18880390-0407-4efd-bd2e-1595193d78e0@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:06:59 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-3-e1d80da54e01@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-3-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX1RHR6KTw22Hv
 QO+D2kxrY3QcpR0L/ttHYXMkw8GaiTP79Bz2YbiD7Kv9FdIU643iOA+uiXsZ2EyurMtgA1pTYsr
 CUD3+1buEz7GJuN0I+EhabNIV3/0T5UeSUx5Qje1B0hBjh4QU0yiDliPNuxCkXPLcnLlAay+YZ0
 i/mrwk5gPVX9XqNpUN0bDrNXopimPzlrorksQSrx5oG9x8Pxn98JuqMneTrDxxNjsaZ+mB6yy3N
 B3KoHU3uxQmRY3AkKifjaRH0s24zWBvP70YQSLwpppZ01nQ2nyFqlWXEjsvF7M8YlIIIl7C6OQh
 PdyIP8/eO4nMGGCF0eVqMZSTwxQbHpox7Fvp9XRkQ3xuje5mpiaRRWnsn/vFqfht1akRf59FjM6
 eMNy4pZfMwWUrBQUVHGPWe8tEGxq2VGpesXayFQBap+NIic1PDR0G01fwfQN+XLlujYM1QdauBR
 B+uDOa2lVAfacsvTESQ==
X-Proofpoint-GUID: YK38cF0dKSZrAPG247xVTw0YAYCWc2ww
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a844ae7 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=IUKAjBX749pkMcdBEW8A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: YK38cF0dKSZrAPG247xVTw0YAYCWc2ww
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX9WIWJXP+WUa4
 hxbNg9MOnE0tdCAmY9vWXMyvj8akKDVTHKViCzxvjpMEQzg8JV/tNDR1XQpXARMnxDUPB7G0/HF
 2tA4t7LY3vq6BpYcXricJKwlyxSPCKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180089

On 8/1/26 10:10 PM, Loic Poulain wrote:
> The v2 CCI (msm8996/sdm630/msm8953/...) is normally clocked at 37.5 MHz,
> but its CCI clock can also be configured and run at 19.2 MHz. Add the
> Standard and Fast timing sets calibrated for 19.2 MHz so that a v2
> controller left at that rate still has valid timings for those modes
> (Fast+ requires 37.5 MHz).

The v2 naming is misleading btw - we have e.g.:

v1.0.7 on 8974
v1.1.0 on 8916
v1.4.0 on 8996
v1.6.0 on 8998
v1.6.3 on 630/660
v1.7.0 on 845-8550+hamoa

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
