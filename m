Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23D3F1AC5
	for <linux-i2c@vger.kernel.org>; Thu,  3 Sep 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417678; cv=none; b=QZFKWw32obyAJF/zBkKS9dAJ2AvdMQI0cdcJtR/QYf7gCPUTV1wQjmuCNblfPHac7VE+FRIkjbfYqIemVNUSU2bPXNMJ9c8zGQh2VFt7zu8g1ziBWNLXZbjs8xqctQTwxdayiDQJF5ln+BlAkgW6TtKnT3Gu21ZTsLmAcc909V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417678; c=relaxed/simple;
	bh=Ls5xqUmeAmTLmj3AmZZ0s/A25Eqwbt6dYckNCixgm5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjLU8gaJgidZzOOuwxmMlfw4xXMJmBfmrw7Sgl3okUXw3ha6NHvvNl6Bk+xtSBSipfttaFQ2p0zjSZD2kH5JStbNgfR51w2FHewEF+SwK/SdeA8ocuVPg0Ov1oeaxr+ntlUCknkD8R2Vrl/Mb4XXdzfw7ftvKcMZTt+pGqXG8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H/Mj6gOc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dj50SRZl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/Mj6gOc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dj50SRZl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835mNF23643134
	for <linux-i2c@vger.kernel.org>; Thu, 3 Sep 2026 06:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8oGlazNlVh8Ae35ZhxfzQkmJc86P2MjFpqzNS1CcBjo=; b=H/Mj6gOcB8L+wQKy
	s5WB6jpiIl6ognzbyOpD0YN9m/so+EtlR620Zi7FkWiLgCtwGV7ZLn1D9B8YQbBA
	kX0vmcOOnC5jhvW9AE4DZ+SmHmvBXR3HyUONhVBfx8awwfZCVztec8jvTdQcjeUw
	vrEBcmYPOZP4L0aq96NeOUNrNLl0oj6FkJS9MVsJrw7QXlRoyuyCVziCMju6Mudl
	AkNje0P5awCVeoS38zCPSdRJIIGUPYcbdmdEaNVl4CpGV6yIx1X0brLKsk4LBhyi
	ZD8GnfSDjf2THUlWYunpdD+F7BQoTD8ttKkRswZadZgqTDzaAaDAkFK640YGrv2o
	wJOzBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrduh3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 06:41:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so2989081a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788417665; x=1789022465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oGlazNlVh8Ae35ZhxfzQkmJc86P2MjFpqzNS1CcBjo=;
        b=Dj50SRZldQQQh84vo6FVIsRt9doonK0DA9e1s1VLul2b1z72nN7X096SvUcYxnzq9t
         9Jfox0x4BqQqsm2wmRcHGu74nmrWX2nFa9LGacJl/e+EnItxIhuQ3Fc9DSG1BpwaixQg
         ytcUmD9KqZHY5S/oIW/ho1QRZMyswUt5PiKYhYuLZtmiTWj7p7exL29c0ZOR/GHHxAgv
         iM1bU+8BM6z99VmYvZQy+PhwRb0fJXMJ7cqtp6lZm8YchzAitupMY+6HzbGBlMycDRn3
         /KaowdCIr5XR+XtQSHLDImzlg52iVztwTK5ywO2xCMxK0jPGrWXGYNSmmVCe/BMr/OnU
         /xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788417665; x=1789022465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oGlazNlVh8Ae35ZhxfzQkmJc86P2MjFpqzNS1CcBjo=;
        b=fKUr+dxK/NA00pTtGCie3CQZx6l2gMQDsaJV4F9KIim7bJVEU987qCcWwauZqDf6yZ
         33Bg5N8PEAN8a541cssLuOGEJt08vG1YCKMmLOthmsS86uqiJ0s0JSIHC8kPfl/Q8t+1
         tKt7iOg5tM1rS/oi4Y2xI/X21+G5qR87H5GgkkviGlyaR3AmuoS4GaI/drVz2MaeFeOP
         gE1TGiQbCTmS28nB5AzZ+w7uCgw2t/jiNcODcODdqi13eHt+V8v1O26SNh20o+aN445R
         MRXWJzbMmFVHHYqztV+ATG0fH0v1raWx4O9M13eL8o+jUrcuYDJ1reQDX6F3XRYWGprw
         kzBQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9UhL+dSprxQehyGEHe9jlabmCisxei4yNxRqw5m9yenhETnzE1JYXMog6nENbIg1ecKRf5LYH6Ts=@vger.kernel.org
X-Gm-Message-State: AFuF++kxyqdfe82T9wRC3oKSOYYCvGtBYvSuem5H8GoCNX1Sm7nTzVlg
	9dStjZ7cJIw1DH3nXeaLDEBdxcW6bD9DpD8bccbkXWOF+hAz3HfXfAu/xA+0WHfVjAi12hKnbj2
	U9lsLR9Jvlm8OclZBlLh8BG/KXw4yD2cg9tYEd1WjxLzCbabtFwcVP9P+vxOU4IQ=
