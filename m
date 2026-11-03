Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690389;
	b=TY1wOPSePWZ4Qp9WhQIQx5XhsIfCfxPZGZEGi1rf2EQzc6omq3M9bTy7axzcVO7nK7Y3
	 VrGlN7aTnqfuYWTHQikgc52PFkV6SE/plpTbcgiXMeFwJhb6AiBFxcYM7RrSLrhSuKLD9
	 1hJXqdTodnWHGWDzALlFbqNMi/PH0qN+Mir0nqFW7NZztqNohJGnyBR2UJgM4gs3quyW2
	 XICynYccWTOJosJebljMCcqU3qE8a52OzqOKWaIqc9gD5ZAXMEUGUCOXu/hMcNVUAro9r
	 MG5ZuI2sM/OXIGk1Oh1TPwIwggkqXOXZ/Tqo9ualT0lIRzwjx84CJnFd+sf8GKwUMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690389;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K2CG3b4t47yXaBdjLO2bPQOOsh8D5qOew3uLqFztY7I=;
	b=Hh07UITH23DCJTFngPZikXtiRUHqykL09/MTnY9BfVQ4NWZD+upATQJ/lobiL3d11K1/
	 VXVoN8MbPkgRWQqv7myMg29yZiPf4xPYLstB5noLeaj1iSQb20vwsYC/zU//P1lDtH/ZV
	 fpcTxdNg7/Lb5okjpUKSKDg9NPKfItOitaP7Bh9JAHxpPrVqPhWxPMTDxDLFABCDy2NYJ
	 tFRWHC2I1oJsGCoRmh5xkY3uOduNB/jLZtfC55Ey3kJQZAWq+f37QCXcD5QeaFCXZJt3P
	 6ZPJfhqL0E+DRuRCqOfemv0rm5HNSc7WFjn00YsKTf04ooA1UvUcuoo1aGVNEykk2dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XpHOIXNz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=feRmNSMU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A55606A32D
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 07:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A55606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XpHOIXNz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=feRmNSMU
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eMhg471225
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 07:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K2CG3b4t47yXaBdjLO2bPQOOsh8D5qOew3uLqFztY7I=; b=XpHOIXNzBBnR2/X2
	0b5XmdXW1XJNxAsPUuItnr/snKzhBS2jog5fhps12ehBR+pxFTfWYobk15L4Zg37
	6s4xGT93eIDOjB8Yb8gFc45sa5sMG4Zy9jUznTtNwCyB7UxY/XboUChTY516KLlg
	g+tmhYGfBlIS0HId1HY7F2Nd9Wk+UzCWX4etmk6ZZ6vioB0D50uN976PfR4jUjDk
	FZ/iYCxgFNXBmodZ1xbNkRoq8Yvh8wkAsXJjLoE0g07PDji/hS2bNiD4oX9uR3UI
	8/VZmekeLcQWhP2t+LvkGlacFlL1ZFKfKiACLAH/gTOsiLVbtd/KTxTGU2cSA9TR
	+NRRmg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081tfvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 07:19:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89ff475a0deso3432601b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793690387; x=1794295187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2CG3b4t47yXaBdjLO2bPQOOsh8D5qOew3uLqFztY7I=;
        b=feRmNSMUJHeyYErxl9D2PeBg0cYtRqWnkkT5hJGcH3zfKFlek8t4SLbsdu6hLJ/gr1
         C/TCVMoJF05kpAp3d/jg5KPN+7zI9r9SSHBj7YomYWEKbfdME38YnI7JtPqTKXZcrOWN
         8EnHNN1Lw9U2/8/bqUOuWwKZzKrVsyqorelXeFE7wSm4yklfVNBL637pEpE9YZowvJWA
         e3E/MZTvaa0eiCPsDdrm+vy27EztIu9flcFNlYZkNAyGCDPvlfoGr+w1O09wCsQB83nU
         KO5qka6uSIkeOO3YPUaWIeKgY1WC/UMFBhsnxsVIuqzn5wJXwPoR0IH4l9lKnGYEFo9X
         Ia7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690387; x=1794295187;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2CG3b4t47yXaBdjLO2bPQOOsh8D5qOew3uLqFztY7I=;
        b=vBCnnhB2/20m6EeQZQDwsSlEE/YldqEPQv91SdBAFrR4u66kfnIXkboWEdpeFIl2bu
         B98FujAb6zL8SyxBbjw8srokTRgTr+Illi4riS+i73i0bkNjDVNxeYd18tee+7qqnHPw
         kat9dDQBhGpzBWrexhIj2zagdAI9Cjaeph4L87znRd/zTmsS8G2kq8Ww09K3aXETm8/P
         4L5h0W8Y6DJHfnM17dob3m0P0U2IBPa81mePree/qiAmHuamlIuDK4xbXEn0vrNaHhkw
         v0IBs0utzEwK2llJ5JibOrixL0aSYFea+6kICl45OTKTXV8m64qPMdhUz5b/uju87yIq
         3VAA==
