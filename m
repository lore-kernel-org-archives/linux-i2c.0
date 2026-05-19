Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480E3FDC00
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194982; cv=pass; b=fUaNT9vhGkhdlPIO8B2S0dmLK1g8Hl2oagzl9oTj6SXcjLmXUkuG/5IAFzYOSgZhM3T2b/k1Efb90uWZytARJC+9kxHHySoNhMByp4ko1DTyufmQdU49ME1XgPRdcTAru4jP8Eed7xhqovKPx35MzgTTrjcaiJOeaO/q/lrNuuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194982; c=relaxed/simple;
	bh=V5Zg1C3oSoD8d/oOBD+crRDyZXzch4ORUXdF54ozY7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn/P0dh5bFku1viWkLV5nRPb4rzzA6YeJdKoGJlmTgW5IcR4gQ6pyRdr6gSDzlOiybpRjSxbSb4zN38QbmHrsTSifxlfOaf/Rd/iqXknTu9jXR5CJw/0ahzNqlcu2fF8ua3QunSQshZZYCLhMBJ8PDzw5tr5u2OoEsYhZoTE9zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j81F/6Un; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=McSGQrox; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j81F/6Un";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="McSGQrox"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9kuOq1257048
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6NmyUddfrYb427GwBagrxr/nluvoaaw+FvwM5JKj3FQ=; b=j81F/6UnrM+ucBBJ
	Dg8VIH5yB14RiqB54X7zwOjOm/rArZLvE+9tNPQG2Tro016LROeua0fjO/eYlH6S
	5Ov7wYe2y5IZbOMKEjK0+uL4Y/ASVVZ7DnGlIRxOSDwVdn4XJA3ZOqmGWa4HXg0C
	n39+sRoLyK2Di6I6c9ZQ1jNLPd0U6BS/yqgpcnE70jFwBJ58W54TWb4sbBlaGmmu
	X221MzJhrYrLRQ2Awr/YmfUFFfuz4sNkund4bCkEwMKkhXKCoeC9yezcPoreHKAb
	5aUSjjkpdutlQ0On9j0jJmNd9ipZqcloRpb7A6voreMXJOH4mTVpof1gBghZPRhP
	I1mIPA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj8nh0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:49:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8c9352f816aso85463426d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 05:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194978; cv=none;
        d=google.com; s=arc-20240605;
        b=C1wfpSmLLjkgSRkYl000OCDgsE9/W7elalI36W2SdktzVCdJ1r9oLN+SqrgdrO8hLY
         N61jqv/QyK1NudQR2ZkXXDJlsrHAeIvymTFHXj4JEU78jhHybkkqXM/0AEKrJrdceLXc
         le9FeqaAUWdFvBvQepzUmlR4v1BhUDLb6xfgZHgPGMDI2QqBW+knVmsiwZ6W1PcbCouf
         CT702JLfo0Lsm87H2d/+cxT0OxT3H4+TAfxkzQgJSk8fBAPAMfFM8baJcOElDddqOayf
         zgBDRBAZBAyuQumrrOI+7N0nkcF5YiZDJGWQspqaXWhvTTDB6YkBG8Fx/PyApJVzu2MW
         3V+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6NmyUddfrYb427GwBagrxr/nluvoaaw+FvwM5JKj3FQ=;
        fh=6MZoEcDrmtAYJKfNgc6ui/EFs0J3/vnk5rbr32ZtCig=;
        b=fjfB/Fa+GoLgYdIX/sJ8feFirrUMlRdROEOxyeEBwExRGAFRZSe+WrkV4mfoxnhKgx
         CEXXn70S/T1ixwA8sbGDKP1435ta3f6t49LDGkmgCOVtSVP6rZkLpd8UxYkZ9QPWlofs
         igzdjqULO7zHQT6HBOTCJ9kg/fzJGFDiz72CnXWNZnjMsAVvDKBmxroZqzyqH7ZKPjWh
         Burfyzhz5EBl9TUyclkGfO6seZ0dOJWriJqMo1TVnnqBViZ0e1TfQnh2qA6VIg5I8IPz
         9n4w7VdXL2Ic5f0mqT+JZdnsEfUY/yk1jejMnJiAY/gzPv7m69qsPmxXayx3intiJ1Db
         Jm4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779194978; x=1779799778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NmyUddfrYb427GwBagrxr/nluvoaaw+FvwM5JKj3FQ=;
        b=McSGQrox/RvcxSQINYDnWMuh4ySbkLWCLH7sr05nG/sM3iVoyfXWjiBJA8DKLOcTDw
         SBjgNogIgVyifkVqp1Owoet35q08fWLvvJJ5YEvtMpu1K3SgjPOBKX/12jXwPJnXCVxv
         s1Q3Oa/t3KDmhNpbQpDemWB/ImbS8uhJdU0Nz2mr6Zy3RYDHMWKcKL2U4/2uCyUNmLtJ
         g5qLJpMI8bRwNTnXcmGq2XVY796ia7lYsMa4CfZNux9QsmLk51635jZmzRMSQoxKeP5e
         +V4C5wU2JjsdCamH+UFXBIFslT4tslXnWAOQWdFVMUvceFilXJLMdNZtxeiaDiWvx5HJ
         G+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194978; x=1779799778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NmyUddfrYb427GwBagrxr/nluvoaaw+FvwM5JKj3FQ=;
        b=IJthCTIgIcr9DGcQ4xbEfRaElwI7H5Md83B8P/ote5Ywg0XLWluck3z0j6SOjMVFcU
         fRpZEYyLMNqgaQb8HTROx5JxxHRhrCsCejEFUiDFwdc0XMUkv2TIgy/3LYXRHBOaXC3R
         vjrasxUnb7sCNTpinb33lDZZC/ttPoqv/A6kZD9UrneedABJNuIymDkEBChoKzGd+/Rp
         c47mcCV4VRnkFhPLt1eeF5r7PAjOiuTlf9QZ6u7OD0+CRj4fI5vFkzgN1XxogFVUSH1q
         rSNvIO1be1BfuFyJlUFicVcqJQXL7H1skILs5jDfONlrq6bbYNatzTKQP4bb14maXxaz
         07bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TMz7dx9qdBC1RlIgY4yPJ8KeRWLZkt374hxdLALlu/oE8P8sOXCooCotUq+CoFzzQx7ptPs3mTco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjbujZ9xBsbbpoVXNwpcyv5xACGFAT0vLthN7mR1v/IiXC7WO
	gLiIWmKEI9zBzSU4itZvsykXiAzfaUnymMCF8RF8bUtkGX3v50xlJNrxsHd0DiVlwi4uhQsGMy1
	oNK2RomXaLcfCj0nPzj8SPRjc5eIANBMgiHXsGTVVWqAopowIz+oop0V+3CysM0mRMZLPBCp/ZS
	MmoIcn0O7IXyt+Uxqz0nIaAN821ac/ox8e5UihoA==
