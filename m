Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B02480DE9
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990125; cv=none; b=e59170iwpGWpl0LjZiiaUB3ppZKbsjefMe831/1J9CAwmQMlWCwJ6xWgJYt20/581tvFwDC/UK1sj7Su27UYLNpOOVqYuIl3EOHmA2St5z18J9wwF58jaeTxemWxqbt/NK/5iwPAYU3xg4m6kfWKS4/9ceXnKtQojD3/4rk/qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990125; c=relaxed/simple;
	bh=xHdnBIT5cVVjKBvOsaBlmEr3UWvl+I+sv5DFQkfJS4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE3X30dATqlf6uBWq8qT8tdIvG8bUWx1RNTwxhxUTNGK8nxkqZfjEhj/frJUsViNVa1TIaI+Iy8y685pT0ULf/mZ6OQ9NE4m6ieHtYEnMk8EWafan6BbztBa5qSMCETT7atuPpCLLt5A8gcFpVuTROob25DcatNojKpvdLsdvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo97j8qo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E4mydxHz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo97j8qo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E4mydxHz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L4XeND3230488
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R63zeNS1A4Z+sO68oWo8FrXbiTVs7VdMbMNjJB9iN1E=; b=bo97j8qoV8Eu4WJp
	LZfvBa2BNjPKS+Pi6Q6EzAAQs4uwvkIGPiaoKgyHQS6DRl2i/twapzEl0GULjGmr
	rmJaBFzgO/39uR502NWyiuN2kbuhxwQzdDqxKe1pKD9aNrtTjESXse9rgTuJkjV9
	qJZvEin5jY7rjKEVBi7H3FGe+cqyO3M6Ig5O7h9WpTxs/1BNNDm7Bm5Ss9r27JFB
	8RPUlqHPwCkPnuDJ5b5V4P7HyOPF3kldAvCrB4H6+iC1k3lTEEba93os2152WqPV
	OgiDenfeZznRRfeUFqrNazdn3160OPez5NggiSEG6EO8Y8IUN8quUW1RasM/uTcQ
	il9OWw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqvp9911-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:08:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8946f1b8691so24691036d6.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 02:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768990122; x=1769594922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R63zeNS1A4Z+sO68oWo8FrXbiTVs7VdMbMNjJB9iN1E=;
        b=E4mydxHzdBPWKi3xvIHZ2T/kBrjmWImpUnE/4XAGyBouCMbJRDPWF9SJC3G98zUtMs
         9x4ATWQWHc5P+Eu5mxwPEVUhdutLuJyCNyafA+NR5AkpIRtRfu1E+xrvTwdlwbcdt5q1
         6tKCEqTe9T6pmmL5m0hSDahlwiOHSbfpm8pFz7Zyq3zsW6VYYRvuP1YONI8MGYGg9lyT
         x2zT8fDVWbb7jMrMllFVLODDzpCcxjgdN0kqOIbJCQtUWckSmxanVP8AZkd46+XSoD3O
         Yb/Iccg56qrn37llyVeBgQ6H/2Ji4IxG/eUOxnbOWAJT/ZBEO9087GT5de1Nx5qsP5av
         YbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990122; x=1769594922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R63zeNS1A4Z+sO68oWo8FrXbiTVs7VdMbMNjJB9iN1E=;
        b=qxBEIRM2GYpZ2enbM32nTVPS62e0CT3dHaKiD4LYGyK31GD98yHnQQ5PmJQUABbLjG
         7DrLd5grfAbuOmacJxLziPSnxeddg06Dyy6EcvpgCgJw9nG3Z+u0hQ080ozkGZRteUAk
         ax5q5YBRw6T7cif+qfhdz3wpLjf+NVVCxwsFarn5UmGAcwY3LxJJbkx17fE00ZY6dKBN
         7KLbojOyEoe9n8lDoq8u4Cuccwc46oSkVF8JFFcPJsns+FDWQ5221YDtYRyeuEeqYQIV
         ocVKqgVX4Zs+DUMUyloOWXVs6l/nUk/FjpoPRD3R9bjtHPrKHcsZfajldsMV/bI0e3dX
         uCiw==
X-Forwarded-Encrypted: i=1; AJvYcCWtpWWEML2GMr9iW49a/QD3RYj39GQCyROlCYuaw7BXQwaj/w5HxG7hbXyERqNgQVky9kK1nBFEsPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsia1dKIBLMAPEjo6gJJzLopxOgZa4PBWdRSNNX0JqXXKEyCW
	QUPW0M3iLJewFW+N+c71A/9BFXlu5le6cGhVtPuHIR6rz2ZrCGLimVYFZJGkmqk8FY1sWMzOOaV
	qvKNoAt63xTgxMHsrJBcsRQg72XPk8Nac0hLh5rbEcJ9uu9Siik23cmOhUp4egxg=
