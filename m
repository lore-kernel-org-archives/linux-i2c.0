Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD563FD95C
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426066; cv=none; b=Wj4xn1CpIupWqPuj6h5a1VjhO2kUGdbcLFfmj4+hJHLBNGRp/yhMZGiKFy5Ucwo3sxoNeM7nLe9P9h4kb/BBpyD+6hTTCgBju7trWojjQkOCycCUss4V4BoX3Tw8vljLnJOlf04ODLv/k4sqEuwfvKb0bwJjZM2noxBWLPouhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426066; c=relaxed/simple;
	bh=sx8vAXwqtM2BF1RSMU1Bl5a+jAMRY4rgd8VoA4MEKH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBuix5IXglZUlS5KjcGXhIlcArgm2S8nHJgMfef6wGEw06BgQY+JqFveX4VWNXQdqO9StAu9OLQ+Yu2EIioaiKQWaHUZBm57D0Ike0xBFJZVpALd4v/alb1uk1aPIXnHShQgzBWQB53bxkkZpywH/YDvkbrkIMSVCK+tF1ajPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=go+XicZp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NsoM/IRs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="go+XicZp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NsoM/IRs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667A74at3471437
	for <linux-i2c@vger.kernel.org>; Tue, 7 Jul 2026 12:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=; b=go+XicZpWJFxQRlD
	q0EUzpDkuXG7BOzDsO3p6LrAZ8TKf4BxfuGYViRgyBuKbXB7E/XEb+yH0WLd3QBh
	9YtUZFlHi+9sxl9rVRRpjZeYEPSb9fuOlOE+7d2pBtrvGAZVqxopGXu7PzFWFKyF
	XEfkDfk7Xaz6V2dtpmj4qWI6JkeW/KU7JQOaAr4skymQA0gVc71JaaTujABrld3K
	z5HOWBuaqA7JEBugDGD0atRrgsTkdrNCwdnze1jKdYzSvmAZFsQgCMpvuxWMhLAE
	sXjDGV1VD1HkALkWTxiPC5pjx+m7s/Xt0yzsCGNv5xWx2DdjnTqX16bjqLN5QJx4
	e4RvZg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0geb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 12:07:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso8330767b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783426063; x=1784030863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=;
        b=NsoM/IRsBD8cswNnh2zuMADu8DfXNj0fn+a7JPtGcSXn5LZbrEw1pSXc4nY9r9boqD
         MBFn8tAzI7u5Rnp0Va2Cer92oyTHdpHd/3UZoLYo6b4kQuKL/o7cnR3hVUE+IOb2UYU8
         Vi/PlNBDZ/ntguZyFxrlx4O5ZvgoY1CdW7zAzJX7MAnCfkotffex62R76jeo8chntDyM
         b9tYtjF2kW6129ByyLVEV/nU7l7UCYGZQie3cVxGBP2giRxuaFrAq/NXpEqFaRK1G6r8
         E8DX4jORNNafA7y39gtOSYUG27gYnVsFBHuAP8sqeoZmZeUsyoqoMhu20BN3jCkjq6Pt
         BPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783426063; x=1784030863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSZCpVJgYGNPn1Ohux957EKWIlXyg6nTTccZRFciuH0=;
        b=MQqM8tN2yVe97PKGrfMcVESk/XOUXZlAzMj+58v0oCI+TkVQmDyRpmXi1uhmJuxD5m
         zCZdtDubsNf4YMqqkkRw3hLjdOkSKRHA3rPvVzgyG4f1xJNaxe3nUre8uS/wC0nAUv04
         AMeKTcbDLnk5MYkVgs3316Khdv4hzvKlxiMI1NXuy/Fg0bajk75cCUv8OAauWKHJ0mIH
         /GAY6VsLT+gqmVfrIxLCYw8sJicdxEsX/RCpiJloZi/dd9KxJdzBgrHn/eSy8mITtSI8
         I+vu77TsaXnruaG62k/rAXNwxv06nOZ0Nnbx82xNws0DHLN4sJR6Nfs0/iBgEwgaHvpa
         0zdg==
X-Gm-Message-State: AOJu0Yy9gtDIWZIyqDKb8jmbQhOboDpKEgSeELmozGM/mX0eJjsyGkRU
	LZ1hHsn/ujYQIexFs0/S4qO6+8CcxEIQZfqshJXM6ImuPgi+7k7nQg/34BIepbxXxg/5TwzmYqE
	iR9wezukTxhugWn0URzdf7lD2E0kFnaz+8AtmPgV8HyEDrzHYSM5SFSW7EG/oOTo=
X-Gm-Gg: AfdE7cnwL/lK3FCFcWFzDZhR8fyC2JM7MmoE5sdw94ywXfTR/uNZtwWKAtbaZyT/LGE
	wD5kvdWbeBfxda/Rn49K3avvC5i51wyII6jfVQAmL93yGWqQELSEpErsEpk8Iv+3W3WmQy23qwm
	4gOA75u4S901Xk+VHXRaB/sFH9DgTUUwCqoxOp65vew+MtyGFlDO3366JvFqA8aSx1tMIhFZ3gO
	OclLY/EFtNrtU3CbzOtjBZ82CFCoULu0GInipghvkYjZ5eJ3F3qbQB3fF/i+gybYl2qwidSvojZ
	3KaeWGQEa2Y92Ri1NajBdAD6czuIdnCa14vwuUR61Lavq1vjLtQ7xUE5hmTs6okMpfBVv82Cw0m
	VSTqfPu/gIrvlwVaZQk9/ozo+d/059eAfqTTceQZ6PuVB
