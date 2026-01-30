Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866636C598
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775186; cv=none; b=OcWWalsvpuiP9IxX9CcLOQnVlZgenpghLnNs9LVy66dtkxRr/IkwEI8anFVxfmrRHMa2ZzQVYqZuJc5gw1oOu3LMLSA2MlSETSfxS9bJ2M/ecWVt3Zk45OaJBu3+lWxprFxUKY0TEFbDcNMH8yDvprsZJ9353ga/rN39RheptN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775186; c=relaxed/simple;
	bh=/ixdRevMqPEE1lODMPoaKQo9a9vLiHkiCmGYyHpvje8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQKYM+urCk+x2csfcyRPy1dsd4dXbMqvCfQAKNKF1uMpgVV5CfTrSKx8zwckvwTjj7Cqv4tm45v44KDTOfUjp3whCZhuHA5nanJwzALCi88Y2vyx27gFNDKrgQULiKER7S6Kx4fCL8Yygc/j5uvbhAijl/v54/xFUtKrm6ZAwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXZ+8b1J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SsEJT7pn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXZ+8b1J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SsEJT7pn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBdAAo2993795
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFLpSlLM8Y/Fn7u02xJzrPAJxhRkRWQE0zeelLMBT8Y=; b=NXZ+8b1JtGFAdORp
	LqzyEhxdqF73+1fNJJqF6X2s/FLQWTFpR0tE1/Ap8pRShNcHf7tdgtPE/yLasjoW
	S0vRYA/9smM9kdaIZwe74haroBhbjsoGQqYA66qHUJmfJfWnjuA15PI0LhXS2/Kb
	UHj1eLJIX6mGNOjS09zCH4trvfzJVQyn5lvGpYaCS6Qo02Ijao4or3g0d3NembYz
	jU3mcOGBYJHRf/q1iOOqn2G9eXOUoj3rzGu6hrr3/iJ45+uFdvk9o7T7Larb9VBR
	fjJNVKhv9v6pVdn8bGid+j8j1xlUrbvkn5NJBSnICCWdSJCzRYBJBJKz/8fQlRkC
	D6v49g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0db1jqw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:13:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c533f07450so16303185a.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769775184; x=1770379984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFLpSlLM8Y/Fn7u02xJzrPAJxhRkRWQE0zeelLMBT8Y=;
        b=SsEJT7pnuig+PnfDPl0ZKUn0zLxkSnRYG6/LKRQyt2qVODI0vdgeMO3U8usCHpy5Ac
         mykNRpxclYuiZ4boJr3pjpBwpIRFLHo3dEi3aEb3PtbsJ1xLKMjXRkxAPMzyDRCJUqpM
         gVHzmIWwLY8yJbO2Vk0cfdeh3I7XYajZq4SnzvUSASrstsgZpfF79uosNx9lpZomxTHy
         WoM1xfM+OOV6jA2ilfJnOfaYayNl8OuB7BYitPcn/U/yGkFZZhCxOnybD7I1tMrcYM5p
         ddm0LrTNxuFX/VRRshqMnE33RHjRpvT7bZKY/lYZKZaxAgTlGuXvhDJIW9FuN6DYNazr
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769775184; x=1770379984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFLpSlLM8Y/Fn7u02xJzrPAJxhRkRWQE0zeelLMBT8Y=;
        b=ToRRDy3pzCmuqRj+PxEU7r9tZRoKTs+zguBXWEpW3P01gLpgo8J/maqW3iM71mC15P
         JT7T3njiAKGPmpp7Wz+W3jghhJcn8ZwdZYLCwzxtR6wVt8ChYXuR4St1Yo6Vdotz7OuU
         agIZSrTUGHjNyXflTv/3Ln5RaTj9fvEPLEALt/g6Hx8yK6CHrYzwKcfSiMQha2gObVyV
         TnEHkH6POsOCCgD7KEjKrcJzXZRv//57zO8/L1odcubLp5bQ2x5hanceCYR+a8gMdJ7v
         2U5C8WuwblaqCQ6whpPybC/UpAtIuOwZVDpeaQ20oVQEURT2+1t/JGPRaFJPzyCD4FrV
         lIQw==
