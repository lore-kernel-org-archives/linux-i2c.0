Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EE3E2773
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092514; cv=none; b=oQ3s6dM2MDg21/CLZ2K+R/9ivy24IbjGk1eBIInJIsVau4Nj6wHdI+AIPom44cJECDhYJKutHFG8Qvy/a0/rJQR/SCl4Q6mEfn/Km/FfhaKvjA4rSwS+3cFeaEf89/Y9uXuR65spGkIZcVjxAs13haLPItKRgjhTndICZWqfCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092514; c=relaxed/simple;
	bh=ragH+UptpsP6ecGfp9Fq31yAcAD4v5jryRmNz5NKeo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT0ZFN03wpT6QAfRbU+i0fR4qah3LO4Bi6Zp5gtCMZ6YASLH7Ux0Vc29N5vGTqMjZTFxso5KRJ9cyAq84VT68Zg0PZpSs4ji6b57Ro+OQX8XFQkqh0LV3d2Fxqmmxj3zZuYr25F4Iivhz8N+Kqk9wNk/wriq1O2bt3GNHep9q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7PHyemE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdGtsY91; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7PHyemE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdGtsY91"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6WuoQ3453828
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PqE05k6PQgDXFwB3i3GMPc3Iovi47SmjdbK1gLojyvY=; b=i7PHyemEetV00Dze
	3so9XA2JcitdhOrcg/E92qqFBd+RosIlGs6Z280F2Q1zjybRsBcBDLBaKl5j2Yxv
	FCX3Cxepsov27bO/pHqrhIuSZFuBJ3VeNJhItg+oeNIZQuo3ZOJseOI70ESS+uCa
	z5WO8oDw/C5ZPNXWvFzit8b10k4QSAXy/HZiUeJ5ecZngO4JzxPAMwvQTSnumloc
	d1S3H4mbJWSZM02QynUHwKGY08KcHyc5fbpxvysQfm0zUQohCbYWtFwP23EK2jS3
	bnfp9Grhyww3kT75YSDGFX+p8AIPwztKCOl8CsYNe1lQEDLoHtQTqxJRvMcnGlhy
	w6GGhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7wbu4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:21:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fb0b93e90so6776211cf.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779092511; x=1779697311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqE05k6PQgDXFwB3i3GMPc3Iovi47SmjdbK1gLojyvY=;
        b=LdGtsY917194P3YBN2dPWLp7Qvs20m0PRFI7dmr/kmjFTbz78kYm05+zoti8ia1Bu9
         k8tyYoFhKqvUKL3pN91DqHtqPTbt+lXsYUrassGurUXTi5P3YTWSp/uqm8uamiazZodx
         d8J2NvpMcelxnXXgeJr37E6HVL0mj9E/TqmPb/eB/9ZzU28sBlNVJeQofTtGdh+8plGV
         dn8nHJEod6/4PHOIVoUsxB92dWGL8R2p/v/poUbBojvUYdXq7vRIQOY68tX1p9hwvmDx
         l0YvVUGnZ7YIxk/IHBIpjvjt7ggkoknFFw15zsfhC0zQLSTD1Ypvg8903OX5p7N9Fb4j
         KInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092511; x=1779697311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqE05k6PQgDXFwB3i3GMPc3Iovi47SmjdbK1gLojyvY=;
        b=aFKxydrRbSrllkg5fFokHnf5F/uH+JMGH10K2GOUonTVRRk5RbAv1mAKefp1zLtd7P
         kpfqp7hly2e3vsDSHzOqfqgghSbN8IwX9CAFR5YyLEhM5ygEUx/ZfT1CikX+hOktUsRU
         r/p8H7mu4TvFipuHrsc17y6cwygq5MwhxIKNpzisw6MGV4Yb2Ehm3SFD4Q9ht2Xtn0iq
         pqtZO0RcLQMzAlvPtJHFe0ktkQBdG3BlkoSGTF/fropu8ugTOgSZ64XB27jDKFy1GvHP
         Dlav82GnuogmzOYYCi+VDZ7MTYy2cj5oXZslGoHOGjXB6+XjKXQGWEFi35BHGcATfbzZ
         7EJA==
