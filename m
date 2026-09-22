Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDC560AC9
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092311; cv=none; b=eJbii4f2Z6QamkIWVMCnbqj7d407DWQSKQhBuENI6OhUb56w5w7/sOeWE8xiI/y5u5rZAxpBfLGwuwPku9I5cq6yxTY0Jjj0yB3wA3XhyjTYUf7T3IVm/OYMrBl37+Y/NN8KLTLZotD919ZcmFaW9vjCDrr84o/9vkbl7qsBZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092311; c=relaxed/simple;
	bh=h1Jirh2njNXWwpEhevaaC+b4awoAc2Rjo8bbL4rz7r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzjL3VeyjZGfBD3PJvNsMsADSyFA5sYSsAJL0gISILBaWuG7bdJGeNqDUe9Htm7nKHvyi7gvCFpOd8qRgeiAzEXFbdIvo79DqM8DIMNBfIc1szODAjeBKwgqogf6w3sbW5EowcnYwmdObuWopxF95kyiiloqnLjBmZYIq6Dhls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7JebKBj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VgE+xdf9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7JebKBj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VgE+xdf9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjBRB4109932
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZIlFbcfWSSBPJOpXWFjbHK10Sw2EK6VtX9GqIx0bZ50=; b=T7JebKBjMDSTjcvT
	jvvm6qlOAFp3Opw7JH9XLLvMpxwQ5Jx8SIE6WCmEtK8wAZHPVPkKurHVgh/qpV2o
	af1yerBOqUz8i3e4pe+Ia4j6jFrQX91Kds7/kehSZJVYzUc3KJgQoWA4BJqL8DDU
	z/NSwxieaNJhA9DuHu12joKB/Abvrn9nXKbJz2jnstzcVS1uO+Pq8nJbKDDId+Vt
	2YdLVB93mNnV+gMqTyH0I3xV7VwXGVrJ1jvEzXeu2bgkYHzCycNoSkXBnKy/rUVp
	ht6KQCMYQTaBvyEiZ3nLCL3GzwTDag/ZwEzA/0sOWBjZn25Z5QqN1v4zd7nnZSyE
	tXaQOg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnt9a3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91240299f0bso39066d6.3
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790092307; x=1790697107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIlFbcfWSSBPJOpXWFjbHK10Sw2EK6VtX9GqIx0bZ50=;
        b=VgE+xdf9DIjpZNi8EZhYGbKI/PkBnvZ39yh9RnOxL+zcWVL3N+x4EEUekCfm7oggpe
         JE1SkLUftYfLDzJXbJFRNv0+fjYjO5sQlD5yNfwCjxKv7d4ytsdwOwtsKgG322VgYECc
         5Qu5AG3/4vu1Ru+fieoh81eaS428F+dyIit55IcC2fcHqa9owTKsHJbtp3KWcCINQNFx
         fkEHndar0VGah3FuG7XOXvAyj6NaHBgP61/Glgam1pu6vbErJFigOnTLg2nCoMspzp/V
         1TsBDkKzp+fgaGLnRwCbn9VO06HNwf1ZHQo9kKU68h7ytbzrEnWU8IgzMGJ5JnmlcH8y
         Y+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092307; x=1790697107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIlFbcfWSSBPJOpXWFjbHK10Sw2EK6VtX9GqIx0bZ50=;
        b=ODrr5uW7E5H/S02jSgqQK2iZW5pg+NTW/myjoHqfWBEkiFCPbkHdN4fj67IMXMcWGH
         +3lbfoWmp7Xyt4JBFt+HAN7r0L6R3jJYnO3v3Jwf5pOKNB5R6fv02FUJcXAL4r/Vw+I0
         wPzgjLbrxg6xOQKZbfTEnpVt4VXB4Z3UOKaS4NjjhSDBHbvEXrz0+IUqY209mtXauDzQ
         foRF1oz/Jc5z8GQ4DFpS9i9DqLtGyZKl+KPOd3vNx0T8EFKpcS8qxLkOTq/hB1ycnpCR
         q16xIbCS0sUDd7NSTi1N5EwlrC/AgAh64OyxmOBTycRffZMMqh3R6zJS0GTOI/Fz24ou
         lToA==
