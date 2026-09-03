Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EE47F2D3
	for <linux-i2c@vger.kernel.org>; Thu,  3 Sep 2026 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452085; cv=none; b=sYo5JQXk4MQhksCIjdrt+jOlbsyYLv5QDMaZVjBNT/L5gk6PmmCLT1q3iCoSyH/mZxVvzWVCQqKaw2w/owCR1JhJ+Tzl6JZuglf+gc4HeWpWy/NBpN+HWwo3MmznrDl8l//eeA1kHGsaHnN84dkJ+x+Rz/HcEJM/SQvdrxwNRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452085; c=relaxed/simple;
	bh=KpUgVbJEJhauXlCo2ElxjoeTHrdPvZ44Y93fb41JCkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW/RdlFw3wLxwR0P4VinfnA9yfhwZ5XgcVUdUflX/jtAsHSJGXJaVkHifMUrF39psMyi/TqV5N+Jj37XcTE/LJz0N4xuI+2csaYK8uHItMZZBNQyzdavog1KaLjICpKygYBGpKvHzjv/yzCHrHrDCYDYqLZAmGCE7VN9JQCXOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6q5atdo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axqo3y6K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6q5atdo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axqo3y6K"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3rci1091730
	for <linux-i2c@vger.kernel.org>; Thu, 3 Sep 2026 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dUUQa3IhWuf5ncDuuq5tVYRMx6lHsZYcTMpZH45yYcI=; b=X6q5atdo043c0aI3
	fl5u/axFQrGR5VP6gXKytSsYT5MFMQj5S/iZxd47gAQzx97F6jypceq/WY19jvEh
	PnnonKOGoWaCgZowS4Ky25PNwuDbU3RTWVZDmrpebzvpXGUumm/pzmwtO16LLj+x
	3eVoUh5JwWlVry+toGcevuiOtc7ejFAWL9DP0+P2gSTWQDv76uhhMscouti/G++4
	6or19FaGOSNfPR9dgwV65VekJY4hO8ZqLjK2jZMo4NSHnGWE6+tIn/EtBlKOz39X
	5A7vIB0NhkRILL7P89fwwYEBl14X68er5lW9Wc3Zaz7xi+OroYdIEEQx7A/kSKRB
	y0anSA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekja2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 16:14:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so3333439a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788452081; x=1789056881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUUQa3IhWuf5ncDuuq5tVYRMx6lHsZYcTMpZH45yYcI=;
        b=axqo3y6K9HXnKVjTbb8aRF3SiUqmoz/8audQt2JHIu+FNUGWiCiIcNg/u619GMdAxB
         V6ysqT58UwUb52yuvNbx8iw1CQak2c+KUa11wQt75DaEizXRdgVNu0L5KEO7F0sMIUNK
         DAsLJIvWZHwpg+n6gMHNGLxNjMQR/olFtTG90O8Z0bYmYqdy6sRn3MKOHJmMJ7Cgz790
         smAEEN/qmsPezZsc5q9QxDc386Xrb0UUgllxidSsWrVggdSpUD7sSYPKLmmzlprH/kHD
         nVMQG0Y8sQ3OxKo8cUDmtxGZDd4bgXbrW2DFlpZohM83jOtD00+IaY/OoDvt8mzKvRV5
         tzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452081; x=1789056881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dUUQa3IhWuf5ncDuuq5tVYRMx6lHsZYcTMpZH45yYcI=;
        b=J1IpONkJFALVaNsjqYA5MtmoDkCl/tIuyEa1+xkAb8SHXgiRvmqS4Q/8HtQTmzy0Z4
         KrH3OhV6gg5lzxt0VYsBQCk+gzNfSNT8xCqIh8e50R7jF/oxdiZOUGGkCfL/KKfVlDwh
         ePNrIf2w6227uce1tCHtYXjmKf/rZkgXYqrlak2kP0b9KfGd7K10Wm8cdWGFEBX66aMG
         0RD4YUxOppputRVwYE1ZNbi+h+juAq6gbxh9CTd0yRo3c7br88hHkRoQZTtrwd+H7n1d
         Nr/BtBdpJFZ5kwh/31AQSc3GjHV+GJNnZ4XwEKvN+hMFS7lkH3ZJKOv6GSh90pojQppb
         gHNw==
