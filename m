Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79D3ACA6A
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320647; cv=none; b=KZenCAjzQjCCNKEAX13hkbx0PB9jfXSK/y5eq3TOxl5NCMahtZ0WSORPQ+IIIzp6KuE/BjuTdNOr0c0dBGjtqE9WmpXgFvFtdqxtWFuiwGYMBZF5S3O5ht1qhl2FshJtvWIgKIFfzcoGN4bY8NBL8h5T2t0IlTvF/sTUhRIe5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320647; c=relaxed/simple;
	bh=UDmJ1k1aLBInIvFNqEcNOlLzi9eOR2sEjPHpu1oXk5o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BR13W44Z4NZpA4Xoe6n6gQ2tJURzsZ2HPZzkvzQH1cVFqA6Gba7xDATnY+hAI07E1OB+OgblM9yocoPs9gp96ZXBPuXsRPi68FJUChgxqpxpbVESiBayE/s5etUWzZeBpehdpSOI4VZX4jpcJKzdDsAs/w5QT/AM/dXQh60R31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SMm++gvs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Do1XWa0u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMm++gvs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Do1XWa0u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651BM0JQ621991
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 13:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bhd58qYV5qQ5sfvU/qA2szyY/a3HbSOfNKYbjuYIxdU=; b=SMm++gvsFKSE5wBA
	g5VS7Jqcx7dcNO2P86vhYJWGVcerVWx0P9ivsVJ/5bPFjCoumIJr0oItSxwxL+Co
	MliHmyCSqwUR1fNrtr6SMp1xY07Xy3ydfng1lpyPXatpimcb7npllGgqe7pQ4aKt
	7h7cwcYwO5gbtd3kLiHku4DB5teQvOdbC8bsG0kEkAYzy/TyHZwXV8Vy2Yj+u3YR
	f3IiuxovmzbWED14m3FJkiUEiKMRcWCID7ajSWFnS/xr+zTZQ0C7ONhgPE+2Of68
	GrGxcFcnBZDVFMsN43OPuf0LQT3/5ffZWftqpJ7hayxl40W0qA4NOM7hFPdjLvFt
	oRJ51A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954gg6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 13:30:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf0b7425bbso76557165ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780320643; x=1780925443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bhd58qYV5qQ5sfvU/qA2szyY/a3HbSOfNKYbjuYIxdU=;
        b=Do1XWa0ujBw20wCGTbZPGqOUBbAcsTsMYh5eB9cm0AK7GRJCVUY7BvYxUOVU+Q0QKZ
         6TS0UtoYuUCwWEZkDwgCqolgbNjNakz0LyGVuE4TXwMRKc2yFSmWzqFIQ2nGRYa7Xv4p
         y7CqOQnDmzaMsaIAniXs+2kTg52dbnaobtHtf06I5rCCRvJJSPDcCLxyk+XevugpCvGG
         AdW2hJ3fBdeyNVqfW59b3xsRdS/I7roQrrJfBmyk3W4fa/6huiXeLn29QMUso2LpgpKY
         uqGf7ZrTEozTpmOfhCOp6InR0+P0EI+BHkPMj0Vijf12p0VGdlY4/uA8l96xUTf5/wyn
         jLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320643; x=1780925443;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhd58qYV5qQ5sfvU/qA2szyY/a3HbSOfNKYbjuYIxdU=;
        b=ptN+OmIgTt27XjzVlYiyvlgO5l37NUtocHJgvaGGT1/HF3YrNGGXqKd/lzAdjtYQNQ
         Vcq+ANjQ6RsCir3lPZtlZkJDnid+ZYv5Btayp+jS0H3sfxvQ/42SGA16rhD/Om5tc7Ac
         eoLEfh0GpkgJYLMj4JjY5SRiM/iTF400Bs4W315NzRM8YfF3k0OsLWPRkYXQ7CSis3TR
         hrjJ9mv9x/fKxD7LwHwsnYPktyAa/FecPUUhDxJaDMJR1LnhuskN5aWrwLn58LDI82o9
         BXo5AfzYoY5bVo1FOhhyJDTQy2t7MuvsHdYg5I04IL2/GmcXAdD7NxYB6sYTAjPeTF8K
         yiSw==
