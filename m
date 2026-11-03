Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690521;
	b=NrU4R33MQmagMe2aVmP5GCvnAkzmc+HSew82cUa5KhvkcwKpwiT7ncyPZT9tQeKTEePM
	 RpU3/AFcMGneT930l2ITd8+Nt9zqPGA6W2t/EpfLrFNy3SRogOLqUvfYOL9de68nbWIwk
	 OAC3gH6KQp/kE+S9MWJJSTj4XdXJ1FdWpQ7MGat3+mzPBt4I4zQV4XOCycSBFX4GO4CXp
	 E5+aduMdFT/CFZM0WJrmIWuIm+XESpSgZKzqwVnaLHZfuW2a8KAFYqEfhDHZpMZHVBKQ2
	 GRb+BgnSn1o02cWIMndr7z0N0F3EQWWkieyoObS6DJ0aR/V2Hwr5l+rs47V8FUHFdzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690521;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oNOQHJMVvx6lR/9lQldFO/azLOgEmsHBjYrpgr2OldY=;
	b=GD3PGWNNbIVsNGG+0G40BNOp4u382vA5NK8cKgt03qi2IxDAWy1hhJB14hFvN8bmLHm1
	 GOipf4aTeNMvC9Si+tBdyZYGHoClrcWOmkpWVneVHIdSK9uCjd7bIYSjsVYKgtZ5AQ6TQ
	 W5l0GTEj2Uze8EQRSgCxjnlVaObnvISRNyDlxNS2+lFLFAV3sh5YqXCI2g6H1B5mboCqm
	 55Lz/cT25f7Ca38Gl/4VtzQgsLLZfXmNWSCbVD7aZR5tfbDKAGe6mvhRRSr2JQ8toyYj1
	 unOrzq6I79z75W2ufAs28N7O0zB0o/A6rara78ZqJa+Ahjk4s/hcXt5XzH6pVmFQ2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ezMF53wN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BGtTIaBI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD129606A331
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 07:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD129606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ezMF53wN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BGtTIaBI
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31e5EX1397179
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 07:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNOQHJMVvx6lR/9lQldFO/azLOgEmsHBjYrpgr2OldY=; b=ezMF53wNN1hAlzpQ
	zPBeT7TC/xSZHNmjdsSl2GQ6BmRxXFvF3LseH/sFoC3xmeQqk/6NIN1TekJ4maEL
	KS788+hJBxvPILfskRTPGdZNmGuZ/KG8/5nB6EOj/VyBqQsqv6Vq47Dd5KkBPw6J
	RyyvbT9ow8iG0IElFc+hEonEiK9JZDRMZnZpxb/5mqfLLhP+FlGE0Psp51EGg05x
	9llxfvRzhZDSStQFRFcM1hFbbSTKEiF5xn1IyDsl81n/9c83XJneypRyZxizAylD
	eQk5XEj96drXanlrr/bl0u/Kmdk0z+1MU8SSMHr0nmEKEh3Xsw7jgrag5sF7FVjv
	2Bzhyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5hdtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 07:21:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so3531937a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 23:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793690519; x=1794295319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNOQHJMVvx6lR/9lQldFO/azLOgEmsHBjYrpgr2OldY=;
        b=BGtTIaBIMrrKnFSxyT/4pFlXPo/SdPLLEMgB+zfOxCcp+KH1PDewGJhYGrZCybwz6Q
         KAIZTGGGgzJQmxjJQc0BMwYbfey1e7zdqA1vyR2nuNrAHwkWZDVG6NwuuZv4HryuNPao
         Xz2bqjEwD3eWALRv6JavURbxtGjxLm+BkFP3sF/79xOh2tf4KrSxjrB5Y5G1Lyfq9xUR
         4a5IboolIfp2BQrGugwpw/iNnznq3XiJd/6U7xWoPkkyC+YwmXQbLGZYbSNcQhYJJFG9
         WDDI1CLFmpm6ExoYae0gp4z9Wd4cmRaStotTYk/wyXRyEjJlPOk1HzrkCJF/rxHWrZqn
         2b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690519; x=1794295319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNOQHJMVvx6lR/9lQldFO/azLOgEmsHBjYrpgr2OldY=;
        b=XKDZciI9rJ+pqM9N8E+CuFIxvTT3BEF5n8sUVaVsODFpUxeFTQanDQlaAKtPV69SGf
         75dllSOSpKJw9UQlQhPV3OTpNzLOs3FXRyvME6yoQ5xFN+WPLnhYHysOMA8aDtK0QtCB
         upKjcnZ/A5WmlmteUudMt5gHunCcTNKMQKonqsDEpANTc4T6yBRCyYXKukAfNyb+qzLJ
         HnrwuPpgOJX1xCFF2E1iLMQA1Z+R2Bo+LnvwROa1B3CY1iOvViimKXCYxCNkTLBNFEUG
         83ZXjg4sELT8KLkO1Xcd3X6SAyLazws/yvH3HbU2Y6wKH+ILRsExk/MkkklmZQjA2AXH
         fqOA==
X-Forwarded-Encrypted: i=1; AKwUvBwAbQVBEvDGShzsvAW/sUtaWBz8gcENvuSimu5dmYIGITzUda60my0Ga2vHP9CGIL7NTCGVYnUG5Vo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+QuZmt20DvtPQUmUyoneHP/bpRTMRRJN003+j/rEzHzko/oIS
	cMclhB6jEKQP39pGYKJ3up+t4M5rPcD/38r3d9hSzVNe+8SZaZoWVa/0+KeGw3tYDgoth/ehoRn
	y0DqfEPyu8tRKwRXtgTOsCBfkk5hYGlcO/6xuPyckYzlQEehivZQRGQ8EO8B6FTk=
