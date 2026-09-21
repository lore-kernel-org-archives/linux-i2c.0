Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044045D906
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982062; cv=none; b=eMcsuzf/qEhJFrYxnnZ5NJBI5cFLIupT4WqsJZCHUN8/TKN9NckmjDuNbqtEfX279qfRMj9QGcJsWKYdImgO+mz8PgKCAd6JUlWabnLVJp1CLvlATS3IMpzsFeIOgZEp+N7tZrO6uma31O4V6W5W5P87NJuDABGvF4K0rMip8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982062; c=relaxed/simple;
	bh=PfVA9QbeKaF0Y4LuByUhN4p90CfHZjcBndaPI1b/Hm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaJPmqyS4p5/F5ZjwPh9Zm8e/9Q2SDBMoZKX57KQg6VkClhUwoBTYa5eAHLiSIp2W5TQcygMxY5PATBxghpdKrVbAd45aJuFKx+gblfHt5sIoUcNSSTCKNt0QMYE8ZNMmmtxzRB9KItxpVj+XuozRZTXNpWkuug+6gAuTpZe+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VA65YmBr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LC4/paSz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VA65YmBr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LC4/paSz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A61O608128
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 09:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QHnCeHDZ+jggQvXwQ9B0nKY03L9Pb/MItyLel2n7jc8=; b=VA65YmBrjiBH4Q32
	eOxxN0Qw+yJlYLOHLqnNFwfcrIvtC9f20vy8/DBNgrKaZzvpMDx7buhEiEjfF8kA
	F+YsunfbewBhTRsx5B0DY6MNk5tm7pu/8np+v/aQ80zf0Y1YTsYfC6SFdGiaas6E
	cCLqnc95tPWmD313b6d5f9UYnsJjg3uL/vs2XsJtgftacqRdu4laTx4EzR9NBQga
	qUYx3JKLef+E8IXRirEL+MbtuNsjzjnkGwtB4nXIe/nwLS1tDn+FRR6Wh2psHB66
	w/orTOdmR/3/tyP2aymfDHTqfr0AGCdriehxM10e2vSNFzRZdC/EjWcbKKvoCLLW
	pF0V9w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehh68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 09:14:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so2245847a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789982058; x=1790586858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHnCeHDZ+jggQvXwQ9B0nKY03L9Pb/MItyLel2n7jc8=;
        b=LC4/paSzvSqFqmlQKdBmQuJbwu8cr0Rnaz4Hy5sI97yYVjeORWqsb2Z75JpSNqSw5A
         +3CheP5aL1feJEmERrK2tL0+ImK0jal7oqYI5Oso87VmN9q5y8lRLv8W1o+otgqb8eqt
         Ti727eC8uBR0olYYDKrwWUpt5ZKd/6nD4+SJ+wqOq3OvMnNJGueXRcH4xAWtxQ2HBQI/
         N6l+tMm3zhCiVRSrufUtksO8LUvZHb/Fz+EEzTaD/CEcOOGT5O5YVbTVBsf0jct2MQNf
         55/7OoUCEj6z0B0V1/rTKCdCKyz4Zp8FBCcSyGLpMh4+IWjJV10h99TmgVUUa/XCuMLB
         gTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982058; x=1790586858;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHnCeHDZ+jggQvXwQ9B0nKY03L9Pb/MItyLel2n7jc8=;
        b=zavWiLsAkSkRL3vPMzklwv8M9zH6w5xpcyk7mSJ7djN61Q9sT1NPA0Ap6ZIoowTBOl
         k2mRFal+/sNK8H/mhddNvLQM2wsXj4rtS0pTBvluylCp/NFa75SZR/moV/zQHcLxB40Y
         Gj4BlOoDGuEjuXmHzldjSot7+qSN11C2hhsymZ1TXhBGm/maNqtqFcBUa/vH62W7myhf
         1Edt5oUtfXOUq+vLG3nZ3XbOWZrCl6qeHs1FnpHwtDBOCbhsqzpKnaatnAS5PXEichyB
         0+NJKQ4B3u7XSygMcjMT947wbQiDVDHJPjeRvKnlMTAakxypcDcTB6c4JpwSus6HkbZh
         YxXA==
X-Forwarded-Encrypted: i=1; AKwUvBy8b5hPMhD5yiT9dmGMQ4nwfq8jlMtQLY4ynUf7XAMgYnzINIqkCgZz1vRcKduBGy0hH++5BWv6oec=@vger.kernel.org
X-Gm-Message-State: AFuF++lw5mWiGFM2ZRTMkHH+kBUXN7zVBnHOkAX2Epw7Aw6PjK5zcz7S
	KVe4vcnXvvfRDUF8AhrJdCAvKyl+N2CL98giaYuM5t00xWmlM92KCDjjO+WKjnufRSWniNV41k0
	e1KUSGOhv7hCMiPoZJJa2838sJ6e1bRcP34gx9b4OYztXeljCRftgYRS8/DlPr10=
X-Gm-Gg: AYBFou0I0Av5V2mUyrOLjJEID5IcvTAc1k931KDajh4b+hl2zo0GW+Cccqd0LLlgVv2
	xzoIBFKVuNz0lJYx9XUY0SFvyt6YVl61HPNVy5pKFdJICmLnSSsYh5pYvU63NCipczXfCfPxdrw
	zUBno5wCmVU0G7ZFONWAYZ+5Jk6yNnFGDr8a3OuOCz7Hw5zfT9TPULRyS8zqGW4RbgIrM/Dg0uV
	XDKqvavnlIjOpRx5c/8MuyvoIShYS0A0RlMOnLJwmkeStPbPMxsbQWkfiSpYaXebAnVmiOeX7EU
	IVSrUcexrLbq/VIOyqM5X9E5poZRV4kQIvuxOfkk5AdYhopeqd1wS6BZIcBarcEAKmIzv2VMQYQ
	1Ru/CXz8MyA/9odd5EjDNCzB43YqV23q6
