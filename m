Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6A37A847
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552399; cv=none; b=JufKPow0zpYI50fYol2rNNp0nqj0D6tUVXoBHR9vxrlD4y/0+anI+9V1xBDcI7HdAVOayVqdSqKGzi4iUNe4WNnvvI0PMQNKzB6HAR+CtoX0FvC+CKgq+pSdYSnH5U03EdjzgYFL/zVwsLfTsEL7To7FxmQtAs1N4SPNkgF+nEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552399; c=relaxed/simple;
	bh=zhci3GeC4y3P5A9XMBDTzxBHiu9XQ7vIFjySCKubQng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBwV+e3DGtiRQcOeaqP9zEJ3ouSyxwzdsckvlhEM+1/vNoQZKkvXlF7FPQ0o90Fwr1WmScN6CACC1Q6LdVZ3wRGpvnhO2Fv4tOQHxhxRstaomb8xaNCjMwwHbPWeTJXBjoCdtZDYzRE4oeGtMa1kpZpB5nSK3v6MkY5FgMxEUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovXEU5fq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K1Csvwle; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovXEU5fq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1Csvwle"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RTO91577437
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 06:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oPNyJXSmM754bjM4+PUtlpBzKwKkj7QX9fCPtPpbqNo=; b=ovXEU5fqBkRByt+e
	t4drYvpoSdvP6KAbR709xhfrW2/3FAJDVfaHrFb4fZv2oVpOxqndyjjRbAqXvusK
	e9bgFAdtjY1UQeFXhF8+zT/iifPh/649FalyqzOsgxX2u0vWLDX0B0lkBmEq9sd+
	KpFePwjy2FpO8IFzxyhy2qucoxTrnUEE6XY7FOF5mrjz7sElVk8AbuBonRAvt3/7
	2f6Dxb17ORygVAZ13KWmNuWFAU+YlAdTNiz2mZf8bcHmJ0wMk2MFgMALV0kOogHU
	KERRIoNsmtbQbPUV6wEka6/4Miw/wnqaWKU6NenUl0soyKXwaQHRN4V2DGf4sSCn
	kv+Y6g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74hcwfsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 06:19:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso4118574a12.0
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787552397; x=1788157197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPNyJXSmM754bjM4+PUtlpBzKwKkj7QX9fCPtPpbqNo=;
        b=K1CsvwleezijSx8KC4WFypb2yaeXuiHI6Iamo5wnETWwHYmCfxVbqaoTVQ/+yaZtQ/
         penmQ9XvnR37oYDqmJkfv3qZtEilMtw5eueXDWI0w2CcapZLGEoVWjoz4EGvPdrN9fAz
         mKSk+KF4DhmTI+dmciUEb5M8RolRX6ewz3Wmj8Ul1eyj++9iGD/3+A7XrhaxKx2ItjIy
         1IGRQ6VG51JcLmQD7jUxaYryhYf3w4zQGP3e/5TLK6Z0bqPaQ1PSBxJ/PnJkTQ4ZUSxy
         23MFx8pdQGZqPVWKL/8sl5uotvK95++GX8nswh/seGb0noJE3mAepqa3UIrjhyIt1gV4
         ipQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552397; x=1788157197;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPNyJXSmM754bjM4+PUtlpBzKwKkj7QX9fCPtPpbqNo=;
        b=qXt8CsaZ/YatfFP+2ABbj0wo+gq2NbndZfUxsoFluuMmZnkyQicanC/FhRaeW15cSc
         Bd0oKwP/dKL9/5SA7BSZrhmargsw5hMS/x5bowFvLQ1fU+CT4l+c5qq50VUaEpMOsdvs
         zYUpb6lZouw1dQIF+cg7w3AaaGMZyV96QeS/BfZVpm0iYK4FVAPjtfY4ipfas2WqWihq
         Il8XRQFpw7j/U/9nZLMOaL91eQxuMQQTtiR04XaK0x6yLjncFjLHyZ0VfaXTRKSIwtYH
         u0/fAYTXLLYUn8/tUkdrxWp1grkE6Ke6IMUdfhhy8IGsE8bH3p1Kr6rWTAp+u16ftphy
         7w6A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6c0u+z+S1aOj6UWJPiyi4ROLChq5j31D1RPHCOtIiW1wKg+iYRGzvpF7OeLtz6AVcTa46CwFlaeU=@vger.kernel.org
X-Gm-Message-State: AFuF++mymKX5fqqD/3phxQ03x1xSDq82keo5fimbxvMC+PWkQEx2u47A
	lRC0x9UZ1IEbXa29R30m1cYyRRnV206gbS/WSe68iyh5csiRoUN4qF2nXMl/pZknNszD0BMGU47
	p9PGAIamRRueq28Bst1RUdRI7XLyE/3OtyXdSdEtHBpmegtXlYAjSuswooypz/Xo=
