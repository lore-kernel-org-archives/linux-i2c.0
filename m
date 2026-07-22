Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FD305670
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697981; cv=none; b=Mlk4QYmg4Xc8Ir6WQznTSKQIJGcxjf/d/VwqTh926DGf6AKX8aQJvWHt4wafhJERI45f5Hb7WGOc6Hb9VgjygTdHwZWq2r/6nENca8UprfJKRjkQhQDnnEcs/03/kx1ywwPuZ1yNDolLxzmgK0nkfZ0U5prGSEwIV9Y+rfaM2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697981; c=relaxed/simple;
	bh=p6pMiFPNFRV0q/ClqzcxwbFwjahEhceneLX2wwWlseg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADoUysifv6VMK2fXfKQbfmURyT7wMJj8fj/y0M0AXHk5BrA/FljUqsus5p+MOFVFZw4LcoGad8bi3O2zTN3KdNmEv5PHnLs8OMzCzxulT/ajgIDCUetoPAq/6yTOV5D0MvpXO5jPiEnLVlegoK+KKeEDaoMzrN/JnF3s+caOGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fayd/dXB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PpP6qNH+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fayd/dXB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PpP6qNH+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53hwq3787177
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XrelDr0RdHMSFDyRQ6txtRLTxoU70OQ8dC7HYaNvxX4=; b=fayd/dXBqsBnkEEC
	mZr5Lg12Q3wn1Ivzjkczse94n9fcFsl1yPlfpSOklxWd2QxzFI0vrToW2Q4URlc0
	R6QFBNRjIplMKh8pzMD4bv+gOnPdA9hNE+E5FVBiYpy/aYOH88Wt4kb09RBAP5ek
	sCoCw5CQ9xeHS4GT973hOpCuFSn+Dqs30h2mU9rd7yDwAdtTR0kEt6l/g+/scY0p
	xAUCe3BRR0xXrwY06VVQpYGTegYASSC7omZPmljBM4BkNEn35e0m0sgtk1YJcy/U
	YoBILXlsjbIYaCSKqutQqTbzqq7tml2B8tRXaVmY2ZKuMOJDczRqT4g980HoSY3r
	5lAy+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aebr48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:26:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cea6a46766so188198735ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784697978; x=1785302778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrelDr0RdHMSFDyRQ6txtRLTxoU70OQ8dC7HYaNvxX4=;
        b=PpP6qNH+OsMzBTzhFVth/GMiqHMPlno4fcX4XlP9A6IHhHR44iMrW/w4NEBvU1V83H
         nTmIRaDqk257oMnDt+29NkNLJtqMSbXd18MJAQXIpd9YGj4xHI4N0wWwxjghTHlDu3OV
         bxxhXFUgdahZWyRaMdHd63tyFbqdnXWpBgSrA0W5UcSbs21a7L72jjbg9GSuoef3I3nK
         4iG8uZwAmDaOaQEYuHfJHGb37xwG7NQdeROVnVecPrW7XwZwbOaZ907wooUSY43ZcuBG
         rEdn0GUAq1XtePKlL/sr0gREYrbILwSbwepGjm7lJ+jjQAeAdZHIpD3HqGbZEe6wLNC6
         VwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784697978; x=1785302778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrelDr0RdHMSFDyRQ6txtRLTxoU70OQ8dC7HYaNvxX4=;
        b=HVFITD0o0Xwsi52Fttz+d8JY2jh9dJmvQzmpwULFFtHHwVNWCaJk/Wz51sAhejplkn
         p8ipEAlU2h4n0T/g9aDkYia6xfxp/PILOSg86SjMyp+fF/3unTqqBulDgiRhvhfV8Sx1
         ++G2EdKC9ojqW6dOvXTO8C+nuJ5YHkuh4z42cfhZByS1RlA4G9zj4veI8v/OTLyMPiev
         O6vWlidf4fahtm3TRr6uoXJaEI3d/6tCdN5kEnnoPEnbMw0TDLp1pDKC4vByly8WdcRa
         istnFMJ3tNpjWTxp0EZYn00BM9V+kI+ihnV0EMre828vNTrjZj+SzI0tfbdg/esTSwLZ
         raOg==
X-Gm-Message-State: AOJu0YwVWximSr4vaDXRzkEipdQfHWNxzGsahUupSEI0pZZ8jUvWXmcS
	zlSZbjw3R8Ig3MC4vlk0AnxXY+DniqeQuNRDQk8hwwK2mKMzObFuejTGxK01mvoC3VCZ4c5l1yU
	pzCWUikEorf1tPzOFIXO7pGYsTkC15HqxuWTlRjRSmF5xzjjS9QrKrQ5/hzsozL4=