X-Gm-Gg: AYBFou2mkTMA2bwZpbNeP/1eVtGZydGJJpBx8kueqPrnqzXXx5XNKamiX7qLYShH8d7
	ndZs6D5VY0OkMk9OIfzLdZag1kfnxr2IXshGDuQaQZwVatwuS6uZMHCHQ63SzmGhJHBpF4dI/Hu
	tM0gXX2zzZSETX94FrrCI/sBN8dVZDcGWx4xam021fbm97282ZyMGs/CbAU5Tn9AZ7jrImdswiy
	o1slJ6QEcLeze6UX0IAvPBrbwrrSETesafJ7jmWdRNZWG7VdEXqFkjaCDOEmLygVFIoVWzgsom4
	yLigVAB+sTJSk+X7GGH/EmH3XsIbuF6jVqt1qse294pXgyPSpwOVlP70Q9sn3KG/rlpRJuzVVOm
	BvRvtD4GCAgUs7YLuN6n1Vo8quNYv1Phl
X-Received: by 2002:a17:90b:35d0:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39aee10890cmr16128779a91.18.1788417664903;
        Wed, 02 Sep 2026 23:41:04 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39aee10890cmr16128682a91.18.1788417664257;
        Wed, 02 Sep 2026 23:41:04 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.111.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534e83csm3931460eec.10.2026.09.02.23.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:41:03 -0700 (PDT)
Message-ID: <60fae28e-73fd-4436-8dd3-bcedfd5f19cd@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:10:59 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: qcom-geni: Clear stale TX/RX buffer pointers
 after GPI cleanup
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902-i2c_double_free-v1-1-0f582ef32e55@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260902-i2c_double_free-v1-1-0f582ef32e55@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a991686 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Z/g59IqO3Gki/5UUpFMnLg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=a3YfMl8QDvillJtbYr4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: WxykFPs2caeYa9Al3XbcHs7MetIWyNP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX46Q4x2P+a/SG
 PETNhtHi9ieUuccQN1MvvDhaiLYIMYDD87bI94xgkgjZMWHrsF+SLEn8DO724YSKxKywNDTNcP8
 EzN4V0yfIYWMNnnIRecJmGWuy9NLwxpd1SAbj7DRWVZg9iVshc255dEbjWI0jBRYtiNdG7J5gzn
 33gaSaqkPE7aFWUShMHZRgA3n3b4UhclXISMUykbiOYiKsGPa0KVu7WsqNWN6XEArT7elg8qSNV
 KzVz4JlAkS+g8oLPs1CQ/yh/gis7A8c4WuKE8FAfTyqRFoSZS9MzLxf4m5eH2GYVRokaP4W5foL
 HLYekbyj0P+e3PSI4OPll6oqrSCAbATsuJ1uQOHMhc0PvhVvEzZZ2lBQR49ids2w/26T+9gz1bC
 Ijbp4XVxrp4rn53NRXzUvxLEgRblhFUDTeETqeWXbEA0IzGc3QEOLsDM/uPdyj3K6OhMai6/BWW
 KK151NgFuIBljbOqbEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX9Mff8zlb3FsF
 kge8V5Zo8oMEGR5qTDtKUZK7JMY4//foZOwzNclXbRWaU0MgYbL1phBRlpnq8ZFBh69bZkX310R
 BJX5YTW845xslxIb0o04mZNI1/WeCGE=
X-Proofpoint-ORIG-GUID: WxykFPs2caeYa9Al3XbcHs7MetIWyNP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

Hi

On 02-09-2026 20:15, Aniket Randive wrote:
> The TX and RX buffer pointers are reused across messages in a GPI
> transfer. After a buffer is unmapped and freed, the pointer is left
> unchanged. A later message can reuse the stale pointer in the cleanup
> path, causing a double unmap and double free.
>
> This can happen when a READ message is followed by a WRITE message,
> leaving a stale RX buffer pointer behind. A similar issue can occur for
> the TX buffer when a mapping or allocation failure prevents the pointer
> from being updated before the error path runs.
>
> Clear tx_buf and rx_buf after unmapping and freeing them. This ensures
> later iterations and error paths only see a valid buffer pointer or
> NULL, preventing double unmap and double free issues.
>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 942cfeee99ba..4965872b47d5 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -911,10 +911,13 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>   			goto err;
>   		}
>   
> -		if (!gi2c->is_tx_multi_desc_xfer)
> +		if (!gi2c->is_tx_multi_desc_xfer) {
>   			geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
> -		else if (tx_multi_xfer->unmap_msg_cnt != tx_multi_xfer->irq_cnt)
> +			tx_buf = NULL;
> +			rx_buf = NULL;
> +		} else if (tx_multi_xfer->unmap_msg_cnt != tx_multi_xfer->irq_cnt) {
>   			geni_i2c_gpi_multi_desc_unmap(gi2c, msgs, &peripheral);
> +		}
>   	}
>   

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>


Thanks,

Praveen Talari

>   	return num;
>
> ---
> base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
> change-id: 20260901-i2c_double_free-09ab0b97e61d
>
> Best regards,
> --
> Aniket Randive <aniket.randive@oss.qualcomm.com>
>
>