X-Gm-Gg: AR+sD13o4AE5M+S4EI2/79xMhOY8R/gRZ9Fbqq+Q55M22jzlV8YtWxXzJp+P0S8vxeq
	xzLZ7i+mVKS0Y/Yva2kZnHcNP+tPTLeZUqmti0+Dw3JhN0hJDGw3dC1qyE/eSua2vnP9GKLGCcT
	fgvAx5mO4BcpFKlQPxhGVPqL+ymg9BXJheAiCGOVepecuFul9u0zpnfSvr/ZF/J/olWXbQ8Q4+1
	q0q0SCnR5ByPIy/A0Y0PS10E+aO75o1hV1BN+yOa9ByvHOP7MbKU7thjsx8Nn8vvNgpzvfIC1/X
	c0Et9/kpo72WIywgr62Hysw0ZlTrsoiKZXzl+tJ/vLhXUgyCDGWMJIV2yreeXJ/nWFMWl0LTE01
	HN/ys9IbjIyEkHIT7lT3luMaowGj9HhVig7U=
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3cd300f9e23mr43811492637.13.1787552396814;
        Sun, 23 Aug 2026 23:19:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3cd300f9e23mr43810425637.13.1787552389918;
        Sun, 23 Aug 2026 23:19:49 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e72326sm682881a12.32.2026.08.23.23.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 23:19:49 -0700 (PDT)
Message-ID: <29719c5f-757d-426e-94ca-c221f45c00cf@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:49:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
 <20260813-master-v7-1-3f9010cf9229@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260813-master-v7-1-3f9010cf9229@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: t3ICnOMIkoqNtGhjPLNELCvPGEHxjEiO
X-Authority-Analysis: v=2.4 cv=U7iiy+ru c=1 sm=1 tr=0 ts=6a8be28d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KUGX3CDIF-uJIBJLYKwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: t3ICnOMIkoqNtGhjPLNELCvPGEHxjEiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1NCBTYWx0ZWRfX5ZmIxOnCtdhB
 mUQRR9qTcTM27sfpX/BXnBzDBBb0Y9tu+zKQtnaq0vEEL7NYHpTBQKy7EpzLh2j2VPVqDJ7qfzK
 oH5l34s716nHJVsjfms3ttpz0/ovfYe4e5uNyQzFXqMuHevCMTLgj8C3qR6fqIs/LCyEUDnwkEN
 rlpazsTnSCwz+WJirzWrMwROdobWlamvZyuVfzPCJRRXUcf9gzcIWQI/NbAL+qfCh9yCMVe1ANs
 NT7QwbfvVc4rdZt2P1RJCYdcNc1zSzBGCQmvcDTL8a8fgWRzACvxTzeVOGHMug7o61ofMqwllTA
 bTYrCC5Rpt0PXbJRGfAifThfwgq7MUdvOcDwSz8pOHo+1+6OLq394WWIwjqVS+z0i1jih8IXQHJ
 Qm/deFMSE08mkpV3KmX4xE8iqrvI6oSbBVbu49RyQ52yNpOK4FfItosK47Q8DmUHJ01M0w+WhJU
 lfqXOeSq1xLyEOedz1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1NCBTYWx0ZWRfX7LbQbk5b08e9
 4zdpwiA1Uj8SRsVUPPNl0M43gFdutZba7jhDGkXtcs/Qk7accL0nwSlIc9op05lTgwFRKk9zn4I
 FwOmZFt6HLiyP08cHnSNlXGyhT5JzWU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240054



On 8/13/2026 11:15 AM, Aniket Randive wrote:
[...]

> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
> +			size_t len, unsigned int safety_coeff,
> +			unsigned int min_usec)
> +{
> +	u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
let's validate bus_freq_hz to prevent from 0 value in case of any 
abnormal caller.

> +	u64 total_usec = bit_usec * safety_coeff + min_usec;
> +	unsigned long jiffies_val;
> +
> +	/* Userspace-configured timeout always takes precedence. */
> +	if (adap->user_timeout > 0) {
> +		adap->timeout = adap->user_timeout;
> +		return;
> +	}
> +
> +	jiffies_val = usecs_to_jiffies((unsigned int)min_t(u64, total_usec, UINT_MAX));
> +	/* adap->timeout is int; guard against signed overflow. */
> +	adap->timeout = (int)min_t(unsigned long, jiffies_val, INT_MAX);
> +}
> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
> +#endif /* CONFIG_I2C_DYNAMIC_TIMEOUT */
> +

[...]

