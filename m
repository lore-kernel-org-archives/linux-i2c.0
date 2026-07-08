Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44A3F58C7
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496145; cv=none; b=G5+YtLCpjie7mLaq5in/ykp1VP9l0tOsYNK+QrniptvnjeoVP97ibILwB2DiXyxpbdpAcldTiJpi/XZjykQa/Ql+l9vZIarcrN+bFsM9sGmyVHNmEFQq8YJAcWIWeODG7cnWHAQvC+saqbZcOG58P0vIMjOYq0bSDlbDogUSDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496145; c=relaxed/simple;
	bh=b5ZTxjwdijmuADzULPIvDGzxFk7ODUmj1Xb0RRNjP+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9NFfc4fc3VNasdIr8ZRjj/I6GoO2xY9YPLKm75G1v0dsk3hYiqgh+yQazFb3FQD67jSI30aQ7s3wHXitubhIuOmGKkceWeyFe8Jdpr528vaj/Lva1/6/XlRcfOL2joskmf4utPhFlRQN0QxshJAIQjJ+pgpusAFBocWw/sq7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d1BJxneH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G3QBshCs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1BJxneH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G3QBshCs"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842ko61625499
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 07:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3nrZBDGQDmY+CQjESpuWaDP7VmOJKMsPPsfgvpK8nTM=; b=d1BJxneH8nuJ5u20
	HuzLWDQqdekws2WZG82OdLcnm4tKzco5B+Zz3fkfgeU8AETXA4zft8PLCS+OLvZo
	Z8uDEFVgc2m3Mwlz27ofzeY3u+xO8lbKTVaZORjje5sXT+NnYXeO8WeRoV+6PKcZ
	8rueLzNyWWQYsarMKBOUwSmP4Jhh2RHAW4VEs1pv0XmgkszWahJM1kStWONu9SrN
	Bfneww2ra2HpWDh8+0DqHkstAxRq+L0K1ByYBnJulVRYI0UcEBTBrJPZTqNh2XkC
	z201L4GHoovT94Uc0SOtJ8804WfnaihpDJk/tdIu2TBd/Txdf9e4rR0oSXHV/E31
	eQUB8w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd39gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 07:35:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8479b45ad08so703548b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783496128; x=1784100928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nrZBDGQDmY+CQjESpuWaDP7VmOJKMsPPsfgvpK8nTM=;
        b=G3QBshCs0/wFXpEQut9D6Iw6HGqiprLA9YqpyiGwLsBvOlPny4+2H3YPyKpjhgmMGp
         kDS8ygLsnYxfegUHyz1g13Wz/QPNb005A0oPr5v4Z6bLIUddJw7Y6To90/lgucejw5/X
         VQxoujztrhkUtLfFREc4KGXx0wK9m9qvUtDDKeUupkIxwacQvujTWnoIRk7BwX7orHfF
         uf9YjSUgQABZuXoLWZ04HafNSmjiuhtbvdyvZZJlcAjM3b7XKAK7MpSULK4AUhc0R1sr
         zzGtZz8aDUMmT5agrdQJ4qRO41CGBWYwqBOfuyLqO+XPVBVCSCr1DoBaOiODCAxmegtN
         2Qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496128; x=1784100928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nrZBDGQDmY+CQjESpuWaDP7VmOJKMsPPsfgvpK8nTM=;
        b=d5gL1ZtIABq0b1VUVNX6urtBv/WC48AbWzUvgWflve5gCsP+cFZa67iwxu5WQS4nbP
         9wip/ZW7T4N7qUTbi36S4BGSsdoga+w3e2ipm18l3rt2L6F7MpoRJ1UcuoJHLS2M2SIV
         Vouj6SnN6l37aLLDtS0xapQ1RLYXu9nUw4sOnAXeTBtO51lF8OPblHcO/V8kWkHWZyy/
         qR4rShm65a3me3MnlWumXgpG0Vbo7C8Uq9Uk8C4LKSgHdxhSZlUGykGprkYKmW1bwFw3
         GbPMilVMsOixf+k4362du8Y0Rfs+pwMOe6seO16VcHrw5fhgg+zUO541K3KdHHV07UqS
         /IZw==
