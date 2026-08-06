Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0C3F8246
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011566; cv=none; b=DD4CYgsBUj8XY4DQ++oloL7UsosBAON4aZvs3/jHo1A0EeBiB2ETzMOK636+J04y281L29/P9/sWQf4CIgaXxOlarRbMHgO8eitNRuX7eAZVafBP2b9jOvTDMs6iZRlwhg2a53NjffUvJLNajmra+NNYwjlytXHVyppL7HtdFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011566; c=relaxed/simple;
	bh=rNDF6Fc1Nx8BSJb7zv0d/HGA5TytMPXHoOXWeTu5FfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dSofkfC9aqBVqpiCXHTpj82OfA7CKJtOHF65tnBT22NLTEq8yLSvF0IcjL6C8JJqm9E97ENPNyS0Ae9NRQ9URAkHyqe8ki8xDLsrydW35BN/6EAbMK/moPH7jmqf4zX/z05O7YIKC9gRnKnfJcSGBPZ3FFuK/YQJVuYYMMWS4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3RSyiy9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mk1WANRe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3RSyiy9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mk1WANRe"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhPg1228148
	for <linux-i2c@vger.kernel.org>; Thu, 6 Aug 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SF4YFqwTJaTZdpTLrS1SvnqTddRHfDqH32rIPLqrPVw=; b=L3RSyiy99zz3K7Tv
	5TxUKkgOkGgR/ViRGa0fVxGbIUQBcfjwliXHXWp0FuCrP1WCKmtsOgkVUH8AZ04+
	7JxR2Me0/iCWhiXva3cpnrWF4xNWhApDPXhQsLbABcAz8yyqgrMWiJQQFCH/eI2i
	TtYN8lmNOm4EX7AQWY+63KI2vST2amMHOs6zVikQ0yzWKOl1Vq0adEtZM6QF9YgK
	XaqQCpnvFeJETQ9FtVbh9yUIHQtng2oMKVe9M8ZhH/ibcHK/qm4bKZRikTeWLu5n
	o6ZB27TmM62XTh2lFYDYtqkz68R1zx1p/txoPAnadrIKomSwbVEzat37WBxhN6+S
	8NwyjA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvqdug8xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 10:19:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84857446424so3492739b3a.1
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786011563; x=1786616363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SF4YFqwTJaTZdpTLrS1SvnqTddRHfDqH32rIPLqrPVw=;
        b=Mk1WANRemLafgMJyyd2jDPkLPGe9aSk4O9DDRN5/hKQbPz276vzZqe+z4sLgKpTqWF
         dr3VUYpMQtLIco6QnjhQsuB5jduz16HOgdybl+6xkvMaAgd23nv040MgK29XZQtoFWUZ
         fG3AccYYacfqL7QxpzbuWNF3edks7aWM+H9W69GuIyFhlrqNUFLXMX5MJxv7GGfIXufc
         JXgvTgW/7+wPSnUAPurciBU6Fgdjpzn4qKR1ynKF9CpIkMGS/UNgk8Uh1cBBTS4Y+v/I
         wBe0fphyGdLbBVS/EruyURdvHIcvyYYwGn3YKj5EMq1xP6EuB7BRQY3NMRBP4gdLS6ul
         H9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011563; x=1786616363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF4YFqwTJaTZdpTLrS1SvnqTddRHfDqH32rIPLqrPVw=;
        b=e8Pe7LS0TbmmIuLHvERUZkA9GRTRMJFDm4EZ3sW5tS4A4UpRGDOgsf3mlKrcpnFsoB
         I/y7jVRkHWOs+EhpLmqCsvwuUXrN7pcrl8ImkpVZYWpW8TaOcMQiCMB79dCAjRVtG37t
         5SAWdcxIIMXnSMvGA4S+aQbtYQ/ChMN9Ux/Je/eknuJ+wZuDx8H46Nd1Du0Eki4DVLlu
         gzLro7//hqytxuwPem+ErXjkB20m+21YPxu/bfHp7C7x6NqVJyweUDQtQ99Fum8Fkva7
         Y78joIDen1sHG87eNWpe0+Mj5mTzcWCRWwa38gQPHgpv4oBcL15k+DWECxqaU6I7DFVg
         NYRw==
X-Forwarded-Encrypted: i=1; AHgh+RpKBDyqsQhINhurFYUCwbzUSHUCkDVaKhQ+0eooKWRkwkhU8HP1QtTAkxBCNPRXFPbymeJ/XJqUMLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJThu1l5NWY0meB/M4k+q0W4l4ljeS+5YvAOcwQNedMBcPqt2
	LuYLpH1+v6wYnB+F7YJ/aZK9AnUOg+inAd2DE5mPzQBxwzKsSllJ7j8KSVUeD3QEce50EjOW1YL
	M8qwPk8SBLSvrnOtyRhaWq4Pow4GVSIR/YJ4dFZq2riBrwLXXkL4/kyGMPpSBDtw=
