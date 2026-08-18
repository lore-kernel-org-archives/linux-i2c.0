Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDC466B63
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053300; cv=none; b=IfLkmhTzm9IIm8Ga3MIM8ZAUQ9bygEud5YB1qPiF3ejPWWYU1HEKZWoweqwJ6MmTnPT2wjc38tSxSFsXy2WKf0i6KcVCKy1G0iSHS4bOuE21gxhGG1DzP7bu5Mq82wPUl5urxDCskwSV6smEkxiw9SZsIxxnrYoaoO7gtBSrORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053300; c=relaxed/simple;
	bh=RvSxX6oZmGjbe6YiEyqFFCX3HSBjb2y7CH1DHWUF4JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbKagbEjWKpkMkeEDFwgqcwruBIwWbR/v9dsyFoaffjoxUWWNeB5r2KFW5Gs3fE/52+1OuMpy706TaLiBx+Elx8a+IsmrZ2vfA21TT0baCKd4CRQVCfxWZ5wcIOd9rdbpXEABN0MbeH7TfuUg96tATxJuYG4vz6nhQho464UL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxzsYLiR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRxyIfMo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxzsYLiR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRxyIfMo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABnEo1336559
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SO7C2httQArhnA51QW3MHKUNt1SVTvkobwzu19rnX1M=; b=DxzsYLiR8+xHE/+y
	NOWyZLo2omRYNX7il+FNbDRuohPl2DsdHqWmDktrN7C0OkQ4dhXQ9QU5caRmER5s
	QjtAYl6Wqbdw1mAu/Yfb856z7r0mz83vRDvmcvBKOI+pJ6uzDMeoeFFmdSCCyTLq
	55ZZgT6qO7dX8CVJPEdDAv1UZMRHHOBdzmTCXleMzld8oJo/G2wu/ZnaX/FBGzWC
	eQW5lY4ZG30V6B2VU74cPozX2K7MOvXpYIPAJAx0IqbWPgzzVcbmp44rHWG0TGz4
	L+n8w+o0ekgugvcLzTz1PDsMPFGRDF68v58kf/zxwdvwXhtdAyUvK4Gfv+Nl+7mJ
	zGd3Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp1uc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:41:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e661ce1dcso101158085a.0
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787053297; x=1787658097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SO7C2httQArhnA51QW3MHKUNt1SVTvkobwzu19rnX1M=;
        b=NRxyIfMoGBkCtnwZpsZb8IGBCfVDwFvnUUIQLIqGi9tylk8KR0f1ZGY3kcNKhDQgYY
         Lq9B3yWL68PM7F47yyz8AYmn9SwPmT0Ozk46gFHHFRv/PNVCHdCjD7cW5uGtdnZMnuyC
         yGH3kU+cbpxj/Ftsgy3JKk/48+DwylagR6nUr8VYuolvvH0LMdZ5Nz7lwsTk47kDufcG
         N2JIlg73igD3NrvnBYiLu2hqZkvQ1XvdmZ6JTaXpnUAIHwM0ovW4Bt9913GMLBOqWAoA
         DLVMtey47cgDS8wJ6ajqkzu8VHCbE7Nsi7S5xSN4dlXiH9M9+UtfEakra+PrFVFTyZqh
         2jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053297; x=1787658097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SO7C2httQArhnA51QW3MHKUNt1SVTvkobwzu19rnX1M=;
        b=cFq3IFQ4PMTrH1Ddy9zV65QTFpyAhkEDSp4/wd6GuBV6Sur7B3e/BcqQtttA8ZhMON
         kL4OboPGissCNPHwbSK3ExosXVcuQT8oMTaFq+vpjayxhku0BRNhs+Or8iMjE5XldarI
         KZFeaJmuhXh+TYUA1muDUBoLp9IBjn84rLrBG8Oc2cpim23Jv3q+/OjDEkMAdPSM6VNC
         UMV/R+7hcWQTPyV/vWYRiITI6q4ZRvGYeHCHe8pid2/CvW4a75epSAbCN2lC4jmCmUGe
         AE8Hrm32C0NaCtmJLrSGM3cWLlIpgYeuKdzvksNUlSSbvSkLa+SxyN5rVjrurCGUYsXR
         rGpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd/dz/YKj4zeVK6FwFHLgKrTRfVcLAjynTlk7zGSADVcbHv7KRb2bnzwMdPXQ+JtTazefy8f9JKPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJ/T6r38sHbx4hMTxyyDj4GpSNZkU1zTp0e4oAueZQxjNF9B+
	+vM/dCPAuzf6MYhiglVhESN4DlKCmSo6zICZY/I6IT4c8KS9XlG9eyAYWawPpWPpCNWq4vlkNjs
	Ga/Lb4uffPAX1VnUMHWf12c5BsJgUjM2QDB6PUuTSiu9Khut2qWAsnTccyhRNZ70=
