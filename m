Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07D5013B5
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797680; cv=none; b=jiVAG0NMukNZOHL1SFZ41C6hVK9PinRKlXaosIrnaNCJwIt+B0eS78M/MbZdYPgiJQVmSHR4AAsnsqGVwfm1qo7f91q7XQtc4bLdsL3Vkvp3dm9j0Yg/nLASQyKxfq2tQdi5kF6x2KeT7jQ8b8fIe3mQqrV5Yf5GqpK7USfMSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797680; c=relaxed/simple;
	bh=bTou4s9WtnvnRB7zUTqm4C5hI/JGWuphRfVr860M70Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoatU23mYnSB/jfIDwECT8yq/rRabc879gvUrvo2dCyCal4fnOnwzaggRu4UNGFAgPOV0EYOLtOX+vqMC0kafoKOfgksa/UNzjNEX3CyvCwNVFENh6szxDPCGySE9BjW9GB1s5kJ9SPSaTuaLA6M6GZrzHiQDCNrXOh8qnpMVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRFhJ8RZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIdmjHiZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRFhJ8RZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIdmjHiZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdKMW3554708
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 16:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRLhwLego0nM5nc5MW26QLSRighHf4TgXZ93ENod+Lg=; b=mRFhJ8RZbksD0XsD
	svr9r60C2kNT3WBbe4uvif3P/oOfBsJtS88cHHH0EHhCoa810t6c/i6tp7+4rG45
	JWMN9DJ4c9sI5x2/DhxcWU2eTUOhI2h4kbpGjIu/TcwETKA/6KSXNf/Mzot5VfIz
	eQToWymhBsuWuC8jlRXLMVIqbSrKEmD2nGTImIuIM0OItzZU7jJfrIHFE6rYVCb8
	/LhrhNXs+gL8oNjNtNpadJiLEkQDVa+igrbja3KV48AAH0enUVZUZg8IXhHuvIOP
	b0Yb/vXK2mf5U8Zd8YZIA74i1+wTZw6Q/T7CEGdSbC32cDu6VnLVLzZjrkaEN1Tw
	4kYQBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw21r2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 16:14:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39906175917so3954433a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788797677; x=1789402477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRLhwLego0nM5nc5MW26QLSRighHf4TgXZ93ENod+Lg=;
        b=YIdmjHiZFftGV1BgWvBgkBZHbXjaipaqsdQ6bXtbg0hLRHMyH+8r8yXeSeoN2PHV3g
         C8m0T5Manl3h//WnHiTmhUvZwwvOGRk8+9RGCcJJt529t7t8HKb0oF9/ZImDiv8AcLx7
         yP3hFVS16OHaKQZlz67rG20i+yhQYxV3Lw5+l10xn0KZq1KctABTR3Khu6KYexs6MPAA
         k3rjMqaTUXJea8F2wswtzG5gUD8nt0vc4Snymf9ZL9O9iuOhscdMvhQZuAXxpr3gXDtN
         m2zxuJ8AvKOnNyr7gx+9XMjKbJ9lDye0nuRcePKGOYZutlTtV3rEM7j7Dso5U3Nk4+0W
         d88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788797677; x=1789402477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eRLhwLego0nM5nc5MW26QLSRighHf4TgXZ93ENod+Lg=;
        b=OcBQxmmc7TuGMSMwha+4ALKIAGXfa6OyEgzX87U+BwKS/kYilAuvTmsQup8BeXB05L
         aO1qehEAHy6aA/1qM/fwGNbmO9Zp/Gfx3admbNRECXPKmVAAvdLViDUyNDUzo4hS8liG
         nx4isu0qv6/B3wGTiyEJ9VeprVavtjJ0zxC8OUS1kL5fD45LaWt4xvycLBWBy7M930+3
         apR6Zi6owxBB/rFoJsf7R2CmYHauPPL/CII0CyQd5TtOTT3CBjhWczWdv909k9twQtkd
         OLXNl/NQDy+OySvItYgIweArxfPpUdvniZw2S9BUyKabze1VYgjF9tfpDQMGBAJYapVx
         4EOA==
