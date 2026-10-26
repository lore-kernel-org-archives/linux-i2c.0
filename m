Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040345;
	b=0xjumqi6sGowvJtmaMcwQEZpZQtgL5fE5ftL5c0ESRSgFeCcWVXA1LW4w0ftah19VZWt
	 qHfm+3RQC56hsHbJr7DFUGj0zxVudgLxONcmlc3hBIGGZjG9NmQQBQqtOHUfcwVsK95w0
	 6f9XrCPwbEVPX98lTaSHwa2WfjWA2hyfNiyX3eHRPgFnIFQPJB90jXyX17AvGUtCuwHHf
	 VKK2MGv7w4xnjFQmznOSmZd0zf2o3Em0RXk5DEbsmEltM4lfm7siraDO/Vz1w4jIG/oXC
	 35QIlXFv6VEmKcS8ylUJmXyuMVX3fps2menARUtcrdvyfP07wripfm2Lw1WCTilQoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040345;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=s9kKn5OnW0rSv2c3iz6WM7rho6XB5fObcZeQYwnjFs0=;
	b=qSZAxSQCcI78xFyaXhUVW6Nx5kM0N/RPOiMOKR9SLT30DNfRYcjjWjHCTe0lSTp+pS+e
	 cjRAOEOo26ZXrkfDs9eYj02qGZ89caA0rPuUGcjn8pdNAw27Og1QKb+Rwvu06XdaYM7Hu
	 /k2tE1RPNCfSVh8W4k2e6OBlUDM9dkvRHsPJXjWIF+JS0jW28DX4RxySo2iysf1CggjbA
	 poR2oWJlBsLSn1Gyw41UHeAZ6Ur5PUlhnw9zdbcZnVGuFMbRGYYvl/hqylhWy/m/3pUw1
	 l3JCGnAXhagSuJ1273JIb94Ad3JXcHYOK1xVNSAHLWHAdGxyMvEnalyngK3wFDo3Fcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sope3mTw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B8mXtiHF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D55606A32E
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D55606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sope3mTw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B8mXtiHF
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvtch3567388
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9kKn5OnW0rSv2c3iz6WM7rho6XB5fObcZeQYwnjFs0=; b=Sope3mTwm5HyUkLJ
	x6jQx52i9U0ecmeJZJ6qH94yFRsy11XErJh51uRDJDpuTJGrRNIViamgJHx1QiZ3
	xKfa90J6Agp3uy1aMvwH+FQtvQV2npPxF6PVJ20850ALK90sqAIb1oOO9JeUDhuH
	cPjS8l5fgbWpex089wYTcrJvNFsE0HY9ARYjwTNHJl4aLvguXECWyQ7i5U2PBcD0
	wIitKtL13jJxrPig422W669mWUtuqu7n5oL6XJdtXx5l3snNAhKxeqvHsgc7lSao
	Xzr4puP5oqAmiy3fHvDtFzHsTpiujsj21hANOW0mEZxwwSoqZO9mJ5KoBviOeYs3
	pTKiLQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y1wmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:45:43 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-186c1aae818so2863256c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793040342; x=1793645142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9kKn5OnW0rSv2c3iz6WM7rho6XB5fObcZeQYwnjFs0=;
        b=B8mXtiHFbgXY+kZt92oZ79JerUUCf29185RekpjEMyHcTSHIchQeAQ5bsCGsDTpDBk
         gb46vI6FIuocc4+IGNuob8HxU/yUi1eFf36eZ2UdWhWCyIhYCpINY7TAHnqImJ1sN8dk
         8ECj2VcqZuXkXH7A7AQcjO8c1AX5FCKVWoF89goiJrb/wmIVhVONX0ZFnbW8rbKX0AZM
         V/ki9/Rv9TvmTqs1HaJpH0fTW1LVqIhCHYf3UXpuR7QDf+ksQvnQqsQZzfYEiC+CVPh/
         xEJgcvZfuh2dwEJiXtZf1U7zdosiRd0fBkLBVxBKNx1AW3Mh2xIH9kLwa9ILDWy5eeWc
         O9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040342; x=1793645142;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9kKn5OnW0rSv2c3iz6WM7rho6XB5fObcZeQYwnjFs0=;
        b=nSELZhojdiy7RtwcV7LCgb1KXbQ2wwoYENRIBbTSdbRTyKyFcO1leqNggfFUttqNqc
         6bExb9zf7F4pMx/fT+0NgxUlcHAP4FFkEIGtVIrT+OAfPMXz6nYtUehsGxqsl+8SvTm8
         JgeqSH+QMuGwoY0HhlGKBzoUub5+w75D92j6SWwvXJPIHh6AAKWFLrZHBJhKredQ1fN7
         i3xVm6A589NbxG2QZYLFXcFunn5xB3N+OMoOX+x4NsJIOH1rOTNAgtaySt6nt4LFUfPQ
         vJBMSe2adrtMXEkDnwejDsMT+2DN2YYgYTn/MeDZOPKuY+VBzak3Zk389AhMF0O3MVKx
         Fb2g==
X-Forwarded-Encrypted: i=1; AKwUvBwgdoaE13A0OnbKt/XdSDp3SuVIqgUQfJEoOPNcF0ERUuX4v9SISXzZnJerawPRdcDezn8BU6PgCKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOOiOE2yov06Zr9fRCsjtdj/wUlkmkMrL2aTwZJEQiZnmHWcIT
	0USVEjPjMQIySFGDYpAR3VmVpAKSdW+sbYR4LflWqYCeVLMfJ0xFCe+SpZVpJxM1QOAPouQghKy
	8l5fU1S2Lj618GxPnmxqSSRZxt+oD9+2dqcrN4HW1wl/j6qb0zf/tMAExHHrWZ8o=