X-Gm-Gg: AR+sD10UC9kdTXnbZdP+U9N2yIXwznHcDuunaE5FHxb+8ysv//91M05Id7nx6RpDxfD
	Dj4appEOL+RTpz3xVaRLeidmYN/LWGeJbxf0xMX3VpKcvugsc74QvZzKn6ioLZR0xMAzIQA6Smy
	qPKYFTW+E88Wl4dWpYoxAZKfFONk0gAi+2PJfb4xvMjFhlvIIj2rpRn8BDcI9hqEgjJPULk4GB0
	eZEEgy4KzS2jAw4Hs22H4ThhJ7vLKtqkZs/WVV7YhBguWP+nrglTzTEgiYI9mtK4C5HElFScMdm
	rkh+s+7x7xaBV/9kBoKXnEyodP4akJkettP8AyWEQJRFFoxc4en1Ea0/ttBMOf8OjtuqJ6vR/wn
	bal8JKTon0sYAbjIy4ZyY5DtcONk1ceEsuzA=
X-Received: by 2002:a17:903:19c5:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2cf348f88abmr242816165ad.16.1784697977981;
        Tue, 21 Jul 2026 22:26:17 -0700 (PDT)
X-Received: by 2002:a17:903:19c5:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2cf348f88abmr242815605ad.16.1784697977038;
        Tue, 21 Jul 2026 22:26:17 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1ca3efsm5441955eec.30.2026.07.21.22.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 22:26:16 -0700 (PDT)
Message-ID: <2b025902-8879-4426-bc81-484fd9553aa2@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 10:56:13 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-2-671261b05c61@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260720-master-v6-2-671261b05c61@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x076qPQDtLHvyh9UJ4inBddZBY_lpoq-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfX3KPk4B8zgITT
 43SXwdr6RDrFKfD/qoEG9/ZbOcITFANVKZ4aS/xGhDC+Qh3IrBXV77O4kh6jp6ZkxjHFq3lHd1f
 8cL7ngstSHWJZhhA/UTZTR7yzWgXd20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfX7MVbvTVyKHSC
 um4TCMp8ptEvrNI7wv7xHiNtJHD05tpL9Q3LD6Mw0e5WQERCdibzhFv3R572LICVVimVMJubO+t
 whVntETNsreXCftcCDvtrUAAK0btJ0eU+M7Yq6nHFSaLBMNusEWIHJY8DJDE9EF4vMvHtK6GL47
 sTiEVdXM9OF6qBD4v5C/7IpwSoHihWJQxtDqeXEGYHk9IqQFCMkR5C1Sw6Q0b83kdXNhYSanmbX
 F94M4d0U6IvmajvNqFm7bDRMt+LE3/RCRX+A6h1XLKyO3+FjEccMnC3QKy8Js+H80Mc5ht3TR6Y
 2eLTSi2J0mYfSxVx1zr+swKfKKf5UvUCi95C+bgNuNcSJw48jkhOcVXkM9+65REsiz+G5GLJNo1
 VUFHgVjlF+uW4xQwjDW6Wt+YBkPowQPI+IEAF1Q8klExk27lEylXahdEhfFAgIbWHiBixXDTmob
 NhncwyWTsfnUy9OQlPQ==
X-Proofpoint-GUID: x076qPQDtLHvyh9UJ4inBddZBY_lpoq-
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a60547b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=jYUsI6dgtjGZWMlStScA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220047



On 7/20/2026 5:11 PM, Aniket Randive wrote:
[...]

> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 37 +++++++++++++++++++++++++++++--------
>   1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..d6fab3aa8468 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -74,9 +74,14 @@ enum geni_i2c_err_code {
>   #define PACKING_BYTES_PW	4
>   
>   #define ABORT_TIMEOUT		HZ
> -#define XFER_TIMEOUT		HZ
>   #define RST_TIMEOUT		HZ
>   
> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
> +
> +/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
> +#define I2C_TIMEOUT_MIN_USEC		300000
> +
Let other expert suggest if pass from DTSI or hardcode here. because 
this let all other controller drivers to make change. I request to 
conclude on discussion, i kept my point in earlier patch.
>   struct geni_i2c_desc {
>   	bool no_dma_support;
>   	unsigned int tx_fifo_depth;
> @@ -471,7 +476,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   	}
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
> +			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
> +	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   
> @@ -513,7 +520,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
> +			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
Expect some discussion or conclusion from other experts if need to hard 
code these coefficient or pass from DTSI. if core can read like existing 
i2c_parse_fw_timings(), it would become generic to every i2c adapter driver.
> +	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   [...]
