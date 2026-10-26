Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040955;
	b=B+wV730/kZkwJsM0r9Ed+4GcWKtRCkWv/IoJXTfiNchwXQwJ/Rjtf39eKzE48o6jO5gR
	 tP0F282ctKbMxZMBlI1411yHAiEXOuNaYTZ/Idr7fd54XDLQATfPeQC0SgbiuUsgFQ3f1
	 UcWf7rFKPRu4xoUrw1oynLFW5UB8+BOSoh/MVezmb5nmiyr54pmtwCxjfqNys9wDTBLaz
	 YbJuVhbkzOJKEddxWxHkxX9fbYRd3DRQzCjZ7FtW3CTI/k70HlycfVH3V13QMFvYA9Img
	 32ikyb/jQk3ntyPTOzH/kIlxDWdJvBZepLOMkdnfD51MMsMpqlqrwv1Jhp9RqD7i4Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xEsMpsQ55jhFoaZnvSydqUSOdqSiWLsTJYnvaYwHwnI=;
	b=IzklCMrHBmNJIRWD90nigA9ise3PHT7u1lsCj4BMJc46a4Xdk6g8OEFEIZCWB6ibk29H
	 c5xAlwU4jQgjarAHzdMLs96tjhcEObaTYwyR6pjFKQBYvNrGp6+54rcMff5KkUnaXybYm
	 nfEGcUWhwJHfM5hZwf/8lDbQe8WwMg3LblkGMlB6sP/qJKi0L7m5d/+pddI+fycXx7yuu
	 7PPvuzRnL0dUVHcGl7Vrz3dCzo9M/kTGTc5699qr83ANUoR1bRRcgZrjmGB0o1YQnuGMu
	 /e76jb49Rs4Z+F7MKriS48H8oXvAi60az4mp72XUYqQvSuIf+ga/+ufR5x0mizAjgng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g8CcWGjO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gppPlZ5C;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5C606A31E
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC5C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g8CcWGjO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gppPlZ5C
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QIp6Lt3586845
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xEsMpsQ55jhFoaZnvSydqUSOdqSiWLsTJYnvaYwHwnI=; b=g8CcWGjOODJf0ZcM
	rWkRfR8bRcCQ87JhB8IasVUfx/x7ASY+14OCCcYts0SlZ4cwSV67RCV8ify1x8fP
	69D2U/ApSx52D7eAETPaKBo+7mJNyWbyp8ubAnAok7RNOKoUKzyfp/z/hfj6yRgg
	UsfArqARmzljpTmnNvoQQ6V2WKGovw2H4bbGavm+CLr6GFQDTr5wC5qpVC3cdaDG
	YFd4lZRXJzu7YX5VALBTVPYGLcVO8l/tRSrdayKE0+/B6f9pCMLMygyFMN+7ur1H
	M+BLRguXQrcLi5/tOVNSkYoJR472vf/n7C8QQqehf4+HkIJchzQ9MaoHKTkStHgV
	cuimwg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm88d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 18:55:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so9477835eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793040953; x=1793645753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEsMpsQ55jhFoaZnvSydqUSOdqSiWLsTJYnvaYwHwnI=;
        b=gppPlZ5CtlJAmB3Aex2hWqbpd0eZHpNin2NXBW9FMwXs57fsHRR2btBBVfZpugUu/D
         UoGMvBRWJekNBh2KDDU//KhAElG/HkaQHdjwlu5oxJ8vnZSB/5o2VsdgH6rtTqXC55/0
         uXN3lGXtTB8rnu3W4xnF+Vxtd/DtTaWWMbFTdfyULpbjabE4pM3tJ+lMN+OPUqWBYhRO
         zeUnRavRH4PetasOHT2tx8SynDuCZnWsDebHJ0oyY7ShkoBFtiHTPFh+5I09Sr0fgILu
         NN40bH5yirb/EAkJIUiosTHjxXsSjmMuT7Xzj7FD8g+IQ1AqCfh7vdNRije4ySbVn+D3
         gq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040953; x=1793645753;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEsMpsQ55jhFoaZnvSydqUSOdqSiWLsTJYnvaYwHwnI=;
        b=Qe5E74NSAnypALd2j8+aNOV4aQzplSO9n8ABIWfW7D34sug68sQBt/VLhPrj40mR7Q
         e3YzTRo5+fCZvZL92qZ/lQRdohCcvlA9KKANFffJWAeeUs60ZtKIB9yl6ZRNYXLW6nC8
         C/t4fszWFAxuoq/D4DD179vIAUWRFqOrsU5434poVkSC5PKZxPDCRHw25nFPKZHcZ0Vh
         dRApKRvhYPHrc1bj8WhlHs7221LeCbYl85e/oALUrTTtuNtdJmiUaB1GE7+GSXmTXRzr
         2jlw00dKoxky77gvxBK9LBJBVVZEFBRzP/H0rDFhrARqEGEFJ9fJJgSeipr07a5j7lmR
         x4FQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYafcVrxvU3fBpTzvKG+9dg2uNkeHakAA78ed4heH+pN9StAcUUuO1rhbE9igGjxBbDzrzeJS4+70=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNx4i6wWgxQPeomXTValJiqp0Glgsj/7g13QFbVYC9pmyw+u3v
	1h1187d/MdwtYMDcDn2V4O98dvjraLAocfU4cYcploy2w6Kv2WoATSnw1ANEywwfaq94/oeL99f
	P+GuX+LJ9JhdidywEVVilbVVaRLb0jAMxgRMKEuHTscDt5C1NqvsJmJ+FoUFXoltQOqMrK1c=
