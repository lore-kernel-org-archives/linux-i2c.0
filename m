Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13A3859EF
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646435; cv=none; b=gZVZwILcMxljz/pHb7/zPqAJnyQLxJGePQd0ezXvxTMLsSRz/I8M9mYCPtNhqrqUAo3RfabH0XVqdGayjmGALa6YXRT0Xd2laNMXVno1icrjuAcQxSDeE2gR9gEW3ExWtm0f8i7EIdmmO0cCdOqZp/JLbWgrgzPKMoJJoCPKlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646435; c=relaxed/simple;
	bh=TC2thDPFQGLj8bXGlbz3A2c5nNROvXh+s6iU21A3tZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FajgN4bMbpLSYWXofsbN+54wuLDL1It8spYbh4NYgnEslOQJdD50dzZtY/aZhtX0BTdZMaId8NySND8ztD//bxYiNkpUgDORxMGodv0DkLSVft7AxrU52x7NdI2go/ZlgDcGK/WhRTM2RlFuc8YnJzlTcx4zId6i3tEcD039M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBvQBWnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1YZY4/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBvQBWnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1YZY4/u"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg0Df1971306
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EIBzEHYEHlt2NCyRG5veKGHNrgK+qKQdl98wSUvyMFw=; b=kBvQBWnVEinGwxkU
	1N26HkRvE+wRhhpA5vno6buQahdfCferVITy+k3vqJSkUYBHRMkyG13afMd9Z90V
	aTpql1YLbG1/D2lQftefCEoZFlwjAcZh0QpQWLnkkAMyaGu08uJ9SMdZ7ZDMnPDh
	hqdxUIZdNumiZBP6G5N2U0Sd3BaA0eNwQ+pyyfqZoUUKKT+9+GqlsVVjY8LjJdtc
	YmwkNCuamqmj2KRVZ+JlumhzZyKVrvNHuyRlM9GXCi1IL/DpRoOZuxtuBNt8ELTS
	WRfe66PhC4QZ675oRsk8BVaz/H/+NlLl281E8Sc7QG6x9OVo4j8lDZnr2AZfmdZ1
	njewYQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6861gyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:07:12 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5bf87ca30b3so602946e0c.2
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784646432; x=1785251232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIBzEHYEHlt2NCyRG5veKGHNrgK+qKQdl98wSUvyMFw=;
        b=d1YZY4/uD/TdAZeHVOlE27hCjAjQaL2CBJnjWJFDdTB43dzWTe9R3dWeG5ObPvpxh5
         /d2bBATaXvVhEUHvHzVQ04RcW2zTPS3xYQp6IAJVVHK8vmlvKIVg916ZHB6QnwscpKgS
         Zi0JIGaBvoxmbofjd9O3RyWrOK1DYye3Gz2uHj7uXnaCsJhF0cDtT9dS2+d/3OlYMyKA
         xD/vZQUrERYG7w0bzgDkE4jh1z+43i5yzXVe2SPpLrZzi8ruNdugZqephEIbES1kq2y2
         nL72jBCmvOCXt7llAvdm1yyneMGxA1UQykxA6lecPLlOVLZsuLwF3H/PBrvQsON61E/h
         6mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646432; x=1785251232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIBzEHYEHlt2NCyRG5veKGHNrgK+qKQdl98wSUvyMFw=;
        b=irGEmPzYgPyn8njQ8QpL97AEe3Cck7ZcPjp1WBhyxgbx8YObH8BqmggahyY2HeMzqO
         ZtRFRDq5GKgn49xHJEJTYmZhwIPwU1aofv8qBXRdAickAMbtJ6uf2b4M5f8HtKyo0nje
         ZO3rD4HPFW9ppvBrZX+jKa/yMyBQUuUhuc2/k9utaz2EjvaPwO4TxMC8I5/F5O/WzNwQ
         0P9EBBBoymEuvUP8+6E0DqqA0scbyQ/1gsk8Hwylfh0vbVj+g0JQJcuMhF/q/KRtLYbt
         bCv1qX/2STWucCQg+jJER8yowKUfgPdbs100pCD8N0pcIbYDlMUE1o+nQMCG4tXN7xtv
         ynCQ==
X-Gm-Message-State: AOJu0YzVoJGSFXc0SXqb0BUex6X0OijvERynXryGiUCM7DCXoz1NQ4nO
	mE7ZqzDvWNoT8ccBizRCuCc0sFdq+U7o7v9RLLnn3QHi47qYjflnkuwvnqSt3t8uE3CES+/+CQg
	Nf5B7oGJTOoD20o2p5rd7cJ5fn/fgNO+MCTXGE19g6Ai8IV5roWqtvJoWZjC/QWg=
