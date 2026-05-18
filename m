Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A6313E3F
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092162; cv=none; b=kbooAw2jclAV2UM+EJ0ZgifrHyrnS+UhRirMxU7EEklsd7+D4dmgtjg7xYP7dMTXvCczTLtaKNuA1z5WXDmXcq4LlxX71X2ZXyLvPgKhzrVzPGCRROq+8NUv4yzVF8JnolIx3Zl6UTpkkMk0+7a5TgBCxaxEIHaXR0APM4/p5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092162; c=relaxed/simple;
	bh=2EXg3OxF2j/6al05Qm53ULE8j+fAjq0a6MlKEUyB/Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIoHX2EBkYEXIE9mYayZTTAcdUgk/GYmXQdr7BSOWVwr+3v3n3VTfOCZ1CGHqSc5l29rSwmEqLRfFrKoMUhthY5ni4JYChrXht8hgJfLmrhbmGjeBI5JXHlZo0vYv0seKwGMoXtQb+s6e+g6au3e37UuI7Fw8BCb0UMtIUvRpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzhU4nZG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IP0YDWWl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzhU4nZG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IP0YDWWl"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7e4Hv2892697
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+BXVo92FUl9O6WDdoWVkgJNuoOJFy5KObzGmTx3Jm+M=; b=RzhU4nZGfi/gQBRY
	UzpruqOz7ulYoB2AwkK9924jVo+bHfw91xww8btYZ5DnL1emiCmiUPtZeDlYPufq
	qx1q9T0VtmkONvwrZ0R3EgBE/diuHpPXkhWWwydMx6rR9wk2ZguQfxjSGLMet6hs
	V8rmAyWPjC/UphPxxdtEKvtggkBrPtJFGGK7UMhRSSPVQRRYxmoUpLz3IL9nkvEk
	GOhrL0uvgvQGAqa8GEu6um+dMec2w0VPb324CNXgShU7PKpZd/x6ewAnBa2Jifb6
	IdOG+g9Jhm140Klp8h1RhbwYf4whuJ/rsVwTEHnEsZQ8iqNXU58oe9ivnLzx+nQp
	f3vsBw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk18575-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90f5edb7516so23106685a.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779092159; x=1779696959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BXVo92FUl9O6WDdoWVkgJNuoOJFy5KObzGmTx3Jm+M=;
        b=IP0YDWWl0XGpxOVycwEuiOTNyYNXzWsfJoBY1Tww0Rp1xocd4QBHhEQLaHbuc9oZii
         elQ6Erl5FwqVt2HsThTjRmqJBWtUb5tcmB9LG9zKWZOsleDwp4QqQniX0lUZU4PWg9k7
         PWuL8pa+qlhbggdv4IPxPWtlSgiNNVnlQJRdZgQ0OLd3xbPgqVPC25YRCujFNp/TT+Sd
         c9m/ebyZPOBqDO98xprR60aW+nnfbO0AWT7hRrxir6/ZJ/c9VWuiHNjUSqsny5dXTZXh
         +6jVxf4xUJ8wgJhH/7irst3iGWLb4c0gZEYqucB7nQSYLComkmeG3Qfhnc3goIxyP2Gf
         g12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092159; x=1779696959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BXVo92FUl9O6WDdoWVkgJNuoOJFy5KObzGmTx3Jm+M=;
        b=kmehu5Gv3X3uwFh9DevOpIZy6A7cI7p3YyX3N5LxTyc9x1u76p/CVNqBMaDbfcQhEp
         QCL2QdhWxVrCGNuiTiBWChdJ2fzD6H23ebsVg6gBAWvy4rcSDXYqzV8LKCs7YbLVfUIP
         UXNJLvmf3VbKN81iMGPe7dbnsmtPXXb7fXGjLcDuN9F3dPBjOI12r/4HQPLvC96HWK3W
         ia3ow1C/sPjCWIYG2S3d+BOZdRN8xUlQrMMzw3qrLNhqEhgLFlaLe5SwTcMOaCp7FVZs
         kYps4mhbLOZldNHzepu2GKzLdsfixPrPjQw8bR8w++rZHPxYcYG2f8sDX0byVhNT6hbd
         mk9w==
X-Forwarded-Encrypted: i=1; AFNElJ8SQ5RthRaPZ6hIfTImP3nSqtTcWdF+wNXGS+SvFuRvhqgmP1sKanO5jGFvUUQMDiVqxyJ6N4NgQJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyED+RapUTyZbJMnLJdGZ+JkvdP2BcK6cEDBJsKd6uMBT/8Dxjc
	srip1qBqltPjNoamgjNO3SQPjlmz3WcbH6C2+aqBH/hwHk7ZClfYyGSnhTxzS0wKbF6Q6q3V24P
	kGAvXizCKtKIyq1798i+srIrTmB8AjU8oFBq6KyXSU319xjJ+pvfu1SBcI/Uar1E=
