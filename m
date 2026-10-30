Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374154;
	b=mPAY6SntQNZl7hd2HRVA+Zbt1G5w4b+9OvuHXGGd0VANhEoR4w3++HYsXJ2cEK+u5WvL
	 M9Tre2BEQbz3H30ojq6iF2ggx6iOpdJNCbt4U91RGSee82LeAmlKL0s5Uxki2y2UN4IUC
	 DCVXrFuIYQ7+hWsxCnIg3zTYsYZLt6Uk1s0Q8qyYx/5WXqTnKkd9wDsBQx6EghHTgRezG
	 Bi5cTNAYuE4cZwTyu4tsYjMmcKiQOMFD16p+S22Z3kqmG/X8M7Q1nYR5/cXsrmToPtkIP
	 9vk+mYJl950PEBDCJ4eS7m6zjyJLv8z6/+f6IRrnbxVF/iK9ZyF82tiEf1GEXxk41+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374154;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lpfxxF1BXeKYsOQeqaWCrwdbveAmxjDzeY39sdHqnnY=;
	b=XtCezgdVtENXlQWPWtSBzqQ2E2M0WB34tuqvTZx5fgdWtiYxopD6nLVJoSBMTjQkXHW5
	 5XfOD5wfNmm25IdHXN2BVRjLbOPnpvEDFI6Vi4VhndKkClSmXNuViAvMJC++lzR1JfBky
	 wWdcJJxF9dRemzDue+jgFX5XRODyt0vF3E1AAbo0q2iJLrzTZzPF++hpVdU1gTICVeZEg
	 v51XZBSHP4cLQQG890hzIBEDvWmh9Uc9AKKdvYYnVB5adrWqMqh3ZSqUzT+Xstnb4rxb9
	 ygTxPI3pKAbh1ltAw9M58CcKSP9TZPSwyHox1NUfoxip7DP23Kib/C4uRhIZeJKgy7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF2zeuvs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjGU0fPd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0020606A321
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0020606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF2zeuvs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjGU0fPd
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERDqr3564437
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lpfxxF1BXeKYsOQeqaWCrwdbveAmxjDzeY39sdHqnnY=; b=bF2zeuvsw8xTU40d
	HT3A/yDe4WC9oljx4DKP+7HSiqoE9+lGkf+ymTN21QJD480GTyQ1CJtgBZB3qrHU
	ImLYsqEaLETN8Bf3czzoU4YN2cyGFE1+OuswgKdL3Wb17SXpYgb7UYpW14Lz/qxe
	yJK+863j/y17yMbvgKRvcWSZX/dvSVqxQpCk1aoFQGpm8WJqnFL13Xbj19Y4SZFF
	mK5KdJyby1L3t8TcdmxyONIf3mU+G0I984B4n4ksG+ySVoLL05k1v3iTvqXL56fe
	RflZcfEETNCUegj4fE3ge8WiWNvwtmiiKtTOX/I057m+pb0IojphXTVCyAxB3sOL
	USiJPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkqq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:29:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaae62796dso10830275ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793374152; x=1793978952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpfxxF1BXeKYsOQeqaWCrwdbveAmxjDzeY39sdHqnnY=;
        b=XjGU0fPd/FoAjh95t5/VvQCDs+5TxtUzwmlg+vVR6Dpxf6XDog4JHmvr9vH4te1zW3
         6NJ1VUuC+jf8CbusDtfj0zFwmd/1PmAd/+qlSa7cpbmsDKR/Lw9XRyrka1TJ/tyRdWCx
         ZATq2yi2YyuSI2QUlFO4yINsS3HTRsnMTiM2qw4/XgitCmivYMn5LnoDdg7+J2vHWb6y
         kT+mYdgXV66stbpPUJ/hQzAHj2Mp3LA2aryyrKV1L8o37faDdaVDtOMsZ1YvboFy9Tym
         Cfg4LB8c4Z10Et12cQVkP3tIze7K/ab3efvtjqS6k+XcctVmPY/5TOt5wchMG074JAc9
         BGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374152; x=1793978952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpfxxF1BXeKYsOQeqaWCrwdbveAmxjDzeY39sdHqnnY=;
        b=kDDwmU4D9Q+Nhi5Q0V5StVMIFYmsPbj7XVXQ8wOZuuZPbcWKHUwzCE+DFk1TxTK4Qp
         HNHnUH5txbcSqJpD3PC8/gwin9nTkbrz4svpIvSYdysS/SGIwIPKC2V4yCz40mpaL/Wp
         PBIYJF6C03nhtWnRJlzBhgD+AiyKXWtEDA5QwuE/wLf3GnzuGZXYFdDu2c/LnRRKmAnW
         Vqsyl4UWaCgDhRJWiWENvgv1RBuqs0URkgzJQiwSH3dYzZQuu5Bl0G1HbeBR5ZXx5Wv5
         GGnIKT48zZsFzDxwRaPSm/Je+XLg8Yhq7RyuacF07qWsYGHEN2cb9yMQJYHG771tCydo
         5cvA==
