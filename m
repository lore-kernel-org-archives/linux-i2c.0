Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FB33A9CF
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775910; cv=none; b=Jz/GxeaK96Ty92PsSMbGQZJtviz7yq+xrenTTjlllUvS3fBiL9+bO/q+AxAj9ZMviuKNDwuXB4Kja19PjbIUkemhw2ZtaskxzuvEyvplDTTgsSFwex395VEsz+IJlRln0G+dxKTUZmdE6VaPZopoiEjg7nNxLXbVfMOnCp2jGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775910; c=relaxed/simple;
	bh=Ox96qHvn47+bpDeRKjnqV2scGXDoWxEm9KijiBs3wr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcD6QPQEcJaCOp/TmRNMBrg2dA+SyI5A3ctC5zPvWI8uLSVZzQYvziVbvPM+dxNDdRWsosCOxo7T6AHOsGKETAezxC4e6YOP7G4BEFuTIp7TrPkSz8lkNb2PindkAk5gidx5G/cU3Gxkhn3A7xdi1PTzzprj45aDjo+L3oYeB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C5N2xAIw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azWgu7sO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5N2xAIw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azWgu7sO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0Wi8R2657429
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 03:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5HM0b+gY2t3sPr+G6m2re9kStqVxWC/05ySGuYZwjEs=; b=C5N2xAIwB68UaBld
	waSrddvYUXuTcmZIg6G7VczquzU4Soi4EQD6/pN7CJsfyWDek85js1qRPwQYMrvK
	Z7RKm6ASRxoSRfuaHWLsF7wP2LVAwQhVDdCAzb+IcbhyInV2KwJeF7C7/3LLbeDB
	52W3w4WbvkuLuYVE/YhzpxMR4wr/qLJtGaOMz/OX1d2qM83VsgknvXLMTK4jDWg1
	21DJ8ZeTMYJaDylLNblMMxuvw8DhK6xCDaJRkWxty66qh+1z8VSE0NaZ7/pBWxwI
	AZ6wRu1rhqaoaimjNH+oMsuKZDfVr7UF0O43heotVadd60hHO0OZIh01k6uzeBqx
	fkwnfA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk7b50pb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 03:05:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso3435061cf.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784775907; x=1785380707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5HM0b+gY2t3sPr+G6m2re9kStqVxWC/05ySGuYZwjEs=;
        b=azWgu7sOqKrhY7pC+ag5xZYLvuzsi/zaROCzzZRV61pWs5Nn48q9BwiOdRrHb/NZu1
         8vfcNZTjSezYzxup/6iJd8su6Go6efJ/VBqYlgfOV/4OpDvMqa86/D+BFRQ1gV/0sIjb
         f3Z0lt6di2iMnNRUa0Q9SuPx3tlTOJ6pWV+/zL7L7DacmyUHaCHwuYlH9T5cNtIBF8do
         zGrnykGHvUtv1NQ2xRBBE8ZtnixztvLtWOs2BY9+FgkVn2gIOeEhHz1GPNDkhe4JNINq
         shA1izurWqxNBUfrAE1tNGzisv5C1cKZtmQTGMqYNo7Bks/VYFPq+zTk4sUcGFn5NVz+
         zOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784775907; x=1785380707;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HM0b+gY2t3sPr+G6m2re9kStqVxWC/05ySGuYZwjEs=;
        b=qGLrHMqLzrsyQ5NOCsoAToLce/1O/l3Zbrok0GkO2x1Kw8P1/D4g1rPPZar7o8lyws
         bZKvcatw+LqHwEQos7LatGuFUK0JUsjcZG6dLs6l/d19tLZJp8V6vUHKq97DZ81YZq95
         BUX/wKDjCSu7eXls3m11xE3uHYiaFWFr8dID11P5Mrb8E4+urOruAfGRIkd+9NbDjSIw
         1PUlfmWblzpsup0ZnsmLBVCToKmRlLCuzZnEXe8kc47lWLpUASJshmEQCuHrSAX/4YPs
         g6QNbPm7eZS/QGN71dc9498CsSfZhP5SlRcwh0aQurMOMsu9gSWVCnQSKUq4t6m+t4ug
         zRcA==
X-Gm-Message-State: AOJu0YwEDSQvH3QGUa3uNwT9+f4RglmO8AF6dX7oqZRkvlwM91PkqOAf
	xtK/rd9E4RLjfqngBlGrOQtgvPZZ/T1Etn65YFPKygluqx6nXLqmrwVCbSFGaywTpaMNzt3cys/
	AC0STy3NWjQSe4e+5A16SvzFeq/lFHTMO+blMGUdVUIglEqY+re6YVanOEL1QM4w=
