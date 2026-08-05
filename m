Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD21403142
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923031; cv=none; b=mRn2njcnx2Zu+QRLHJifwyCJmWZKG/akGleUUZX2Hp3xOjdznJ4C0AVrD/5mkM1k4oONEN9pimpFilH7L2mauGhazHdTNUrZkmB4PhBIBebwPJFC32B8+vl9a8qxasKLVBNAtnsK3Flvst7LoX0XyuyrCxBfOXqPgD6Wi1exYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923031; c=relaxed/simple;
	bh=8s79aeYwOOL8zPp/iTPRuJMIlsaMOrpzvva2ficiOzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZdEWIqpJPFu8zVp7aM5Fm6QDloHt/R5InQjyskRs9QW+seq2X9zMQeE2Ozfn6TdqCBvxm6b8Jq0xOh1jAuVYr658/+aROsolDk4IAOJ+9Pse3yTp7S3DgvQ+j7lhabHC+rAgPwrUcxnOX2CW0LAKAHGDOJAH9439HhBsx/koDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtLt2tWn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuhpnoAV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtLt2tWn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuhpnoAV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dDJF2128941
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 09:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C8lP3h0YPqAglTQfp6gAPb3PBfqON1O+iSsRvWAj24=; b=BtLt2tWnbgdddhN5
	hImAR9mFTcPpQciHDF/be2nczLJZ+QXzRECEjLPbkHV7YQ8hwCAedz1Rarbvdp84
	1IeMo5iEaqn+tuGRSVrc7m5vI3Gb7eDA3IaU/J0BYYAbztoXEpPLD5H8uagbiA1t
	oyU1I6RPTaCjsGlhS93bbmO3KSvuksvRbuAAoLs9SvLJWcv/ve6HFkMytrAjgzeV
	DXvrvgCk5tg8zN6mOrU3qYv9AONNi2Bg1SBkL3KJrPHsn39EfU3tmY0jI+0bpHFy
	Kh5sFa/CAZoaG4SNtbp20eW6eZX2VYhv4P7K5OSlK/qi5uA4GYijrbZ8i0Mztn/F
	bttUlw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv1qg8ath-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 09:43:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1125703a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785923028; x=1786527828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0C8lP3h0YPqAglTQfp6gAPb3PBfqON1O+iSsRvWAj24=;
        b=MuhpnoAVvA2KkUriqvVwXZvjMVow0mDeO9IxgmYroormf8T4K54BmY0mHBqTTk8dY+
         INwsYqdSQnArGE+5k4IPLlzF3TA+vIpR4fSPVR3ntZGwd/Bgl0sE/jFsAw5s0/u1bJKq
         ZcgxBVpQSgEZMmasAk5qGo9RV0sa9rCJ4oV6/YhQUahOg3b8ErN089QfhnKCdHUlITxE
         MaALQ8ydaNi+cYbhOtGr/GnQMvF775HIzAP4/WOcUYtvIavivNWBlgM8X3zuzW4KDGeI
         18BHB2tDUPcPxXBk5cQME7Od5oqOQUhHKwb7d7bGh8hmo54D5WIVppwvKUStD1oBYHOW
         EnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923028; x=1786527828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C8lP3h0YPqAglTQfp6gAPb3PBfqON1O+iSsRvWAj24=;
        b=mFVySNArPE5UNzxch0caQf2CHvFwd/Z5uIv5+DGWIEoi7zJ98bri3Ph2Tl+IgjWLo+
         re6Dhdg8aX0PNV7t3YebrXIQcPxTatrgUyLOnLfAq6tB6Zh+N9umkRLqS4HHx5EoIcTR
         8YsElhLiCrYoYnNGzWwhk8WAsSFWUoxoTQO4UCGuImOaD6FvSnnfTJQ9j/6vyKjVs24N
         Un7LWv6BVAUSgdehibCqXpj+u9WkCdOCWKwP9/7mRe7Bd7w+lfascQU9uFv29S+1qqG6
         TxPXrW9yUdysDQdWxs+jaOCNORn3jnyyqv7Yev+MJzlO7QY9YouKB/NOYWrn3ZqMdJtK
         0KNw==
X-Forwarded-Encrypted: i=1; AHgh+Roqyf+dJJKZKRFEt6fQhVEQSwD3jOZX2xhnAsLVs+nQhXHT220vFgQ1zOn+L2d5a7aIHT6xw+ELckQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gkQwI/2S5bwW9nB15Vu0ijdSDtyf0LNpAWryNL6XwD0A0kKM
	pJii5i/EbDH/ZCk8yAnqfn2Fiszx+K75TEopjoCVFxTL19s17fCrWVYqAiR5IQ6BUSxDwiQSCk/
	1TLZ12xfA+JifcCKMyJ3Mgct8RiA0Y0pzLkL/WL2zNcnDCUykl3lMveBX4KHnBVw=
