Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3213E9F8D
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584827; cv=none; b=ZRw2zO3Z/n4SZeTOmd33QiV1leANBGhSB1B8GYyloYxnw6ONrEZBtH9eJrgSudvUd3pIsF4Bxg3wGmpaa9kR0YvxARb5ZT426iJcyEbF+3aptmXT6/Twp0VlGlmPVXE4zFE+zap+bPvQGIe8QnR3RdwcJ9rRBZo43oEoS5xK6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584827; c=relaxed/simple;
	bh=9/WUWgdh3PDVlVDre2TUuajRrGAsJgm7LeGNzpx2VIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFRPy2e/Nz8nhUfPrOoO8F9siMZafzZZqv2G1/66SydF6wu6/C/fnqdABeK4mzIfCJL9UFtfqNpYTvcf5ixhYnUgaTEnz7p+G5Os4dubN5M/MOYyE7hxmrOJXy/pUwtHuAxU4PLnQiuz78ihB9Bt+9fG5Jgbkzioripnu8Js9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmDwH4F5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gz9kw/M1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmDwH4F5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gz9kw/M1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669618dA933300
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 08:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9q9J4qXMFiZ/ZPLYqKi9AFHblEBcuFUAYAJ6Fh6AC0=; b=kmDwH4F52D77XGIs
	zjpium6op2JzSAwo0yBl4Esk9iyeD02LiEpY6+AcI+YUWyiy9fpDH/xOVilj6Y/e
	FXrlloZD1HK5iCDri/SRZTKmn7B/kOKscLc4tB81eGqVC85rqvwxh8RkiD6e0Jn8
	zRsrHaARZ7wVtvNHo5zQ1qfEdsOzyQ9c9dGU5aV4iKJTCqhjtdAj3HpAytGvDU0Y
	W0t59pFXueW29ylZOqhAn+Dg+B1LcIDvJEeynvtanOQY++Hj4ChtNupWSCte5Heb
	ylueQOuZE8SuhNV+bxze47lIDbOV76j05WCvIW5qByKM0M7DQRhOw+/LLYWNJs/I
	n5q0Fw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6jmy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 08:13:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8018f11fbso26789735ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783584823; x=1784189623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9q9J4qXMFiZ/ZPLYqKi9AFHblEBcuFUAYAJ6Fh6AC0=;
        b=Gz9kw/M1Ch2iyBxnK49+PIETG8gNizR9qEa0LUohorzADtB6k8cZkNsRY/yWdfqjaz
         nO591wuip5g9c9eBrtnmK9PKv2HYJYxAXn5rus+YvrELrxo78hYLHJQcF0ljjRbZ5yG1
         PfkQM1/5sajhpzdAvILGfxjit1UdiyQRck6wnMiZy/svvu+15+TRBWlIGw1KWbPsCNvq
         I//Q3S0zropHhezwc1Z6UOtZgCSWIHWcEZps4T/+NUCQZwOEQDYucGEL4p9zWR4XrOBX
         qvPnGNq43zKtxDtFrxVmXDax8ihTFE+ttYNHOhh+mYkZG91owte4yLqi7KNtpSwqPf0i
         IZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584823; x=1784189623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9q9J4qXMFiZ/ZPLYqKi9AFHblEBcuFUAYAJ6Fh6AC0=;
        b=mA7QYIlfPTmPBroTElPanHU2q/XgQxo0LR4AgmxxnSsdrXMQLoBMww3jI22ads+2sE
         8mafAI5e3UMvKlfcf3QE7qsgV6qTQKusGrNaYkEuTAwtevBMjF/0HpJ2hCpzOcelMU+E
         JRl9arzqWUsc/E7ZgoXaeH/+5QIMfEyvd5wM/aB/GHDlRAPVyGHyNC3WFZ/MeKdB5+sG
         V93305bLYX950SezzZB7BM7t/NaZvbFkV4AikaCH1fLb69MCGOFNR2sGvwVApl1dR+c2
         VpWmrQqcGbkVcOKMn5aP/dRotCLr/FHN3iewewUhb/1Eg9rQ5sC4Yg54OoWxF9ekl9JN
         sWyA==
X-Forwarded-Encrypted: i=1; AHgh+RrdU++Cs4NRbxJIC3ofylDqlU1G5QjT3JaoApFSRclNEWWdKhD37ArWJpZWqdDv5CmbuxA3ER+TC20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydcm6NERb8CDFJI+AWebFmPRozr6Hj9bpz6NNZHvA7VLMNgTD8
	uKAUC4uYP4Dd1vNz2+ek7AR+CxNiT7tY2unUZsFHNhYJF4KOXstMPIRy+Zcf+l3CuLxW6+czVgL
	m2YPDvc9C+LL2NEQ2NYQRcfMERTGSaL0AVYuDYEQY6IfFO6bH4UN72QOhtnpxUuo=