X-Gm-Gg: AYBFou0/lkoI3ZiXIhwUTBBKHxwTaZbWwuci0AzFmQk2vjLobbfhWws3UnVOolEgH99
	R9DVaUXNn+7zPIHOUo1aWwpXnNYy/MvYRGzD5VwtrOIjrQ9k7+pMs1I5Y9kBYkn6+OfPg00SmdT
	ROmS+Pz+d8oeTRcWVWrb6VY6fIa6emqCqPfyZKhK4i++rs/hoqvEdwlGENqNNb8YDsfBeipQvjI
	TgcJ4h80S1t1Ghc4Qnm6XBqBJ7V0hogZKgszJb6JcFibfWODriEc4QZ2tJHZx1fn6DBzpShmKdN
	8THG/G6wBZ3FrYWKZ8nmXjxROkrZfX68GjO8h5upWKS36UEig4dzx5xwzzCefevG7T+28E1AqM4
	Ygbz/U/HaVp9jh8uiTQH8nJo1Rla4ZdinqhYYbdl48eTxKS5623P7wfXjmM+R2xSTK0g0JYu64N
	9WZfU=
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ae8980bd04mr8855426a91.50.1793690519171;
        Mon, 02 Nov 2026 23:21:59 -0800 (PST)
X-Received: by 2002:a17:90a:c2cc:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ae8980bd04mr8855410a91.50.1793690518518;
        Mon, 02 Nov 2026 23:21:58 -0800 (PST)
Received: from [10.217.218.73] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm2799014a91.11.2026.11.02.23.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:21:57 -0800 (PST)
Message-ID: <cb63c8ad-abf2-41f3-a2c2-0b21196fe46e@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:51:52 +0530
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
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
 <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-1-7f2a6e572de9@oss.qualcomm.com>
 <197ed473-d259-4f1f-ace0-ce98ac0fd127@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <197ed473-d259-4f1f-ace0-ce98ac0fd127@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M-9TJyxAmqYl-GHJZjBhHrVdq_xB6Plo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyOSBTYWx0ZWRfXxqEnibvu4LJy
 6rJxCpFCSG8rNXln1cTyAn6zWYfX5mVwyY30+gZhD7Yi3hDMM2SLftVUGgXr/xnAGl/nGYjXb7o
 ftL8iCp1KK5xe9VPbsoET3ZjqmLqVRjZLlmPk168YLvNiQEAAN7QHuiLRDEnMDfYVf2D2nosHuo
 MUb//HdIXaGMGnsCzy1nls2rKFdY5Zww5jBXeXRcXgisP0bE3pgViUT/nnzw/EJ9/tM12mYBXDu
 jT/6IGvA/0EAoF1kQCu5FseHQDw0bGCt6PZ4cAy9hislm/0XJPvw80MqwMavdURW8yTvmyrFeeI
 zOam/LhZrA6RxdcbOlxPNuydUTPBjLwTEaDc5VnyHUwrGfIUE5cy6Ddxn8vl+d5HRrz2bxcyPsR
 Kr02WHKTHMfbe1q4G1tGzq8HtXYNujKcEZxSOBGa1WF1ITfVcXEjEdZCjF6X9Mtx2UFyWFvqppL
 YvIY1Q3YHgnvCUJQFTA==
X-Proofpoint-GUID: M-9TJyxAmqYl-GHJZjBhHrVdq_xB6Plo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyOSBTYWx0ZWRfX7Dtp8T9N6Uum
 EkHXPwnm3efSQ7NqfK9Xy5NhEiFXff0tbm6AQ9OhyPZVbIwxGuIrDd+NKozOVx8oAFbfr2aF78c
 fh1hE2GSdnian0XDqTXQ8VRnojOwri8=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae98b97 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Dft2pwwzc1VQXl6WdfMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030029



On 10/27/2026 7:04 PM, Mukesh Savaliya wrote:
> 
> 
> On 10/27/2026 10:43 AM, Aniket Randive wrote:
> [...]
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index c41bfac65ddf..394e7287f6e9 100644
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
> 
> [...]
> 
>> @@ -1692,6 +1709,7 @@ static int gpi_create_i2c_tre(struct gchan 
>> *chan, struct gpi_desc *desc,
>>               tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
>>       }
>> +log_tre:
>>       for (i = 0; i < tre_idx; i++)
>>           dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>>               desc->tre[i].dword[1], desc->tre[i].dword[2], desc- 
>> >tre[i].dword[3]);
>> @@ -1825,6 +1843,18 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct 
>> scatterlist *sgl,
>>           nr_tre = 2;
>>       if (direction == DMA_DEV_TO_MEM) /* rx */
>>           nr_tre = 1;
>> +    /*
>> +     * Recovery opcodes do not require DMA data TREs, only CONFIG
>> +     * (for set_config) and GO TREs. Since gpi_prep_slave_sg() is
>> +     * shared with SPI, verify the channel is I2C before accessing
>> +     * the configuration data.
> I think i have mentioned earlier also. gpi_prep_slave_sg() Not only 
> shared with spi but rather say, is a common function for all protocols.> 
> +     */

Currently, the GPI driver has only I2C and SPI clients, so I mentioned 
SPI specifically. However, UART may also use GSI mode in the future. 
I’ll update the comment to state that gpi_prep_slave_sg() is common to 
all protocols.

>> +    if (gchan->protocol == QCOM_GPI_I2C) {
>> +        struct gpi_i2c_config *i2c = gchan->config;
>> +
>> +        if (i2c->op == I2C_BUS_CLEAR || i2c->op == I2C_STOP_ON_BUS)
>> +            nr_tre = set_config ? 2 : 1;
>> +    }
>>       /* calculate # of elements required & available */
>>       nr = gpi_ring_num_elements_avail(ch_ring);
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
> [...]

