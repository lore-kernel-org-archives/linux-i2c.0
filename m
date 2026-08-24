Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7B3EC833
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555491; cv=none; b=KwmWSQW8u9c/9GyhqVkH7tw0oG0h4Rk/qHGApVTWrgAJP88bb6GDssIRRAahTKbDf7dkNPohU1ZFf8bCLck83JBVSRXbsENnC8kMezzuRicggDUpshtnJoQUXPzT1KFKBCais/y+kO5VkcpO345d6lXFzFnz7bM2kgqOD4yB3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555491; c=relaxed/simple;
	bh=FrdPFkyHggmSRx+RzuZb5WT8yJ1zubNcZiIbwDqt6mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcoZ4d2mdHsPOQEqfvdAc5/F071CUUpLdYd06+ODfSSAwRo7+WuBUaEwTTzJPGLAhVVAhA2bSAMTFwneuQREHynSPXrgchm5ht8d4Esbtk/yjfY6KbMApVDu9UOSRKG9DrU3PqrzszIcK7Y9J+Tnb8VC0+gJN+8zQ3t4vBf6Cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIl0hdXR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X9zRBGnx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIl0hdXR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X9zRBGnx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O6Se3Q1982510
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ds5lI+oACc5DuEDOT144k75RF4KIpDN8t6w5EHUqSmU=; b=oIl0hdXRkdkFIAQ3
	tPaV6B4H45/ZoRwErpK7NiDGYPpcZWMO4++UOPa3RMAMCdCtGdAFh7Iob8nVeeeX
	q3bQ0As6z0h+DuH0mu8JvVLLqH2xOLIoepKrat6vFESRokV7GWF3QlzbPhwXVMPW
	R2oVnzOWuxXrNP6ggIv/dGMb70Yrn4Qrp91TRQlxTPY/AaHMsIq6GWE5EsguFM0k
	EKATdl7LPEeI0AUIu3U5viR3IIvVBbxS+vc56AUZRmGUYGi46VNMce86/rxcCAMr
	XhUSLPnp//cd6e13bbmzsAv4cyyJepdj+HAD2gk1zWKFtEt5LxXXFbKiU77gcv9u
	spAu/A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn87d1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:11:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso4885018b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787555482; x=1788160282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ds5lI+oACc5DuEDOT144k75RF4KIpDN8t6w5EHUqSmU=;
        b=X9zRBGnx2pYbsDUCW5PAVgGlagxq94yi3CXXbPXyM/dCXth7LtzTzXq4LOp/TTLTfH
         sSVdx6ObRASboQ+FZTxwK7ikrF2MgBwPHavuSUTqarFHYXMQk+hmWGA8Rvd647n/T7zz
         5UDyTK+HMiBYYUcwJAW7tcvhb7ThlOWuPVrGFiX9tjGGtpanM46owKrlRtNSsHzsAG6a
         rBxaqwewQbPlCrfUdBDOUYWsEPOje7KPIaecIv5Ikyx0IhYeyGvfoBt8ayXgmVD5eTC0
         nE5KGs5+e569ceDqmP3gTaTRNPmCaV6A7qoIvelIfnhBo2kZDAfIhz1tiURb5ydqk6ry
         KdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787555482; x=1788160282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ds5lI+oACc5DuEDOT144k75RF4KIpDN8t6w5EHUqSmU=;
        b=Qi2cZQi9t1t7eJ1ZvMQ8toJN/7XpeRLBqyKKShhInTaP+w+VjLoBkTEBaqDlmvs9Ok
         47i0hAeDaiDxc6Q4ndDwxvRtG6puP9G33cI7nqQyGo8XOVOG/tA0wRypMdGdgk05ZvTD
         WHyX2mOJHP2c0tPSKNS681gbieCVnU/6mz8DOP4Q8ZzntiPgB3MN6x6QNLhsY0nXC9KC
         xYbUE92V1P5qJwV0+8qhlvUnzRDtqyrvUS+g+YJYViG5Dtn4Fr527TswRoLYXqZXJEic
         bwLHNgIpUwHj6blOq77tDAc+kdavQiBJsAEuy3N8RCiyP5ltoNuOGkHZuu5BoSljsP4i
         ef6A==
X-Forwarded-Encrypted: i=1; AHgh+RqAndH6K4sKvcRROwvIVOs/eqmcz/KEXNu20DSU+NMDdDtspM98Q90E61zJBs+pONVuUwKfvbKaip4=@vger.kernel.org
X-Gm-Message-State: AFuF++n24zEtp6dujmZ1bBfbSpex3AZB6VlT19wQcW4+BSPrxPjfArgA
	f6lmFaqjdFLe47xNw87Avjnndb7Yl950UasU+sKGVU5JurKTWH0tLVYfw8DBy9TPs+c/xsNc6SZ
	jDNUGHrIQw3G4UNjfClVlTCAG+HHBaBsyvWJPYxvW98klyMMOJ8ifgkI1kOUdLrig2QSBZgY=