X-Gm-Gg: AfdE7ck2PEhDfJE12Tobn5MeDkMxflEPwCd6PVo1Nm88Wf7VSXgZlPLdtagh88k97qY
	mGMfXtLlzti1SseZGdU+9bvMutpZ2GWIRRCpt+qvQ3ATAYhWstc0k8LLTIRSIcIDI8TUYgMsAVZ
	WASu9URp9Gp191hJpExEgxLYEJ3b83RlXmxSsyxDnaUqN/ujlF0/91FK+RhKvZjxF0a9Aixa9dD
	XTg364t1LvPlDPtEiJdnQ+G5i0jyOBbU8LMz75NEAuv8uNSv3jNIi0nNl+4J4ntt2eZns58rXSx
	LlK8KWy37LZDNrGnqcZy7LirnBp1STjpyl+lw5syTMohC3g7QLrdlw9QP54EBvYyGJaHkWX6pRr
	QIrkBefknNETQVclVu0uE5RY50WL8rdW0ZfcD2YPaWL9EEMXvhA==
X-Received: by 2002:a17:903:3250:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2ccea371b35mr61446805ad.5.1783584822953;
        Thu, 09 Jul 2026 01:13:42 -0700 (PDT)
X-Received: by 2002:a17:903:3250:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2ccea371b35mr61446215ad.5.1783584822124;
        Thu, 09 Jul 2026 01:13:42 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c100adsm39213395ad.32.2026.07.09.01.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:13:41 -0700 (PDT)
Message-ID: <b7404cdb-7c67-40b0-8124-d4977a8ed3cf@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:43:36 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i2c: i2c-qcom-geni: serve transfers during early
 resume
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        andi.shyti@kernel.org, viken.dadhaniya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorande@oss.qualcomm.com
Cc: konrad.dybcio@oss.qualcomm.com
References: <20260629134140.755193-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <20260629134140.755193-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX/zWbcFuFjVcn
 uauQZ7N7YmxrfMQYpN/2Bn/lLBOIJPSFIAk6CdYxZ0em0bDM5Sa+C2S7TaRpi0YYIj/sDzHz7jO
 hUf9c4MFofc75h2qS8OwoL9x0HHJfKw=
X-Proofpoint-GUID: xfQ14ag6uMVjfqer031IpFZA0Skx5zGP
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f5838 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=55kWd-6b5CD8CZZ_UxgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xfQ14ag6uMVjfqer031IpFZA0Skx5zGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX6CcM3Gzc3sdx
 U4rs9CgeFHMn4V5UAztOfyozg4YqB7UuO29eiYVVDQsgI2YYOj95fJ/ljQmRk9E2GZzM0dMI6LX
 8DbGVjqwNoFOwwmEz6HjlSsCankWldnnSc8K6wj259HYYAo5ldBHpGwIirvOHP0W3d5FflX3+5U
 CSBNkGnY5eA4dwGtQn8FqislAGHclmkGgjqxUuZZogq77xxbeniXsgJrY0L+Tv2KB9d/GxeAHG4
 tUj3Qu1FIhW/LP2JeHaaOBrz12vQ3YRIlEoHyjB4zrZWbZrSQgbqycE+3AsBdkHN+Zmh3JY//vG
 +2uv2nwPQWgD3AUPgyF08su8sQbqfTBij5RPRQNUHRR9X4U1tOenmCsroKNvLCTiVr0PWfnw6nP
 +NsrcF9C9qoftrpm58/kRdWvbX/Y0FH1nVq0lGeT71gJ2/N2FRBmc6Bc73iuacC7VS7H4b72xwJ
 AmHjWWtsAG48xFHk1Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090077