X-Forwarded-Encrypted: i=1; AKwUvBwCXZ/nNL20eiQt888qsx53SrCV0Gl7UViYqQ+rtRUT8E/GJBZ/ivlu6WMEcMuyu+r37oNkkF8H3U0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W+5PjBhlL5C6MhPje73WqCJ7riPrKBgGHDXcXFhfp4mrxgLJ7
	u2o5TIJl6337PLuswBh1AbUULwGvKB+eMuz8F871MI9ROhgY2bzZXuVT60EFRJpJX18JXYf2ift
	k7JuBGvI09UHeLgEmrybO84Xj8HY1Hjxz1TEBc975K2iFT3GX2Cryk0IKdU4DtlQ=
X-Gm-Gg: AYBFou2y9yPQ+fKV+MM0MDEm9ygD6n4xgZsmZ3JyRk/r5iDMd7/RgQzHJZCLK7HmJzr
	oaq1T+7aLVgvNjorQfScB8zj7Z5POl63z9XvQHcs87fRK7+TtkH4PxLYdutlH7d0Bqx/Dq4ZneP
	38tRbZ+PCM9TATNDZcbcPa3jfH42Kk+hg0k2J3RQj8z4jZH/I/FFnU9QT8W7VmCqMCUoFzvE1MH
	YiVlhVIy0g9JrUYnKXCBlPvA5FHkVc0+nQV9YksITN19FRVeY3o4w5sSJfJSKNJU6kvhh8j/tNO
	e0+Bte/HGl0xI4hmhrs5inW59kvnTYkxqYglUpPF33nlLW0B1bYOZNmDzoME0LWqw4mRk+qbKue
	y0ABstecCqf6/GbjiVoRYI006PT0Alrc0HDA6KKX2ZeCthtbXrpER9nvoiJdozvSFN2NcCaNQhz
	tGYbc=
X-Received: by 2002:a05:6a00:181d:b0:89f:63f9:b6c4 with SMTP id d2e1a72fcca58-8a9bd9d6ff3mr8752574b3a.32.1793690386821;
        Mon, 02 Nov 2026 23:19:46 -0800 (PST)
X-Received: by 2002:a05:6a00:181d:b0:89f:63f9:b6c4 with SMTP id d2e1a72fcca58-8a9bd9d6ff3mr8752561b3a.32.1793690386349;
        Mon, 02 Nov 2026 23:19:46 -0800 (PST)
