Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706459;
	b=KBNhy5QOg1444u5XEzF5fWAoxEwLOCHwC9DlMh79CE9dPMzT1jubucvascmgDCOU8Iul
	 tqK63aVgeojcZFaifwF89MHrRNRRj02UgJAxWebXLxoUo3EehFZtcbVtTa5c1UQaJdU/b
	 1au0q6khpP2Mtpq8N8I0RXP94HkQopGBk2s2Rs5mcqj+b/2P44lleyu17/VGHKp/AmvqZ
	 oWfwvQD5zFM1meyVOCBnSI4MPX/B8dAVNJNjqHt+kcjRNpQ2gZVO4xKLpmjclMa3+E+/g
	 RYploc7/Y6bZal3jFWAN8E8HFSSG6AgY/4z6PO3nvzgPoKypjAx4Jk7Ik0mshKL6lRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=La9ks4GtW0VZMxi2UuVB9fk1/wyf2ZEPSoiB/vRT8qQ=;
	b=UoGdIX5A6hnB4VRW33i+R9MXEOe9viUv9X6wSmXCQoJ7aC7sbIs84RAO6HMK5Ehknk8g
	 fEbKulST5mxOn6UAyO64vnwR2wiY97sUipL2/1HQsb5jvOY7pA4ohNiEY8FxG7dVykqmy
	 8V4UAXGjDYF4CQAqLoHwoS5mJ2WhU6WUHQt1+1g1p69W5sEWfwmTINULDyW3/4wY27CcU
	 mUqPfA8ynpCqFKWfU5Snzg+nNOKKO0+yvavvBZtThKXA2tf+dyq4czBNZl2FY5r2IV1cd
	 RNoBgYt/pTLnS17Q1HwZvEKm9RE47kxDLtOHQAisTVsokE3hCnIKRrhz+6OL60RZHfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEcT6s7N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z++lb+vz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5B606A32D
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 11:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C5B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEcT6s7N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z++lb+vz
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AA25G3577814
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 11:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	La9ks4GtW0VZMxi2UuVB9fk1/wyf2ZEPSoiB/vRT8qQ=; b=lEcT6s7NS/n9mC6S
	t5+EyoVw2iBm0mUVcFCfmLLzrLG3TSjf6LvKRb6miyQzMUXQMcWXkiJEk7BhSJAB
	QyN3vLhMuwrxjZn0VP2sIJxIRxKpIRTwUy+uay1/OqcalUe7doJuJxlvrTRzvj/3
	5oPNQRiGPnGV1f4iUb+BEUb/6CSvm6XtP7ky0fumzVqEBLwggf3yppRFxHxdHJJb
	w/IEhssBXLus2WFZiTB+7DtWQFCqIteGrOc/ZIkzJhV9cIKDzO/ZZ2uWxZuJ26st
	95NtxqiO8EBpM+2bFoyhIP9UeiCq3mg9m1/rApddhFz3aBGjHHQRq06vZtS6jVWx
	en+5vg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76d9xt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 11:47:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so6806328eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793706457; x=1794311257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La9ks4GtW0VZMxi2UuVB9fk1/wyf2ZEPSoiB/vRT8qQ=;
        b=Z++lb+vzo/TT+/Ugd+doJDxO14lcMbXfTqksucPEZ8rec9SDflYTk1blTZa1n22Us7
         dA6HF6MKP6o33WLH83GyADaAqkUZM58mMZUen+2UpTSPs05XGTclDqSSH2vuRoy/WQsa
         7SSk+rLKVOusXsujNiB3Y9K3inC1xuLJL9LP7WAO0nTpHaQ7rKZHncHUWjZVcbabYa48
         67kQicJFiY07hrhc2JAN65neccJHWwieIh0LMD8bp6Hd24BbiFTf4kEueN5nShRX75v3
         fwB92QD+E+6eTlwxBGHlW+cEEk8YuxZUAp3fLTlL6ru9IvqQOUrPZK8GXZz4lgslAh5f
         SKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706457; x=1794311257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=La9ks4GtW0VZMxi2UuVB9fk1/wyf2ZEPSoiB/vRT8qQ=;
        b=CFfAy1Pb+7pemy+hM4oiSrevd36fLFPnukIDCKQ3AJoZt89gSiluE0O/NAe9k1gauj
         FYrhx2D5RSupa2/MevJHojX7FG08V7efZBnfBSWAtPRaCt0dWeOp4wCCcTqMkoTrZhUP
         +PWrZd0ERiQZxwwkVl6YOWDwBNaBnKHueTH+QxO4jQZ+ncCsiVhw8Oa9AqhBNcOwDVG3
         aMdf6gnLvR6CayMBNJjazoTeX/4it3HqjGA8XnH9BO+ynnGGfg5Jyhn9tjOvBNKYRRfu
         VmRP9ALp1qZUSNW7sr/kMtZfn74kEnKZbElfPZnG1eXuN/ukFSxFIlCXwgnTmdDhLxRL
         fPCQ==