X-Gm-Gg: AZuq6aJeXCg0V/+U8+r2TOmo96mkqGJ3eCbm2olZgTXxIPfrzwbHRHaK0py5apBOM1N
	h7+M25NhH0xgeyU9K4PsHREvynKWIdCTxEuvrxDn77otBoOgcPd4wNooD61zkY5pXR+LUI9lNM2
	Gwb0vvJ9g1HPYaGIjJiAFHJpKI/G+GUezF7iSG4PFkyTiSUHGq1b3DmmzbEtKcZp+cdOnutDFf4
	gMYaR4fxtlISa+m6CsV/qy1yO0RM1poGX9giob4sIFXH7Y/fNeWEKlyN8/cYEQmDXeaqZG/Tf66
	n9YiDbh6xnmw2FGlKUsj/Ury/rvQ9woAYUQPbAr6xK+kMj7HJSP5bNdQSK3/iP+jmhRbjUVIKYa
	AQ4Rek9e0Ur+wXccWggchj1y+sPS33h1Z/WU3YOx/Nw8+XXaHJrzTHhBBrU4MQTafMKf4qmdM
X-Received: by 2002:a05:6214:230d:b0:87c:1d9a:d0c8 with SMTP id 6a1803df08f44-8946388844bmr62930216d6.27.1768990121784;
        Wed, 21 Jan 2026 02:08:41 -0800 (PST)
X-Received: by 2002:a05:6214:230d:b0:87c:1d9a:d0c8 with SMTP id 6a1803df08f44-8946388844bmr62929796d6.27.1768990121368;
        Wed, 21 Jan 2026 02:08:41 -0800 (PST)
Received: from [10.111.169.82] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm103910141cf.14.2026.01.21.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:08:40 -0800 (PST)
Message-ID: <d15ec6f6-7978-4e6c-a752-ffa8a44a9e13@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 18:08:31 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add CCI and imx577 sensor support for Talos evk
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260115-sm6150_evk-v3-0-81526dd15543@oss.qualcomm.com>
 <aXCiEyyu7mcx0YhK@zenone.zhora.eu>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <aXCiEyyu7mcx0YhK@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SUuNLwOF4WZPU0cU2yUoQSmvfVM5Mt_e
X-Proofpoint-ORIG-GUID: SUuNLwOF4WZPU0cU2yUoQSmvfVM5Mt_e
X-Authority-Analysis: v=2.4 cv=cdPfb3DM c=1 sm=1 tr=0 ts=6970a5aa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_YHlsWu5nELmUMumn10A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4NCBTYWx0ZWRfX846swCi+luxq
 lLTwxYaNZqvvwSLFhlgZYAaHw3ID2qYYIiSjxJ7H6Ro5uwwGW6TwzlKx/DqIRODlH0RwFCdr1wp
 z2k7MD+MNE2+817eJFfWu97myqk/d42jiRDtXdy/Zp8EXXrdQ7p2uuUvgW6pdZ/7XN4J/RmrXwh
 EW8P5FXnDkS682X+PLYemUbzdhKFD7gK7RHzW1I6Pur0bQ3Qf86OjcuZuVoD2EiX2a+8uq3AIxl
 fTpUGI6UXUkhOm//Cv/Q6+yDCoMyz69fp/Nv2aWhEp+5PvnNqvcrjiw/ViI07lthG/8HPittpwe
 8ONLIo5dGb4B/n+y9d87bEv35DYf4Rk84s9uPeebp3xreKgHeJ4lvjbmpIYIwwVGhKNWsuFdkjM
 EShXYJj/YrrxMVCRRIO0/5YBXUuc0m/Rnlx34WC+KM2iejnhCVW3u/9ixN5IUrZSc2DWxiA7Eqd
 s3DHN5EKpBOzDi1qbQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210084

Hi Andi,

On 1/21/2026 5:54 PM, Andi Shyti wrote:
> Hi Wenmeng,
> 
>> Wenmeng Liu (5):
>>        arm64: dts: qcom: talos: Add camss node
>>        dt-bindings: i2c: qcom-cci: Document sm6150 compatible
> 
> I assume you are still going to address Krzysztof's concerns here
> before merging the whole thing, right?

yes,I will push next version to solve this problem.

Thanks.
Wenmeng
