Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B137DEBE
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318884; cv=none; b=MIfXsnjMLgVj312BwXdp94mjLLYvRqtZfkPgb+UOGX7pDR2D908idniXHqeBq7L7m/7U4EKfYtupDgU9RCk2/yEEHeYYQcKigmXuc9MjPdqMxTf8mQIzQZ/LogRVVzpadEy+44Yov0gjFTTsLFdCVp8awrWa9j/ZCKnjg3JaFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318884; c=relaxed/simple;
	bh=LmCHox6K4Hi42kXwKs9ySW3354qUoc6q2Mi90mLA92A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m7jlQVZD36nn9tR+KHZyPe7wjwSfup1VLU8aOMbMNRhIGkq4qkxGMcQJ9BsL8LRY9aW7bFlwEZcmol22LpILn2LKievN0rFIyQMeYY7TbG6pKDzr9IHubPo058xrnDzWAFDEUILF/YQlJ0sV4z/s3nL84XqjX+GKwDzUpsQ3U2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BC42pSrj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elyUq5hS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BC42pSrj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elyUq5hS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fXZh4065781
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 13:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LmCHox6K4Hi42kXwKs9ySW3354qUoc6q2Mi90mLA92A=; b=BC42pSrjgjSCSHjn
	KmPLCceiXWU4HrTBGGIbiTCKI3XDQTpPyHQYyr+Sxneylqn5jA2DIstdbc9tAAGR
	nQd1hGUhbJeoI+aCN2iufghJd/bgDuqn9qmVRxhnhTYJX6eNhFyzExv+5hyaWXHP
	nWEtTkoJAjkjG208cuKXgUD463y1f36b4KbCGrWVeqLEQqqwSj7lNrYq+H43Lbal
	l/KOgfvGpmFbc+2YlfyB2ThEbaMeGxMHfg7tdYB3ULB0KbpbeTVaLzVSU7tJCBxo
	Lf+Mk4wa+w/FwgGTS2fLUBvNeKd38PNPcUTXXJLALmMyPo2gBQtNfkRaBZ/LUPnZ
	H7vnsg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sws14k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 13:01:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2f1d1e5so783589a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318877; x=1780923677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LmCHox6K4Hi42kXwKs9ySW3354qUoc6q2Mi90mLA92A=;
        b=elyUq5hS00ePjtkjUQfWpUmnm7s+no8xim9QzRrStoNaU9DHFmusm2fsYJJK+zEupf
         etNUzWjdEne9j5W+XFpDZVYEFEHN3hK5UFKo6xZPpDozxUogvXEeTrQrfumeRoo00YXN
         QxIvunczvq6xFCpdrszEoY65czXboSETrO5O+iM9+wC3doNxiZHG5vmqrR3eCWJaTa9Q
         dZLXS+SdySkytPmO51OzyJeVlZzNnkG0SXYCm03U/Va9z+Nu8XxyIQKiwZ6spqTUkZ2v
         +DcYriRw5T8Yo712WdU1lSKlox61BQWf3e9tKtrwzmh9U9yX1mv00NPFf2CN9BYszrPD
         R3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318877; x=1780923677;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmCHox6K4Hi42kXwKs9ySW3354qUoc6q2Mi90mLA92A=;
        b=NOvrEfgLod4MkTREX7F4qEkClmNcjJAZnqYbmcmZYPuEZ9euF4KpLv+h/k4bthLaNu
         yUeRX5tt1h/Mw3iaATl7m4QzuERAJrC5HeO+TmeQS0xcYjBiSF2wrAdevMt6a1UDRNjG
         0qiwpZKkWWuJ59MWvYLXj28fkzwUrunFKWylq1BpOdRT+UTisdcJCUCEZ0VWBNyAyA7k
         UaEvPBxOtBxVGjveEl5JKZFgogjAngdRDPLQb/TXMt6EdxbeAkWBhoYS64umIETpSMLC
         omzFw1daR4OuNNxGtfrabOLw6HTKcbBhJMLWXRQkKKRbF2zymyKXLqVPz2IufemgsE5X
         n/dA==
X-Forwarded-Encrypted: i=1; AFNElJ+qNdGhONzC5fORqGB3pPpOgQXSL/xS7ySBZF+2CjQGsAXOWd8TI6dINfLoyGQaFwFkBUi93Tj+4kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FoKtooAravEFGoS6+mCgrMA6Wawj9PaXzn5akcnz+BjioNzI
	17tu1H6Ou3C8MlptdVMf7mTv/qcEtd1/g4PnpUvjnOiCqfGRt+bAaDHxkJukfbjoGBmb+UfPA/3
	xayzjitVcuKE1p8G8ZFHx0EKJhLC4q3fa2SVk9t7wPU1Dvoy0HqQ3wU//D95GZOs=