X-Gm-Gg: AR+sD13o/HsVFaDVSYoKV0rqcOlvOV39CRwtN84RLY+0rcvcbhWQKNTktda1BqfNqz5
	Vf3BTv+wIC2gmGT3KVxFYBN231pcmGG6ofpunVVSgqsKL0RPSqFchxvM3j6kw6Nu3xjNntpWLWQ
	XhkMi2KRg/tYdVCNFGomO+lhXvbngKgf+69u0BLJgyXgklT5wnHEQhDn7XSkoXrcv2W6NohWvwM
	G0eiOBNtFDL9po/ox09uZV3doIHGLd+QbKlsof/y5pv6yn5Dq42DqNGuRg7lahw7BXSngP0puzK
	2pSMHVzFZ7ejRWewHOYVx6u6j9UHGFvJawlLJ0dBl1e/E0s5hxHEajZbc8HjgS0c5CqMDTkaSG7
	+5FJ0fsae7B6aOUakNuIU9wBjrtXw6i0=
X-Received: by 2002:aa7:9303:0:b0:848:77b3:579a with SMTP id d2e1a72fcca58-84f2dfeb92dmr16446733b3a.17.1786011563510;
        Thu, 06 Aug 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:aa7:9303:0:b0:848:77b3:579a with SMTP id d2e1a72fcca58-84f2dfeb92dmr16446688b3a.17.1786011562962;
        Thu, 06 Aug 2026 03:19:22 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f459bad48sm1089601b3a.47.2026.08.06.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:19:22 -0700 (PDT)
Message-ID: <dd000244-fff4-48b5-9a6a-80554243b6fc@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 15:49:16 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        viken.dadhaniya@oss.qualcomm.com
References: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qZ4B5-HbdinWnvFZFoZSBEO_UvvfeBTI
X-Proofpoint-ORIG-GUID: qZ4B5-HbdinWnvFZFoZSBEO_UvvfeBTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX5pYGt+fg+r+3
 fd8xdhpRmN/TAD7RmbefN6hxb0EUduduAYkoyt5DTDWTrpH/q7Op+3Yt8jqO8xBUmVorDLsRlXD
 S+N9R8GpdAB2jaDx8jImx/xO9AxQYUXlYWbiisne/5NUcqW56sNxszwAYHXXfyctDpyGWnHzhLe
 wEVjWpsJB1ywHNTTO72GOv5O7uylp3ZMuo5X5G0Lj38jKqK3Q9p3ADAZciGDZVutkfvmJ0svk4P
 bSjfXvhUiGrKHDYSYj9tG1ebmmvSMfHmdHpX6j+SeEcFwA7kASDdIfsTBqkwDHXNmAeSxVYZF8N
 UiiofxOr0iSWS2sr2iCXR4WF/Qhfc9dQn9vMnDmmlKAz/pxVusokYeEzxqMaFGidXno/k5htcjL
 Tjo2BscFfyzetF2Z3YQGoYo4hWDPgRZRlnKztGu8NSef0qWfQ1VLSWGrqArcFuVusBNKyqRUg5Q
 ohifrwgyYJYDs/RNKpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MCBTYWx0ZWRfX3m/ieCkx8nDB
 lcYbkVN8MScOW6xP42qqcCEGZ+reqN24m/Xj/pAig5gClS7onTgELCptHc+DOt0lpe7ta/GOpaU
 rgGZNGtOYJiowvsVCYPtzHdi8WbbWBU=
X-Authority-Analysis: v=2.4 cv=bdtbluPB c=1 sm=1 tr=0 ts=6a745fac cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6z8TwaGRFWoLiM2ZyNYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060080


On 05-08-2026 12:30, Mukesh Kumar Savaliya wrote:
> The driver currently logs pm_runtime_resume_and_get() failures with
> dev_err() and returns the error code separately.
>
> Replace this with dev_err_probe(), which combines the dev_err() log
> message and the return value propagation into a single call, consistent
> with how all other error paths in this driver already report failures.
>
> No functional change intended.
>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index d5c977e34994..96015e077b69 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -994,10 +994,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   	int ret;
>   
>   	ret = pm_runtime_resume_and_get(gi2c->se.dev);
> -	if (ret < 0) {
> -		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(gi2c->se.dev, ret, "error turning on device\n");
>   
>   	proto = geni_se_read_proto(&gi2c->se);
>   	if (proto == GENI_SE_INVALID_PROTO) {
Acked-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