X-Forwarded-Encrypted: i=1; AHgh+RrOxU9ncoijx3TsjaIWpvGmdC0rEUkKuX8DGziiWhuOefRuNaHjRgR4Q3Du1RWok9dg4+4Vg+EJfwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf/hgE9p2JHY2wqfpTmPA4AD3VPOZvXTBscJQcqub6V90qH/f
	4fhNp8kGFrdIPdFHC8p2vu2r34J3KB22zlEdcLsiHrBKRxaD6fNVwUtYQzMQDZ2k1ns7wCPkH4F
	P187AWfVamYqb0QUS0FaZznlhkV6/USHS2JlCp8vjDnEMwi1U6/fSQPhUVrxRPpnzAKhJYis=
X-Gm-Gg: AfdE7ckYf08Jdnrqcf+RXR2qOcNb6tPzws1WrARQkgq3uPucOMjBoP2JOrvIkbaSlym
	ESBKCt9FeKUWZirY6zxwb81I8ekyZE9Bzs4NTeP+4QeKgMBd6EcoucAF7GXR/H1kjgNQltpxQ4b
	EaZDFUHz5abGh7vCnx0zykKXHixogOHSVn2dGZBRJ0MB67Soe2+L4hNqe4tZ9yxpNLF+BEw1gHS
	rsWaYWxU3DaPNA0imd5PFD7BxkXi+zcAkfZZejMxBQ6lxDsQ62uU6s/d1aY0P8akwuErsZ0p6hg
	LeecGim+om7CieB1qa89Yms7j3etrfS6sVBEbauZL91VCPjy3Mw2pgdRpyPlcFWRrouDmjiW/ZQ
	Qaf3FzMMCq+qXNxZStZFQSTtOLZUPH1TIhlvlKTS5A5PE
X-Received: by 2002:a05:6a00:244a:b0:847:9ce5:d293 with SMTP id d2e1a72fcca58-8484301f0a4mr1601366b3a.24.1783496128155;
        Wed, 08 Jul 2026 00:35:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:244a:b0:847:9ce5:d293 with SMTP id d2e1a72fcca58-8484301f0a4mr1601339b3a.24.1783496127648;
        Wed, 08 Jul 2026 00:35:27 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d48sm6644002b3a.39.2026.07.08.00.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 00:35:27 -0700 (PDT)
Message-ID: <74520b45-b3d1-475a-8929-b965ce760d5a@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] i2c: qcom-geni: use cancel command before abort on
 transfer timeout
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
 <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-1-dd8f841f36a2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-1-dd8f841f36a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfX9JgdAul4jmdo
 ZmXCZynlNXRU1l0rqZxUrjzZUwxLgufgMdPLn+Oc8KT3AhDAYnLC8G/rl/cwHurh+GAzD/rs8LQ
 MEtfEXTsup8jwe9D6COd6tEseGr200evTJ395625lc9F55byGsFKU/j6GbEQAZM8dwia+1Q0YOr
 VVwCH3UqQo5mxp5ny19uVWqJGiXNwbGURfqZAjza66Lj+kKSOiI4VExkAw4meMtDdOQKH6rU1nr
 oirwXRjN7aNIzKriDfnDQa0OhSHQNSEdx/28GSVaiw3o2DWmzAs8P+4dRh79YhAGO0gpYIllufk
 SudG/zFEVCXJBt+Pb8GBWrYqh0nL2sAQBh66ElfD9UjYOscELKbo6lmsZBfHrX9nK+mxj5J+/uW
 U+q70ndkXmHfEXu7Jrhzz1G2fV3E4zXKyQ/6es91afqmcJi0DEe6h5pjSJ9GK9SDGNePRC27dPs
 i6HouwFtIH8wFqvBLkw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4dfdc1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6kLu1IwUGHXDgf738pMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 8dDSUzxzPuidSeBg9PpMQgp8vdA6qJIl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfXxC5Hfn/7O41/
 6awd9kTJKFRZDSvkddFPasYMIitowitI7t1qhNIYTWlIGD6t9YqxcBKwwaFeufNn4aljA9r7TWR
 wVCsfSNoxSrRWx3ISKFAZPNQRP8kGoE=