X-Forwarded-Encrypted: i=1; AKwUvBxeKNhqHBhf6OxjpoTCOPiNESLsw5WylXEg1jKUPdQLvN3QCIDop7Cr3TJ0dytm+0MELK6CKsLd2lc=@vger.kernel.org
X-Gm-Message-State: AFuF++nfzsIZy6LhmESdkGsNrmv1QkIEddIItLrJSfNKkCKOkXkOKrus
	buVBJTAr/DjDk/z/7kpCMQBdULBcLhLhomRiBOdwfbxrXWQv6prvSNdwnGjSTWNWaFcMPygSoTk
	ZiQWioOhlcnlX+L1OAfvkeXbZI6x9fzeSIPeicW/36meBio5iUOGvXrboHgFS0jk=
X-Gm-Gg: AYBFou2FtqBpqJc8v8dVHS+LO1Vrt9tyxHcSRxW3M56Gx6hXfXPvrurhHAwlFS0vkyp
	xeWVyCGPdMyi9aWlg/uFdR/oNEnlDW9/HcQbNoxdTueQ9bm0aeK03nHKH8Jh/t936KlvXPPVeE0
	xAMTdfHF9aIexhNJWI6zMlIKgU2yl/sk7Z66aj7oPB1RnhjCpEW4MjyAogjk96IZnDseebkj/rK
	m8tFS3LJlqvGJWnmCfvQZFsWkFI+mMnTv9bCJPQ4WrjVbAPCMAejxH88qcNScRvOBOtkzKDVWbk
	bLzhKNV2EQK5EjZZWBfnFT3OXoMXqLQPCUGRViTuIbaiGG/tN/EwtobQ9Cvw8AQb9PigfNPB3B0
	p/ypnDIR4Xfm8qZxD//Opc7ozNcqaK5040QSZ3Pwnwb9J
X-Received: by 2002:a17:90b:134f:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-39b22c5ae4dmr1137792a91.3.1788452080439;
        Thu, 03 Sep 2026 09:14:40 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-39b22c5ae4dmr1137690a91.3.1788452079818;
        Thu, 03 Sep 2026 09:14:39 -0700 (PDT)