On 6/29/2026 7:11 PM, Mukesh Kumar Savaliya wrote:
> I2C transfers issued during the resume_noirq phase can fail on GENI I2C
> controllers.
> 
> Some devices require I2C communication before their resume sequence can
> complete. One example is a USB Ethernet device attached through PCIe,
> where device configuration must be restored over I2C before PCIe link
> initialization can proceed. Since such accesses occur during
> resume_noirq(), the underlying I2C controller must be able to service
> transfers at that stage.
> 
> However, GENI I2C transfers rely on interrupts for command completion,
> while IRQ handling is still suspended during early resume. Additionally,
> runtime PM may remain disabled until later in the resume sequence, causing
> pm_runtime_get_sync() to return -EACCES and preventing controller
> resources from being enabled.
> 
> Allow the controller to operate during early resume by requesting the IRQ
> with IRQF_NO_SUSPEND and IRQF_EARLY_RESUME so completion interrupts can be
> delivered during the noirq phase. Also restore runtime PM from
> resume_noirq() when it is disabled and tolerate transient -EACCES failures
> from pm_runtime_get_sync() during the PM state transition.
> 
> This enables GENI I2C transfers to complete successfully during the
> resume_noirq phase and allows dependent devices to finish their resume
> sequence.
> 
> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
> v5->v6 :
> - Modified commit log to start with problem description as suggested by Bjorn.
> - Moved to new implementation of the logic while earlier replied to comments on
>    older design and considers latest fix added recently.
> - Made change generic to I2C including GPI mode transfer, this was not done earlier.
> - Changed email address to oss.qualcomm.com domain.
> Link to V5: https://lore.kernel.org/lkml/20241227130236.755794-1-quic_msavaliy@quicinc.com/
> 
> ---
> v4->v5:
> - Commit log enhanced considering Bjorn's comments by explaining PCIe usecase.
> - Enhanced comment with reason when using pm_runtime_force_resume().
> - Corrected IS_ENABLED(CONFIG_PM) condition inside geni_i2c_xfer().
> - Improved debug log as per Bjorn's suggestions during suspend, resume.
> - Reverted back comment before devm_request_irq().
> Link to V4: https://lore.kernel.org/lkml/bd699719-4958-445a-a685-4b5f6a8ad81f@quicinc.com/
> 
> ---
> v3->v4 :
>   - Enhanced commit log by explaining client usecase scenario during early resume.
>   - Covered 'usage_count' of 'struct dev_pm_info' under CONFIG_PM to compile non PM CONFIG.
> Link to V3: https://lore.kernel.org/all/20241119143031.3331753-1-quic_msavaliy@quicinc.com/T/
> 
> ---
> v2 -> v3:
>   - Updated exact usecase and scenario in the commit log description.
>   - Removed bulleted points from technical description, added details in free flow.
>   - Used pm_runtime_force_resume/suspend() instead customized local implementation.
>   - Added debug log after pm_runtime_force_suspend().
> Link to V2: https://lore.kernel.org/lkml/202410132233.P25W2vKq-lkp@intel.com/T/
> 
> ---
> v1 -> v2:
>   - Changed gi2c->se.dev to dev during dev_dbg() calls.
>   - Addressed review comments from Andi and Bjorn.
>   - Returned 0 instead garbage inside geni_i2c_force_resume().
>   - Added comments explaining forced resume transfer when runtime PM
>     remains disabled.
> Link to V1: https://patches.linaro.org/project/linux-i2c/patch/20240328123743.1713696-1-quic_msavaliy@quicinc.com/
> ---
> ---
>   drivers/dma/qcom/gpi.c             |  3 ++-
>   drivers/i2c/busses/i2c-qcom-geni.c | 12 +++++++++++-
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index c9a6f610ffd9..332f3aa40628 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -615,7 +615,8 @@ static int gpi_config_interrupts(struct gpii *gpii, enum gpii_irq_settings setti
>   
>   	if (!gpii->configured_irq) {
>   		ret = devm_request_irq(gpii->gpi_dev->dev, gpii->irq,
> -				       gpi_handle_irq, IRQF_TRIGGER_HIGH,
> +				       gpi_handle_irq,
> +				       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
>   				       "gpi-dma", gpii);
>   		if (ret < 0) {
>   			dev_err(gpii->gpi_dev->dev, "error request irq:%d ret:%d\n",
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index d2f5055b0b10..d56b36bd1d26 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -913,6 +913,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>   	gi2c->err = 0;
>   	reinit_completion(&gi2c->done);
>   	ret = pm_runtime_get_sync(gi2c->se.dev);
> +	if (ret == -EACCES) {
> +		dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
> +		ret = 0;
> +	}
>   	if (ret < 0) {
>   		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
>   		pm_runtime_put_noidle(gi2c->se.dev);
> @@ -1045,7 +1049,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, gi2c);
>   
>   	/* Keep interrupts disabled initially to allow for low-power modes */
> -	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
> +	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq,
> +			       IRQF_NO_AUTOEN | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
>   			       dev_name(dev), gi2c);
>   	if (ret)
>   		return dev_err_probe(dev, ret,
> @@ -1257,7 +1262,12 @@ static int __maybe_unused geni_i2c_resume_noirq(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> +	/* Enforced disable_depth = 0 to actually enable runtime PM during noirq phase */
> +	if (!pm_runtime_enabled(dev))
> +		pm_runtime_enable(dev);
> +
>   	i2c_mark_adapter_resumed(&gi2c->adap);
> +
>   	return 0;
>   }
>   

Acked-by: Aniket Randive <aniketrandive@oss.qualcomm.com>