X-Proofpoint-GUID: 8dDSUzxzPuidSeBg9PpMQgp8vdA6qJIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080071



On 7/8/2026 11:45 AM, Praveen Talari wrote:
> The GENI I2C driver currently invokes geni_se_abort_m_cmd() directly when
> a transfer times out. However, the GENI hardware command cancellation
> flow requires a cancel command to be issued first. An abort should only
> be used as a fallback when the cancel operation itself fails to complete.
> 
> Introduce a dedicated cancel_done completion that is signalled on
Typo :signalled

"signaled when M_CMD_CANCEL_EN is received" With this , rest looks good.
> M_CMD_CANCEL_EN. The timeout recovery path waits for cancel completion
> and escalates to geni_i2c_abort_xfer() only if the cancel command does
> not complete within the expected time.
> 
> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

>   drivers/i2c/busses/i2c-qcom-geni.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..15403edb355a 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -74,6 +74,7 @@ enum geni_i2c_err_code {
>   #define PACKING_BYTES_PW	4
>   
>   #define ABORT_TIMEOUT		HZ
> +#define CANCEL_TIMEOUT		HZ
>   #define XFER_TIMEOUT		HZ
>   #define RST_TIMEOUT		HZ
>   
> @@ -112,6 +113,7 @@ struct geni_i2c_dev {
>   	int err;
>   	struct i2c_adapter adap;
>   	struct completion done;
> +	struct completion cancel_done;
>   	struct i2c_msg *cur;
>   	int cur_wr;
>   	int cur_rd;
> @@ -361,6 +363,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
>   	    dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
>   	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
>   		complete(&gi2c->done);
> +	if (m_stat & M_CMD_CANCEL_EN)
> +		complete(&gi2c->cancel_done);
>   
>   	spin_unlock(&gi2c->lock);
>   
> @@ -387,6 +391,27 @@ static void geni_i2c_abort_xfer(struct geni_i2c_dev *gi2c)
>   		dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
>   }
>   
> +static void geni_i2c_cancel_xfer(struct geni_i2c_dev *gi2c)
> +{
> +	unsigned long time_left = msecs_to_jiffies(CANCEL_TIMEOUT);
> +	unsigned long flags;
> +
> +	reinit_completion(&gi2c->cancel_done);
> +
> +	spin_lock_irqsave(&gi2c->lock, flags);
> +	if (!gi2c->err)
> +		geni_i2c_err(gi2c, GENI_TIMEOUT);
> +	gi2c->cur = NULL;
> +	geni_se_cancel_m_cmd(&gi2c->se);
> +	spin_unlock_irqrestore(&gi2c->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&gi2c->cancel_done, time_left);
> +	if (!time_left) {
> +		dev_err(gi2c->se.dev, "Timeout cancel_m_cmd\n");
> +		geni_i2c_abort_xfer(gi2c);
> +	}
> +}
> +
>   static void geni_i2c_rx_fsm_rst(struct geni_i2c_dev *gi2c)
>   {
>   	u32 val;
> @@ -473,7 +498,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   	cur = gi2c->cur;
>   	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>   	if (!time_left)
> -		geni_i2c_abort_xfer(gi2c);
> +		geni_i2c_cancel_xfer(gi2c);
>   
>   	geni_i2c_rx_msg_cleanup(gi2c, cur);
>   
> @@ -515,7 +540,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>   	cur = gi2c->cur;
>   	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>   	if (!time_left)
> -		geni_i2c_abort_xfer(gi2c);
> +		geni_i2c_cancel_xfer(gi2c);
>   
>   	geni_i2c_tx_msg_cleanup(gi2c, cur);
>   
> @@ -1107,6 +1132,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   
>   	gi2c->adap.algo = &geni_i2c_algo;
>   	init_completion(&gi2c->done);
> +	init_completion(&gi2c->cancel_done);
>   	spin_lock_init(&gi2c->lock);
>   	platform_set_drvdata(pdev, gi2c);
>   
> 

