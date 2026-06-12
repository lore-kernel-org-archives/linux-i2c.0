Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4838838A
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781238547; cv=none; b=G5bdMny57YFeAiJ7p8AV9yJkTVyLaJhrJTEPzZUP6hfQS8tNBcBWJQUQn7OWA6UTzRYq13408akk72w2Gpt5I7hYEFsZttjk22nEa6yY55aY/ORRaz3EXeE2nF8POVA7IBFH6Lj3uhVrLE9AXgOkgCFNb9b6yuFFgKXQt6xVf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781238547; c=relaxed/simple;
	bh=Qq3QPHQQplIj6vQL+RwVx0v0hCi7JnuK1p9NR1v+1HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9ZBtqHui2+XifrEBx8a7oUbkttv7yOsCL+W1HILZyCH0jpokeArGYG3v1H+BKHOXZV03flYYakGq4OqGlwFCgl2ChvLNcrL28GrLTwPMZZEeWjfoEL0b5hFLfh1QIDLhItiSdya1QpkIv0rpLuWMmLjh4PcXOltb3Ba8TQYk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeNuPdkj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OE5KSVAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeNuPdkj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OE5KSVAK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3Bq3r2401901
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 04:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmNdWicmYA/hCWOfkYARYqJaGdXG2iYDvY8C9/rp4bw=; b=jeNuPdkj9czCH5HS
	Qt/sYulB+z5oP1QJXs2uwCW5tjaz1/QC5zHG5zG/ouxsZMCgo/zFXi5AMzUI3kaW
	Tidbokmz2FhKgBRrloIaek3XOLVs7HFbdvIXr5LV0klebXwQGtgh0aTznMcRZGLS
	Jzq0L+adYfkhdzni7WrAvoqtkjqCH99MkXju/iRzPwC9CWQb9b/0v72h5jnz+TfN
	UJ977nI/ixrn2D59bRs1M8aPtdcCWQoKMKn3RO7lfc/ZZgPJSfHk2yX3a3aCWalI
	F2hyK1MP99EXqPY1s5hngemSs068soo91mr755/CwLObP3U31/5bGydZVkEjfuOi
	ZI/3Lg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30g9jxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 04:29:05 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842446a3851so338559b3a.0
        for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 21:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781238544; x=1781843344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmNdWicmYA/hCWOfkYARYqJaGdXG2iYDvY8C9/rp4bw=;
        b=OE5KSVAKWlx6vnVLft00DR0uO/adVaZZ3icZLORGW8sLQHJ0akG37TeLLTHJf9izvY
         zbNzcgBIxOUSjJ3jLngw15J+hUviYXnEDzlG2FJ3I9aMdOqzkp65nM4eXQyTNrsMOnA4
         i+hpiaJ0YPk7pwVNLQFKz2Uh29U/sb7dBWigsgAB9jQa5RjUvOibMf5JE+eTP86Y1BmU
         SLu9/Vdu1ogl7cW4EOGEt3rQPkkYlpjaO2QMDoKTetXORLCVOcXsPz6eG7rFYTdzJVYl
         y1DCZ0uD52oVyhZI7CKQnnDrYEAZcE740JfareTOaiENlDKDjtigYCHnRKks7EYsE6zS
         QIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781238544; x=1781843344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmNdWicmYA/hCWOfkYARYqJaGdXG2iYDvY8C9/rp4bw=;
        b=eyoknncpIGkwuva9/0fmgSNwJCVGs3zyi5eWoi6dJTAi+b0ODenF0m/HCzmJ0YoFfW
         jNIEYmF8E60NaAMMIVudi30MPH4KdBVWjjUl+T9ZbhM5s4Y2hZ5nXIZ0FUCPR94d9Xc6
         lwPh4N7lCh3JswP/3S322z6l6BSd+BExD/NHcABimo3R2NNew5Xr4un2TzwlpDd8mJwL
         i99O3YOHzB+alFqxSyeggnSHskzP9Fju9c5njOL90K7amErjnhwx7X9+5aX4tuvkC51a
         cOUSX7W6/e7CsD3w8aQltEuukDKiuY0AMdXgLy6YZ/5vGQNsR7q1iV4pFkYNKtct5EB+
         4sng==
