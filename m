Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108097;
	b=kUWYeJibXbDtwGrAsQ8G/RW8ViKnoUfu2O7CrcwkVlkbp1ZFyIfIq6zOn2rVkXP8lVJm
	 v77ilK9PPCENWlf0tw3Qdz38hHBuf5m52Aljz2UhrWO9QHDQuX9dwfgV1jAkwRcg2C6Kh
	 ozSjAGRbED91hIfGWVwbKJXwbTq5cbkkldU4U6JkX7tmxK5QC2pg1X+90keZSnmH9OuAi
	 6rX5k5I1zUEfhNSn6z8frQrWs0A2m3EKbnHV24gVUy/FO3S8YlW2Ylx8hES6tXbCUStkm
	 P8ckzDHOK8Ekcy5t8PD/5caKEpjBlSG3xfdKlVyPAYrKePlQ7WixiX+EMETPNa2KE+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=humybFG+4U6oD9aPKeirurXab/GZiJOO+gMWAoyWycQ=;
	b=uoXprIDl8+YcpTIhdiSfAaSzu6xHnOHOvXZ0GC7l5kgI5ztD5jS8n0ERwnsdglmcHqTQ
	 hEZ9skbwUGo9DkV4cA2U5cvGOcZRe0ahtXXdCheLDe1cpD+HmFE5xZieUYhUoi09SJR9U
	 3A8z631TPgOGOcnZiVp59uHvzJl7tkck1zW00+8IaP6v8jO6GhDbkQ4Yue558VxDJ+NzG
	 Syt4s3v+h6pDWBjsmlRdYJChRXbZKR6WUIsfj9mKGFTqD0PDiejrjvpnkjPD2opneMa1N
	 /zPskcOU6mxpvGzzOqt/xy2Y+Q2Jbb6j3k3WTsp/Q53+j9D88vngFsmr1Dw62WTRJ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZc1ObIq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kKgtLxn0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65775606A31B
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65775606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZc1ObIq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kKgtLxn0
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeK8W1427452
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 13:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	humybFG+4U6oD9aPKeirurXab/GZiJOO+gMWAoyWycQ=; b=VZc1ObIq3VYML8eh
	tRUqcPH7SLsFquAM1/bjN6JN0kOjqUOrYN1f7uZJfTkqBvUrK5bDlwBaLh6xKsvI
	wpwpF2me1hy9+cKf4i8IWqp8GQFKUNRz9HrEzOG1Atw4xQjon9+RWgsqHzfvmCAK
	1C1ZPuc3XNVCOMPr18aOeVQaPElik7kOQCnq3Seaqyx5hlRF5TEsMtI+xD6HQWaM
	7rCxBIg9Z4KDz701Wg+H8j/nlWMGp3P9rkEUPQnhCki2Qt+LvNQFi2ct0WBvt3xn
	QYB6tQJ9yWGltPT27H3/z44lskLhwuH2e6U4gEAcph3HI6N8L+XGPCG9Ik+R4jce
	sEFXwQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbub9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 13:34:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14364a88479so101020c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108095; x=1793712895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=humybFG+4U6oD9aPKeirurXab/GZiJOO+gMWAoyWycQ=;
        b=kKgtLxn0gyFEUGNKsxvLyDDqTSPC5z7sFnBKKR9r6iMMsJVz8ZvVaXr85XUZdmmsM7
         kB9P8yV3q7jINgcjjz0d6SyW7Q/UNlR9vlNMoPYWWEq/jD8+4wgHeGd1JSPkeGc9pO6C
         6wVCvhqjeARyCD5ZIaqWkU8nB+n4s8ScuR8OwnbnBA3iiyZx0yXJdGwPKxKv+w62Lwq0
         LzJwD6AAe+Wx45ZeUfeZSE4W6y5xQ2mXcJGflzIL04CwEYpe0olMqvmlMtVf/bvjIZh4
         eo+lc47Ql6QDtx2YIhhh2qYTm6+o8KH+E0U38r/dP6B+FDDfFvj4siinR6JTiacybEh6
         /9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108095; x=1793712895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=humybFG+4U6oD9aPKeirurXab/GZiJOO+gMWAoyWycQ=;
        b=1UpJpDRxdL/M6x1jcZlXYdXYSqiRdgcrLHv2C3SecroZ3bYZHv/Cb81RrV3341G3cE
         y34HxcAHAWd+QTNND0Kcm2/c4eKp2AHiNjZSi0d2Ghee4oCFifwMMlkIAh2+o9IYd3vS
         oDOydrLNseg3xGTEWx7TVhUyJ/4N8k/HSpZUqopGdDtSlceNdjDAsyFXIFLH0OJsXp9K
         bVXsl1k46SBjk/W8W3+9rw7p3LO467BErX+/qlEtj1A7biVQw1U3kM7nZzgOi+WPGv+q
         PGBX7wmCUzx8ONep2qDk2sqgjkHlV8mPEEWTE6BjzHrMxgen/t7Fa1o7/QKAAt/Z6kG8
         pc1A==
