Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06955C312
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092293; cv=none; b=IcgvXffb233AF3w7h4yyVe+dc0GYijhpDZVgByie6gNic2KtqmSLoKoJ0r73uuFnisrOCywcAL8O+vGGoWywzx9H7LDA+/k9o9f82Pytn86ZOXBCuRxyjOhANjlLfgt+GQnZuxvOf/VkaFgxrLQrzsbgaFW78tzNtYtSeAXybTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092293; c=relaxed/simple;
	bh=CoyYTnZ8DJVM5eZTTyQQ88Q1PAuHVEJ7jE5IuXsp32A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/KcUCVPG5gJkJBcffUP+YuCkf8TnT1tb++NLZHpLsIIKvA1Dw8XniRXoVo+R/0lQP3+7W6ChW2DmjoonGJHSMfNMukzK6UMcvSz0wuYXrN2afWbXvxObLj+kmdE6XxHYotAhBEjHE9bEjv6ui3Kk2CtL1iSFOM79ohxhQGH61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSgbiMZD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWHpB/5z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSgbiMZD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWHpB/5z"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEipOc1583993
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RnmPg50OEmv8rP96wxGaZ+xgbjo5u5huRl5f5KiIQ8I=; b=VSgbiMZDKXRJDmXc
	D4ULXJkDgfpS3i3YddwY4p1jbbc6884X4j2GHj7YPBxODjIiBJrn0cu+L4EiyN/f
	GIlqcZ1IOHG3KehVShBsBcnpTdfpvutqtWmajzgDYxMn/OwH97ROdZOaK1h2ZaFd
	UiX0PAPLu+ukh0Z8hwWvBZ0D/ms1BZkqXkxWmZiwMCso0HPEeumig+E/u+WHAIXb
	le0dz3LH44A65XNnt1HTosj/HvyG5JuHZ32SYtCem5V8H5RD43FX4ivkDFL3mG4z
	XnjvJ4GxGPoYjj9R7mhctNT54NsTfJ7+QAiO5jDyqAxiTrDJPIhZ57CdWQbn0tkA
	wSWeFQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guqycsfwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 15:51:30 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-77969cb40dcso106597137.3
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790092289; x=1790697089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnmPg50OEmv8rP96wxGaZ+xgbjo5u5huRl5f5KiIQ8I=;
        b=iWHpB/5zzWoXcl4aIEVAUwb6iMA2NFwRfFVe8hFe7Mld5dGMK+QO4fpztIoIgUW/ME
         vHqX9fH4aKspVxNAoCV71cDaACA+SR5RwX3FRYGvvY0h6HZVpusaRFD7TWHh4GHHbgjn
         Pq2Ryt5S6IIF8f/yIiBEfAM+T6O3Wcf3eKKAfBGWvYJZbfHy63k4DdWreNyKok+HVr6p
         Rqhw5/pi2HmTFRDsy5txoJrFJ4XaOm7LH7O9sfzqanavZvIdn/BKS+ak1DpxrLHFRu9m
         aYuH8RICTsyAEN7Ksv4uvrrBmIZiS8fwAlvhZesTujlr7hV9pCOFg3QZd+W6n1Zfj9I3
         +dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092289; x=1790697089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnmPg50OEmv8rP96wxGaZ+xgbjo5u5huRl5f5KiIQ8I=;
        b=nFlis/+CmshxzqaydKh7608QN4fztQVaicUahdTQGOEIiPqIyyCuU1WVQyovye9FVc
         0xpgsmVNI2onJh/XOjk/6FzeubIXBqic9myyjOQeeJSU0kirhYEr2UY7kru6TL5A7StK
         x4/WG/cNxRQuPeHQ1g0rsw0+vVodBH6gp3GyY4i4UK4Nrsyk3rmZ/VzbMsnBFZ3Zq+mz
         pDN/ixTbhKQbhIOlNAPPiviiIYrIpPuH/XEjHHRlFZmP+U6DW25rMHy1BIt1RggoQE2E
         xGx9kC05D0nftCbmJLefDa7n4SqNs0zbtxzUfsH8GwoLdExJx2ikxOqGDG1v+7rR5BG4
         7DcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzNoiKVoWY8JtDadZPcRpiYHvmik+gRdPcfkCWvXj3HSZku9SVXS9SrwYYC5HDIbklYz7uHX4Zh5U=@vger.kernel.org