X-Gm-Gg: AYBFou0xeT2NpvaQucgJjzxRNTLlH59+5+0pUiBemSlk7u6Ahd7QcQcmugnRnrPVtHL
	SkuPX3wXu+eE/ZHLRsOATEy2XP5y59iz1tLvj8hUEjb/anWiV6wHtCra9V02VGIk2FabdbO3eBe
	32YgyGzmKGKpt6V4tMUf4Sea/bPP2mAUptFcWpaJc/2LpSd59juwj9qNh1VVxUKE6y5glaWr1om
	t88RbsxyqZCQdBYVnACkwILA7u6ixYj08WPV3hNKUdLLV3A5ZsVjEqaerwDK1P0huaY49rQ+I/l
	zZL6uh/hDuWZtYRfdeDYF/dr5xiDyRDxU4XDF1x4da8xoQF9eGIIyD7+vSOH0xBXmS4TKcsmdUh
	98FZckMisTu102lNkjWLKIULCQQS+/ijZrw==
X-Received: by 2002:a05:7023:a85:b0:18c:ad6d:b790 with SMTP id a92af1059eb24-1993f6d3884mr12734000c88.45.1793040341946;
        Mon, 26 Oct 2026 11:45:41 -0700 (PDT)
X-Received: by 2002:a05:7023:a85:b0:18c:ad6d:b790 with SMTP id a92af1059eb24-1993f6d3884mr12733961c88.45.1793040341387;
        Mon, 26 Oct 2026 11:45:41 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.233.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm25283040eec.4.2026.10.26.11.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:45:38 -0700 (PDT)
Message-ID: <1360aff0-d738-441c-a631-0d2998889057@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 00:15:33 +0530
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
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-1-9f31b5fae5f6@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-1-9f31b5fae5f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3NCBTYWx0ZWRfX29E496OFcWoQ
 ucCqLHTdojeO0WN9UKlv6Dls3IXT3cbhaTGEz9MT+/HpTuTHAjpWFdmbyY8mxBFzIuiDkSwVHtS
 M7jbAFrSw55Qkjp/MKY6xelFMm+I9tc=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf9fd7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=5/Y9Gi2N1OwmQbPtUd2E/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=hUR4YRKjZVNWWFvtt-oA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3NCBTYWx0ZWRfX5EW5Gy1VlHZe
 AYwxUZGWhcMWGOuJ8nduaVi5IsIIEEIFterBX4JIOF5SpmSAZVnH+YycyudUp6eHo2LikRXLrIP
 uoqYVaQiTy7mnAMoloyys0gh+ly8fAYuu8l4XBrNjsRFuFQ1CL01GCQ3WP4kEnxtkdimwC5VST8
 OaRRd6w5mYevCUnp8WcwyIkVg4KNtYVN1DlQkUA0eacJomYngHs3hE95C73y8lgEpRnhYoTjwcn
 1LNN6oqezqmGynbwRzPigwWlgQ05A93JF3mb1tRZTJ3piwP8D9br+mrvczk87dMaDNeSBzDsdiZ
 UhzjX9mCbuYz3ZakA6pUDRRrzKwQGHfuMnupKii33SuYdNfkWHTIL73SoqKkG/cZl91PAYgXoQz
 VgVx816wOqkqGCO0+Qtoe0bcCZSgsGB+z6tMn62Be1peE9ytlBAmOmCPIE5smcJ2QTu6Uf8Z7hU
 4PKgnSy3v7el8HtKNSg==
X-Proofpoint-GUID: ZL8WIbBWZtTM5b3nATdSzwQyxGRLSjL1
X-Proofpoint-ORIG-GUID: ZL8WIbBWZtTM5b3nATdSzwQyxGRLSjL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260074



On 8/18/2026 10:31 AM, Praveen Talari wrote:
[...]> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 51 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 658636c1ee0e..10c6a4b0b825 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[...]

> +	geni_se_abort_m_cmd(&gi2c->se);
> +
> +	if (!readl_poll_timeout_atomic(base + SE_GENI_M_IRQ_STATUS, val,
> +				       val & M_CMD_ABORT_EN, 10, 200000))
> +		writel_relaxed(M_CMD_ABORT_EN, base + SE_GENI_M_IRQ_CLEAR);
> +
> +	if (readl_relaxed(base + SE_GENI_DMA_MODE_EN)) {
> +		writel_relaxed(1, base + SE_DMA_TX_FSM_RST);
> +		readl_poll_timeout_atomic(base + SE_DMA_TX_IRQ_STAT, val,
> +					  val & TX_RESET_DONE, 10, 50000);
Any error log to print if times out ?

if (ret)
	dev_err(gi2c->se.dev, "Timeout resetting TX DMA FSM\n");
else
	writel_relaxed(TX_RESET_DONE, base + SE_DMA_TX_IRQ_CLR);

> +		writel_relaxed(val, base + SE_DMA_TX_IRQ_CLR);
> +
> +		writel_relaxed(1, base + SE_DMA_RX_FSM_RST);
> +		readl_poll_timeout_atomic(base + SE_DMA_RX_IRQ_STAT, val,
> +					  val & RX_RESET_DONE, 10, 50000);
Any error log to print if times out ?

> +		writel_relaxed(val, base + SE_DMA_RX_IRQ_CLR);
> +	}
> +}
> +
>   static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   {
>   	u32 proto, tx_depth;
> @@ -1209,8 +1257,7 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
>   {
>   	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
>   
> -	/* Make client i2c transfers start failing */
> -	i2c_mark_adapter_suspended(&gi2c->adap);
> +	geni_i2c_quiesce(gi2c);
>   }
>   
>   static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
> 

