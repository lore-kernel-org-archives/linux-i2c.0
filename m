Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDAF34DCC7
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763586; cv=none; b=nTqciaiqLuedfyPvbat9SuGEp0LXOXt/T85YPnuRHRhNO9JkM+6EAKvBSVGCfCvdJzeZAfC7TqVMf4RmIDRKePBzso8leUVLr4WwkZwSkhRhoMf2Ki7OVCG4iwzp0NTAuRI/tJLSqzMvMdB+1Rj+PdU6srKZzocjQ/X1QP+KYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763586; c=relaxed/simple;
	bh=fM7fhcx6hqGG/yvwRQZw/AW5oiBbcnxITrr2S1uzF5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhka5jjD3VIo2B9inF6N6HGVFNH5baYIozFYCLKGNs4S9Kjf9jo3zqmZJBzQHdTtIzMHeR0MrEyW/ft1EYqKv2gr+KDeOwkVE2kVpVB3DeC7hqFrGBEoR5YbsFkq8DKMiWubXC0wH25SwH2Ws6+OosTOJZ0MZ2qDHr685tXY4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNGA1Bi0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEUOXMa9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNGA1Bi0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEUOXMa9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873l2FC2390295
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 06:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z1/b/ciKiZaldA0A18HpPcagbdf5bHqmr0JAuiX+snw=; b=nNGA1Bi0LAfAWnrd
	B1FUg1B7QBvr1h6DQuPVLG4uSWJQJqqu4mAt11fA6uWIzf+w1ddfXoVf3JAXwjbX
	jcCZ61aUIY5p5/enVlUgtfwvXlzunAhm2CdgsKW+JI/8AKaAoSH0M5WOcl9VjoQa
	7/x/S9Wp9duN7svVM2e6KsFojdP0/v4Wl1jRNYc3UyczRj1QIbQoyEjdNmMjl3Za
	dqIM/7x2twDHY4Oe2ZH9gNuyIiF7RTCDOUd5N+okwcx4zZsvfC3KSJli61+G99x/
	dX1fkDoq5sftDFjCpLht91IYgl6/FT0nxjkxgvmruoic+bLs+52ouWEjeShfvFYS
	WpuHAA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuenfab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 06:46:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398d7e0f3b4so4022984a91.3
        for <linux-i2c@vger.kernel.org>; Sun, 06 Sep 2026 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788763583; x=1789368383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1/b/ciKiZaldA0A18HpPcagbdf5bHqmr0JAuiX+snw=;
        b=GEUOXMa91M4Xp5ZNLeVDIOxf9HP88ant+fuLixw2bPdJeMU9SlUBW1PhNil3EQRloh
         +FwANFI/PPS6Tet75mf/ZlxbUql8EZWGw8jTm7YXWfk9JiFYXwd7mQjSs1ooCvkCPsuG
         wSGxzyqz5KVDtwPin/STz41HkZBAwntOg2kzZbIknOwMu/dkazcGAK9GtaCwv6mc3lhj
         +JdceQ5Ju455J7gZjwqJKY4ViEFGkw4Iy2p9SfUN5Uq0C4M6sF+YUkPJVcdKNFCisg9y
         0K6iHVkMrSGtMiixqVKaabf5vQQGgyQlcHW01/2168mTv1vNpNQZ0OAfg+r7xXa4khm/
         rQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763583; x=1789368383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1/b/ciKiZaldA0A18HpPcagbdf5bHqmr0JAuiX+snw=;
        b=rRf3LyCzI0JcA4PPzsXT0fF70B7r3XXG72fBVmj5Op6acp+OW9ISsYf9e3ffbRsESd
         l369S3/BrM1PWmVXAXxO3NG5WJXVZSle8NYry+yY2LBiYAdv1fsiW+x88u/OSfmseY92
         pSWSir9OeBcGj+tlHglwWBafd96+03lLzYKxCJzFcQ+1XWECO+Z0nvsVa2tPTWKuQ/oV
         tqxNimQ+IK5agzSjoP+4KWFUeJopyK7TrS/hwgwoLg7SAYEVvd6YWnLrlu9TAOrtcoE3
         ZXLJQzJOMBO2TSuKbXeQ0YzhnKdGS6H1D6nQTu15Ffz3po6ctH2zZwpWzqL40H7CUJnY
         xhQQ==
