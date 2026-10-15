Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57837F01A
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036735; cv=none; b=i8n/vvvHOi5absajxxFQwdtLUKXZJ89gAsc+3iCGd4pSKu1P1xTkmirCOpExI6gE8vFlNPip6Zl/gH2p29ve8CGAk2noTU/6V6XLmc/bjSDqlETfG1N/yDK5DOIgmfcRSPw/5eQBSRLSP5spr8/rqRPiUtC7rseoPAD+FhIJz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036735; c=relaxed/simple;
	bh=nguePDkbSX8CdLrI5jeCiApYYmALGzarrJu+OM9Fqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sv56w0dirRPyw2zLy24QJFMxVqLlgqgsLFAkaT8ZEskVQW7e8TcD+qMCDcYMawnhpoXQkEyLH9TQysX/Zk+gd8x3egz1c3euECGFkmoWfupIcQ0MFfkNVHsb5G37ZMwFmL5UhV5t+Gy79Sj3HlRENYbGgkl+UGAGiDjEQZOm/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7kG2EMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Id0lvc/g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7kG2EMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Id0lvc/g"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ENxEaD1682677
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 03:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=; b=a7kG2EMKtNc3ppFV
	ogttzL9XW4vzOAZkDYPt2ffRra6tQRSjZqEc5ss7PKoRXS3+CC1neU11bs5H+wJJ
	hv0t6JzmuVAVNBJMNpYtXtmAHgvs0ZLgHPfCtsrwNzyRUiFaFgblwJe1V3XC0PN6
	5e+BVu6dTNcrxA0F6uGaN2XuN3U1OMcoMCDwscp9ZABI6fTaQcSDKunlFPDiWZXz
	U7uPDBBOcvNuwLLzE9W3WPH5sc8IN6Vq+iPqdYETcyY7IVg5T/j0sSvSx/BEH4d5
	1QpW/a0vbZDFtNGyLXbtAzN3PEPir4XiS13YiIp+WaDrZsNUxAmRnoE9UN1eiaua
	Q34uFg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb02gmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 03:58:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so19031183c88.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 20:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792036712; x=1792641512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=Id0lvc/gB1ttqNhQU+VY8Qln4VW7JI/Hc/1p7Xth4gMMixMPDw/2SCxgGmr9vugWNG
         HmR5B3ziZR6DM9ei4H5f308T+5S8N5NHGjlanX9r119OabRCZbRBrC7aLe3MXryDhO6D
         n5TheWJYicYF9zshW060AYXhuX/praOpZ+hT943/rwIeWTUPvk2YqipHurYDjzWjmY+k
         MTxXwXtYObE2BEJzQBTEMg6cKXiBnCb1bBAHW/wlGpGrZcdkOXXTxSpwIesm97roxXML
         F6V1tO/hmHYn8EyDrsA6e86MBba6Ec4/RQR0Fr25eDBflegDMVx2f1br7eDm0eRwtBGb
         TkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792036712; x=1792641512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=qpLCMbll5A9HkKgxeaIVa/fDBEBB5j2xIVVx/dnT5REXSQE7nxLA7foZkzTBLEnw8J
         ymejBP7wtuuOFhZl/UHQK+F+mdvBW5EuiXsAfh4Nox66+cGHGOJKOx8naEUi54Q2HaXW
         gxoVYRs25DyB3o4yiKucTUbUQib/EJFcodD1kjoEX9WSn9MPo2CN7jrOc9MCszi+uJ08
         TLf4ld4cTa/fgaIFMXHB5SRP/duuxn4m1gMfCCyQPnZMaS5lpWhc+ZLGXj34yNAazriN
         WjXFTW9L+TbE4jW+3nrSyYed/jM//y4rHCzj2tkOJELxYUOBCdQJ0mZRS/KIkAqkXvBP
         DKhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP6PtklcCdXKQtJXqQzJ5eGOUeWDF4TQic/QGtpt6fSaq/HffT0i9OwmqIBSEzxJuuusp2G5gguPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4RnfnM5eBcvdSIpSMJBDurYPKVZ7kpgMEtzavLtC0W764toN8
	5YPLxKnUKIP936MB6IOm5Y8Ka0vBFb3hVfXw+GvagfULxyNZwGXYpS+zWKnsLbkNFHZMvVq+Eh8
	BdownNJvP4/tXJWheCGdFC4cN5pbNc0uDjdmn2xkKolT1cnKxJbTB5RMtGA3IsXA=
