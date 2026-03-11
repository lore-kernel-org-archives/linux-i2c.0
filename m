Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97731F994
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236138; cv=none; b=TN8jnQa9/Qkl2i9JkHbI8jOeyxSrQ6iRRJa++opG8JqfoEJlthT5Gt9qpnYpAFGCCRETCGzj3y84t5PiZ2VzhqnULnPNcrfYVx8MJnzCyDGG49U3r/74Evr1+OxxM+/mphC0fdjMYFTBSRj67A7rncPu50sjKZfgVxsQP6nlJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236138; c=relaxed/simple;
	bh=7/ObD/TJUlmT4t94k68IR0en3VvGQzGl60rNU9IjKuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcQRvu/5+JueFuJMPhLL78FpuqrKUbhNWtjbD9G2tx9yLXwsMu6D4CilkqdElU54dOwn1Xrw0pHkClCBvrRl/keJomxSSPbV7M2/70OhyoBvCIyyaMr4HiJJKTaHBQaGRHTXEGlYZqxpF/s1iJpBG/+L2kHzml8kHuNq7x7jLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKrXsoTB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wwf7Zg7m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKrXsoTB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wwf7Zg7m"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBnv0Q2677237
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzmA2I1G6+goprv8ITZ/YpJdoF5jLQr22ZNjDJ9ewuo=; b=oKrXsoTBBKnRv/1a
	T+hVmuun+zVPIfbP32DKBj93LkGGiGQrmhGzIrqCqEpt8o/zIWHsV4MJC+qWV75n
	RsORO/uVjWUAfhLNdKJNI1dLI/crG/MlcNyw2cwdigX5JWdGGi93SisPjhIp2yzT
	wYZ4piBCBXn4EobHYO8rCwJOMxylGPK6XjoWG9iIUdlyp3QfgwJAhZxdk9clT2FJ
	yytwqO46PFH+/cHfRXPnJay2EUu/An7nk6YH/eDCKS/N/k+MsqSFQvn0B3Je0cYi
	PzMVNosMmxvRo5IgQOEp8xJuQB3TAEaK/675wocfQDbgtQiT2bkYzHt1u3L/INbu
	3ZKfUw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu3cd1hc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:35:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090114c791so28575681cf.1
        for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773236135; x=1773840935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzmA2I1G6+goprv8ITZ/YpJdoF5jLQr22ZNjDJ9ewuo=;
        b=Wwf7Zg7m+B4FwdhFGCko5F1qrtbqfWgpqNYR63JA6ZwcgQHXm7larVjSPSWWuwQuQV
         F+d/ADqWM2FYMD9LLI69ETppBuvyi6StX4o1GcJA8Or6yF6nY+MsqSQSdVEWESMRgbZJ
         qB7GCF5xJfZeRbYWcWYJZpTg2buoQMbRsX9xKSuLZiXyOiOHTFcih/1gTLZ7VVIsO+m5
         +bmOI2zUUXdFmG3Sg/zbQXDsOFgTEctq9Cyw+o4DvRmQ5fzfuuWpeAd6k5+CQ/I0XGbS
         UCQekH0lHu0fwxDFRIiINF2iky0x1T9OkQW34Plui5fdx/0PRD6ZdlVswwnCJ/urpPYq
         iETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236135; x=1773840935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzmA2I1G6+goprv8ITZ/YpJdoF5jLQr22ZNjDJ9ewuo=;
        b=fljX36XpChGr+JyphHbBe1D2NWOwLxqxTtcZ3pOAj1ABCuGfgtabc0ySVnrTEeHUAa
         ddmI0K1oVCA8Pbpd0UZHiNJ5vT5Kt4U936+E0tR7zuZ9c9VHG2zMXUMjwlAnqOPckRkP
         KDs8G5OkOrBhyGWAIBJiKmDmhG2h8D1MSj7g56Ao357OkrC9xByig0XNbgZdrrQbuZc8
         oPMcnXravtWevWcDOcTwtfexImfFKvRoVPYss8asoYE7T2wHNDMkJZGe0jNa7JxdelzN
         NSmTFEVMnYrOERqi3r0yu8T/VX6Jh7T1k0wXNS1FBdDa1RSVnx79JcKXDV9NItHaLiI6
         Jf8A==