X-Forwarded-Encrypted: i=1; AKwUvBznjNo50FWUheK5BN53GmOal6JHdFvn77djOE2UwXVPZWfJEUMuQzS0JfAsAd2JH4XiILuOSsWVCR8=@vger.kernel.org
X-Gm-Message-State: AFuF++kt/UI0A4I4FtNWPXfboSyQtJCiqaMSerInLQqUwmCn16hSWEJU
	P59aaXtuMnCSlk8ZjguyPjP7kDUC0gaYGK4sCKvJEU9VpHWdVfEI366sxxDgMTPdZwYoz8Om0TN
	gWS916PQfR/TILIXtMsb1/qlNOCxYj0FolXyX2MT9AAtd1WbSqfFUwspFB0RwuWw=
X-Gm-Gg: AYBFou18z2lMzg+EQ5MXwZ7Oppz60WUGb/JLdZiPjm6nj7o06fz6vYaRbEvVsGmc7br
	DCTXEAT8xv5DF2NCJOCJIvKEvPLuKBvoCZ4++tK8KSkipQmbcf0wnJRSA1KDb1/PdpZa7dHFj0o
	16eZrWzm1VcyO9gegud0ekrlT0FAjuUpXSIrEatdKQTUfl1c0ZhGlcOd21oqS3vqPibDd82lwHc
	wAyhDLR70QilMhluUBztYiO3QQYbrG5eiZxX/EXIMNNircroOBojfyo1xL+j2fcA3MjnvZ2KWvM
	R22fcIzWbYiCQF6bMp10t9Qmv4lSAQ6RpJojiTRkmrAejS/Pql+eGFmx/5AGVMBOp3NDUkndILd
	sNj9Si1MC/11EEciwHalETU9xHz564Qgb1Q==
X-Received: by 2002:a17:90b:4d85:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-39b2617abf0mr32619191a91.7.1788763583430;
        Sun, 06 Sep 2026 23:46:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4d85:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-39b2617abf0mr32619152a91.7.1788763583023;
        Sun, 06 Sep 2026 23:46:23 -0700 (PDT)
Received: from [10.217.219.15] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm17219997c88.8.2026.09.06.23.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 23:46:22 -0700 (PDT)
Message-ID: <bcf5b148-d4d0-434d-a020-deca2381f5a3@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 12:16:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
 <20260826-i2c_bus_recovery-v1-3-203f0ec76f84@oss.qualcomm.com>
 <7cc05c51-811f-4949-9fe6-10580ff90eea@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <7cc05c51-811f-4949-9fe6-10580ff90eea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfX+1dpwds75k/W
 obfySkqy8+HDBcEB+QH6QS4A/LOAHMZsoL38DuqWZhOnIur7iREdPS3TZzbzMsVCQ3CbQhpow1X
 6F/3AahBt9JtMIO2RQlQRKVotoHZAJCdox/PetQNFIxQivc10fRS2HoaYuEN7DHA07SkIJ25wN6
 58bbP1DZyuF2ZVMPhVw4EWAiPYEpkJ7ML7/YFqtaJNScD9qxiTfWlnsWNF3Ji0nLYC+mN6mMbp0
 wQT3/iu/5HRum9CTRNtAwATpXUmXsHOoi4tRVeK6ZSUjz+nC8uZoMJ2wkDzQEjAksQ+FzAJJ41x
 +6rayyhD+YadCl39ok2dNh+FYCRFsVclfxzqBfhSOLnSQyviKhuInMQjrh89snhcZzV3Untt2nN
 2kvjHzXMvgjh7SC0jK2COCWMFHb4bTUaWONtA6uhG5psUmbwl/Gupe5APoS1skxjQuuK85t/gmI
 jBOO0mesFKrhdkZHdew==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e5dc0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8PfKY5Vedw5zlJPuvQQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: VVL3hhzyfk_fq2VZMNccSWJL2YLzkoFq
