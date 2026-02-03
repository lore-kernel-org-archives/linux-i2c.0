Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FD20B7ED
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122898; cv=none; b=pp2UcM/8NpuHijzm2DdQZA/g7nbMGq2CACRaBo/NMi9asa/p8RitOq4pfcJ1Ti/Zh/I5tCwKTQcdaMli53Xrz1WJdjWIKv3n9lxy9vl575k5s5IiUqYpMd92rRAIJ6+7tWCRtPVsHxGzrBMUeAnhpkJNsNXdeGiC0koJjQQbtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122898; c=relaxed/simple;
	bh=TsBycMBF9tmAwhfR9s/Ou+SnZGtzHqmnz4gVFu+lt1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfv9ASZ7S/9EKsA0X3uLaK1V5auYRB0dLB9a6hTvk+p5PDbYujx8QITec/4Q4grRnbKYH9wLTZDBlAVerydeefpdA0fZ4qU2+wEJb4mSoGbc0IteHBdetd69ioXGISDb2RYdAXPVU5OOh7NLMy4y1FwUH6817RyKNK594e44czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=icni1UEx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VXKZ3X7O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="icni1UEx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXKZ3X7O"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ANmJK931274
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b5reiRMxf7eQPz/r0JsXzDKnp3PHnj9+4R8qPa+QT20=; b=icni1UEx5BbtmfoD
	WQ2eRYue9Z40/HVaG8XNwZFFrgeKyByNqpl6gaShT4fRWQSEvtQRaU6zyXu7rEg0
	c1fLkj21pYApOtw3WJzy8Ibyoj0IJxMUyNQZ5/fcmz3yU1SSV6e1z1TlJmJWlGCW
	O5d5NOYogkfaGf7xlzNuvtgv3xYts5tLi4LBWpN7w7BCHcp0ngPhBvL9gpljW4Pa
	n9aHyacvOaDVuR5wwOC1StU0cAPfo7e+MH8Cntu/5TJvytWmVSiFDGZ7gxiUl+OG
	Xim4uFcbna5NVVBC184pJLQ+pOyQWZ7y9bN0p6TqPvYHDbVTP6fbb/3EutJ4FIFY
	R+RC0A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c38yu1mjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:48:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50340abfc02so9301191cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770122895; x=1770727695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5reiRMxf7eQPz/r0JsXzDKnp3PHnj9+4R8qPa+QT20=;
        b=VXKZ3X7Ot30U0mo3xdWmbbu6RX08sIHtkB7972xzcukQEdPeb0rxNXVDX48mn7q8cM
         YFC5nVDEfsSGx3irk8Z1Bn6sNkofza24icS16mQH3i9cFvSODtiyZ3mB5m9sc36IMwVG
         zXec4HJezfDmqJGDFkUOpXsLhyPmDjXyjJdH8C53b8miA8KxYBUpmbWfMMbiQYK1ARs2
         lJNah3sDOb4lRUl/6MX3ovGPko8Btfr61zH0X3cY77r+7H7pwaoKBjMw7S9gHL8qWa4D
         qPKCbeHkZI9n2C4q0/dA2+b3sXNCW8uKjDJAxBISafyrNnYyuvDZ8MCxGcj5oy90vKXQ
         ghhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122895; x=1770727695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5reiRMxf7eQPz/r0JsXzDKnp3PHnj9+4R8qPa+QT20=;
        b=W+Y8vqJJVOJNsvRfTC2iYVBF+nSaU83fmmycKLm5sPUOr6dDXI+94bPtn/Go2XbV0s
         tGcTtzhZWSqxlMphUjQ7NNIodPddms20HMGODppTn9wu8ghJEhqxYt2Ke7OG3Jz69tWN
         DNh5G4tR278OrED57PPntVLzoqnyKtqCC55mkd6qtj/UBpOxVD/0M870eMPXIJqvWz2p
         NZN/EsqozAxJetq17J6CjeR9n/9topi3wbDYE0VEZ/nhxfj4wSIT9R8nvy5Zi0K+PXYV
         dF01aJ1NgZPPNhPcm8+7VsIjYM+NsX39HSY+VIuXwJH5Svu5vDXfy+5WXL1VzT8QBoxc
         4YFw==
X-Forwarded-Encrypted: i=1; AJvYcCXcO+ir/FPkA2K+ur7Vzdq46QIoCdl6LgeWIARypJNMHeLrDVS7hPL+O8ooq0I3FcNiCxa9VhqTKWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwxFQrH6ru9bhk7lAqrWeRrJsdSHTQ2Wu0z3aV3bj6Op5W+ng
	ZAzfK6Fd4nFbVosPq+JafrsYr9CXnS+xSETdVf01EjYneJ9wmUCncaXx+fpObpRlgu14/taE2C3
	v6pUMuLrDvban64fqC4aowvqQx1l7S1pfK+LK0Y62rud7lAjCfm8ZCmmXEKb4HGU=