X-Forwarded-Encrypted: i=1; AKwUvBy3KhGEh9RTC1uBM8Dc/4Vk6eqCrLfoVZ/A39S3EXqnzBqJrXtaUvaIF9B5LaeWIMxJfdiWP4Kvk8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYImaezbbmb936kzvTXrBMfr82e4sYgek61x+/hJ2itDUrCQl0oT
	4AaRMQG1wQIWshrJq7kTyUVb9DjPQ37RgfwYsQlWwJF6/c2jGToVJFYrOwL6L84q7kpH/OK9K5K
	MqRH/U4VwVNpqYlIfM9R+Mi6hWsgDTkMLUCfG5guXZRdN9EkFHESLgJb+k+uIAtU=
X-Gm-Gg: AYBFou0ghbB3ityGstzO0MbaKMcnRBpSP/qPqSGQFv/ZFe1bRLyybRPPhAZy91DJqRO
	TmPPeRNm3V9fqn80MUiyB041KFtO03gHUrbEJg0MgSQrT6g4v38CgiwiC6FobuapnOZSYTt47Ku
	fq/66KkXuXcRlYIaVWTRElcabuyrkJatuMZ6N8EKUM3WMAiC6MnGSbpVFCji2xArKab6vyw91hc
	4XGhvabYZ0zmrk76472geUS11keNraE/Ro9UUUke3IkgAnzpdL04JxYpcl7UDTUuS7pN8te7muI
	DmQJK6W3Q5G5zPenW48tQEpLEvu1J6jKTHwBk3sYbRyHK7A6wCgeJBxJBFtIfyN+Jf5Z0q3o7un
	xL3nYQ4U1cO0a9B9NnOq+Yo29Gttc6/5eIDGDokDoiQtyqhvNf9sK0EFPH2eHz2ZPSVVa4m7pOA
	2IH805nVRKRx8h6GtE6AvCVBePbnaVVvYg+T6H
X-Received: by 2002:a17:903:3804:b0:2ea:fb8b:258d with SMTP id d9443c01a7336-2eb36401e95mr30024385ad.6.1793374151734;
        Fri, 30 Oct 2026 08:29:11 -0700 (PDT)
X-Received: by 2002:a17:903:3804:b0:2ea:fb8b:258d with SMTP id d9443c01a7336-2eb36401e95mr30024015ad.6.1793374151265;
        Fri, 30 Oct 2026 08:29:11 -0700 (PDT)
Received: from [192.168.1.6] ([117.143.160.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392add5dsm9202195ad.68.2026.10.30.08.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 08:29:10 -0700 (PDT)
Message-ID: <7d443972-d4fe-4bb0-b758-49608bd27446@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 23:29:01 +0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
To: Bryan O'Donoghue <bod@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <23845ad3-dedd-4e24-803b-5abf3b030c4a@kernel.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <23845ad3-dedd-4e24-803b-5abf3b030c4a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f5AdBI1t6vSxOxXXMolTFUvmxl_RFamM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX9/7YBl/s3TRo
 iCuUVqKmbDqwICyI5bDtYNhFK8BBS1J/G8aO/GlpEf4morTGmmbw2J0xqAdOb7Uj9dPMoU8sWta
 Bd0TRoW8NMapWNGYQPIIOJW0WJHAANw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfXx2XWP2VRoE38
 h+q8k7DmTshfCQiHxi/SvSQDYJnS4r/cDHCuuLC/o2cIDvEZpnP6idP3tKdHy2YWrsfdBUX1ZWt
 3mwALijuHzdw4pilqaFhcvyZoPJo0YR/p2Lv8XPt1DexoGwRL8snJ6O0YQf+1zKtZeRA+cxhdwN
 Ytzl5aKccZ6I/mwD2aTMRkgCyBq9nK/sdoQgnp2FmS3K7+lf1dO040AIv/TYZUyefh8gFcPg7gm
 mt/j3QDOu5vzYyQTUhKYNP7g0TS7aPitv4jWbEpV0ywl3fIMvsK8GwJYR8Eu6LJ211P+Kqwxq1G
 zUod3Ayuv2aVseVVtxjGYpRSt+PmAl2rK3iyXAbOsMdp61X+Opk1zNMd/XY/sN2nlMaOK4oJ8Ee
 zTlN8BJX1cbvO+RqL/37Nl35U4LMa29lbRswaDl+XyIeEhfP//BWnVIqT0Hgflve7fJQQtjEtYP
 fUA1zBEpAHjHblUGiOQ==
X-Proofpoint-ORIG-GUID: f5AdBI1t6vSxOxXXMolTFUvmxl_RFamM
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4b7c8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6d0oVIyUxUng7TJeo7N4IA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=l-QsVsxeav8zdcdG2uYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300061

On 10/30/2026 11:05 PM, Bryan O'Donoghue wrote:
> On 30/10/2026 12:43, Nihal Kumar Gupta wrote:
>> @@ -6113,6 +6341,7 @@ static const struct of_device_id 
>> camss_dt_match[] = {
>>       { .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
>>       { .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
>>       { .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
>> +    { .compatible = "qcom,hawi-camss", .data = &hawi_resources },
>>       { .compatible = "qcom,x1e80100-camss", .data = 
>> &x1e80100_resources },
>>       { .compatible = "qcom,glymur-camss", .data = &x1e80100_resources },
> 
> this insertion makes no sense.
> 
> In fact glymur should have gone up the top with hawi underneath it.
> 
> Could you please remediate ?
> 
> ---
> bod

ACK. Thanks for pointing this out.

The compatible order should be checked carefully going forward. We will 
correct the order and make sure Glymur is placed above Hawi.

---
Best Regards,
Hangxiang