X-Proofpoint-ORIG-GUID: VVL3hhzyfk_fq2VZMNccSWJL2YLzkoFq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3MCBTYWx0ZWRfXzEnn1UrBH9ia
 4MgrwIc2krimIdGURyHQAgcLYePI7qFLImR9894RrrVKNA4wfUAc9lP3tfIZwyan4BOLCqixyRL
 rQD6XXCY8P3PlljqGLPD8sEV0Lensfg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070070



On 9/3/2026 9:44 PM, Jyothi Kumar Seerapu wrote:
[...]

>> +static int geni_i2c_gpi_bus_cmd(struct geni_i2c_dev *gi2c, enum 
>> i2c_op cmd)
>> +{
>> +    const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>> +    struct dma_async_tx_descriptor *desc;
>> +    struct gpi_i2c_config peripheral = {};
>> +    struct dma_slave_config config = {};
>> +    unsigned long time_left;
>> +    unsigned long flags;
>> +    dma_cookie_t cookie;
>> +
>> +    config.peripheral_config = &peripheral;
>> +    config.peripheral_size = sizeof(peripheral);
>> +
>> +    peripheral.set_config  = 1;
>> +    peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
>> +    peripheral.cycle_count = itr->t_cycle_cnt;
>> +    peripheral.high_count  = itr->t_high_cnt;
>> +    peripheral.low_count   = itr->t_low_cnt;
>> +    peripheral.clk_div     = itr->clk_div;
>> +    peripheral.op          = cmd;
>> +
>> +    if (dmaengine_slave_config(gi2c->tx_c, &config)) {
should capture the return value and print, as it returns specific error 
code.>> +        dev_err(gi2c->se.dev, "dma config error for bus cmd 
%u\n", cmd);
>> +        return -EIO;
>> +    }
>> +

[...]

>> @@ -1066,14 +1136,18 @@ static int geni_i2c_xfer(struct i2c_adapter 
>> *adap,
>>       else
>>           ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
>> -    if (!gi2c->gpi_mode &&
>> -        (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN)) {
>> +    if (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN ||
>> +        (gi2c->gpi_mode && ret == -EIO)) {
>>           /*
>>            * Only attempt recovery if SDA is stuck low. -EPROTO and
>>            * -ETIMEDOUT indicate bus errors where the target may be
>>            * holding SDA low. ARB_LOST (-EAGAIN) on a single-controller
>>            * bus indicates a stuck target, not a real arbitration loss.
>> -         * GPI DMA mode extends this trigger separately.
>> +         * In GPI DMA mode the completion callback reports NACK,
>> +         * BUS_PROTO and ARB_LOST alike as -EIO, so the SE_GENI_IOS
>> +         * RX_DATA_IN check below is what distinguishes a genuinely
>> +         * stuck bus from a benign NACK: a NACK leaves SDA released
>> +         * (high) after the STOP, so recovery is skipped.
after the STOP, indicating i2c bus is in idle state, so.....>>            */
>>           if (!(readl_relaxed(gi2c->se.base + SE_GENI_IOS) & 
>> RX_DATA_IN)) {
>>               int recovery_ret = i2c_recover_bus(adap);
> This does not appear to handle scenarios such as an I2C multi-message 
> transfer where the stretch bit is set during the first message, but an 
> error occurs while preparing the second message (for example, during 
> memory allocation or DMA descriptor preparation). In such cases, the SCL 
> line may remain asserted low and impact subsequent transfers.
>   > @@ -1292,10 +1366,8 @@ static int geni_i2c_probe(struct 
> platform_device *pdev)
>>       if (ret < 0)
>>           return ret;
>> -    if (!gi2c->gpi_mode) {
>> -        gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>> -        gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>> -    }
>> +    gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>> +    gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>>       ret = i2c_add_adapter(&gi2c->adap);
>>       if (ret)
>>
> 