X-Gm-Message-State: AFuF++leYRQYULAzMiu44dKQmfByflLpZzngmBxKOwu9HU5nyz06a2c4
	0B5IfC36l6XDwcJ+E8ooHJltFdGyo5SU8vXXBgOlO9N4x7c7+jhelTp+Uk5M942GiWGD3ccwUfD
	ktVY1Xyq1WayDt6D7jS0omvusPKCvBzmwY8D5MpRg9JjfZDuD6RDHCpG2EBm4FKg=
X-Gm-Gg: AYBFou04D4G+XU0aHxh0bW4L/rfJLIoD0j1xkkjKA14WXRvqoixOdKo8dUr+3IdaznE
	ch2TD2jwB7FT3aKgsIw0cGQxzK29m4oFdv2g2ymrA8ZTK2nQaBCTE5Kjh32KJMQEJsuPj6Jrr4i
	ZNx58oBXNbPgVcbSh0tbB9/sQ4Te57Sx0SBY9dFlh446aZJ9qQQGfCLcrEJsR7AovGm2QwtZna1
	TP1ahcng1fKliKK+7oMnQcArJ1zgVFivjMOJd/Sl+bfCW9OAQI7WGteWfnfYAVOg39fA9HYkEox
	POElPCmOt1OW+XSHRJ35QnKJ0XnEal2s6O28EsL/MVRwtm/KHU+/EDYWFaVBEiI0R9kXAZ5hOfO
	MyA0sfbocJMAXpVCAjXM25A==
X-Received: by 2002:a05:6102:b0f:b0:791:33c:9d1 with SMTP id ada2fe7eead31-7a59d45b711mr8581244137.1.1790092289177;
        Tue, 22 Sep 2026 08:51:29 -0700 (PDT)
X-Received: by 2002:a05:6102:b0f:b0:791:33c:9d1 with SMTP id ada2fe7eead31-7a59d45b711mr8581185137.1.1790092288703;
        Tue, 22 Sep 2026 08:51:28 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c2a6336sm113065666b.0.2026.09.22.08.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:51:27 -0700 (PDT)
Message-ID: <27810459-c127-4b85-abcd-43d8f1e25c15@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 17:51:23 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] arm64: dts: qcom: shikra: Add CAMSS node for
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
 <20260917-shikra-camss-review-v8-1-9b9596221cfa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917-shikra-camss-review-v8-1-9b9596221cfa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Zw70q8xOaMVn86kZrWkkpZfMrIrf2kHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX3S4ywoMPvDq+
 duMlPKNRJBeztqnf3VUiW+Ow5SKR/6fNkVEXNsxKk6ArXz62PJx2xYPzlhn4fuD0I35kjUxVQaA
 j6vk76jBzz5gPAX06qhPc1qH9a0iCbpgXbzjlBqU6spp78vOG/SWasiq6c8AbokYUX3HnrAVM1A
 UR2kRhG++GCfdKq7CoyTFlRvqDRLO+V48IBx1TzMfOp6MOb0uSzBF13arQa4addClVZKOT6xwDa
 UWJbloXnBR4nDPTubOctfOkraXVzhja7WNm314mDmsJh4ZqBJepkRQZOmKG6RN55oIYMz0C2irE
 3gBbQC5ew4KYQfjXb+dCuZgH4E+0QWO1YJS+n+XZ07ZaVJgTeZSoElvE4el/dNph8mzY25vyoU9
 O0vFxrPAqCWd9mHd+/WxFHmVLPcl7CEBdAUthTqquZ00FKzLigdlEz5ZoD9r8cmtqlIXXc5OS51
 MN2sCWkQ1jILHehA2OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX6FxNZtkOL9KG
 uiYJRZME/s72hnxKgyheawgW3z5p6vilp6xRoLEhmB61uOdzjZvnc5VtgYDH4zmLkuNIICwPFcR
 F/e8WEhmUirs2oUAS86IE0sDRRgTgRc=
X-Authority-Analysis: v=2.4 cv=c8I+0h9l c=1 sm=1 tr=0 ts=6ab2a402 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XE-wypd_VeY0GsksmEIA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Zw70q8xOaMVn86kZrWkkpZfMrIrf2kHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220231

On 9/17/26 1:41 PM, Nihal Kumar Gupta wrote:
> Add the Camera Subsystem node. Shikra shares the same IP as QCM2290
> with two CSIPHYs, two CSIDs and two VFEs, but does not include CDM
> and OPE blocks, so only a single IOMMU context bank is needed.
> 
> Co-developed-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