X-Forwarded-Encrypted: i=1; AKwUvBxYTf49wgZpagq+A8ENC5mnIyu6jBcfDsbARWrBfCyZhm4ZiQeRhQaLF5+6RZuN4i8V1jzrbFVhpNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++khbzcd600WlYqx/ozIcRGPFuZ6uOFYDqc7TZYrAcaHw9BtJJgY
	Rxt3pKmQ7Y3Ej3j8ONL4RD2FwZ7Fb9B2xWqU1ArI2Mldgu6gYhSo9F2bDoKopYj+c5goLN9Qi/Y
	ypPutOOeai8OvS3G+x1W1CZbSxPzB5LeCgiYd0LDI9MR/61pF16c5VelQu12NOmM=
X-Gm-Gg: AYBFou0cuE1B88vXrY+bERxQR/MzBIEObAoQOYyqYfQAtLpxOxjf2RjeWDETytiZKmv
	SCkq4lGrvJnEF1uvcBaw4rDW0gZLE95ZpM4Rs39suEne7yEnDHclz7vAd00jtaCs6i1g8l94EAX
	LXs/DU4JZte5F21z/I9VEJ8yF1+Ps6r/WeAusYlgOS9nvVcKNptxH4nQA+2u/leJ/rCkQmPV3Hf
	Kss3xcwjFzFpZfOuFhJK+eVwZfv3S52jhNGJ74PL2JfnCG5YVolIdC3tg0QB882qlikRUJhqOsx
	x+Mov09gVHs8km3drR+csF0D6j2+XeQYIVLeCETMLaid/MOBSsMC4WFEdkW/wNinfjfMjmJB6EW
	KaPLrNye1uFpUpy7rDRPwSUCjYRJ1UfSTO8qeU7uWjiVP
X-Received: by 2002:a17:90a:51e6:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39b4877aeb8mr13830379a91.22.1788797676636;
        Mon, 07 Sep 2026 09:14:36 -0700 (PDT)
X-Received: by 2002:a17:90a:51e6:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39b4877aeb8mr13830341a91.22.1788797676080;
        Mon, 07 Sep 2026 09:14:36 -0700 (PDT)