X-Forwarded-Encrypted: i=1; AKwUvBzkDdkYA00oHuN4wXvODRXS8L2+2N/KC4TNBg6IJKO4JMXp0lp0dgfALKH3ezIzyMY/ANV7TdNtDko=@vger.kernel.org
X-Gm-Message-State: AFuF++kUbCUbzNjLMG9xF4IGF/jcuEsFyj6raJ8WJ8exPhMr6MFQ3IUW
	nTfVK6XkRJsdVUbsnVWrGB1n0oRTrd59iCPv8/yfVxV5NGL/1Cw85RI8A2VDXUsXQ6jNjyHwaj4
	hfqSvEi/Slnd5dPPZpZ9norN3x9DMikLs32M/MfALUKyjsz1w/ocf5etXEfqPPd4=
X-Gm-Gg: AYBFou31kcer3GdQFIX3oI43jV9OveQfVx0nhJb2x+jw6iM2y+/egUln424MqddIJ8p
	JQOsv890/UbziKtv3Ba/0ygFAfosccO+zkqK4nX7/DbsGYqGa1WCX5kx5pCcE+B3Y0Wiv7DgDkn
	doYGO1eAHqt4F1xpIXzGYn1ud5rK9gsm+PvnGKv7UEmDohrgyg+8+2Y5vL0EWGY8pxSFHldlbkT
	bYHtLxwUDzgTyXnp+qlNteSFnJWisGnHTv2+lIbSDYeUkHUXKHhZe7a+5xb07lL1OTI1wkq3yTn
	Uumt8ywDPxIxLgd4lmy0647JB3yjXBzbIz0SooiS9UWw59qZOr9NjSFb28XiDXE0NNAlTLBoNlS
	f0u/dy0B1R98nbn4h70ya7A==
X-Received: by 2002:ad4:5ca8:0:b0:912:127c:d7f6 with SMTP id 6a1803df08f44-913fc9782acmr62342176d6.4.1790092307337;
        Tue, 22 Sep 2026 08:51:47 -0700 (PDT)
X-Received: by 2002:ad4:5ca8:0:b0:912:127c:d7f6 with SMTP id 6a1803df08f44-913fc9782acmr62341686d6.4.1790092306971;
        Tue, 22 Sep 2026 08:51:46 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa440db2fsm1379520a12.3.2026.09.22.08.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:51:45 -0700 (PDT)
Message-ID: <29671684-020d-42e5-b7e2-f7882fda5ffe@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 17:51:42 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] arm64: dts: qcom: shikra: Add CCI definitions for
 Shikra
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
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
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-2-9b9596221cfa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917-shikra-camss-review-v8-2-9b9596221cfa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 092oW_bGiBhH95KZmgZqQyFfHTItNkE1
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2a414 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kTwRDD6jQfcqJCPQX_EA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX55lU0Dy1Y0Of
 qg5UEJpTZ3krLDG3kbJpnZDZVkAG8nG+7d1xwKs++KcSd5YWQ6bX8gNjdEsgfhbws6Jgs9ICqkk
 ycSH6ZDtGhj7AnHl5nBtExpvMcCd9bzWREG4FWVu7q8D4NGzGSmd0AyUtLN833mLMTnwFYWTz/n
 kV5ThqeGaDImE8MBcjcltYs0NXoMq8XStLE4DU9osex1ECG81ReMYwc83LH/Mq3VmV3DP70JKk9
 aIpQYHdgABTBwFIR72xBKtNr8Dn18Gyc2YuaJmFRG2iy9DUVvwjOE92zR4xcOfkWOI8LOgGwr5L
 yJxTtHOjV3efGjtQcxwxNi8ieSsKFd5hv5ZfeiSN7jufpt/imuhvZc5ZRw6uHo3GcMpjA8L4dS9
 NBgJzAJhIEMg+x5fg3gtXh3JYxXZe8E4xZinqcjf8PmeIth2Y15ZQt9FPwnI8YOT7DqHCaoMPwr
 i3Yi5bhwRw3dzEB6YqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX8TPUxg6uQl4R
 LqKAqb9evdTYxD3XUj8V01aY/8TY2FcO3Su6wlj9Mwqu3JgBg8K+fNK163Zmu1DwQQoi8mwmYDQ
 QkdaIp5WUByvNjv53aCeOLI7DpT60xg=
X-Proofpoint-GUID: 092oW_bGiBhH95KZmgZqQyFfHTItNkE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220231

On 9/17/26 1:41 PM, Nihal Kumar Gupta wrote:
> Qualcomm Shikra SoC has one Camera Control Interface (CCI)
> containing two I2C hosts.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