X-Gm-Gg: Acq92OFht5AIhyl1Kme6DdTQ7LJV8TLektvwzB3foUV7uXAVYrQkn8DhRLLwGMzHBXY
	VsES7pdkc575ABL08FPftTWe1ySdWG/kVVL97vpSzTxL5g6HVXcPPohD8syTREBK2BDZMZaKa/7
	zBa2JAi+qGXHyujCmowbmdkIsM+t99lI9GHumsEu4MbmVbLTl3NY5qkDqT3Z1tl7AXhFDkotMRi
	EJcIyxY7VE9EC6oSIg358bRL/mJEisDhX4YmFU=
X-Received: by 2002:a05:6214:6015:b0:8bd:7192:9506 with SMTP id 6a1803df08f44-8ca0f64235fmr283460256d6.7.1779194978121;
        Tue, 19 May 2026 05:49:38 -0700 (PDT)
X-Received: by 2002:a05:6214:6015:b0:8bd:7192:9506 with SMTP id
 6a1803df08f44-8ca0f64235fmr283459866d6.7.1779194977716; Tue, 19 May 2026
 05:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org> <20260515234121.1607425-5-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260515234121.1607425-5-vladimir.zapolskiy@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:49:25 +0200
X-Gm-Features: AVHnY4JvcMMmko_XU6sC4WGN2U9-8_uZbIyKO4npMY4X1Is11ZZYnAx4UtyOSOo
Message-ID: <CAFEp6-0En1kQ7LXcrSoi9X6fGKLOdXTHZf+SECvUqR114ThB+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] i2c: qcom-cci: Remove overcautious disable_irq() calls
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: raJsR4QQHCbyLgJDa3b9U2chbCdiS_uD
X-Proofpoint-ORIG-GUID: raJsR4QQHCbyLgJDa3b9U2chbCdiS_uD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyNiBTYWx0ZWRfX5SLFeBQ6Vy3A
 4+Og70xiAvlgoLCpjtE3TxNN8tXKNimkXAa7hIeYAL4n1pKxh44Ym5epiKkkbpfsWZLVMr36bI8
 lVCOJcMOPNuXDcZ7ktdqYsOhC43wFjDl6gFtA/oeuqQb99kBGCMGUa/w/IrQT4YUO5jUILZoemg
 enEFQd7untN7OZeo4meadyJqfa0X7dgSyCsUD1LuS4gZkMv5ak60w6Vz36YxAkbKw1sCH5L4Dbx
 cgQseeQALS6y39IpO2+kApDjKl5s/Mkxt4mJ3HWGOfdm9HwbwYpWISQqU1UG9mSZOMLOUQIEYsm
 S6a0mc2DINUNyZra2wMjNwYkzefvZpreVE5Txt1/TYqyFBlx9mwEqLT3yo2EvEWbbEGx5PN7CWi
 hFltMTkMxcIQdyWYVhJmR2sGoI+KVNfdnyvco4eQGiKpYN41vmKwPAQMGK3fww7xNVY2U/i2VNN
 4lg04CMkwWuuhzv+swA==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c5c62 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wJ32WsedhRsoF_vvPlsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190126

On Sat, May 16, 2026 at 1:41=E2=80=AFAM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> In cci_probe() the controller's interrupt is requested using a devres
> managed API, and in cci_probe() error path and cci_remove() it'd be
> safe to rely on devres mechanism to free and shutdown the interrupt,
> thus explicit disable_irq() calls can be removed as unnecessary ones.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 2d73903f14d3..4d64895a9e9e 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -608,7 +608,7 @@ static int cci_probe(struct platform_device *pdev)
>
>         ret =3D cci_reset(cci);
>         if (ret < 0)
> -               goto error;
> +               goto disable_clocks;
>
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
>         pm_runtime_use_autosuspend(dev);
> @@ -638,8 +638,6 @@ static int cci_probe(struct platform_device *pdev)
>                         of_node_put(cci->master[i].adap.dev.of_node);
>                 }
>         }
> -error:
> -       disable_irq(cci->irq);
>  disable_clocks:
>         cci_disable_clocks(cci);
>
> @@ -659,7 +657,6 @@ static void cci_remove(struct platform_device *pdev)
>                 }
>         }
>
> -       disable_irq(cci->irq);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>  }
> --
> 2.49.0
>
