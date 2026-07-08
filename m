Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FB407CC7
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502255; cv=none; b=co0gnr1NfybQ0d+DUGRunX7o10pIVVMxQ4/0GWFlATtwOs8TyqW0kn7Wyak/Dw0dNyNAzL1KrvcSC3bhrtm1mHJZ0oJRqNjSK27xIORGcnvtETUZ23YJ8Viyk3I4UIm+vUIh9q4rhKkN883UHWdtYzF3RF/VFPmFYDwgBk8hFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502255; c=relaxed/simple;
	bh=3RFR/Gguc/98HvS0WeNGRxHWF//aqmOcqKEB6aoQYIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK9AukHDkWA70kMs05XTWobgg6hN8pjt9wfdldOrWT2bc+m92shDPjAdUHgJGAxyFieXV2WOR4T5BItQW0gIrQbEEBwNRLgHqMs/MlBcpw4ITq+IbMsp/Mn/qdL5EL9C3s//cy2jzh9P6NUoAGyjN/D6m6FXQDKZjyuKsg+NWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xtj4ssB1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsC4dkol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xtj4ssB1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsC4dkol"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889KEk2186513
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 09:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	79kuVe6jehvLCKmHClhipj8oSIDs3F6t6TTlRvIhYNM=; b=Xtj4ssB1PjEjBSEu
	vK6O6DSO73pkEclDNXg02v1q/9crzf5058NGOsirO1ZqQEP83xTUnUmKQatLbhCL
	Qii/W4puh6QVn1DNpu1YCuGgtK78WsrYogVFWIurKT398n4Ui6tFIeDwW0MbDxjx
	3ya6al49KIBpk0jgWDV3pvzFPGdCeMqfSUEbdQAqIQ6ME87fzP0hQOXWTPP/ybDD
	64GwqLiewbQNpNzeWl4VOGEsgN0srOcC+aZEUwZnY6aR5BW/ADOFmqLCAWvO1lES
	GNl7DwLdbuhQc6vXgQu8AF4J1nPg9IGPTlUe6o0J/U5ZgBKkpup33cGAS5RCddHV
	vRON/A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd3qaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 09:17:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8482fd61e83so833345b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783502251; x=1784107051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79kuVe6jehvLCKmHClhipj8oSIDs3F6t6TTlRvIhYNM=;
        b=OsC4dkolOUuexQDo0QvawrEMQDCAzvBn0nfNap2NWHTmRTN78i7baY4QcXxUXjhXCV
         utxgF4ixIYEh3IxY0XRsItXFj50s0sjKnHyL6wiHPLJ4xX/8A3E2o5w5qq8kMAgiS7Lf
         FWzm7aX2tIzThJZOGYLWOFSem0KdjF5G7Ml0t7hYLBUwCmrFHNNwGorTF42OmPpVbrmC
         hBFIfa2COIVZM8rv2Uqf9n8BLeXGFy6wBIx/Z1ihQe1OAF7zxp+q+rjDfnWwT3n6mS7J
         wcf9Qm2hB0CSvCGPDOBVa/+JuPPPhKOQ2FoMEhjoLteWYvSP8Rf6darKWMUNTVt9off1
         IXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502251; x=1784107051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79kuVe6jehvLCKmHClhipj8oSIDs3F6t6TTlRvIhYNM=;
        b=Hn1rUeRMXYSriAZqThXF7blaj0i/Dq//nYvqWefT1OpslJOLggYrO9q2BWKRVxihcj
         t5NAx0dknaKoH/xapeATxLadyLQNjhw7dwqolSOevUFXXYDHVmQZhdRRxFAwfmFjNct2
         AwZfGxCCl8s9uVh6/RdMtecTC7Rxw4hj/6joCHXHBXYgry6+C096V/cC/9oOV3TJU5A5
         M1zFnY1Kcl/XgktkKugkyKAp3CvSflbr0zdRRYi2SRjie/+Cgh1kBoyjLavx1Shk5BQI
         L4N1leYLLdAkDh3YOs0lz16a/NoQxPX2+NWUVHKfDCmIXd+yB3vKEUnN4IH/ox3CJjHb
         j+Xw==