X-Forwarded-Encrypted: i=1; AFNElJ+3ktoUxnijSQVXzbOUBHM9Fv1CM5v+IhUn1Yu76BEGQGg7sG2M2ZP2of1kKV53PYyB1e2zeflNkLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+1zRO+DbgaALFG4YMj3zsJw+ouqgnUTRhixms4dM1ntd0O+V
	f+LsPnkxuJF2QmOEH8bC88qw+114gYmXrhe+NTt5Mh7yfKQYQ0gqxMgh/YRrLpq2Ro7AJgTS8oS
	3RGugjb27ztk73g/0QfuqGGVlmRR/yPJnqeBtEnULgdOV3uoeZUapelUSd8YB73o=
X-Gm-Gg: Acq92OFsWiO5A4FFdswIK0p8XN+2LViJsTwo1o3rsrwnQWdTzZBbkD6lW/0oMv1Kuhx
	ToWrPev3r4dVJqTSykvvxciPiJDdgxmi70w8AAp1fJ/279J2zQ5ZCWZkrKa0YrdLSKkt0VGcN67
	w5cO432A96iw3Jd6NBb0H1i0Co4dXDQTuXzVWNbtvjGsGH9Uot+kLAU5g8syEd7jM/k6WvpIugN
	diaulFbawY8Wpqyfzg8/1OyXnK3/oZOhy853QiQk5Xa4vgptA4+Q2u72DXdy86hkKmljD/S12d/
	UTMr11XXPmHlfl8+Vg30btd/QOdS/M4+j+Q/i9XeTm56fkR2esUYIUa9/79BvlhlBiJ7DFduNut
	OaXWs66Lvs5RBAdIKxh+aJ6HnlLagJlx5YtO6OzCLGmJMZPhoo8ufy+aRFJSfQw==
X-Received: by 2002:a17:902:d58d:b0:2bf:2e28:db28 with SMTP id d9443c01a7336-2bf368263d0mr123080595ad.29.1780320642775;
        Mon, 01 Jun 2026 06:30:42 -0700 (PDT)
X-Received: by 2002:a17:902:d58d:b0:2bf:2e28:db28 with SMTP id d9443c01a7336-2bf368263d0mr123079815ad.29.1780320642277;
        Mon, 01 Jun 2026 06:30:42 -0700 (PDT)
Received: from [10.206.103.106] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e6ff5sm143718315ad.7.2026.06.01.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:30:41 -0700 (PDT)
Message-ID: <c1d1a8db-9cd2-462c-ab6b-d14eb97c644c@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 19:00:33 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH 3/8] media: qcom: camss: add support for QCM2390 camss
To: bod@kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-3-645d2c8c75a7@qti.qualcomm.com>
 <178000641103.4557.14582699057810501776.b4-reply@b4>
Content-Language: en-US
In-Reply-To: <178000641103.4557.14582699057810501776.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tKqvOeS5tAsH7qzxjbabBicXeHa785QU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNSBTYWx0ZWRfX4sAxg7iolYOm
 Axp8w1dCl2ToY8bOnWXc42ILEkpGNFS4BwmXVI90PUFyWE7oe9lZWAUAAHlEPneeLJ3+O2kF5tV
 Taxkb6xwh7lAGInltN22FoP4y6yrtNeI2ruFavO4LyLoz9pfELCNVyG9clZcSW2hQVl1/At9a6G
 cT/y07aRL1iYD4vkZ5SNBcgZAr29zN3P2xKEJybcs2RMg/cAo69ogyGOtsIut7kQQW9h/SGuJpt
 kaT/o7yOf3CeB97xjl/Fhv4qr0IXVGoFuXOMWvzbRJCC3MAafDxf0U5ttb2LnvUMtA1t9kjhaio
 8jlRHnmnAfE9lHUbeBQpxH5WrMWbLE1zD8D+h++7E0hd2Zn1tgbAUwthhDCRCEL9fTbQa2Zbea/
 Nppu+9jaQ80gwsv2QnDVPeSfdtHFIMsmbEuwaNRUajoFkOF7nQNAZpzgC66zDU2YJirZU7htf8G
 aE1OJN27ucGkVHpH3JQ==
X-Proofpoint-GUID: tKqvOeS5tAsH7qzxjbabBicXeHa785QU
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1d8983 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=FPLoCuxg6rETm2Q1RYYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010135



On 29-05-2026 03:43, bod@kernel.org wrote:
> NAK - what is the point of this identifier ? It literally just adds a new
> define and a new string.
> 
> Unless there is an actual difference with 2290 which thus far we haven't
> see, this new type is not required.
Understood.

As mentioned by Vikram, Shikra will use a new compatible string with 
fallback to qcm2290, similar to CCI approach. 
The CAMSS_2390 identifier and the driver changes will be dropped in v2.

--
Regards,
Nihal Kumar Gupta
