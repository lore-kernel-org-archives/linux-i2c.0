Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FE4A21
	for <linux-i2c@vger.kernel.org>; Sun,  2 Aug 2026 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676706; cv=none; b=bYtpGywIcIZ3RjPp6wLn2WhnvWlrpCJwg1+rZISKfqbTKEmFz4LAov46LLCFXhbolK3F2vYxhhbQPtgHh85YSxMLjBT3L/qleayptfdpTwoBZCm+wEnip6CbNqVrYQo2jmruBvJvsqw66PX2rLPiyyGg0B7gsW32HxhqArVZ9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676706; c=relaxed/simple;
	bh=d/Fx7vr5Gj4NRWLzIbzD3BmFIev3xD3vcFIE1MI92Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKw+MS0tqkpVl932Xe0AXj/lQ8CFHzYlyoYsHDrUzA86NLC+PrC5AdTZbra6eD+faFWYpaoPu0kqMMOEH8UjUmCrb7wRa/gZPpqVwPk8oa1kFhsTdGKd9sdgeDWcAstEg8+iEJA5FjSf3Xia0Rt+wGRUU4mlM05ZzBaSg24qHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HcvoorLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a5mMWaMO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HcvoorLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5mMWaMO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672B6ZZM1278357
	for <linux-i2c@vger.kernel.org>; Sun, 2 Aug 2026 13:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mYhYgtxNHleIqvPyf8VrDc8vyZ6Z0g2F/ppx8lw59ZI=; b=HcvoorLG5U5Ylkbm
	sJDRyZraEo7GWFuHrMU2YMgwGFVW7jyJa9FxIBO8hdFtsLZfjdILiHY7Ng6+D7w+
	s//L6G5QBpGFpGzzWLh/oRnFRg6+Vs92nAAx5A2PcBw6mmvByFWm5uNgGKHO3T9o
	S8qkt50xwyFUZ3yni1FOH7PEhT4Q78NvhquJXxb/5ocs/TYw78FOixiQ5EwI1qPb
	qnvnfIl3dr7p6nv1vhO35Xu6HIRfJQm05e618MUH9e6PgRbUR/dkCpGT8KcavWf+
	8FHr59yv65XBn6essjmr6GRwXRuIRC62UGsx2kyvz3N7E5YXe9P03WoMY5KOalD/
	adDQ7g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fsa382pm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 13:18:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3850958a12.0
        for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785676704; x=1786281504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYhYgtxNHleIqvPyf8VrDc8vyZ6Z0g2F/ppx8lw59ZI=;
        b=a5mMWaMO0rE2mz3tnnC4+FfM8Eczorw03mmmO+EvlmWVip1KI28NrcetzArJYUiR0L
         nrJFOMlGT+qYXXcXumIz8yF4uHozZwIUBR02hHQQu25qsiVtDY47OKqEDvVRbwXriy+E
         GOUcpWrtoy/cRNRis7K9fO0OSL1smi5l9nGb8vSs7H72GW1QZoK23I2nmCAkFepZHUN9
         BPhwSt3+RqRuIvkBznMI/VXq5lh2EtmycnFJo4F6RN7598M/PF4dEcBczd57MmN92Qtf
         Zrab1XnWe2ZXUyY2I7fqLVv5xK/hSFoAh16itW9HqWARSEMTLn/QXZAfYVz9mxIKFJku
         r19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785676704; x=1786281504;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYhYgtxNHleIqvPyf8VrDc8vyZ6Z0g2F/ppx8lw59ZI=;
        b=RzwZ+pav9xg2s86CNGp5jOXEKgGumGtfQoLHBkBRIiA5Q+TAMbefCn3XFoDYIH4E0h
         7K6HbPOmw2sDx5JvRcbeW5XZN8IowEyqcaID59W3N7WWQNU0z55TvhKBYdASPulOx8vz
         hfTKK7WyYIjKxAGBVlTbtt0PL1UeK8Hz/lvqNRg0GsOdMnD/0K9FWPmgs7G2RQBpj04z
         unxsMvDzAfDuaHdAfiALpUCG8wyBGIAQaLn6Dntj27bfE+jBtj+wm337pM0q0mOnRG0o
         qXAgbKWMNM7Tf4okDmHFFdOQyy+x8fHdFOJbJwtIW0l2sPKPESRYAFnCo7Wmb8SNfSe0
         TfuA==