X-Gm-Gg: AR+sD119vKsnt3rv3bho51wrFrSagOqJe/nWVUL+lqKuSCx+kUEkG2MRu17qLC/VifX
	62pvdE1reA6pPUsKC6QtY/3vTPlxr/ncrV1ChQz91W7Zwe8/d03iJwc9d3yOw3yUYTGc4YWQ/8u
	PMBAOwiHaM2UBczptqCbjGn32IL18B9deO/mDkEXeZt4F+TH1htSu9a/T0CDznxhyhFlXKvOya8
	4nfgm+BuKJNVyHy0es5JBKAY9ni2UpvrZy5Fr5PE6HpOkSoxoh1gEa7sGv7A+dK8wQygmn8pt2P
	t8a8wupD5itsuZJo69ag/Omq3E3eqs+PqOS9AmffgzX5n+otIn0LqyQGKzy1EEq3fcotR4T1vDk
	GW2d1Pxgxnuvgh0Vz+WgNLL25
X-Received: by 2002:a05:620a:4505:b0:92e:601b:8d43 with SMTP id af79cd13be357-936d22734femr2373145085a.1.1787053297388;
        Tue, 18 Aug 2026 04:41:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:92e:601b:8d43 with SMTP id af79cd13be357-936d22734femr2373142085a.1.1787053296955;
        Tue, 18 Aug 2026 04:41:36 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8530d3bsm1811320a12.10.2026.08.18.04.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:41:35 -0700 (PDT)
Message-ID: <15b13316-a9b5-4577-9be1-98f4de17951d@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Liu Zhenlong <dragonliu2018@gmail.com>, loic.poulain@oss.qualcomm.com,
        rfoss@kernel.org, andi.shyti@kernel.org
Cc: vladimir.zapolskiy@linaro.org, wsa@kernel.org, andersson@kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260815140931.53297-1-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xkIchZmwRDeZ3DWYrTeU1MqCW1mIoXVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX5eCnpxXXEf2j
 Oqnwgd0OmhIDKZB/kn25V2+fFryDe8MJw1JV+N/kTxPJqGpKC/9Dr4T91Ql2mur/aeau6cVhix4
 ZJGT7TYnntrGsLqzbNK0kAAvSOl7vJgg0AuWSJZ0+ueIVFzBOqY/Ahqn1Km5Eg45O6MydHrtge9
 KPLAE1Yrf0XTSz/xKL+947P8i1CQCcB7tSpOobl2kYtXkbhHsBk3zWuKSDtCTxtmqCKZHjZr3PK
 +Fx1FMpPiGMlRerkarzv+i2MDm+Rist8xBBzGgSryoEwTptWon9gb60LKiVbVQzMlXNt40fMjQA
 uhJFbxd+V1Nt/FgZOCxvtOukEP7f+svq6zr2LzlMRUFiAsPXRwxtiY52LcyiCT7PabFsWTbGTJP
 9fpJGl+VfDe3X+oFKQDRn1GIXxoOSGWqsSNrchQmXURUOe+efLyu8CfMoxah63PYSlk0lTCJwT2
 fQdu/PBV0RPw0dxLpTg==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a8444f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=S-fymDIK2t4towvNsLcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX2TQcRqR+qgvH
 cp4FD7e/fM5suJrCQfgqzT+wi59Hbt+cN/UA81KxrRyy+0PqZRSs1QjNRiVQJBwzL1ag7WAP1AP
 v4weeECYP+yWphfIG9D4oDensuisf+A=
X-Proofpoint-GUID: xkIchZmwRDeZ3DWYrTeU1MqCW1mIoXVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180085

On 8/15/26 4:09 PM, Liu Zhenlong wrote:
> cci_probe() calls of_node_get() to take an extra reference on the
> child device_node when assigning it to the adapter device.  The
> matching of_node_put() calls exist in both the error cleanup path
> and cci_remove(), but they are placed after i2c_del_adapter().
> 
> i2c_del_adapter() clears adap->dev with memset() at the end (commit
> bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter removal")), which
> zeroes adap->dev.of_node before of_node_put() runs, turning it into a
> no-op.  The reference taken by of_node_get() is never released, leaking
> the device_node on every cleanup of already-registered adapters and
> every adapter removal.
> 
> The commit that added of_node_get() and the matching of_node_put()
> calls placed the puts after i2c_del_adapter(), so the bug has been
> present since the fix was introduced.
> 
> Cache the pointer before calling i2c_del_adapter(), the same approach
> used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
> ("mtd: core: Fix refcount error in del_mtd_device()")).
> 
> The of_node_put() in the i2c_add_adapter() failure path (before any
> i2c_del_adapter() runs) is correct and left unchanged.
> 
> Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index bdeda3979c48..61c535b8196f 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -618,8 +618,10 @@ static int cci_probe(struct platform_device *pdev)
>  
>  	for (--i ; i >= 0; i--) {
>  		if (cci->master[i].cci) {
> +			struct device_node *node = cci->master[i].adap.dev.of_node;
> +
>  			i2c_del_adapter(&cci->master[i].adap);
> -			of_node_put(cci->master[i].adap.dev.of_node);
> +			of_node_put(node);

The fix seems correct, but the way it's done is still fragile - someone/a bot
will surely come around in a couple weeks with a ""simplification"" undoing
your change. Would a devm action here be a better choice?

Konrad