X-Gm-Gg: AR+sD13QTjzN+LvttAsJD+tOtO+jutKoN3tElG4w7j85RCNSI6tHN4elyQWX4Z/1BQJ
	IgLbBa/SH1Tv6iASpKpJE1tE/ybEpWj55sFXokEZkeD5uWR+rvl7tCMjBvsnEvHP/ezwPd4ZICg
	VY0kHiKtvQF1Brjk/CSDrMFu7xWsdvlob+UckXJsYhwrOlerfyPL+/Vlu3uzq1wU1s7d4Yq8Q2J
	3xmjOJSR2pSQMV3FJ0nVWfrwd73h9c65+4J8DZZxfPD9vLwByACBCwS3jUsQEapN3AcGBKY0Upw
	P/yU/8E9i4NyYRqsPxPadMQpUsMMRxLBbvNrUrwFc5oxluX+6gNnXzWPFVdCzNdz5VaO+ffxdDs
	oCF4rh6P1XR8tM/gTPFGBtyMXy7oulvnUhD4=
X-Received: by 2002:a05:6a00:2443:b0:84e:354:422b with SMTP id d2e1a72fcca58-851f9fa4beamr20152378b3a.2.1787555481783;
        Mon, 24 Aug 2026 00:11:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:2443:b0:84e:354:422b with SMTP id d2e1a72fcca58-851f9fa4beamr20152323b3a.2.1787555481299;
        Mon, 24 Aug 2026 00:11:21 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b065sm1605045b3a.32.2026.08.24.00.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 00:11:20 -0700 (PDT)
Message-ID: <7222e72f-e618-4a78-8b48-1e712b9beba5@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 12:41:16 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
 <20260813-master-v7-2-3f9010cf9229@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260813-master-v7-2-3f9010cf9229@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MiBTYWx0ZWRfX+qtwgRA6HKA5
 1N6O5QLgCRqFOVdohato+qlwY2a99oZlE5Dzgr9ep1nIivzjzD2a2JsfrShJ5QROnIZ/Yo0FB7+
 KuqZIvGsgvyFDOI42ywLPYginUP4rBk=
X-Proofpoint-GUID: RsJFWMsnNz58nENEBJpPkdbcwKJmN_kf
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8bee9a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=XKFieZ_GiUe8G3MB0dMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MiBTYWx0ZWRfXz5MAjiSaIEdK
 9T8XmWgFCM4BOsrFqW883KY8BpOht1U3jtI9yDqZLElrIZMdzTDN0HEpWfhUV8sdQ8qdHSexIFM
 8g+mHyN6yPlukFBYnHv8SUALMXeEt4cxgrrkN5EFlOUe4d8OYHXweN46sxjl243n+2CDqHuPa0n
 0WqM3oiN//Pngcj1VoFm2ZY1sfMR3iznV/wa+yd40Vjmh55iT0tBGTJInSp5zeWJcCcCMccjRMS
 2gixBOHaKPGO8osarJplufagbA/cgdtChNwj4PMU9eSg+Ki/AOXseTyC0ZmdQ74DQ0QrFrdiPd+
 JVj+PX/OIrIkMmG/5O97+o4+OuGZcqWswoPSfpJeW6taIcSnD6uCY5pFdC2BKR+f0P//c1jOaX+
 +aK08C/zRny1/q5ZHq1yQTwEBUuVhomH9xqtK/6POBmwWzuZNzZZXwI/w8WcowEoP+Thn9POx/W
 xKZPQOB9r08DKm7qzuw==
X-Proofpoint-ORIG-GUID: RsJFWMsnNz58nENEBJpPkdbcwKJmN_kf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240062



On 8/13/2026 11:15 AM, Aniket Randive wrote:

[...]

>   static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>   						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>   						   struct completion *transfer_comp)
>   {
>   	int i;
> -	u32 time_left;
> +	unsigned long time_left;
>   
>   	for (i = 0; i < multi_xfer->msg_idx_cnt - 1; i++) {
>   		reinit_completion(transfer_comp);
>   
>   		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
>   			time_left = wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);
> +								timeout_jiffies);
>   			if (!time_left) {
>   				dev_err(dev, "%s: Transfer timeout\n", __func__);
>   				return -ETIMEDOUT;
> @@ -778,8 +787,22 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   		dma_async_issue_pending(gi2c->tx_c);
>   
>   		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
> +			size_t max_len = 0;
> +			int j;
> +
> +			/*
> +			 * Use the longest message as the timeout base: one completion
> +			 * covers the whole BEI batch, so the budget must fit the worst
> +			 * case single-message wire time.
> +			 */

Using only the longest message length may under-estimate the required 
Timeout.

> +			for (j = 0; j < gi2c->num_msgs; j++)
> +				max_len = max_t(size_t, max_len, msgs[j].len);
can we use sum(msgs[i].len) instead of max() ?> +		 
i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, max_len,
> +					   I2C_TIMEOUT_SAFETY_COEFFICIENT,
> +					   I2C_TIMEOUT_MIN_USEC);
>   			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      gi2c->adap.timeout,
> +								      &gi2c->done);
>   			if (ret) {
>   				dev_err(gi2c->se.dev,
>   					"I2C multi write msg transfer timeout: %d\n",
> @@ -899,7 +922,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>   
>   		if (!gi2c->is_tx_multi_desc_xfer) {
>   			dma_async_issue_pending(gi2c->tx_c);
> -			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +			i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, msgs[i].len,
> +					   I2C_TIMEOUT_SAFETY_COEFFICIENT,
> +					   I2C_TIMEOUT_MIN_USEC);
> +			time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
>   			if (!time_left) {
>   				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
>   				gi2c->err = -ETIMEDOUT;
> 