X-Forwarded-Encrypted: i=1; AFNElJ/BHFoa5VsGptWAegeE+bhBXlUrTxJSt+HVgNUaMsYp9Lh/3E/s73tOIu7io4BikbZZoqht7Nc1Cyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETqEgYz2WsQW6cX26Nf3Q3kaRDyreFN6ePK/eTTflhW7wXWC7
	ni3B96zrhmw+wwaZ/NtWiCo7yzcXNISisx1i5I8f0A8STer3kXSLGIzXcdOcKczzKg445LWhRpd
	yL674c6pJWlm7Qu+5MzbBq2KCwa3nVm4oNcdVzOAWuSNbEP5cDuiZm3rX60FgVNs=
X-Gm-Gg: Acq92OESHJMc2Zn6jFlCrSiJPMxyXu+9JlxK10tcowfAIKN1h44vwzauVpVRgAu8M/R
	ouUXhL8ly/sLLdVg/QPBgI5vV45x/PTaz0XIzju91io5L3P9KeMBAkbsAKGkjB2RgEY5+wS/VMZ
	JDsmrxZbckN1KPb7PwXG6HUmFr4b/rCHVT+LH8yVk7Oth4FqlqV7MNARO7FTfP5177jJsmn7SpQ
	b1tPBYB0Ik14dowzlpixKsIH+2+vhs7m73hVY5mSGMY47/qTs5gXft5quw+uz0ozI48lJw9ynmI
	FnDowe/htsw+tt9BlsT7hP2CnkI+PxZ4bhYnBSof+SEvv66UK2L31tUNkrVK6yaAXMG8LmoO/QG
	IELscEsF7Gao1+Vxqbt9q4K5R+aFthbWdEbLVQTtMvGbRsudEiVI=
X-Received: by 2002:a05:6a00:22d1:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-8434ce0e251mr1229400b3a.31.1781238544379;
        Thu, 11 Jun 2026 21:29:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:22d1:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-8434ce0e251mr1229378b3a.31.1781238543954;
        Thu, 11 Jun 2026 21:29:03 -0700 (PDT)
Received: from [192.168.1.11] ([103.211.19.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd50e6sm711452b3a.30.2026.06.11.21.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 21:29:03 -0700 (PDT)
Message-ID: <ce7a9067-bde1-4989-81ce-c5663a20ad32@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:58:54 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: media: qcom: Add Shikra CAMSS
 compatible
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-1-ca1936bf1219@oss.qualcomm.com>
 <20260608-reliable-vivid-stork-f4ea6c@quoll>
 <ab1055a2-6916-4083-a360-62eb15171fe3@linaro.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <ab1055a2-6916-4083-a360-62eb15171fe3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAzNyBTYWx0ZWRfX3X6JC0nZCpJn
 NpsTEv5q2pZX1OGksmLIsQD6R2owPlM0WsDkeOVZeq1Ch3UgdOqJYaj3wbL6SbWWtFNxn9q8BXa
 OFducYSlQieofM1PBOhRiYnWBiKhS4M=
X-Proofpoint-GUID: Zo7FTSpQoqCHBVcDG7Kxh2zTYv2A1cjI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAzNyBTYWx0ZWRfX6m85+j0CuqF6
 qTSbIO1pGadyUp7O+NBXdWi6RD4QXqR+2G69XrsBkOrWooHtswlwKm5Xl8ULYJxlA221a/Y2AJ8
 5kzxm2uGqECUjAf5QNsttJENjNY4MMM4aKbha+/NnIk+fYT57A0pMVeli4oGrmQvfzFQkizF5MJ
 z+IYOFZ9BmuE7CAmd3jcm+vloVqw/gz/F77zdBiN0eGirQTuou5SLnII4qqjQg1PUiHHrLFWNHY
 zz3BVJGXKTaITXgeYPyZU3fMb/415lGzbtwZume4Gat2vX5lZk377D4ufJSsB+E+L2S4rynTgj0
 +Ue4IQDFt3+95uLafVqZMLbFRonyOPJkXDqkH5MABo1ac6LD21sW4zBv44uFNiTC+6l6fO1ILuj
 CGSG3lE/t6OO+GyWCgTMRFlB7tEPUGpsoS6l1MzBPJoMm2il0JA56bk5v36Kf4yRMgLfNKEZmSk
 zeZTmgbQwmizjvSSuVQ==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2b8b11 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=RuEr1PiGI7RNW/QBahnYvg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=OmvEUramPnncoLCXQdkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Zo7FTSpQoqCHBVcDG7Kxh2zTYv2A1cjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120037



On 11-06-2026 20:06, Bryan O'Donoghue wrote:
> 
> @Nihal.
> 
> If this is the only change you get asked to make, I will just fix this up on application for you. There's no need to v3 the series for this.

Thank you for offering to fix this up on application.
That works for me!

--
Regards,
Nihal Kumar Gupta