Received: from [10.217.218.73] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9c09086sm2768904b3a.23.2026.11.02.23.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:19:45 -0800 (PST)
Message-ID: <8b83c220-4dfd-433d-ae8f-8b65a4865c78@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:49:40 +0530
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
Subject: Re: [PATCH v3 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
 mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
 <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-2-7f2a6e572de9@oss.qualcomm.com>
 <acac5cec-6fa2-4465-9f66-a5e533404978@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <acac5cec-6fa2-4465-9f66-a5e533404978@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfX3KXwqSIR9lyO
 ALCtVjHFTzjg4wTS//jBZ6PhwHWjqevxZ+X5iZ4Bjj1fUNj88xDzH05P1+1XUMAfVE889oWPeQI
 8grjqnQBzjXWlxLfhdD6vZMakFDuZvM=
X-Proofpoint-ORIG-GUID: i07OZEAaHWL7L6xMb1q_9crUy_yMhoy3
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae98b13 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NaWF0_NUFfviP6yxQe4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: i07OZEAaHWL7L6xMb1q_9crUy_yMhoy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfX6gX7gVrqv91Y
 3YvsIxZEdgs+dAOO8cTahs4S9rUiMGobLcmCyfRvkmagb6nK/O2F5xVWzbdjdUf0t7FfD5u+dl1
 S2+wVfldnByYVsaXBSK3UFzKY9gqSsl3l8CmKfAcUybd6bGuhLXzS+2IC1T47XugGI4iPYdjJos
 mJfXDtEBl8ls7LPKSJ3daUP/4HalKOWUJOnvqy2M2S+MUImYPiQ358FIN0LV5fNV+oZ0shqeXGd
 LfsyRRSmANkEMllckxuh+pPvQzVn7OtwIr2uRtPJ6JMvUJRHyz6tcd0dBoh7e3MkIRe7kX1Rs+Z
 EyZamiHv9FyqEy0tKK6cqNOgV8xTDKfZMMQMoW95Q8e3wgVtqiFctSurM9t5GHD3S0BbIUsmEF6
 1JPjQzw0eGTmUjOxiz2yDtlFIQQSi192ddyh8OR2fLNBiEtU+JNwZTUxubMFM9etZLFMTrii/0x
 LgreZ0EvxhhtdnMO+zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030028



On 10/27/2026 7:37 PM, Mukesh Savaliya wrote:
> 
> 
> On 10/27/2026 10:43 AM, Aniket Randive wrote:
> [...]> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 127 +++++++++++++++++++++++++++ 
>> +++++++++-
>>   1 file changed, 126 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index 60b6273f538c..d9e86f110ae9 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> 
> [...]> +static int geni_i2c_recover_bus(struct i2c_adapter *adap)
>> +{
>> +    struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
>> +    u32 ios;
>> +    int ret;
>> +
>> +    ret = pm_runtime_get_sync(gi2c->se.dev);
>> +    if (ret < 0) {
>> +        dev_err(gi2c->se.dev, "bus recovery failed, error turning SE 
>> resources:%d\n", ret);
>> +        pm_runtime_put_noidle(gi2c->se.dev);
>> +        return ret;
>> +    }
>> +
>> +    ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
>> +    if (ret) {
>> +        dev_err(gi2c->se.dev, "bus recovery failed, error setting 
>> clock rate: %d\n",
>> +            ret);
>> +        pm_runtime_put_autosuspend(gi2c->se.dev);
> can use goto , jump there at exit with ret updated.
> As 4 times i see pm_runtime_put_autosuspend().> +        return ret;

Agree. I will make the change in next patch.

>> +    }
>> +
>> +    if (geni_i2c_bus_is_free(gi2c)) {
>> +        pm_runtime_put_autosuspend(gi2c->se.dev);
>> +        return 0;
>> +    }
>> +
>> +    /* Bus clear cannot recover a target holding SCL low. */
>> +    ios = readl_relaxed(gi2c->se.base + SE_GENI_IOS);
>> +    if (!(ios & IO2_DATA_IN)) {
>> +        pm_runtime_put_autosuspend(gi2c->se.dev);
>> +        return -EBUSY;
>> +    }
>> +
>> +    ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
>> +    if (!ret)
>> +        ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
>> +
>> +    /*
>> +     * Recovery succeeds only once both bus lines are released. The bus
>> +     * state is the authority, while a clean opcode status with either
>> +     * line low is a failed recovery.
>> +     */
>> +    if (geni_i2c_bus_is_free(gi2c))
>> +        ret = 0;
>> +    else if (!ret)
>> +        ret = -EBUSY;
>> +
> 
> Please simplify with ternary condition ?
> 

Sure. I will do the change.

>> +    pm_runtime_put_autosuspend(gi2c->se.dev);
>> +
>> +    return ret;
>> +}
>> +[...]

