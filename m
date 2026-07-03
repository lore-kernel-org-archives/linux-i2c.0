Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740AF32B102
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054311; cv=none; b=V6jL+ZyQw8MVgeUX5Na8gSqWU5BluKB5gVrV0jgMV8uqqzOo74CCkGAPuGnnzAy3FjvhSDgU9KCunbufDZISWbI5+DqZpdKe0FD+EZVRzVx/KVZxfA0u8Q6F9YrbYzsTwAVlTePBKR+BLR3vsuV+For1nURqdTU93S7aNb2bpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054311; c=relaxed/simple;
	bh=i9VfKxB6W7SE7/7UGu3+PX6t1sBCwGxQEschIHYCu4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA94BHRnhakkn9gB2wPgrggcRwNvjNBZtaCiaEHZwuc3aOChmJ8kSif3qYgbKMIstGjvbQX6y+ctZSW8HVPeC/CE4isCq4NDiUolwg1KFEKZMJWc/DL3Gnsyv31eLaNVuP5eDfnTDtelx0ICqlYJXpGySp2aRoT0vGaly8J7znE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l5Qi/bD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZHqLuhC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l5Qi/bD3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZHqLuhC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342VTM2705723
	for <linux-i2c@vger.kernel.org>; Fri, 3 Jul 2026 04:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4woTUuvmZDdwYb7vOc5MfIv0PJgvjUEe4j7hT1Oxb3Y=; b=l5Qi/bD3YIBVa2qu
	/fFhGumHdYQDXQpqtgn/JvqqXNF4wKC3zREQ/65b73aEt3OVmxI/vmYR5YJFaJK4
	JTrZADpaN3GS7IExw0Ep5NiO1Q5WSeRrNjFnTuF74gGplIheVDvO4NlOE/v9MjST
	yZLRdankHJHc0fF+o4yxYs/4DVyG6/sNauqJFraW7I17ZDNctzYhJLu2asjHRNPv
	PsNums7Bm9nvXS6UW+b6NQ66zmBsT6uB1shIl8c2BXQrLKJWUvbzh2VEjYfsTH3A
	griXvcjTiRyuaFHBjcDkKRYnzksNyXIUChCM+w4IkdHuPPj7CYbZ0Vh9542YvVHe
	ILjM8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9447bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:51:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c80f89b64bso2902345ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 02 Jul 2026 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783054302; x=1783659102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4woTUuvmZDdwYb7vOc5MfIv0PJgvjUEe4j7hT1Oxb3Y=;
        b=UZHqLuhCrEu6uv8IOlZOtfhnde0fQ5khuCEv8br692kVla7u1lu2Zh1Vj62c8Alkh6
         +Jj5mIox35re3b1igUBwhev/hAQLwYWvY57Kv0ClDCz6ktbALTgdbLGy4VAedDUQtOD3
         81Hg6GglmveoqjeQYNMHTcnlAcF4jaOeuPOZnJH6qK5WbzaG50P6O+rfVoNOTi4Z4g0+
         B6CPic5a3JrDcto3tT2PzXXmsrRBJpMSdwuGvM7ZDAz0gRc3mnOFphBhakgx3Kp851NY
         9o2zchH35PgCgk7wQixhI+y+o55vLEyCbqj26dF2cNjLkPI1/WhyoGWr3OScy5s3f5Of
         xBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054302; x=1783659102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4woTUuvmZDdwYb7vOc5MfIv0PJgvjUEe4j7hT1Oxb3Y=;
        b=GV16DlGm7OaLzAndN6PEJZZfnU07WMLnWPvh/PWvGa/R2HdyGsOdCFFesuAYfdzH1v
         Z1Clg8Zu28wD8gzj6rpFf1tFZVAutA/vEVP41tQczWVoxXgOLEUjIEgl2lbNKCteUHWb
         FcJ2xQIEeu1PXzS8PO1lpyVzu55t5C57XMZgyv4tBdnFChaON8LIj9MRUWixcT8jc7DV
         ZdChLycF9iRdDTsKSfR741h7m5M77FCLIkPmgJsW2fTAGfOTY8/mLLHaPo7Ar5rUAzhB
         s48T9U6lWYc50T3HqztrVfN05J3gv7yx7m2TyMRjJWBzg1VqXo8NftD74nH6vt/07rs/
         2pMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVC9p12iNmo5RiXivjh6/kBmS9cF0NmOr7SRGt0BGoLwJMzSgLbYmlIuN4BBChBYVpXmysES5GneI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAupIWg+tZFOgFTgBnKOpr8wQngbX+BGr8NnPKbSj7mlWqNXeH
	5P2VweyLF8z3hjPXtCpJKvdlnO/beC4Gv+NtnUVdNixwBNph3IzVzTywuqFFd4ObFZvsfMUFEWZ
	wue3jj4qAtCxUCm5hxva0gIrM4nwb+v2vxru/armFaKQy9w4HVPd7XAH1zcmz71s=