X-Forwarded-Encrypted: i=1; AJvYcCXpLqWAuZP+B1i6owZ9R/35uVhSq+WLukaJn4Q2cmwLtmmf0lzwvLgC09MgKE75cY/hMS7bpRGXdoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsd4bY+wImNhvhLOax2qoMm6jLOcc8VvNjuboBSABqv9erTDe
	9PjflN4Ara3+Q01z/oggTyeb10xovYPqhSrrWT+CjkJ+dwuYPaSMyuFQ8ePoe/TuPLt2KmdLtdU
	Hw4b4oTa2jJ+908SHcW6q/1iYsxEYlZvJVJAnXa6VN9g6Lm5DEYZZCPf/EnYzHoo=
X-Gm-Gg: AZuq6aI+11lsPB1yGVgYN4TtYxUl8JinpoYajweObGGNeSPV/OD9Vjou+pol2PdW5tH
	EmzYOkemc4ezllFGxWMm6EaebTLWqQwuF6L+UsppgGHSpR0YR530NYTTGcSnAyg0dFs9/bwoi/5
	4LGEwbSbk990k9g7hBf55vBqL+MLGrJ8zLvKpLLiAzp99C+0TM5uekgXfIoCu259wFzAC/OsuBM
	tJ1Ckf4nGaBDZDvAXEoivqgHlYLMEGkZCorwVFXSTUSuyL1UlS7+2Z4ARUtVZ0sLOYCXVRIv21f
	lj56c8WkJv37IEnSOzTViEwPK7roIu/sqn4iUZkrJYGmZEkPXqCt5McvzqjHzLqZGQxugaCK1Gm
	CbS2mQdUrQ2zun+9FG142+NiN5TKNpliNnEDgUnX6o1dZ9hIFWKuSEIWex7dFwBgzAII=
X-Received: by 2002:a05:620a:17a8:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c9eb265cedmr288081585a.1.1769775183738;
        Fri, 30 Jan 2026 04:13:03 -0800 (PST)
X-Received: by 2002:a05:620a:17a8:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c9eb265cedmr288079685a.1.1769775183346;
        Fri, 30 Jan 2026 04:13:03 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e33sm412879966b.71.2026.01.30.04.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:13:02 -0800 (PST)
Message-ID: <d13d1931-c6b2-4f4c-873e-efd45823fa89@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:12:59 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-6-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-6-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rQV5Qpi4rRndOysPrJ7fkQagYFLa0FV_
X-Proofpoint-GUID: rQV5Qpi4rRndOysPrJ7fkQagYFLa0FV_
X-Authority-Analysis: v=2.4 cv=VMTQXtPX c=1 sm=1 tr=0 ts=697ca050 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Wk3v8SmLDDZtl8l8IssA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwMCBTYWx0ZWRfX1/Aird/vwvnS
 Kt4h7se9ZySXJGtK5jqTDQl/TsAtpgtOrb/MhVILKIZAO7PaN6qdloWFe7mYjo1X3Hd3rKX4vxz
 r+lD/WQiL0uvJzr+mJeZmI2Dv3EDt51ex1pOfY5Afzo2jM2+V/3rVoGdUdeSQ+tONNt9mSc7KKL
 h5ilJftrKDvqAcXEcsdoT8iLBfkIzWPXmZTclljs7ASny2tcIDGcPQxYFGzjjxggNAd94P4/tG2
 c32fI8V+2N2D4qCYR5Oi6JWKb10pKi7hHla61Y686A/tpwve02MdRJ7laA+K3fPef2GAVyRG9P6
 th6uyMvy5Gfnc4gz0519SToxXD2lZZqrcqNQZeFSQJ2M2gzjmtfd68kA2mJE5HI+NOCikJh2bxQ
 8bTPeHR7ruqBYL7MqkKUg5kYECbC5an/dH3Dj3RanY+ZrUo7AZUF3MNQGVQVyTx9DdpGWJ4EUus
 RspANuiJaJ9Y3peC3ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300100

On 1/12/26 11:47 AM, Praveen Talari wrote:
> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
> the attachment of power domains. This often leads to duplicated code
> logic across different driver probe functions.
> 
> Introduce a new helper API, geni_se_domain_attach(), to centralize
> the logic for attaching "power" and "perf" domains to the GENI SE
> device.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +/**
> + * geni_se_domain_attach() - Attach power domains to a GENI SE device.
> + * @se: Pointer to the geni_se structure representing the GENI SE device.
> + *
> + * This function attaches the necessary power domains ("power" and "perf")
> + * to the GENI Serial Engine device. It initializes `se->pd_list` with the
> + * attached domains.

Please sprinkle somewhere into this kerneldoc that this is specifically
for the SCMI-auto-VM setup, otherwise "the necessary power domains"
is at best confusing to an external reader

Konrad