X-Forwarded-Encrypted: i=1; AHgh+RoH5/FMdjtDBXNc5SJHnnhZyKkVuwlzrPyZ7ubWWdQl362lIx4h3A8HrK9WKghQlRxE3HnKFokxs4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyga6I4e5VmRtSfvrOi/9EPcvhFMQzFJ9d+MsO5+Cew1UGIf3vX
	AHvbOyFeqiELxmKWiwv9pqiTe9KmxABE0fa20RxNr2nQPR7kVCZ5rrm+jOJNoAkAjiH0sTDmUrr
	1XqiuJakrdUZzTkzM9O08nn8R5/Kvl6LYbyK2myy0FTUkmwKup2QvNVRGkmGmf9Q=
X-Gm-Gg: AfdE7cl7erxLu5py1SCYGz77q79Fmj3aIRqfZLCq05uFKZKzylDi0OQdhKLVh3C6Wnl
	5fmCfSGkplpoI4qYs2bVce4VsF+roLNdHlRlUTqccqM4rlmdyxwNXg8dPXvFh8Hk7yNMz/w3/Dy
	+eC8VApzgug1jqZ8Mt9LxJUG8J5UzmDHxTF7YThrtNLjH4i6O1Pw0UQYLq+9rDX2fD+Ko8qmHgp
	FjfPn2udiDmGY6t8yh10Ykz+3GbUp2Wy7CZUwzu9ZTAn9sZvm01ZSVeeipSxaMtd4dDp0vDel9J
	ZHvwfFtXD/WRAJa/zkjv4Fgh4XIBTpa7Igjjfy1Fn9TEvSFRAfMjBPN4pl39a86UXnjJEUMAzLh
	8eTX+L886anOjFMwfzHg2lAYjQ2ET3j65HsW96tH4Vg==
X-Received: by 2002:a05:6a21:e8a:b0:3bf:bfd0:2a11 with SMTP id adf61e73a8af0-3c0bcbc03c5mr2112874637.43.1783502251049;
        Wed, 08 Jul 2026 02:17:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8a:b0:3bf:bfd0:2a11 with SMTP id adf61e73a8af0-3c0bcbc03c5mr2112824637.43.1783502250372;
        Wed, 08 Jul 2026 02:17:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162a49sm2070246a12.15.2026.07.08.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 02:17:30 -0700 (PDT)
Message-ID: <9eb94d85-5074-4d2f-91a7-b3d39bd2bc4d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 14:47:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] i2c: qcom-geni: use cancel command before abort on
 transfer timeout
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
 <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-1-dd8f841f36a2@oss.qualcomm.com>
 <74520b45-b3d1-475a-8929-b965ce760d5a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <74520b45-b3d1-475a-8929-b965ce760d5a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA4OCBTYWx0ZWRfX6QayyU/i8x6a
 si5/atlr/OAZgfU5yve6ImUqUA7xjLINDI2m8BQN+wL6YyB5OD8DT15dAfoxnoqneUwafeJNkM6
 hBGU68lJDoa/JtWIRRGeOxQitFkuZF+rI4dzZyC3HqMDVT2fp4wBMXygzP181Ix+em3oeHQxEOk
 dnkVJYp86ML8xJO6NF9IYvk7/MzQlSSNdpQ41HMR9PpJRyscQSkvLSbTGkn2qKzBMHki37CwpfQ
 E976vaGuBJCqTpdHPEUZsKN1l763Gg5R5U58doS+WSVb5mKqd2wjp6KCWipIy9EJDAhzIoioNcD
 hUP+rZxBkOsg02sDBr01Fpbm+VZhxWvgr0HVhF6QFS3H7HYLcnCiQF2T/q6o0X3Z80Ze3h+3iJU
 2KHw8dnRnk8Thqc2qpuOG5p6hOEn4H96MAoI1z7A8Dbn6iVCMst2UWWmQitvK3YkY6BFt24hiA3
 cPLqqNO5UOjHxMA1qQw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4e15ac cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qSuGSYE2gW_qi9-8UbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: ildvOfndSbCyLnAsKWpEbGW6yOgU35aR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA4OCBTYWx0ZWRfX9LloyPcz1wGt
 Drm4CF7bFehIOGJ3kQ9zrKB40Ubkjha+F6+kDuO2a40jwHNrt+qwWpL7a0PWXM7iWgI681I7nOM
 CtN0ukd8y0EGgeCeZCcHHk5PQ7ILJpQ=
X-Proofpoint-GUID: ildvOfndSbCyLnAsKWpEbGW6yOgU35aR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080088

Hi Mukesh,

Thank you for review.