X-Gm-Gg: AR+sD121QIdpsNgR6rbQr+A9i8CUugzLPXUfS97AXe/wBc/n63HBvT+KaBwjGJfApS4
	cOCqPeWK9J1FYR3k/dsxtvQoIso2i2C1C2/uafuWM5y4/No+eYFvrHvMlL6EM223valvSQXJ5BS
	2GBy6PIn2QcKXmMcdGD60a09GUWoJdsGHwEzx5QXxVKAJwm1xTRE9f0gDEnB/0l9CPAlVGj3DHH
	PElVS3HySDNv7jfzUz+uRgaopVxPs9b8GxZQyRbHl4NuYjt9Dr/DcuRpwtrHpqNOfdbw+ehjnx/
	wAyP12jdo7Xea/NgQYg95WdLndr5H8HDJqohEBVTm4vQx4XkJdR5rCNHmg52scaTWvx466RGMv8
	AKDSGDNTcsJ7xbZ6a8FZPocAX+K+EIMbMsA==
X-Received: by 2002:a05:6a20:e290:b0:3c4:3112:33 with SMTP id adf61e73a8af0-3cb85de7c9bmr5995363637.6.1785923028469;
        Wed, 05 Aug 2026 02:43:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:e290:b0:3c4:3112:33 with SMTP id adf61e73a8af0-3cb85de7c9bmr5995311637.6.1785923028002;
        Wed, 05 Aug 2026 02:43:48 -0700 (PDT)
Received: from [10.217.219.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707cab43sm1169143a12.3.2026.08.05.02.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:43:47 -0700 (PDT)
Message-ID: <06b60666-4f99-4769-ad4c-0b69b58704cd@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:13:43 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Use modern PM operation macros
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260729073040.3227692-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260729073040.3227692-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I+hVgtgg c=1 sm=1 tr=0 ts=6a7305d5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=m9ln40nSR70YO6FPyLoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: CukKPEMi5s_fRUv1Ul9gOt-4jkYMlUng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfX2/r4I2/yrz7+
 KX2cU1ow86tBmjiS7pBYeFOHj1nWg/t0SRmyQhtFU2rzE71kkzP+k2cPl7NGLGq4fAbm8jFEXpA
 6z1UejKDILSqBYhAjlIO9iYsXnsZ6jgFBiDdnz/+3+HukYSBmL+9GNmA9T7iufz25Xov5NoiUOz
 o3ewBpGdwgmsH2FddHQf8rBimu9h50MQCuWiH02afnjIo1bHUkjI6gWZ+TKS8JzvboYLXmCw9Jk
 KZsaRXx7gnybUGOSOxnieOt5f35LIeofiwWJ3bbvgXvv/pMAm+MdVuJFfAL+ZmJ2WVYs3rVyo8+
 h3LtGfU0AtvIvNRZ6+xM1x4kAvWtSrdiBqCdfsgeCQY8DDUwbZGooNO8otKQrcIP2ugN5owaIIU
 ASfKUOOhQkcEFXFBgLo7iFMpshLveyu+iPyevduTgwrNetwXrs67tNqdDMP5C69k5bXrOEGQyZS
 OGSeiboTziD5E1LxpBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfXwPoBY0BTPkhX
 HKd1qzAQr0OSV812daBjk0sf3y9NjB0rU1i/XjOEycwVLx4bm6+sOPPYIh0ad78TbW6J5gNLvpv
 p7l+6n+MKsoyfLIRIE7voZMFDXpuqFM=
X-Proofpoint-GUID: CukKPEMi5s_fRUv1Ul9gOt-4jkYMlUng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050076

Reviewed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

On 7/29/2026 1:00 PM, Mukesh Kumar Savaliya wrote:
> The driver uses the legacy SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and
> SET_RUNTIME_PM_OPS() helpers to initialize struct dev_pm_ops.
> 
> Switch to the modern NOIRQ_SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS()
> macros instead. These macros keep PM callbacks referenced by the
> compiler and help avoid potential unused-function warnings in
> configurations where PM support is disabled or partially enabled.
> 
> No functional change intended.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index d5c977e34994..71ae821dd147 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1163,7 +1163,7 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
>  	i2c_mark_adapter_suspended(&gi2c->adap);
>  }
>  
> -static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
> +static int geni_i2c_runtime_suspend(struct device *dev)
>  {
>  	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> @@ -1181,7 +1181,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
> +static int geni_i2c_runtime_resume(struct device *dev)
>  {
>  	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> @@ -1197,7 +1197,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
> +static int geni_i2c_suspend_noirq(struct device *dev)
>  {
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  	int ret;
> @@ -1211,7 +1211,7 @@ static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
>  	return ret;
>  }
>  
> -static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
> +static int geni_i2c_resume_noirq(struct device *dev)
>  {
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  	int ret;
> @@ -1225,9 +1225,10 @@ static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops geni_i2c_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(geni_i2c_suspend_noirq, geni_i2c_resume_noirq)
> -	SET_RUNTIME_PM_OPS(geni_i2c_runtime_suspend, geni_i2c_runtime_resume,
> -									NULL)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(geni_i2c_suspend_noirq,
> +				  geni_i2c_resume_noirq)
> +	RUNTIME_PM_OPS(geni_i2c_runtime_suspend, geni_i2c_runtime_resume,
> +		       NULL)
>  };
>  
>  static const struct geni_i2c_desc geni_i2c = {