X-Forwarded-Encrypted: i=1; AJvYcCUP5u3L1T95JewvBW4qPpp5+xGDt48NxTyM1PlNj7h1uV0zgD7P8U0g+XoTs3tSZ048hGdJgB+KoAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7fRnw58RBXrcVIjNgy/EyOj4zjhK/4x+Tn6t+oZ72iUADyos
	39SbXOeTBHKfp56ZtGLGFjqBUDYD85XTWWVYp1R5lwTBQqcMGBXAGkUmXrHXlSBFZYhdTfJEtyF
	4Nk3sMEcAC+KQibJh4eX2HXvP6P5XIZmjZq1BJQSMKeBTqOIOxtVaQ+GCOA+cRQM=
X-Gm-Gg: ATEYQzw5ry0jWVyXR2fypLk/ViMHKahTpHpsUqMAbXWscIN+0uwPmY3AQxGn5ndLE0S
	IbCSfE/vRUODrm5ufhq8FjFn4lyMOgEezdyy7I8fD5AQee2X9QCe68yJPeQWHig6Row7+etVgTI
	FrNEF0uJGqexfypdKPB4lRtVe6SJG60lTrUZKOMIIjF/kzmT4KN9HiBkpcSUmVpVkZNY8+PCSHE
	eTZg1N/Xgq2H1J56yZ4/OV4E78TQhz+6KI+PjrUjklXdjwOF8F/UUTCk25oZjjPiQ7GHrWOEq45
	q7DxMZM1sgsF/L7GFZwg66DAGiZnljaHvmQtBjrfiqkgj0zY0YZ3o2Q/fR3PK6LB/letR3bft3N
	Ka41SKwnFWRvAGJvynfqTppqMvGE0Gbg2Ns0LqGf/e/lWfVthXpg36UxcgGfKqxNHGjbXsHjvjc
	KPNu8=
X-Received: by 2002:a05:620a:1a1d:b0:8cd:85e1:e1fe with SMTP id af79cd13be357-8cda1a855a2mr240652585a.10.1773236134673;
        Wed, 11 Mar 2026 06:35:34 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1d:b0:8cd:85e1:e1fe with SMTP id af79cd13be357-8cda1a855a2mr240647485a.10.1773236134147;
        Wed, 11 Mar 2026 06:35:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97307dde54sm47202866b.11.2026.03.11.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:35:33 -0700 (PDT)
Message-ID: <eb3b95fe-977c-42b0-a588-cd77cf8d38b2@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] soc: qcom: geni-se: Introduce helper APIs for
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
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <20260227061544.1785978-8-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227061544.1785978-8-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfXwMu0p+kmm/Yk
 Q0XaQouvA41K9DXwQXyy+i+stlA/e3UasA7xFJVcmUoBILPX4QAIvjngDE43t/6pM9MKsqeMhop
 eP9wP4Jg4OfTI4UhS/BqZFx5uDBfmHvlWxhiIeraNBWPa3fN1KRAWRmdfckaf/xaKuZiJKOWJh5
 F6ct4ZuzyXjbGP5ARJ/uMA1jNVsfAsirviNxnq7f2+oHJP5nRCBPakCK+SIbIAzWcF1VwyVXTka
 liqOsjyc+proOIShGpVHQTZ0rj+OAKnWDJf9DVkDfNgXr99iDuA9XCtiw44VKfWtfk2zEPkdka2
 h/Kw1bwBed7C439G5gjDhTJmpllKlzClKpPqnL1lYzRRsuD4peXb1ZIo2BznsEz71Tiz7RrbeFE
 zFpWbQiU7EiNfkyTekP6+PshsDE9Blpoo9mBBHV8ocz1O4CpNj4sJ2C41Rz4ZYOJIFUunbNeLxM
 a++yrO9Pp6HmiwKTdQg==
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69b16fa7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=u5jh5CAnnMYg5Z_R0xkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: NDk2wvhTTcilnfkBAXdu3Oj2NloTYLLR
X-Proofpoint-ORIG-GUID: NDk2wvhTTcilnfkBAXdu3Oj2NloTYLLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110114

On 2/27/26 7:15 AM, Praveen Talari wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