X-Received: by 2002:aa7:9a88:0:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-84826db0b6emr4883538b3a.38.1783426062779;
        Tue, 07 Jul 2026 05:07:42 -0700 (PDT)
X-Received: by 2002:aa7:9a88:0:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-84826db0b6emr4883488b3a.38.1783426062170;
        Tue, 07 Jul 2026 05:07:42 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm5359873b3a.57.2026.07.07.05.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:07:40 -0700 (PDT)
Message-ID: <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:37:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KenjXH8ehqLYDdmGL_UiyGns4YmGc5Ea
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDExNyBTYWx0ZWRfX0ywVqfezCA7q
 2wsTRyQyFfdhrMf5Udd7VKUiIyLzJQqOQmi1/OlN+2Ui3j2J3uZ8bpXh72SvnO10l5yXZ2EpuhK
 W3lx1ZAUjCwB1I0l6jh6SlLra9zMaCU=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4cec0f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=5YGwSrtyFkuD1B6sRKIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: KenjXH8ehqLYDdmGL_UiyGns4YmGc5Ea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDExNyBTYWx0ZWRfXx9rhnm+bGtJu
 IXxrhxfrmDuDYK6E5egzhmErGjtWjqPFQLNb9zA2uY2/ksuSB5XkuQuNkCYh8pKEJV4uyqQVFpl
 6f5PqXbrFB1mniuzfgTpcexRQpQklj74h4R5CXnXKd1TWbBSRfS2coSIC01YvyvwJ0z2WjVxdRq
 3mixsd7sHkyl9fvXMolL9zZry1G/w706qk0Nw7cSlAFP2//X6WW8uQfRVjDyHJEgYZuVBUR7sd0
 rJZaVa3ptwfV2/G8Fb9i+64ppBCNWPJfsW+lY4/fcSGB0gNFG1XvlZiceGKDIc9YMFm6dXATjTG
 tYKatYxBMWRslO6propOIuFx+kOW2bmLgo3KL46xTewOg+Rds/FrMIfjCTVRETWuDeT1/fdldot
 /bIfYurTolImlwJdaDuqTz9urnjhrcyiLXzKq0K/BhhwpuPZRgYj2pBu+dehhWdoT67lZyeeWWR
 QzyHx11c4Q12vWssjMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070117



On 7/5/2026 7:27 PM, Aniket Randive wrote:
[...]

>   static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   {
>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
> @@ -471,7 +484,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   	}
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an arg ?
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   
> @@ -513,7 +526,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>   
>   	cur = gi2c->cur;
> -	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(gi2c, len));
>   	if (!time_left)
>   		geni_i2c_abort_xfer(gi2c);
>   
> @@ -591,7 +604,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
>    * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
>    * @dev: Pointer to the corresponding dev node
>    * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
> - * @transfer_timeout_msecs: Timeout value in milliseconds
> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies
>    * @transfer_comp: Completion object of the transfer
>    *
>    * This function waits for the completion of each processed transfer messages
> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
>    */
>   static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>   						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
> -						   u32 transfer_timeout_msecs,
> +						   unsigned long timeout_jiffies,
>   						   struct completion *transfer_comp)
>   {
>   	int i;
> @@ -612,7 +625,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>   
>   		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
>   			time_left = wait_for_completion_timeout(transfer_comp,
> -								transfer_timeout_msecs);
> +								timeout_jiffies);
>   			if (!time_left) {
>   				dev_err(dev, "%s: Transfer timeout\n", __func__);
>   				return -ETIMEDOUT;
> @@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
>   		dma_async_issue_pending(gi2c->tx_c);
>   
>   		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
> +			size_t max_len = 0;
> +			int j;
> +
> +			for (j = 0; j < gi2c->num_msgs; j++)
> +				max_len = max_t(size_t, max_len, msgs[j].len);
> +
>   			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
> -								      XFER_TIMEOUT, &gi2c->done);
> +								      geni_i2c_xfer_timeout(
> +								      gi2c, max_len), &gi2c->done);
Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an arg ?
>   			if (ret) {
>   				dev_err(gi2c->se.dev,
>   					"I2C multi write msg transfer timeout: %d\n",
> @@ -852,7 +872,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>   
>   		if (!gi2c->is_tx_multi_desc_xfer) {
>   			dma_async_issue_pending(gi2c->tx_c);
> -			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +			time_left = wait_for_completion_timeout(&gi2c->done, geni_i2c_xfer_timeout(
> +								gi2c, msgs[i].len));
>   			if (!time_left) {
>   				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
>   				gi2c->err = -ETIMEDOUT;