X-Forwarded-Encrypted: i=1; AHgh+RpliWCgHbZvFPmThwlXANsMzRMlVCVGObENEEOq7LNscUXO1FmyreSIxKK1/nm4TCIeQ2IZthdgZco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DPSqD2VJdf78MMgfzd1VxsYXkHBDBIFna5xQ4+aqxo2UuxcL
	sb5D0uYIiYuu/eMcRgW+eYXFQjdcRuYd1UUFlRE0wFzoLmcgBC9bY0Yd1wPc9r+I5k4u6JddvAm
	h+UQN+TwRyQHTLy5wgYl4tIkwb8TRi30WHBW+FOEzYMSh8kH2HZxrvSQ+WtrxlMU=
X-Gm-Gg: AR+sD124wRo3Ibnp6u4+LQmmgD5KiJg1Gii2R2345/o8uxn6NXGa5+rrSthw0z8M1fZ
	wLq6JoYib7nVZ7fdJbB3rLtpj2Nq63oVWnhiDa8MVpFzsTK4+7oMaVxiUmSmRu7Y9+ub6TdZMnw
	7Xig4oy6aTphxrd4JTBCfxsFkENBRpQXA7CgFdGvc8WX3uDTBw+5HXhlpxfn9pb/os8uAeHuaoz
	QO/Lq3fC6KJynYRS0M923uCLW9hHSRbmthly2qbk77rUygErtG32aLFhUywGzC79x6MzdpKF2Jr
	y+9jnwDiWQZEClm7sviv+SLw+/TAblZt6+BBeTC8hXfoZva3VhesYcfRfvkT13IXpL+4ogluKdM
	35WErtONIIHzA8Z47kyMw0NEpN/gHJcAL9AQ=
X-Received: by 2002:a05:6a21:648c:b0:3c0:9c19:658d with SMTP id adf61e73a8af0-3c92a89b8d5mr7024087637.71.1785676704058;
        Sun, 02 Aug 2026 06:18:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:648c:b0:3c0:9c19:658d with SMTP id adf61e73a8af0-3c92a89b8d5mr7024059637.71.1785676703654;
        Sun, 02 Aug 2026 06:18:23 -0700 (PDT)