X-Gm-Gg: Acq92OFNPDMO5Qcuns/AWQGgpbC897KAy7zIJZqVaNAyfmoYax3Ue2lgfFLahRId5Oz
	bTAVmeANvsGFAb3isAgxxHHNYeABetd1P2Lwnd5SvFrviNHuVul/G8wDam+7ku1i8IuvkbZ8fMo
	EzdbLYca9sYwAXDz4TmxOi/27m3W1rvFwRB702Zj9o/dYCC/MKbYI/Ypva5w+6moLohDU+o8fcY
	Wg0/NhwFDS6xwjqCi0M5oEzpcySLMbhT44y/bgF6Dx5XsFqiMHzeRH9VgIpvJ1EZWbPeNw/T5we
	tD0ur4E0kMU/mObpYcwxlCpyC0J69bCC0bqKIcAeONqJH7pY9BuaWJTPllsrrBZ1Q+o+V9vRRIA
	wzqpekFLTnLTCLi6HOCCqwfaubucxuZbzqCp6s/Y/YhTSAJSEYMPvAbXqJlPQlPC+Tl2/dmvF86
	qetdcPgQICkGP//A==
X-Received: by 2002:a05:620a:1997:b0:902:daaf:22cd with SMTP id af79cd13be357-911cae16edemr1370910985a.0.1779092159170;
        Mon, 18 May 2026 01:15:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1997:b0:902:daaf:22cd with SMTP id af79cd13be357-911cae16edemr1370909685a.0.1779092158754;
        Mon, 18 May 2026 01:15:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecb7sm4807181a12.29.2026.05.18.01.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:15:57 -0700 (PDT)
Message-ID: <365af59b-e7f1-4450-8ef7-77aafe6c7028@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] i2c: qcom-cci: Fix NULL pointer dereference in
 cci_remove()
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
 <20260515234121.1607425-2-vladimir.zapolskiy@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515234121.1607425-2-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iIMQLIKPg4C6_9TYAoLbZFYSQnV0vWGA
X-Proofpoint-ORIG-GUID: iIMQLIKPg4C6_9TYAoLbZFYSQnV0vWGA
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0acac0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=A1756nShQ-hiEDrWl18A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OCBTYWx0ZWRfXwBdNNX9RoQKh
 K2VX3QQ0jTWmErLz5TASHXDuyY4z/hA7gcl2iyUNWmqr7saNemG8oEx9D50BMts4yMarkEpvY7D
 Q/MODG7McH5CPDzH4lEp0RajuEeasTX8pdtf9q6lFUNMUkoQYNKfFmz5Uhgdf8g4tyXH6HyEYZU
 HXt668Gj/BDKLg3H+1ma8k1BmE7SzWsqsxM/1M+1Cf4V3wK5bkxKvV2waSxWtZ/qa/gSDhnczPk
 +vVZXt1+1+8tp6M127vROgckJTdmbCcpxkw0iFWB1U0Ng0njP9cWUO2ivr17QYmpsER46vDINZN
 yJR3wVcmLM6kI/yWIt4xa8rLgHdpIUne5MWicDP8NGOBUknIz28/m3dskpjkgjS4FGLAliUlZec
 3YbXJxE2TlL7cmY0TOlHVXxkcNnyR+cQLoH87gfckq9QEur4KS8rxeXVo59Qxtdudl8hLQdng30
 3PSugWsnek6zI2ft7MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180078

On 5/16/26 1:41 AM, Vladimir Zapolskiy wrote:
> On all modern platforms Qualcomm CCI controller provides two I2C masters,
> and on particular boards only one I2C master may be initialized, and in
> such cases the device unbinding or driver removal causes a NULL pointer
> dereference, because cci_halt() is called for all two I2C masters, but
> a completion is initialized only for the single enabled master:
> 
>     % rmmod i2c-qcom-cci
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>     <snip>
>     Call trace:
>     __wait_for_common+0x194/0x1a8 (P)
>     wait_for_completion_timeout+0x20/0x2c
>     cci_remove+0xc4/0x138 [i2c_qcom_cci]
>     platform_remove+0x20/0x30
>     device_remove+0x4c/0x80
>     device_release_driver_internal+0x1c8/0x224
>     driver_detach+0x50/0x98
>     bus_remove_driver+0x6c/0xbc
>     driver_unregister+0x30/0x60
>     platform_driver_unregister+0x14/0x20
>     qcom_cci_driver_exit+0x18/0x1008 [i2c_qcom_cci]
>     ....
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

FYI I think the driver currently can't really cope with master0
being not registered

Konrad