X-Gm-Gg: AYBFou0FmRpMN5wu/CU4T4CUCtOdAYLOGAbjxYKHupIvj3xa7ROvgU4ctlwA1euDUOV
	K9EuxlB6JS6n9BkNZUxIA8+2x2+aVyy5ArBXFbCwq0jgGHtxCDTnc+Z9fB4YFXtQmzxqBn4jqkl
	5+OSBxfzNSq74dwTp4ZDmEK51H6JxaFAtK2paykLBxQ1MQLpXOyrfxEGxtcgU60mKJa5LUSMRpN
	4bbB/1xZeGOJsPzWNfafqCIJL1OIxZL5aYCYRE3DoPNPPkAgmqcogUXoFliLTJ1JWPveythy/S0
	fE6sR2p85qvuasFCo8T+zQ3oZdZjvr+XVh94OwpygLeWuTFu4GE1GN3IN26o0wTLo0+r0eUweaa
	Qq/J4gHWRs+fTsfttyA5sdiIQpLcTNVBIyA==
X-Received: by 2002:a05:693c:2517:b0:36a:1104:5fb5 with SMTP id 5a478bee46e88-36a110467acmr156823eec.1.1793040952985;
        Mon, 26 Oct 2026 11:55:52 -0700 (PDT)
X-Received: by 2002:a05:693c:2517:b0:36a:1104:5fb5 with SMTP id 5a478bee46e88-36a110467acmr156797eec.1.1793040952484;
        Mon, 26 Oct 2026 11:55:52 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.233.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm25032317eec.21.2026.10.26.11.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:55:50 -0700 (PDT)
Message-ID: <ee64a2df-db9b-4768-965a-bb95af55a6f7@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 00:25:43 +0530
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
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Add panic notifier to prevent
 transfers during panic
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-2-9f31b5fae5f6@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-2-9f31b5fae5f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3NSBTYWx0ZWRfX/yZK+j62if5j
 TpLHEq/JCEEDzXdZxdMAvrfRQ2E+/1gZRN34Mp7lcMaRZSX+yK3x2r+VNgn79HDb1UJMMPZ6YPK
 hNPMPqs8HfWAfTs7CQVgY8voZ6lh3to=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3NSBTYWx0ZWRfX8JqNIboDPQaV
 +2n8ef7u1lAT8e5KY0Oz0RxCUEUTnLXj0afGqdu9150L6Q7agscwwXGyc9I6MIBoAqsLLb7iBeB
 X6ifPjO6sot6VOb6HVHNzYLJkMGk1YnD83Hpn72bCo+lXDVHRuDNgmn+E4+WFdrD3LGLYYP40ry
 gXjEBm/wKXYtESvUfqR645z+KqVYdhh/WsLCmXHpf2zAxx/l1vsOLSYoQPp7WWWt+p1znACB1lq
 iaGG2B9Xi4vdImCez8g889cKGwXFcm3dar0KL6lXxTuD/ZLkzIwzZ7r70F6t3RVREaeJ3aPqTcI
 XtVENQOPvhtZl85Bcw7+svFfVEsbq3kluAPYW8AvfSTROcppCMCBVFnuDfWrsysQSZp1Y9MSn/o
 PivlSdcOfxOAUBAs23YW9z6dssa54HPEh4fd6DcFV2E0I8t4WUHzkQMVpjKyAvp4ARuFlKFS83X
 Qbti5D0e7KYRpKcZ4Lw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfa239 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=5/Y9Gi2N1OwmQbPtUd2E/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=fx1oF1ougfxQs4UP-bwA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Doq4vTTkaP7VNxb_oeTXtlWKtj7e8vzB
X-Proofpoint-GUID: Doq4vTTkaP7VNxb_oeTXtlWKtj7e8vzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260075



On 8/18/2026 10:31 AM, Praveen Talari wrote:

> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 10c6a4b0b825..2f8237c232e1 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[...]
>   
> +static int geni_i2c_panic_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct geni_i2c_dev *gi2c = container_of(nb, struct geni_i2c_dev, panic_nb);
> +
> +	/* Make client i2c transfers start failing */
> +	i2c_mark_adapter_suspended(&gi2c->adap);
> +
Duplicate/Double  call - i2c_mark_adapter_suspended() already called 
within geni_i2c_quiesce().

> +	geni_i2c_quiesce(gi2c);
> +
> +	return NOTIFY_OK;
> +}
> +
[...]