X-Gm-Gg: AYBFou0LbxtEMDdSpQZKJZg54kY4d5j1EJv9JVjiFhiuPLrBWMXTjnRjeAWjcUrZ+Sz
	0AzfjQRvCwjeMRFowO6uctNmwudjlWsHdGYmpO0nGLbTDDU4rjS4dMbwIWWpv6OKzUF/+7kbygW
	hkVEBGZLDClajRrt1gf1tIWmW42jcsk3eBhpfiAIsWQ9Sr6iCuYMi7tv4b5uJQjOEhht6M5JdnZ
	aYbTm918by/xxQJySw0Ld2XmgT1CRmQFuK7HvCpB8BvSoxmzrRYZt1fMntakZxjdvPrk0xuAm4x
	khvj/4Hf46ZFADpMozxVaIqZKdkHgMW9TBqfA9LLilv8HZVqu3PyzHV/TtSSkOIkYMJYz06P99M
	ocJOKqGIhzCHcFXg9QTTTxmFRIt9+5Q==
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12450101c88.37.1792036712250;
        Wed, 14 Oct 2026 20:58:32 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12449972c88.37.1792036710046;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm41853429eec.11.2026.10.14.20.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 20:58:29 -0700 (PDT)
Message-ID: <666e2768-28a8-4bb7-8c15-457ad20970a8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 09:28:22 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
 <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6ad04f68 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ip-HRx4nHBnhdLLshUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX7Pb5v5MAxQkd
 mfXad8ebNOl10mVo7nkVElS0U50qhhNbkXsQETeXflMD+RxVDk5qBiGsjie/yI/wPZdtkofw66p
 JJgMZE/VQzQVZq+L3BpQOEulFrmk4qQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX3BjqRYwaDgD4
 LtefG2sBxmrV8HjgCqlOmnQbhUj1eptrp+0/aGo63IKc0vEGhjLv75bZU6AGkPS4qwkgR6TtP/y
 1Oewt0a9Vgm2DWW4pK5YZvDAZQ1DBjcNNWEHtmDbgJ1nulRf05cFpLuxR1cUFSGfYMJrAHTD6eh
 sgBdKiqzVJOwM+GCw3W9SB0grOY8UGuLwGzv9RF66qpL5lTFihP5y4Tr1Ag05BBcwgFhp3A4Rnd
 utPeNvK4z25BWLHMfBTkT7kwJmrFtQZ7TIXSJc/o5Vsnh+J9XEWThUAnNdQUmEcqNG25/5rMVP4
 Tm2qEOgXFE0CMD/9kP4X7tuTcJoW8NtRj0wC/7jxN2DJuXKBQ0JTqmHScm6Lzsjv7hkN2baOuud
 NGvgiKLfpmgRjFMHTMeupfAtfD01PRVfM/1EhYsoLKBTpM/3iet+iu/e7f4A65PBkJ88PpjSJVJ
 9+fQJrOkEoH8xCNSdaw==
X-Proofpoint-ORIG-GUID: NLYLFOQE0PaFAJH7MzQR5pxaMnK2T1eT
X-Proofpoint-GUID: NLYLFOQE0PaFAJH7MzQR5pxaMnK2T1eT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150015

Hi Mukesh

On 08-10-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 8/27/2026 11:29 PM, Praveen Talari wrote:
>
> [...]> @@ -2039,15 +2041,19 @@ static void 
> qcom_geni_serial_remove(struct platform_device *pdev)
>>   static int __maybe_unused qcom_geni_serial_runtime_suspend(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> +    int ret;
>>   -    return port->dev_data->power_off ?
>> -           port->dev_data->power_off(&port->se) : 0;
>> +    ret = port->dev_data->power_off ?
>> +          port->dev_data->power_off(&port->se) : 0;
>> +    if (ret)
>> +        return ret;
>> +
>> +    return geni_se_set_rate(&port->se, 0);
> Is there any register access happening as part of this 
> geni_se_set_rate() ? i was searching but could not see after seeing 
> set_rate() callback removed.>   }

No, there is no SE register access as part of geni_se_set_rate(), nor is 
there SE register access immediately after it.

Thanks,

Praveen Talari

>>     static int __maybe_unused qcom_geni_serial_runtime_resume(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> -    struct uart_port *uport = &port->uport;
>>       int ret;
>>         if (port->dev_data->power_on) {
>> @@ -2056,8 +2062,8 @@ static int __maybe_unused 
>> qcom_geni_serial_runtime_resume(struct device *dev)
>>               return ret;
>>       }
>>   -    if (port->se.has_opp && port->clk_rate)
>> -        return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>> +    if (port->clk_rate)
>> +        return geni_se_set_rate(&port->se, port->clk_rate);
>>         return 0;
>>   }
> [...]