X-Received: by 2002:a05:6a20:e212:b0:3dd:a195:fa16 with SMTP id adf61e73a8af0-3dda195fc9dmr9889779637.59.1789982058432;
        Mon, 21 Sep 2026 02:14:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:e212:b0:3dd:a195:fa16 with SMTP id adf61e73a8af0-3dda195fc9dmr9889767637.59.1789982058015;
        Mon, 21 Sep 2026 02:14:18 -0700 (PDT)
Received: from [10.217.218.77] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c342b3c67sm18921175eec.10.2026.09.21.02.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:14:17 -0700 (PDT)
Message-ID: <9c5acc6f-779c-4191-ad3e-a86370aa2ab0@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:44:11 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX/XNXJPx6qXZU
 1si2cAgcMsw/Xv9yPkaIbFQiC7MJryh5eSBNBKL6SXavxYDJbPNXHoZe3ShZES9TmVEk9hk9L9H
 Qn8xXKoBh3esRRW406UJIjbdbeCZ9dM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX2pwMWpdQigFB
 kU7/Qs72nypus4lCHbCZ4I0EV60Gcd/g90VB62AYuwG6OfjGDTl2gNdMv1/l+hxEQDjyqGNwyaT
 mTFZzM9VFirHrCV1F1KPlfqoAt1G3Xy6Dg9D+prRSB1SUh0oTA/OiN1bMDlPQxbugD4SUUJzxt1
 4YxJ6EEnnKKneTJIeRYv6UALMFihCBz7+VXoSqrkO0AMHpqLCok2BSbunDlKbq/pQBYEGh34dwg
 p593P4jLEFZb+pUye5C89U9K1QeGaVQgjPUP1/uVJvwSM1O3A8tX5mqZ3jMbCI7sYSTYnmg3DEr
 5OWUpP/P0bJ4FK/dlLTYTTuL9cKnxkFAfAoH2s35j466yrJLqdQiFAbyrvwkDyf6lZkcmIuPMB5
 Oy8wPfe0w9VSdlVtoXGLD+w+N5GKzX036ch6hMipm9cIluCVGaGCO1jtJgkxw66FBSUCtO0MzDu
 +1h3/800RtVB8aq1ieg==
X-Proofpoint-ORIG-GUID: g1Z60UcnDTwW7aoljhAyV7WFcDh1pZtU
X-Proofpoint-GUID: g1Z60UcnDTwW7aoljhAyV7WFcDh1pZtU
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0f56b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=SKZSTpt7t91TGdo1I5AA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210131



On 8/28/2026 3:59 PM, Viken Dadhaniya wrote:

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 658636c1ee0e..a83297b5fb0a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -82,6 +82,9 @@ enum geni_i2c_err_code {
>   #define XFER_TIMEOUT		HZ
>   #define RST_TIMEOUT		HZ
>   
> +#define GENI_SE_CLK_32MHZ	(32 * HZ_PER_MHZ)
> +#define GENI_SE_CLK_19P2MHZ	19200000UL
> +
>   struct geni_i2c_desc {
>   	bool no_dma_support;
>   	unsigned int tx_fifo_depth;
> @@ -127,6 +130,7 @@ struct geni_i2c_dev {
>   	spinlock_t lock;
>   	u32 clk_freq_out;
>   	const struct geni_i2c_clk_fld *clk_fld;
> +	u32 clk_idx;
>   	void *dma_buf;
>   	size_t xfer_len;
>   	dma_addr_t dma_addr;
> @@ -197,19 +201,42 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   {
>   	const struct geni_i2c_clk_fld *itr;
> +	unsigned long res_freq;
>   
> -	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
> +	/*
> +	 * Counter tables are calibrated for a specific source clock frequency
Minor: Frequency counter tables> +	 * and are not valid for any multiple 
of it (e.g. 64 MHz, 128 MHz).
> +	 * Use exact=true and verify res_freq matches req_freq literally to
> +	 * reject harmonics: a 64 MHz clock that divides evenly to 32 MHz
> +	 * would pass exact matching but produce double the intended I2C
> +	 * frequency with these counter values.
> +	 */
> +	if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
> +				    &gi2c->clk_idx, &res_freq, true) &&
> +	    res_freq == GENI_SE_CLK_32MHZ) {
>   		itr = geni_i2c_clk_map_32mhz;
> -	else
> +	} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
> +					   &gi2c->clk_idx, &res_freq, true) &&
> +		   res_freq == GENI_SE_CLK_19P2MHZ) {
>   		itr = geni_i2c_clk_map_19p2mhz;
> +	} else {
> +		dev_err(gi2c->se.dev,
> +			"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
> +		return -EINVAL;
> +	}
>   
>   	while (itr->clk_freq_out != 0) {
>   		if (itr->clk_freq_out == gi2c->clk_freq_out) {
>   			gi2c->clk_fld = itr;
> +			dev_dbg(gi2c->se.dev,
> +				"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
> +				gi2c->clk_freq_out, gi2c->clk_idx);
>   			return 0;
>   		}
>   		itr++;
>   	}
> +
> +	dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);

add a line space before return>   	return -EINVAL;
>   }
>   

With above taken cared, rest all looks good.