X-Gm-Gg: AfdE7cl3PZdU0WwR+OK3TyO/S9Q3AEpnM8ogC6QCdB2HYjTDkMMGQpGdfjl2N/Swn4+
	R6kWB2pM5KicIBhvJfq7C5QcLlhzLXqk2fIXzAZICk/6nuP4yCSSuIDJp/RvcxeML1fADdhhMoD
	3BdhGxiaDXOtQVK7CmSkSemrkleBL+VmsaMRiaelFEjTDc6kAXaqib9z+E/+ioy3cqCDMieDy88
	HS2YfC7wPu6jXLbceJrK/FCPa8whYvawktNMeEYOsZY+lf94QhQ1SZipfyl7vOa96R1JJBsFVWm
	35gAm5IvFxf2S33uYoaG5a1uCVF0lsJFVdwQyWr7WwNnvnCWxi5++zk+NtMRahis83v+fTQXgfS
	WiTG96Oe+JWjUEwb9KAYdM27SV8oIVF5UOlDgD5cWGOnL
X-Received: by 2002:a17:902:db12:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2ca7e67eda5mr96601245ad.2.1783054301958;
        Thu, 02 Jul 2026 21:51:41 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2ca7e67eda5mr96600935ad.2.1783054301351;
        Thu, 02 Jul 2026 21:51:41 -0700 (PDT)
Received: from [10.217.218.209] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa33asm16106814c88.5.2026.07.02.21.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 21:51:40 -0700 (PDT)
Message-ID: <3777cef8-c90a-4c7a-9b71-c563e8d56f2e@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:21:35 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0MiBTYWx0ZWRfX1OUGVbnxoATE
 EPUBNELWYJHQbfYGAVw9XovdjkVG8oe4X4f1kWKKdDECLu8PIiDDdzubnGbGypaNwqlNN6BkPd5
 MTWf+8qL4rDJ6DEKzH0Q2eAXf47bxSl5Zs0Rb7NWivi1DGLYS7sqXp+qblcP+hk1kJM5y+EjPTj
 KNicMImnBlIs6V+l9nJtv9Kpywd9QQzb8+tuV7hTJExnrGlDWALgbF1fwJHU0286R7jikX0eTMa
 B6bu0FphVx20vR0i4lgww+RoAb3T6rbeAfkug0AeJnGn8+msc0sGeH7CKqR2WaaofXZ9CzxMRxJ
 OUl1hqJ0CtymVsXCK0f5h6+YnfixTk9Ir+axX2HP+8l1jekgYLlwdUFVDRVa95U40uIce0hqCHw
 K2SQPMHbiosKpPj98HEbsg2/pFZxyMbyGjxa5BoTYXD682Go8Wd6TLXUBEE7RIpcwWL+BkKPsVm
 rurT/5QJHPyMwvvo5/Q==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a473fde cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=5gi8XA0zxOeqIYz4FXMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: W5sTqRrbykjuRwZKddK2slRblhkbgDrV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0MiBTYWx0ZWRfXxznH5OY9D5oK
 6TueoTPbZFiv45Mz0KJ7qgiO78SoerRdHNResjjgBxF2pKE7HvrdgElfeIk2PQLMp6EjVeLKs3n
 Lel1rR++1SR9gynRVyw9kTqVRHp2GDs=
X-Proofpoint-GUID: W5sTqRrbykjuRwZKddK2slRblhkbgDrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030042



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

Why we are checking specific error code here? Why can't we use the below 
error check directly?
if get sync itself is failed with pm runtime disabled then why we are 
going ahead by making ret = 0 here? How you will make sure resources are 
enabled?

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

Here we are enabling the pm runtime so where we are disabling it?

> +
>   	i2c_mark_adapter_resumed(&gi2c->adap);
> +
>   	return 0;
>   }
>   