X-Gm-Gg: AZuq6aJ4dzmX2qjIW9j82vYXafzMQzjVvHW6+bDn4lQv3b+XS/ijxP0QUGi1HOIIYKI
	buvaaSMxvFsNp2gMV+OoaQu+Wj8Z+StPiAeqX0F71RGxeTyIsZjYznyGzKNUNs/qITlqZZ7LhNQ
	IScq9Q84ySN384rNUJyv/d/5sBE2pCG9W0IoUgeE1bY4lllB1x2ZkU1lqBegvsw/ECwbFRg6aIa
	vkRd+TI6kOeBNFsKe8HeBtioqRHNqmjZmOR/ktY+O2UY1N0219Z7xkDHty+nPrtwojsEm0HrZ4o
	L9Hfj3mZQEQbiyDBe4cTB/0tDLmewX/EIxuoLY1MpoA7mJICbVX2+x4rIDviJwP8BprI3BpA+6L
	xODXK/swqCqYQZ2wSQ5EQAEToEm5rZsAsFU0aboC9aMs/gs0uRKxhvO/V2ygbVGOLTEQ=
X-Received: by 2002:ac8:5f4c:0:b0:4ee:4482:e838 with SMTP id d75a77b69052e-505d213bc9emr154675761cf.1.1770122895414;
        Tue, 03 Feb 2026 04:48:15 -0800 (PST)
X-Received: by 2002:ac8:5f4c:0:b0:4ee:4482:e838 with SMTP id d75a77b69052e-505d213bc9emr154675431cf.1.1770122894914;
        Tue, 03 Feb 2026 04:48:14 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e0a5a3b1asm685936366b.57.2026.02.03.04.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:48:13 -0800 (PST)
Message-ID: <7733eac7-8158-40f8-8887-44e458d33e9b@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEwMiBTYWx0ZWRfX+R5yUacNm9Z7
 3yh4P4xz4zSjXn6+/HfwQ7+yJ4WIAPcAE6gCs9BStbKKVml/PYdkL6sYAEtsdbrcLADavtHdsOU
 JTeKS2n4t8IltCLCflJf564YWwS7srfblQKc2OCZ70BYlrY3LFlRtqPvy7yj9DF2N7eF5KpeQha
 b1c/Zlqc9FgGQGJ0mTfdvCaaKk5HfaAKogmoX9rLY72iEx94PvtJQ3kvHJm+q3AamuZ/dsMNCBx
 W0xYsiGGtvsQw4VpS4T/x458DTlei0xtFeItc5CtwCMQhKzEjPqoAO8GHbzRYI9yh8a2ap3Jex2
 XjyQDz3qASnxcqA5dlT8X3NTy0FiOIZIBrj/yXE9J4m0ItJhXVMtjx86FWzeqICFDTLa9RVnQ2A
 ZzKLHBJwqpxH0XZnNkAHvhqdJdHE2f4uMZw2r1l4KY/gla773dhJeO0I4aHEAJlJ7S0l/02OKpA
 0nqT2Pv99+K2kURw0JA==
X-Proofpoint-ORIG-GUID: ho4DIyGSwiWdyC0otU9hyNm_BBKKydw7
X-Proofpoint-GUID: ho4DIyGSwiWdyC0otU9hyNm_BBKKydw7
X-Authority-Analysis: v=2.4 cv=UKTQ3Sfy c=1 sm=1 tr=0 ts=6981ee90 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gzD-2WDeCj_JQFVUwcoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030102

On 2/2/26 7:09 PM, Praveen Talari wrote:
> To manage GENI serial engine resources during runtime power management,
> drivers currently need to call functions for ICC, clock, and
> SE resource operations in both suspend and resume paths, resulting in
> code duplication across drivers.
> 
> The new geni_se_resources_activate() and geni_se_resources_deactivate()
> helper APIs addresses this issue by providing a streamlined method to
> enable or disable all resources based, thereby eliminating redundancy
> across drivers.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]


>  	disable_irq(gi2c->irq);
> -	ret = geni_se_resources_off(&gi2c->se);
> +
> +	ret = geni_se_resources_deactivate(&gi2c->se);
>  	if (ret) {
>  		enable_irq(gi2c->irq);
>  		return ret;
> -
> -	} else {
> -		gi2c->suspended = 1;
>  	}
>  
> -	clk_disable_unprepare(gi2c->core_clk);

I believe you can give gi2c->core_clk and desc->has_core_clk the boot
with this patch since they're no longer referenced anywhere

Konrad