Received: from [192.168.1.66] ([103.172.5.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm29345580eec.26.2026.09.07.09.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 09:14:35 -0700 (PDT)
Message-ID: <649f44a6-740b-46b3-86f4-990878ea0968@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 21:44:30 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Add support for I2C High-Speed mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
 <20260824-i2c-hs-v1-2-8dd94e5c6113@oss.qualcomm.com>
 <419902d5-cbb6-4d8f-acb6-d9640adb56d9@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <419902d5-cbb6-4d8f-acb6-d9640adb56d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cgjiFTmxFNnMtFLXIMbKkWv1stTlqVmb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE4MCBTYWx0ZWRfXyCUfRtFFFBfz
 zzn6eur+vhB77abmejgOiTb4ybBEoVL7igitRI44r4mnhMesTdQfndWUB3Scc5J6/qVCgMkkdpn
 YdOqOhUxXpttubpjKI2Pgc49DQyBXLk=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9ee2ed cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=tPI8lZtLbYv5uT6OEmdSlg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=oVe4sY28e3T6egSZGAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE4MCBTYWx0ZWRfX6+ha3ON8ioEr
 66xcXRJ9JuhFOHdekgpK5p/svb60ju+jlGDsF+TbBKSAFEeUMlF2r1yrm76R3JaXTEBMXQdNib6
 h85e6NQ8yb/04X7hrNSOOrlT8zZY01mn0+JZLXdovilD9djsbiQVK7ssqLz1IvPT+c2sM6qMkp1
 e5dU0z7XfeDVUFEl4ort3HP8jh1jLISkn8DLV2/8zD9Gr7OfWwTOEDQCzUnXzQaXqr/DCYsXW3B
 NhxCSGFWBrwKpep1NqrlKqgL4aLujf50sDk0Wg0AvQf2ahHwogDgAtTciJwYTwSXkEIHPOoXsw3
 NH8hoZYKERa5JQVuT1WLZM2f27rsl9YDBhhVxDYzBHWRRRTgkgsbjm85Zj9oQNsCwLmQ3FOBGcQ
 n7/RdgJ0PNl1BVplhl4A9yaHnqwYSvFH2MYOzUivgRkNLftPHKoanoNOPnVUUaGHUzf3F881gNR
 qFSrhfVtLKCia4nfOeg==
X-Proofpoint-GUID: cgjiFTmxFNnMtFLXIMbKkWv1stTlqVmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070180



On 8/28/2026 1:12 AM, Mukesh Savaliya wrote:
> 
> 
Hi Mukesh, Thanks for the review comments.> On 8/24/2026 4:55 PM, Jyothi 
Kumar Seerapu wrote:
> [...]>   struct geni_i2c_err_log {
>> @@ -162,9 +180,14 @@ static const struct geni_i2c_err_log gi2c_log[] = {
>>   struct geni_i2c_clk_fld {
>>       u32    clk_freq_out;
>>       u8    clk_div;
>> -    u8    t_high_cnt;
>> -    u8    t_low_cnt;
>> -    u8    t_cycle_cnt;
>> +    /*
>> +     * In normal mode, these counter values fit within 8 bits.
>> +     * In High-Speed mode, HS_TLOW_COUNT and HS_TCYCLE_COUNT are
>> +     * 10-bit fields, so u16 is required.
>> +     */
> Now, normal mode doesn't matter once switched to 16 bit.
> May be comment also doesn't matter once change is merged, you can add 
> some information in commit log though. Will be taken as default size.> 
Sure, will remove these comments in V2.+
> u16    t_high_cnt;
>> +    u16    t_low_cnt;
>> +    u16    t_cycle_cnt;
>>   };
>>   /*
>> @@ -194,10 +217,30 @@ static const struct geni_i2c_clk_fld 
>> geni_i2c_clk_map_32mhz[] = {
>>       {}
>>   };
>> +/* source_clock = 100 MHz */
>> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_100mhz[] = {
>> +    { I2C_MAX_STANDARD_MODE_FREQ, 1, 449, 548, 998 },
>> +    { I2C_MAX_FAST_MODE_FREQ, 1, 76, 167, 248 },
>> +    { I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 23, 59, 98 },
>> +    {}
>> +};
>> +
>>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>>   {
>>       const struct geni_i2c_clk_fld *itr;
>> +    /* Check if HS mode is requested */
>> +    if (gi2c->clk_freq_out == I2C_HS_MODE_FREQ) {
>> +        gi2c->is_hs_mode = true;
>> +        /* For HS mode, source clock should be 100 MHz */
>> +        itr = geni_i2c_clk_map_100mhz;
>> +        /* For HS mode, start with 1MHz for master code */
>> +        gi2c->clk_fld = &itr[2];
>> +        return 0;
>> +    }
>> +
> else part ?
No, else is not required here, as the if condition for I2C HS mode case 
returns from the function. For non-HS mode case the below  will execute.

+    gi2c->is_hs_mode = false;
>> +
>>       if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
>>           itr = geni_i2c_clk_map_32mhz;
>>       else
>> @@ -219,7 +262,12 @@ static int qcom_geni_i2c_conf(struct geni_se *se, 
>> unsigned long freq)
>>       const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>>       u32 val;
>> -    writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
>> +    if (gi2c->is_hs_mode) {
>> +        writel_relaxed(I2C_HS_TCYCLE_CNT, gi2c->se.base + 
>> SE_I2C_HS_TCYCLE_REG);
>> +        writel_relaxed(I2C_HS_TLOW_CNT, gi2c->se.base + 
>> SE_I2C_HS_TLOW_REG);
>> +    }
>> +
>> +    writel_relaxed(gi2c->dfs_index, gi2c->se.base + SE_GENI_CLK_SEL);
>>       val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
>>       writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
>> @@ -500,7 +548,11 @@ static int geni_i2c_rx_one_msg(struct 
>> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>>           geni_se_select_mode(se, GENI_SE_FIFO);
>>       writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
>> -    geni_se_setup_m_cmd(se, I2C_READ, m_param);
>> +
>> +    if (gi2c->is_hs_mode) 
> gi2c->is_hs_mode ? i2c->op = I2C_HS_READ : I2C_READ;
> geni_se_setup_m_cmd(se, i2c->op, m_param);> +        
> geni_se_setup_m_cmd(se, I2C_HS_READ, m_param);
>> +    else
>> +        geni_se_setup_m_cmd(se, I2C_READ, m_param);
>>       if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
>>           geni_se_select_mode(se, GENI_SE_FIFO);
>> @@ -539,7 +591,11 @@ static int geni_i2c_tx_one_msg(struct 
>> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>>           geni_se_select_mode(se, GENI_SE_FIFO);
>>       writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
>> -    geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
>> +
>> +    if (gi2c->is_hs_mode)
>> +        geni_se_setup_m_cmd(se, I2C_HS_WRITE, m_param);
>> +    else
>> +        geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
> same as above>
Yes this can be set like below:
geni_se_setup_m_cmd(se, gi2c->is_hs_mode ? I2C_HS_WRITE : I2C_WRITE, 
m_param);

>>       if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
>>           geni_se_select_mode(se, GENI_SE_FIFO);
>> @@ -700,7 +756,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, 
>> struct i2c_msg msgs[],
>>           goto out;
>>       }
> 
> [...]
> 
>> @@ -1046,6 +1122,39 @@ static int geni_i2c_init(struct geni_i2c_dev 
>> *gi2c)
>>           return ret;
>>       }
>> +    /*
>> +     * For I2C High-Speed mode, first verify QUP HW version supports it
>> +     * (requires QUPv3 core >= 4.3 per HPG), then configure 100 MHz 
>> source clock.
>> +     */
> /* HS mode requires QUPv3 version >= 4.3 and source clock=100 MHz */
Sure, will update in V2.>> +    if (gi2c->is_hs_mode) {
>> +        u32 hw_ver = geni_se_get_qup_hw_version(&gi2c->se);
>> +        u32 major = GENI_SE_VERSION_MAJOR(hw_ver);
>> +        u32 minor = GENI_SE_VERSION_MINOR(hw_ver);
>> +
>> +        if (major < QUP_I2C_HS_MIN_MAJOR ||
>> +            (major == QUP_I2C_HS_MIN_MAJOR && minor < 
>> QUP_I2C_HS_MIN_MINOR)) {
>> +            dev_err(gi2c->se.dev,
>> +                "QUP HW v%u.%u does not support I2C HS mode (requires 
>> >= %u.%u)\n",
>> +                major, minor,
>> +                QUP_I2C_HS_MIN_MAJOR, QUP_I2C_HS_MIN_MINOR);
> then why it entered into is_hs_mode condition ?
Need to check QUP version only for I2C HS mode requests, for other I2C 
modes no need of QUP version check. > +            ret = -
> EOPNOTSUPP;
>> +            goto err;
>> +        }
>> +
>> +        ret = geni_se_clk_freq_match(&gi2c->se, I2C_HS_SRC_CLK_FREQ,
>> +                         &gi2c->dfs_index, &freq_out, false);
>> +        if (ret) {
>> +            dev_err(gi2c->se.dev, "Failed to get DFS index for HS 
>> mode: %d\n", ret);
>> +            goto err;
>> +        }
>> +
>> +        ret = clk_set_rate(gi2c->se.clk, freq_out);
>> +        if (ret) {
>> +            dev_err(gi2c->se.dev, "Failed to set HS mode clock rate: 
>> %d\n", ret);
>> +            goto err;
>> +        }
>> +    }
>> +
>>       proto = geni_se_read_proto(&gi2c->se);
>>       if (proto == GENI_SE_INVALID_PROTO) {
>>           ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
>>
> 