X-Forwarded-Encrypted: i=1; AFNElJ/Jd6pse5z0M03UdfQMGcRSjopvrBzu+iq3L9ah569tM6FCz/dpqs95CeVonydJ7NnU6pib2wwWTMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd43Nd+3f2wsIY/lbYc+aCqO2vFToqtVprY2vF6j6CplDenEp/
	nlDDgHaqSXMqGZrgkdVbX36IGyOWxf0R3KO9FaPp9B3OrwK6E7fyVXWU6gv6R4ashgJCDyrmwtR
	4PJJ0Da/hOJYPvlGBe1y03PxQH8Dru/cQNCR/0i2WMOvh5ZeUoHZZuiJ8FxHuFiU=
X-Gm-Gg: Acq92OHKVDoJJz3zBAoDiy0ngfhlvn5VTp4T9VdGlnXkrKmAtTuDl1PvOvHLhoslOT3
	M2hTyfx4BAdBeFyW3uOzg5H+Sojrl1vOeeXOuNp3niV0quBuSRpmgoDc/gQvGqgNNAvJBU3pVsX
	SqmETxxgVC0FTj/oD+HguNa9ixwuP+jOcySharSgtTjzZ4BRg4x+TQbot/zwlhpAfTVEC/aMDhX
	RzbAihJn0KUlPC3VfVUmAduo5IuqS43tkYaNCPgPHxh9uMc9/6LLhxCAHmUK2ZsoUZUL6yjs0NX
	G278cxP5CDp1r80t8+gwao3Kd+KoggJHl3PksirY9a93tjhoAWa1EnkuCzTuvHh88Q25t98Cyw/
	lXLLrcfM9jAHqEvy6QFHIMQvhCVHOtLtlyMSKivyutDyAgJu5A5ywn6RO7pZ+gOY4W9SZo6131A
	C7N4U=
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr128792631cf.3.1779092511379;
        Mon, 18 May 2026 01:21:51 -0700 (PDT)
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr128792421cf.3.1779092510976;
        Mon, 18 May 2026 01:21:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ed37ecsm538798166b.63.2026.05.18.01.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:21:50 -0700 (PDT)
Message-ID: <c70ae6fc-c10f-47d2-bb38-b01416d9b1e7@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:21:48 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] i2c: qcom-cci: Remove overcautious disable_irq()
 calls
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
 <20260515234121.1607425-5-vladimir.zapolskiy@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515234121.1607425-5-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OSBTYWx0ZWRfX6n4nBpdz+ck9
 OxvsQaun2UEAbqWNWc+wSty79ZbnEST6w4ccwG+lRB1949P08MemTCRe8hGF9svFFlOYTCstXcr
 wAY454BGxd1gRzTh8KJ3C8dzJQY8k78A7ZxlqnYlF7Ipd4IHi0Tkh/a+ZSQzKV3zWmI/tVrU506
 co87SAmkF2pT5I4EKwSo4itCxcom2kyWmJ00OZgp3ySI5a/7md5vzxLAXTW1GYSwaVoPxk44152
 CnPnI43LgrG08KRISWbZulFvLXKVk1zCpxz3gr41AfBMOypBF1m3ubnKwDXYl20Rsvu6FRkPJAf
 s2o/KUiztWGSCHEbW+eUOvu6XcvDSIWe+hNSoC7SNFH05QqA+LJqfmxr6eMaK08US9afPVk6Usy
 Rq0XqT9a3bsrjEGrVlXZXzC9TpVqcRf3CiSWuPO6ZE0ty5d7ZyAVgMabOybYi5YpPaYKhL71qeX
 HguiUJa21z5SbrHDdXw==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a0acc20 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FPazOdjXQs3mY34jnjMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zu0Bq3PrQYm0UreKjygGUcrfLm44FIqb
X-Proofpoint-GUID: zu0Bq3PrQYm0UreKjygGUcrfLm44FIqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180079

On 5/16/26 1:41 AM, Vladimir Zapolskiy wrote:
> In cci_probe() the controller's interrupt is requested using a devres
> managed API, and in cci_probe() error path and cci_remove() it'd be
> safe to rely on devres mechanism to free and shutdown the interrupt,
> thus explicit disable_irq() calls can be removed as unnecessary ones.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

I think disbling happens for all IRQs if this was the only/last user,
regardless of whether its requested with a devm_ helper

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