On 08-07-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 7/8/2026 11:45 AM, Praveen Talari wrote:
>> The GENI I2C driver currently invokes geni_se_abort_m_cmd() directly 
>> when
>> a transfer times out. However, the GENI hardware command cancellation
>> flow requires a cancel command to be issued first. An abort should only
>> be used as a fallback when the cancel operation itself fails to 
>> complete.
>>
>> Introduce a dedicated cancel_done completion that is signalled on
> Typo :signalled
>
> "signaled when M_CMD_CANCEL_EN is received" With this , rest looks good.

Sure. Will update in next patch.

Thanks,

Praveen Talari

>> M_CMD_CANCEL_EN. The timeout recovery path waits for cancel completion
>> and escalates to geni_i2c_abort_xfer() only if the cancel command does
>> not complete within the expected time.
>>
>> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 30 ++++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 96dbf04138be..15403edb355a 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -74,6 +74,7 @@ enum geni_i2c_err_code {
>>   #define PACKING_BYTES_PW    4
>>     #define ABORT_TIMEOUT        HZ
>> +#define CANCEL_TIMEOUT        HZ
>>   #define XFER_TIMEOUT        HZ
>>   #define RST_TIMEOUT        HZ
>>   @@ -112,6 +113,7 @@ struct geni_i2c_dev {
>>       int err;
>>       struct i2c_adapter adap;
>>       struct completion done;
>> +    struct completion cancel_done;
>>       struct i2c_msg *cur;
>>       int cur_wr;
>>       int cur_rd;
>> @@ -361,6 +363,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
>>           dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
>>           dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
>>           complete(&gi2c->done);
>> +    if (m_stat & M_CMD_CANCEL_EN)
>> +        complete(&gi2c->cancel_done);
>>         spin_unlock(&gi2c->lock);
>>   @@ -387,6 +391,27 @@ static void geni_i2c_abort_xfer(struct 
>> geni_i2c_dev *gi2c)
>>           dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
>>   }
>>   +static void geni_i2c_cancel_xfer(struct geni_i2c_dev *gi2c)
>> +{
>> +    unsigned long time_left = msecs_to_jiffies(CANCEL_TIMEOUT);
>> +    unsigned long flags;
>> +
>> +    reinit_completion(&gi2c->cancel_done);
>> +
>> +    spin_lock_irqsave(&gi2c->lock, flags);
>> +    if (!gi2c->err)
>> +        geni_i2c_err(gi2c, GENI_TIMEOUT);
>> +    gi2c->cur = NULL;
>> +    geni_se_cancel_m_cmd(&gi2c->se);
>> +    spin_unlock_irqrestore(&gi2c->lock, flags);
>> +
>> +    time_left = wait_for_completion_timeout(&gi2c->cancel_done, 
>> time_left);
>> +    if (!time_left) {
>> +        dev_err(gi2c->se.dev, "Timeout cancel_m_cmd\n");
>> +        geni_i2c_abort_xfer(gi2c);
>> +    }
>> +}
>> +
>>   static void geni_i2c_rx_fsm_rst(struct geni_i2c_dev *gi2c)
>>   {
>>       u32 val;
>> @@ -473,7 +498,7 @@ static int geni_i2c_rx_one_msg(struct 
>> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>>       cur = gi2c->cur;
>>       time_left = wait_for_completion_timeout(&gi2c->done, 
>> XFER_TIMEOUT);
>>       if (!time_left)
>> -        geni_i2c_abort_xfer(gi2c);
>> +        geni_i2c_cancel_xfer(gi2c);
>>         geni_i2c_rx_msg_cleanup(gi2c, cur);
>>   @@ -515,7 +540,7 @@ static int geni_i2c_tx_one_msg(struct 
>> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>>       cur = gi2c->cur;
>>       time_left = wait_for_completion_timeout(&gi2c->done, 
>> XFER_TIMEOUT);
>>       if (!time_left)
>> -        geni_i2c_abort_xfer(gi2c);
>> +        geni_i2c_cancel_xfer(gi2c);
>>         geni_i2c_tx_msg_cleanup(gi2c, cur);
>>   @@ -1107,6 +1132,7 @@ static int geni_i2c_probe(struct 
>> platform_device *pdev)
>>         gi2c->adap.algo = &geni_i2c_algo;
>>       init_completion(&gi2c->done);
>> +    init_completion(&gi2c->cancel_done);
>>       spin_lock_init(&gi2c->lock);
>>       platform_set_drvdata(pdev, gi2c);
>>
>