X-Gm-Gg: AR+sD13VNN+aL2L7UWUZwnh3yfXG4L/YB0JhUXJIJimistovnWbgp6w302qmyOgnqj1
	sdHiVrJu0eX+P28AZuW02v5wuzSqfRwKJ/ySKRJxpo1Gh6jAJQUrCSXSkWKYKscCokdzEt9sRAS
	Vy1DWrttqPiPfw4IBH1EWgAap7s4D09nSHiXaJYJcyYtbgwh/5P2/2zApJkpv3duoneCtDxgmv+
	TtbMJ/bbwErnrRD2GI6woW44N9ml/3EUUsjAR4pOqyxlg7A/F4ApKZSfEpJaa23tTa3E0qqm+XK
	Y8o9Qa0jupcitX/wJ+LEGsPnNbRfseuGW5VG4HJfGWsm69eoIdbSMnP8hTW8dYc3PrbWGYeknm9
	YlKka4SS+rp8I/3EHKo9UlOWg1PcNPf21fQ10WY58CwJBWmFahvF+jUxJB+04mXeN
X-Received: by 2002:a05:622a:1dce:b0:527:69ad:fceb with SMTP id d75a77b69052e-5283eaca354mr5740941cf.0.1784775907100;
        Wed, 22 Jul 2026 20:05:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1dce:b0:527:69ad:fceb with SMTP id d75a77b69052e-5283eaca354mr5740751cf.0.1784775906595;
        Wed, 22 Jul 2026 20:05:06 -0700 (PDT)
Received: from [10.111.167.143] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d066e84fsm27005551cf.3.2026.07.22.20.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 20:05:05 -0700 (PDT)
Message-ID: <236c2b1d-7118-4ed2-80c5-a5dd78b2834d@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 11:04:56 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAyOCBTYWx0ZWRfX74/GEhyvvq+y
 bXzxAQ4aipn7FR9qZXTWHVeriNOaqsD3dmQ8Xt5FJ4CwYgaxfT5uJXF7gBWhscklk1P96ghQ25j
 zTNcxxs+PunL7YzFh+OCuLBXAqZba1m/+Q7H2fyYEuQvBtAl99vDXPxVqpeIDBxZXRkv4S3tPpL
 UE9+fLL1IOawSgBTz7VjIy/e9QOz4Cg/t0JM0E1Z+QjuF4QqU2hbZqgKsCKiR45KpC1rvED3gMP
 wPnrNEyfLHTx8CRr+uZF4522m+Bm0A/c98qJVBRc0RidkbO01S1iP+wxvd3Z8B86U2B2Eo3CWG5
 T9hLcPY1CHqnbsJcaf6WXUy0lbSKKaW7v6mkqE8OuOloTZFDsqHg/lkos+OquS0gKZUZpc2aSD/
 +jTgl6yX88N+DWnBhotROfSeXgMU/hhu7tTsaT2MKOFmq/zWRdbqCTCmqjq0fJuNw2mIEg8WYRc
 OBh3VmylKUFJ5oqkyiw==
X-Proofpoint-GUID: h78j8LYCD4WrfPCdnkSHJBoxhoqoH5qA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAyOCBTYWx0ZWRfXwtpiI2QCHqvY
 d5d3JHmPvdQVDTKx97Ux3T/LkOayYlj7OzisnDomaTdJ7IShtod/LGH9HzcbbzknHs8cMT2vG9+
 rYpZ81o73PDTnAxuwoJ9F38ZmIWX4/Q=
X-Authority-Analysis: v=2.4 cv=btx8wkai c=1 sm=1 tr=0 ts=6a6184e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=oA7RtkSea3Gl-iE8cOoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: h78j8LYCD4WrfPCdnkSHJBoxhoqoH5qA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230028



On 7/21/2026 10:58 PM, Loic Poulain wrote:
> The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
> clock ticks and were calibrated for a specific CCI clock frequency per
> hardware variant (19.2 MHz for v1/v1.5/msm8953, 37.5 MHz for v2).
> Running at the wrong frequency causes incorrect I2C timings that may
> violate the I2C specification.
> 
> A previous series removed the cci_clk_rate field and the associated
> warning from the driver on the grounds that the warning was noisy and
> the rate was already set via assigned-clock-rates in the DT. However,
> enforcing a clock frequency configuration through DT is fragile and not
> the right approach, the driver owns the hw_params and should own the
> clock rate too.
> 
> This series reverts the removal of cci_clk_rate, fixes the missing rate
> for the msm8953 variant (added after the field was removed), and
> replaces the passive warn-only approach with an active clk_set_rate()
> at probe time, retaining the warning for cases where the rate cannot be
> applied.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
> Loic Poulain (3):
>        Revert "i2c: qcom-cci: Remove unused struct member cci_clk_rate"
>        i2c: qcom-cci: Add missing cci_clk_rate for msm8953
>        i2c: qcom-cci: Fix CCI clock rate enforcement
> 
>   drivers/i2c/busses/i2c-qcom-cci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> ---
> base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
> change-id: 20260721-cci-clk-fix-fe145b2acfa7
> 
> Best regards,

For this patch series:

Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