Received: from [192.168.1.15] ([106.222.229.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5b0sm25810683eec.1.2026.08.02.06.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 06:18:23 -0700 (PDT)
Message-ID: <0405f7d6-42c6-4a55-b9eb-da537ee7c980@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 18:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] i2c: qcom-slave: Add driver for Qualcomm I2C slave
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
 <20260628-i2c-qcom-slave-v1-2-8b0a5c01f9f6@oss.qualcomm.com>
 <981cfe8d-d438-43e0-a2ff-13f3006f82e0@kernel.org>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <981cfe8d-d438-43e0-a2ff-13f3006f82e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KezidwYD c=1 sm=1 tr=0 ts=6a6f43a0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9c8ARojF9RoukzHm9jbkGw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=n1ePDE42uFpKCxzpWgUA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDExNyBTYWx0ZWRfXxwKwO7v98Y+X
 KGhB6W57+p2lR7aaebHqNK94XNGq/57JGjIi/bVA1jCojOtr9p225aOx8L5FcnL1wQ643XbOeLs
 vK7022uvzRzIDH4jh1hHYGQ8M/6geY8=
X-Proofpoint-ORIG-GUID: Meg545cFvV2hwAL6XFEA32RMoXaPVxXL
X-Proofpoint-GUID: Meg545cFvV2hwAL6XFEA32RMoXaPVxXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDExNyBTYWx0ZWRfX99802J7M6G95
 LMydDIaccAtroHbuaIkUV4E1yZQiiKIodeJ2sECq+ajypncjx6743L9bx/KnL65ZGyIVVyixdLC
 ZcAu3tFRLOcX9R4dCinrZ7vY5UxctYT1z7fu8yYylhOf7Ka7/f1P6M0g5AWpwImrDvbSeOHepyc
 vXQLX2nA0iNqrjdH0HzoLdQm4vUTIYFxbBC58s7CWl4MOLsMg+bGAoU07uIBX5CfVR8jbtiUJD1
 HYrMvTjlsGIdM9HAt0FjlwZZcZtCDj0/Zn1PHhRvWl9OKDiRKVElww20Rv4QvEe9T8x/BErig4c
 AYGRNRX5LU04ZVHCEXl5MSZRwbAmBEtrmapH5tFmKgA+feugjdSgYM1l3YEpNpyMVfP+PUR4Qff
 Nxy5Z+d+bKpEgebX6cy9ocJaC7oxmi6ez3kPmaoAVkmvjJPx4Xz+DslliM0cd8QrmRBzGoTt69K
 UpKH9XzmgewBm9645yQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020117



On 6/29/2026 12:04 PM, Krzysztof Kozlowski wrote:
> On 28/06/2026 16:39, Viken Dadhaniya wrote:
>> +	slave->adap.owner = THIS_MODULE;
>> +	slave->adap.algo = &qcom_i2c_slave_algo;
>> +	slave->adap.dev.parent = dev;
>> +	slave->adap.dev.of_node = dev->of_node;
>> +	strscpy(slave->adap.name, "qcom-i2c-slave", sizeof(slave->adap.name));
>> +
>> +	i2c_set_adapdata(&slave->adap, slave);
>> +	platform_set_drvdata(pdev, slave);
>> +
>> +	ret = i2c_add_adapter(&slave->adap);
>> +	if (ret) {
>> +		dev_err(dev, "i2c_add_adapter failed: %d\n", ret);
>> +		icc_disable(slave->icc_path);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Qualcomm I2C slave probed at address 0x%x\n", addr);
> 
> NAK, as reviewed many times. Drivers must be silent and you don't even
> print any useful information, becausr address is fixed based on DT.

The dev_info() call has been removed in v2.

> 
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_i2c_slave_remove - remove the Qualcomm I2C slave controller
>> + * @pdev:	platform device
>> + *
>> + * Unregisters the I2C adapter and disables the interconnect path.
>> + * Controller clocks are disabled automatically by the devm framework.
>> + */
> 
> Really, what sort of coding style is that? Since when Linux kernel
> writes kerneldoc for standard driver hooks?

Acknowledged. All kerneldoc blocks on static functions have been
removed in v2.

> 
>> +static void qcom_i2c_slave_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_i2c_slave *slave = platform_get_drvdata(pdev);
>> +
>> +	i2c_del_adapter(&slave->adap);
>> +	icc_disable(slave->icc_path);
>> +	/* clocks are disabled automatically by devm */
>> +}
>> +
>> +/**
>> + * qcom_i2c_slave_suspend - suspend the controller
>> + * @dev:	device associated with the controller
>> + *
>> + * Disables the interrupt, releases the interconnect bandwidth vote, and
>> + * disables the controller clocks to allow the system to enter a low-power
>> + * state.
>> + *
>> + * Return: 0 always.
>> + */
> 
> 
> Please don't send us downstream code or LLM generated slop. There is no
> single driver written that way.

Acknowledged. All kerneldoc on static functions, probe/remove/suspend/
resume hooks, and internal helpers has been removed in v2.

> 
> Best regards,
> Krzysztof