X-Gm-Gg: Acq92OFRDmZyRP9JboRvKcVb4Gg3oE+MivDViGw+7kHXU+88QtBr+o5HUK34cS2bbVD
	RiLtLBnD5Ws3Y65UZGLWSFblXE4GvnkZYCqYB2h6vEQA027dqMQQ/eJ2tDbkQ4k0jsk0f6ltJK2
	ZLh/rK0VuBohiQ5zo14lC4x1YaInedEfL45IQT5TcUsBSE/qiso965yp5zwLlfkJcNeXwsJntFh
	7+wsTQ87PqF/Iy82Lmt71d01f0h3/OKVPvmDffIfvG1CsATZ4OwmSbnjPJwDlQQyh1A3Snkyraz
	BC8flWw9VFNQ5rgWcRu1Ta5Rew6j6V9IFPCPxq82TgzUSU0k2I2dg4ZIq7zWGemSBvTFUHUTaeJ
	K9SzgKgGR7yc1HfOn2AMr3lMflErK/1/qUEFHf1VmvIo+fvpWea3/3suapsq8wQ==
X-Received: by 2002:a05:6a00:91e2:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-8422cda7ea9mr7765518b3a.30.1780318876480;
        Mon, 01 Jun 2026 06:01:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:91e2:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-8422cda7ea9mr7765356b3a.30.1780318875226;
        Mon, 01 Jun 2026 06:01:15 -0700 (PDT)
Received: from [10.206.103.106] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84238f1ce65sm6219909b3a.5.2026.06.01.06.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:01:14 -0700 (PDT)
Message-ID: <3dd46660-b01d-4c00-b3d2-d0f1fd1e4fa0@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:31:08 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
 <449651a8-18a5-40d2-bc68-59223dc8b69a@linaro.org>
 <ad3e885a-c04d-4e78-a037-63ddfb0b9c52@oss.qualcomm.com>
 <7clwzl33xumipuucecv5tovo5mfp2dl7j6v4wmvbwj7d3o42yf@3srv6pzfldhh>
Content-Language: en-US
In-Reply-To: <7clwzl33xumipuucecv5tovo5mfp2dl7j6v4wmvbwj7d3o42yf@3srv6pzfldhh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d829d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=tZ79QRyfKbC4N9tKgJwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzMCBTYWx0ZWRfXwgqgnUtjUJlf
 yf4iakw582LHecOlDZeccoA1oooVh/1AnUD7w5Jr1MAZZ/TvYl3BOfGIhgOrmvylFl5ACoXX7Wo
 XD6GPlmNoiE39xvyG8OgBbyoi9Fu9PM+AMJOfySEPOJogTWBGroqayDSiHuhJqG1S7NznnUOrUP
 4yxvTGfhzHYBJnjjMzsDzYZUvYvRzEwXAQLJsQcjerSTjzMnSdZOenJc6n7NL/H5a8twhspx8Re
 HwKMlSTgsO6iQ7RWd4Bb1d4E6JGlB8FcQzqQj9mOUtxHw917XEbX94OQOjj8ZC9Z+pSgRma91Zo
 q534L2kcGeJIo/uh2lQu1TQoQSgI5B7iyU4QIJA/0V6jjVQ7d2BH18d5wdKbFm4Xf922+4gne9C
 3cApYCDsC/wy++9m9FUS7CPaFT3hzg==
X-Proofpoint-GUID: ZJpKbDDriw9BQDZy2pI9xjbp9SSGg5K1
X-Proofpoint-ORIG-GUID: ZJpKbDDriw9BQDZy2pI9xjbp9SSGg5K1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010130



On 01-06-2026 17:01, Dmitry Baryshkov wrote:
> Is it completely compatible? If so, we can drop the driver parts and
> make Glymur fallback to Hamoa.

Not fully — Glymur lacks CSIPHY2. So, A direct fallback to x1e80100 would
probe a non-existent CSIPHY2 register region.

All other resources (VFE, CSID, TPG, ICC) and version-switch paths are identical
to x1e80100, so only the csiphy_res table needs to remain Glymur-specific.

---
Regards,
Nihal Kumar Gupta