Received: from [192.168.1.66] ([103.172.4.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm6255076a91.17.2026.09.03.09.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 09:14:39 -0700 (PDT)
Message-ID: <7cc05c51-811f-4949-9fe6-10580ff90eea@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 21:44:32 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
 <20260826-i2c_bus_recovery-v1-3-203f0ec76f84@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20260826-i2c_bus_recovery-v1-3-203f0ec76f84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: noEyoUWK_RvN5Tyecx4HUCoIp84749Gy
X-Proofpoint-GUID: noEyoUWK_RvN5Tyecx4HUCoIp84749Gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MSBTYWx0ZWRfX5vT77kpnaGxz
 j1ojeEK9rTQ6vE+frgy8C1wJ63PBt4/IMOrn3P1aAKGFsgeXnPpVD7nSTlWQe8u1LblkjAhwSX8
 AIkIR5Vt2Jea0SOh/mHn1/wO24rqIzwptqQKChUFYdRrE1AR2XGXeCKkCaXk+IBbgFrlXT44UUt
 s+wQkmd8LsUcd4plxY/zZNMBt9LnZmkKOmn8fQKGC9XbwWpABz5omHksAGWPWg0+XgVrfdJ8ZvX
 rHZ0rkAnI7RHul9HEyXXk9bLaoK8JDv3vHqch6czT/ibrXq9C1qK/QTXy7iIXsNKmMQyHiye+0t
 J3nCvdWQO/PmNQIFmxuv3x8jZiAy5aJQa/eBA7yMMpO/k1rwcl+Gz4BbD8MaBo5bzdfsh39VWVg
 Nz6n55gKoxFQl0EcwBVMx/C0Zz7CkcvQDWJcdHY7VZWS19F53QbiRT2HV6S3VZH+lTZpbU7sor3
 gUDM/hSKgAuQvXKWqTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MSBTYWx0ZWRfX6qAs499u7VLk
 Gu6QDZ7cA6lKFOIOPYAF78c9cGglq0433cHsXaxgU59+ruZFo97Pz2OwixyVvl+xQzZDYbgrlSn
 xG7EakdGDOlK1IpnKpq7fqKI/uxcMr0=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a999cf1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=EcXJGs5vVKLEW0aY/poVLA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=84XQMU3cwwySlwIbdQEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030141



On 8/26/2026 3:21 PM, Aniket Randive wrote:
> I2C transfers in GPI DMA mode can fail with -EIO when a target holds
> SDA low, leaving the bus stuck and preventing subsequent transactions.
> The GPI completion callback reports a NACK and a genuine bus error
> alike as -EIO, and the existing recovery path switches the SE to FIFO
> mode which is not valid in GPI DMA mode.
> 
> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
> opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
> trigger with a SE_GENI_IOS RX_DATA_IN check to skip recovery when SDA
> is already released. Extend the recovery callback to dispatch through
> the GPI DMA path when gi2c->gpi_mode is set.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 104 +++++++++++++++++++++++++++++++------
>   1 file changed, 88 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 9fa1a8ac400c..85cb1367958c 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -34,8 +34,6 @@
>   #define I2C_READ		0x2
>   #define I2C_WRITE_READ		0x3
>   #define I2C_ADDR_ONLY		0x4
> -#define I2C_BUS_CLEAR		0x6
> -#define I2C_STOP_ON_BUS		0x7
>   /* M_CMD params for I2C */
>   #define PRE_CMD_DELAY		BIT(0)
>   #define TIMESTAMP_BEFORE	BIT(1)
> @@ -1003,6 +1001,70 @@ static int geni_i2c_fifo_bus_cmd(struct geni_i2c_dev *gi2c, u32 cmd)
>   	return gi2c->err;
>   }
>   
> +static int geni_i2c_gpi_bus_cmd(struct geni_i2c_dev *gi2c, enum i2c_op cmd)
> +{
> +	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
> +	struct dma_async_tx_descriptor *desc;
> +	struct gpi_i2c_config peripheral = {};
> +	struct dma_slave_config config = {};
> +	unsigned long time_left;
> +	unsigned long flags;
> +	dma_cookie_t cookie;
> +
> +	config.peripheral_config = &peripheral;
> +	config.peripheral_size = sizeof(peripheral);
> +
> +	peripheral.set_config  = 1;
> +	peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
> +	peripheral.cycle_count = itr->t_cycle_cnt;
> +	peripheral.high_count  = itr->t_high_cnt;
> +	peripheral.low_count   = itr->t_low_cnt;
> +	peripheral.clk_div     = itr->clk_div;
> +	peripheral.op          = cmd;
> +
> +	if (dmaengine_slave_config(gi2c->tx_c, &config)) {
> +		dev_err(gi2c->se.dev, "dma config error for bus cmd %u\n", cmd);
> +		return -EIO;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(gi2c->tx_c, 0, 0, DMA_MEM_TO_DEV,
> +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		return -EIO;
> +
> +	desc->callback_result = i2c_gpi_cb_result;
> +	desc->callback_param = gi2c;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (dma_submit_error(cookie))
> +		return -EIO;
> +
> +	/*
> +	 * cur and err are shared with geni_i2c_irq() and the GPI callback
> +	 * i2c_gpi_cb_result(); both write err (the IRQ handler under
> +	 * gi2c->lock). Reset them under the lock before issuing the transfer.
> +	 */
> +	spin_lock_irqsave(&gi2c->lock, flags);
> +	gi2c->cur = NULL;
> +	gi2c->err = 0;
> +	spin_unlock_irqrestore(&gi2c->lock, flags);
> +	reinit_completion(&gi2c->done);
> +	dma_async_issue_pending(gi2c->tx_c);
> +
> +	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> +	if (!time_left) {
> +		dev_err(gi2c->se.dev, "timeout waiting for GPI bus cmd %u\n", cmd);
> +		dmaengine_terminate_sync(gi2c->tx_c);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* ARB_LOST and BUS_PROTO may be expected during recovery; treat as success */
> +	if (gi2c->err == -EAGAIN || gi2c->err == -EPROTO)
> +		return 0;
> +
> +	return gi2c->err;
> +}
> +
>   static int geni_i2c_recover_bus(struct i2c_adapter *adap)
>   {
>   	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
> @@ -1021,15 +1083,23 @@ static int geni_i2c_recover_bus(struct i2c_adapter *adap)
>   		return 0;
>   	}
>   
> -	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
> -	if (!ret)
> -		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
> +	if (gi2c->gpi_mode) {
> +		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_BUS_CLEAR);
> +		if (ret)
> +			dev_dbg(gi2c->se.dev, "GPI bus clear returned %d, issuing stop anyway\n",
> +				ret);
> +
> +		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_STOP_ON_BUS);
> +	} else {
> +		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
> +		if (!ret)
> +			ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
> +	}
>   
>   	/*
> -	 * Recovery succeeds only once the slave releases SDA, so the bus
> -	 * state is the authority: RX_DATA_IN high means the bus is free,
> -	 * while a clean opcode status with SDA still low is a failed
> -	 * recovery.
> +	 * Recovery succeeds when SDA is released. RX_DATA_IN high means the
> +	 * bus is free; trust this over the opcode return path, which cannot
> +	 * flag a benign recovery event in GPI mode.
>   	 */
>   	if (readl_relaxed(gi2c->se.base + SE_GENI_IOS) & RX_DATA_IN)
>   		ret = 0;
> @@ -1066,14 +1136,18 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>   	else
>   		ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
>   
> -	if (!gi2c->gpi_mode &&
> -	    (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN)) {
> +	if (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN ||
> +	    (gi2c->gpi_mode && ret == -EIO)) {
>   		/*
>   		 * Only attempt recovery if SDA is stuck low. -EPROTO and
>   		 * -ETIMEDOUT indicate bus errors where the target may be
>   		 * holding SDA low. ARB_LOST (-EAGAIN) on a single-controller
>   		 * bus indicates a stuck target, not a real arbitration loss.
> -		 * GPI DMA mode extends this trigger separately.
> +		 * In GPI DMA mode the completion callback reports NACK,
> +		 * BUS_PROTO and ARB_LOST alike as -EIO, so the SE_GENI_IOS
> +		 * RX_DATA_IN check below is what distinguishes a genuinely
> +		 * stuck bus from a benign NACK: a NACK leaves SDA released
> +		 * (high) after the STOP, so recovery is skipped.
>   		 */
>   		if (!(readl_relaxed(gi2c->se.base + SE_GENI_IOS) & RX_DATA_IN)) {
>   			int recovery_ret = i2c_recover_bus(adap);
This does not appear to handle scenarios such as an I2C multi-message 
transfer where the stretch bit is set during the first message, but an 
error occurs while preparing the second message (for example, during 
memory allocation or DMA descriptor preparation). In such cases, the SCL 
line may remain asserted low and impact subsequent transfers.
  > @@ -1292,10 +1366,8 @@ static int geni_i2c_probe(struct 
platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (!gi2c->gpi_mode) {
> -		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
> -		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
> -	}
> +	gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
> +	gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>   
>   	ret = i2c_add_adapter(&gi2c->adap);
>   	if (ret)
> 