X-Forwarded-Encrypted: i=1; AKwUvByg7QbQCnxIYM7WKKhPiQ/HqWw9I2XvcBJEwOr5unvl6yU2KgHg3PplhzBDJUrsy4t+ATsk33jEiLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XPioEaRjreF9Nbqen1dbuv8MLm+wejomPv89Uy8f9adfHo5dd
	QETwQtPsqUqGk1ClO0UmGzKFIK21ZUrYLA1U6N4Qjocbd9/qChtNI6OcMaMlebRVrnGXPiC/qUI
	0tGgcJGQiTKsozH5mDOloL1yko/gR0PGwlqe/CMNoQVWLvYl60FNOdT0+InnDrxU=
X-Gm-Gg: AYBFou0liYUPTJ5npjl42ETYJgPXfiUfaoq+Lm1sS6jjJPq8CkI+Q7mEqPm0vQGoG+T
	ePRdu5CFNUvxHVrd1DEpXutDTQolBCzSzvOu8KWl1VLNOT98+WaDyWwUgjLtnzfIzXZRdibUfHH
	oHW6LzLwqOnU49VPWjpz79nZL2ZUoOlk58G4SAz+9iylG1HumkrNfrduTWTv9rfGF9VbK0O2Q9G
	Wgj2IZ37N036HzeWjHyjQhad1JUQISEwH82E0O85DkfAFSCXmu8kW/Ohm76knvpJKN62t7zVLK1
	awpObvCdc66kHr7HiQ3WjEUIf+4Q86WMk6qnbptP+LfWaFro3u1Qv0v7gdsOwUv5e/9M5/h2VZ4
	TqC/c2dfihiDT1fW2cUoElGDfZx4giKnMmBU3aZwK8wBxq4rgmxdKaUf1T5PsdtpB6/qxCFjyP/
	HZnhreig==
X-Received: by 2002:a05:693c:41c8:10b0:367:185e:867a with SMTP id 5a478bee46e88-36a4242366fmr19630980eec.38.1793706456493;
        Tue, 03 Nov 2026 03:47:36 -0800 (PST)
X-Received: by 2002:a05:693c:41c8:10b0:367:185e:867a with SMTP id 5a478bee46e88-36a4242366fmr19630950eec.38.1793706455973;
        Tue, 03 Nov 2026 03:47:35 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm52840006eec.11.2026.11.03.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:47:35 -0800 (PST)
Message-ID: <bf8d0564-8ce4-452c-b211-94ac37f39209@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:17:28 +0530
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
Subject: Re: [PATCH v4 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9c9d9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ljc_7vWThQ_RCqSD0EwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX8R3ptqRVPOkm
 yUqmnYZLj+WjpgyA/4R4ezROXsrrvu+s8/ngEOJOrQRpjVsAYpxOgDMV4+kylI28pVWGfdFzO94
 h1tepFi1eAP/s4y6uMqTfwskDtiRNN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfXxPzvMbzXmSlK
 B9bSWp5j1MDAE9RsTuEFbVMo/Hku+U62aif8QOoxW1JtP3GKhS08/+YNRTDwLXYIKkL1SzkZ99z
 dpAFXx25tJLfxTJ5GFuJt3Z0XkH8RuAbztry76uZVIZLzV4MbzQebo5tjKgVKbA91gmn2FXH2k3
 VlOsPKE5zA1jeEY9zVudkQrwzOFH0gwy2Gsl9EPPtuNYdusebgXEoY1QwOtqlpOfPsy+UAvHqIX
 EIEeCdPc/XWNdnxJclV+0jrEoPH7meX1MkVodjjvJ0vbssHeFjdYLRm9A8X/p30mL2bDS0WomxE
 eQE7VhVLq8fESGjjwLGkbrw7NDc7TnrA94xRLvLdzOcXaXex3gzd91ore849jeHf5WJ2GlRf+H4
 hXKWupqRHoDy9X3R6sXb/DIk9DyGznzLDqSac4lJRWWV1bcV5dbSpY40FjS10G97MYgmeG15tnI
 RrUd8sHeOF5nBdODTTg==
X-Proofpoint-GUID: wc6YtXcs_kbCs_ggZNg0FaHd0RyzZdz6
X-Proofpoint-ORIG-GUID: wc6YtXcs_kbCs_ggZNg0FaHd0RyzZdz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030046



On 11/3/2026 2:26 PM, Aniket Randive wrote:
> I2C transfers in GPI DMA mode can fail with -EIO when a target holds
> SDA low, leaving the bus stuck and preventing subsequent transactions.
> The GPI completion callback reports a NACK and a genuine bus error
> alike as -EIO, and the existing recovery path switches the SE to FIFO
> mode which is not valid in GPI DMA mode.
> 
> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
> opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
> trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
> SDA and SCL are already released. Extend the recovery callback to dispatch
> through the GPI DMA path when gi2c->gpi_mode is set.
> 
> Use the adapter timeout for GPI recovery commands, and preserve the DMA
> configuration error code when GPI setup fails.
> 
> Stop recovery on a GPI command timeout and report DMA termination
> failures. Do not issue another command or override the timeout with a
> bus-idle result, since DMA cleanup may not have completed successfully.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