X-Gm-Gg: AR+sD115auKfKWmBXD3FxELSaLiKEQvmv4Cw/+oW2a0MUyBIb867OHTmn6rAhmBPUta
	lqbPtbnSKiUpGqoWrBbnY49SDV7TkDjvLkjwOQ5/nFwRRsvx7exzZ6Rqi8ntOMwFAjNCafoaLKD
	AvbJelWDNy2JucfA/t1stI+oyLE1CuuXfsg0Ijose/w/SBw4JoLppm1keoOsFbmwyijzDCKFHeN
	GWVRfxcHvll2dho86sdVNRaXOER/HbPr4brJFQ6dAkBZzU0IrPQWOZxhLljJ4Sqf8SbURV/7WY0
	hHRklLru/LBOtMHvIiqw/tu+X+9Dt/cvF74OSATEv5BQjY+G2rqzzMYAzP1TcjuyqUfhCJRwDeO
	EK+ThB0T6Nz3xNDj8Bqzk1aOw
X-Received: by 2002:a05:6102:3e0a:b0:739:cbf7:93dd with SMTP id ada2fe7eead31-74abc8c54c1mr637426137.6.1784646431990;
        Tue, 21 Jul 2026 08:07:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0a:b0:739:cbf7:93dd with SMTP id ada2fe7eead31-74abc8c54c1mr637416137.6.1784646431492;
        Tue, 21 Jul 2026 08:07:11 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f8c5sm610446866b.34.2026.07.21.08.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:07:10 -0700 (PDT)
Message-ID: <7fa30af8-884f-4302-ba88-92720bc741eb@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:07:08 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-3-5eae78700da8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260721-cci-clk-fix-v1-3-5eae78700da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfX5O4LuGgGinZE
 gc+0w43faPKEJyph11uQ6qrYEbTxvLQ6zSOHL1pkdLC4hBROuYT6LTWWrLd4sycOuB039wOx+u1
 CisNZqNBasKeaRGYvNi06jyov2rUN5I=
X-Proofpoint-ORIG-GUID: iDMtb9V62npFUKu9hX5FdTncN2UudKHX
X-Proofpoint-GUID: iDMtb9V62npFUKu9hX5FdTncN2UudKHX
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5f8b20 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qs5JWBi5AS5GbOw7t0EA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MCBTYWx0ZWRfX5aRkXr+DEUKj
 T75xr20g53HeDbh6qAJZr5/yEPuxejBu2yPZDQHNgo69jCnfXfNQH2RUkqaZrm+GQhnHDK+/xPG
 bqldXPCKXlYWWbN1Nm+JqKX2njH5SmxxX0+qBJvT9wDVYaV3iPcYziYTgLxWeZqJBJglSL/YOSC
 M0X11UCVEJ8HrZKrM4JbiNW60uubz3dbsk09VvAZ7PRu0FAiFUQxpnKa2fR3VElS4LIH2EKH91v
 bLYi3BHn6quhBW0Cmb+YQfgzZJ/MTZV1HtjG2Tr0xx9nqAodnbSgnvrPwjNvhfm5ZiSBy844Z/T
 J8w+8ELxhye1NppeJEoUh+gNyh6P7VRXgFwcxXmHen3TTXSfYRn0Ethq8+kKMRPZRoQH3lch6c4
 lb8AW9BUaKrA93tGZ0CiNBu5tJyuheuMmQYL1Xq+q52a8HMJs//v8im0+VoIUnL7SkBrHyoW27j
 /N5yznt/lyynmMvqi4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210160

On 7/21/26 4:58 PM, Loic Poulain wrote:
> The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
> and were calibrated for a specific clock rate per hardware variant. If
> the clock is running at a different rate the I2C timings will be wrong,
> potentially violating the I2C specification.
> 
> Rather than just warning about a mismatch, actively set the clock to the
> expected rate at probe time. Warn if the rate could not be applied so the
> user is informed that timings may be incorrect.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 5f74edde8558382e63e2c3d0fbe19489f325e8ce..e001c0d565cebd386fd67b1d9d532360b29c67d0 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -519,6 +519,7 @@ static int cci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *child;
>  	struct resource *r;
> +	struct clk *cci_clk;
>  	struct cci *cci;
>  	int ret, i;
>  	u32 val;
> @@ -587,6 +588,15 @@ static int cci_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
>  	cci->nclocks = ret;
>  
> +	cci_clk = devm_clk_get(dev, "cci");
> +	if (IS_ERR(cci_clk))
> +		return dev_err_probe(dev, PTR_ERR(cci_clk), "failed to get CCI clock\n");
> +
> +	clk_set_rate(cci_clk, cci->data->cci_clk_rate);
> +	if (clk_get_rate(cci_clk) != cci->data->cci_clk_rate)
> +		dev_warn(dev, "CCI clock is not at expected %lu Hz\n",
> +			 cci->data->cci_clk_rate);

This needs to go through OPP.

Feel free to take over and refresh:

https://lore.kernel.org/linux-arm-msm/20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com/

Konrad