X-Forwarded-Encrypted: i=1; AKwUvBx7jovVKaDnazRNus8CdGSGpxbae6Xy3wQVUUT1TWZx2Iq+MtB7brjbKU8YzhMTM4HlJafgjv0U7pw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs7v3ZbG05ds8A0cDHE0vno6UW0EwPY9rPsET3ohF7IWzo5nk0
	oas7InDa6OBin1U0lWdobjaaCfF2hZs3mmiFVsEkSFA3JPYMo+JzeYnj8yQBurY1uS0D1+rm0SL
	MXh7g3xmEdYkDAta3bjBNHGks8QIlChD1G6OtS/kttCLncrEmEWdGJQ24c7YdGms=
X-Gm-Gg: AYBFou2QNNsmu/2wphmqg00PnowoC2k6NWsc5nnjFOiDhhvCl1Lq6IWwVBgX0khMt2n
	58+LeFz1asHz0FtaTuoMafExZDJUhRu0ojKuEnQcHbkQodGNRdKVTkSRphJ4b8wDR3fEWX5qL88
	LNRNtif0gTe4QbzFTqUDcaRx/WrzIM3efmp5a0SjfLAPh1uAtBdGiKs5ansC+Xks8f0oAY4Fbdc
	xR/xk1oIw/oVlGek/p/gJ7VADRrpc9YRrMgduGqcOxnz1FzKfbzVEraWTsGWXz2arLUfAvVL4mz
	BXIMt0x6rxQXP/snmuNFF+Y4MRUng+4AzQhP0Y9DCY7ZZA53nwaqfH0EB0XL33hUZghjT46tED8
	3nZJmwq/8EFn7cRyK5dnCNpfCYS2z9Yv9Fw==
X-Received: by 2002:a05:7022:f8c:b0:1a3:cbd7:1269 with SMTP id a92af1059eb24-1a3cbd717e6mr5335380c88.23.1793108094424;
        Tue, 27 Oct 2026 06:34:54 -0700 (PDT)
X-Received: by 2002:a05:7022:f8c:b0:1a3:cbd7:1269 with SMTP id a92af1059eb24-1a3cbd717e6mr5335328c88.23.1793108093680;
        Tue, 27 Oct 2026 06:34:53 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm39957140c88.6.2026.10.27.06.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:34:51 -0700 (PDT)
Message-ID: <197ed473-d259-4f1f-ace0-ce98ac0fd127@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:04:47 +0530
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
Subject: Re: [PATCH v3 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
 support
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
 <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-1-7f2a6e572de9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-1-7f2a6e572de9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX1wBCOWfqV5NE
 sMV46EIC4wjrcLAlF+KRNkXmWw9TRWGVVKox5Ctu/mJWsba5/mq/PHBBxgvcaJg3tQ4stZ1iWpv
 3O6MbTm0WscIW3s6oEPv25p7NA0TIjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX1UzcEjKcumIT
 5BqZ4Ggp+fwZSX0oQq3UGJHfBpi6PaVupTBkaME7ORO0xgNwUOo3/vpZBNTi1XEx0Iou503e1te
 jgtR5rS9iBCwyjinQwVRrcD/vhM24L/ewJVOMVs+o51Pjy0yN1jrMMv0VjrKRxrkMEeXHdU5koC
 hhufYcSH21kFQpRdVuCcyARaMhsMScd7EwGrOw3vajPvsT8R4jWe6Fl4cqju7T8fPjllyM3THOQ
 ygCrdD8YgYw+aQpyiaed6mAZB8jqTvJPL9o91fZpLtL14dqoabYK78tjl2euIhRCayATQKBF1aa
 8i/jyyuXRhNkbw9PwxENonNB4WUFAdDFE7Bge9Dgt27w+ANXp4oc6s5J3GNXPqMTWwNooCPqltV
 kLatZLKsFROmlC033TTtvvHQ71PKuuLZMZR1XlMOen/jkP2KFzWqFl8uQnQ89kDdo37cDFggzRO
 i8s2YjDIEYb1ew1fv/Q==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0a87f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=lV1k8KV2Q4sVphKZFiYA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: ZVCGKkCLSSVmNUG7qFgxRmfFr2upR75-
X-Proofpoint-GUID: ZVCGKkCLSSVmNUG7qFgxRmfFr2upR75-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054



On 10/27/2026 10:43 AM, Aniket Randive wrote:
[...]
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index c41bfac65ddf..394e7287f6e9 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c

[...]

> @@ -1692,6 +1709,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
>   			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
>   	}
>   
> +log_tre:
>   	for (i = 0; i < tre_idx; i++)
>   		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>   			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
> @@ -1825,6 +1843,18 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>   		nr_tre = 2;
>   	if (direction == DMA_DEV_TO_MEM) /* rx */
>   		nr_tre = 1;
> +	/*
> +	 * Recovery opcodes do not require DMA data TREs, only CONFIG
> +	 * (for set_config) and GO TREs. Since gpi_prep_slave_sg() is
> +	 * shared with SPI, verify the channel is I2C before accessing
> +	 * the configuration data.
I think i have mentioned earlier also. gpi_prep_slave_sg() Not only 
shared with spi but rather say, is a common function for all protocols.> 
+	 */
> +	if (gchan->protocol == QCOM_GPI_I2C) {
> +		struct gpi_i2c_config *i2c = gchan->config;
> +
> +		if (i2c->op == I2C_BUS_CLEAR || i2c->op == I2C_STOP_ON_BUS)
> +			nr_tre = set_config ? 2 : 1;
> +	}
>   
>   	/* calculate # of elements required & available */
>   	nr = gpi_ring_num_elements_avail(ch_ring);
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
[...]
