Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E03D3489
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603695; cv=pass; b=Tee1OELWvOm9qrcBGUw/5vnGQE4V0lZJUSRNeFDlIO0UIfNkY0dzQHmn/Xy7mU2u6kBGLPZk+pUTbgEdPk/yjO2VjdDpLig8w2ved5oDzzu8VU5cF9XMxI8Bw6JlgJ9kSRT8LiVK4LiIGQhPVcsUHRjMNHnodTM3ihE55dNgvOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603695; c=relaxed/simple;
	bh=q2wTjoA6AQ5vEokXlprNqUP97xG/5b3CiAspVWzTJJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofTNxysW55Ax6RvJFHwfI280+dypf/aqIgxgIvyMF0YWzllm8MGP8C5WQrcc9lLt75HZisCWh3GV5Oct1zpGxxCAqKmS7oXeWmZTvQy4HYBqZmO1J2UvfUPc+r/c0qc+9/kdVZWZEYMIriDyiiyv2LbjObpU8usLkklpgqvHWaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=armFG/QC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gnzy+K9b; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="armFG/QC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnzy+K9b"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6w7hJ3132187
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+ch7aFI4mufaylf8fLgNIC6y+jzwiCkcyQleXYUlGc=; b=armFG/QCcXwWnxnw
	v4lxtnRWnVbz6lYolGJu8RV2zT1MafVRhsJ9e+3l1mFdNcs6S1cp3lmQVjUmVIvY
	kMI+3Sr9DPphUg4Eu0+/RcAylc+fZSqeSdxsKtqcuMDfHf5XsVKTr0bL9SGP3Ca7
	V3WlQKGGwBkcSN+uSUV5xiO+XNCd0zaKDsRMsI9f+jIKkbu8Bvd0SrYtPhApD7Cf
	R4p1YDtVGC5etGcVgGmIi9vbQb5nWB+26kaX/VbfJnTTq8bgzfb3u72s9SWq6oFz
	O/jZiXLdToqnGV3FFYESTc+qc17LfpyM+vFbMxWDmbOdq/RkikrBg8o4yNdwwGW8
	bCpIgA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s42u9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:28:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b802961ecso26297491cf.1
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 02:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774603692; cv=none;
        d=google.com; s=arc-20240605;
        b=EC4yAkw+exFFhy0BN2VZgTQRhqEo+PiAvg2PB6HUFNWcHVsFB8PD5CbprYB9QgeajV
         mPjgq6E8liCkqu16SGMt576eLXW4VNSRzt4mp2sV5e1AZ2uekUHVOqrFPUnRsD36BueC
         lp4hj6gJ/zhV1W1z6BQUC+mm6FWrDSEHFukDIKgBVsvSFv3axCastArfC6KK0MfkrShu
         ehG8TW0oOClwkMXeXBhlx7M+AdeZCDt07CCI7nx3gltg8YxyUAT5v174SfbTaiNu/+GC
         Uozxqh7qlgsDkL4lsF2jWJsnUdnKXcQkj2dSf8nM3g/lA4qdznnGhvaRxTunXiEOcmer
         WBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+ch7aFI4mufaylf8fLgNIC6y+jzwiCkcyQleXYUlGc=;
        fh=VWQqkJAxjrPIDegKDadgRSrCa/kKY3Xm1HZMq3ItB+w=;
        b=V8jZACeNYj6WwK5aAoGYWOC8z5yL5NnUR9ZWEoPjYhWUx6NnHwBKAkXkzA4M7EKlHI
         0vtFr14jLXuwYHivQRUNhhxuJ2owyQoyyyWhPtNxoLwDl0kWDzXoJrP7RsHMP5TO57XC
         CpF+2IvEg2iv7jdRhHr3pO2sE8gf50WufgjpnwEXQaW3oMLfvU+hlohI5v7+QQxjPT7c
         Xxb2r5wgxgFAZyzim/71CflK88D2qI3CmSJavjcJK/Ra7lZErJZ5/IUP7v+ADSHEYqMI
         dk0uv6aagUnt+fKB/zpB7Vgspfaefy0/L+Vg1B+s6qg6YFq+akb/GmjU8ERn0UIQSkGN
         BGfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774603692; x=1775208492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+ch7aFI4mufaylf8fLgNIC6y+jzwiCkcyQleXYUlGc=;
        b=gnzy+K9bY3I25xNNv7e/brJEsDmuGatEbiep0ryE8K6Qg6CpLfx6zopv6rREDZk+vi
         gihr/Tt/zV8kgEO8lIQ3lG8OLBECg6e8df7UWZk+IZ8pDQhLvKqlUF3IYQLPnCsyCmio
         9SbG2hnnKVoNsQ1LtPMmL8MECtoYfo9HQc+XM4spVOglygxQS9NjWDy0UXfFnUbrNLCg
         MgyPvyDCMYI1+F6S4AEQwxCxYZkvl04NtHfgvo5BXTH3M/+c0vZ/6HJlB1BYsNhADHBN
         hVntEGqrj9Lz+gvcbK0RKwaaNJ9CUa+MXwW3tjXFgaqy/q4gLCep5FHYhN2x1BNitUO8
         dJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603692; x=1775208492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+ch7aFI4mufaylf8fLgNIC6y+jzwiCkcyQleXYUlGc=;
        b=CX3X/Jx7NUNdJ9YJb4C1P4xsXzKEIfdVM7X50j5BO7OV9M7JSwLdAquL//Si1HCl/h
         akp6wuKReqfomwU3c2qRabZ0jrs5frCeHg7qgsBu1kDrczoe4IBV+Rd6PUY2bipLNTDk
         fO219BDFysqEJGyYyWlhha2MYeJYpORRibqBaMGJymY/qDzxf4ZxcVp6HAl5U9YjdosN
         Q8O2lAACE/HVx5RDEzbxeaNt/GxV6AWHQ3IjS3xE6nEMC9a3AVdyoUMNSi3iKXiDcMli
         YnTJd7B/VCBE7wPqEzJ6sJhz2wB90kAfGfjiS8pWSrDC3Y9U3mctuH4Xn2IjalxVxgkl
         td/g==
X-Forwarded-Encrypted: i=1; AJvYcCXxHehZwn+1rqIprKgrDbbeYDVFixoBK8rMseNp5Ohppryh5iWLHAxN/HItsM9mDpnpmihITqKncrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlvgMDiNdh1dzMH55vutKXRq5fcb6t6OpYv/xsL31/guN8f2/
	f68P4OhfN/ymfYhqzGK+dZWQFkkMVOIbW1ZnhEGZ8kvv5fLYSByWmub51bca6L062PIt+GiUWUR
	RdQ1gZGRdkl2KBEmHWaSmzOAAIarNbN9IieglMm3QEs8DP+Sspc9Fi1uw6t4wqyXgDgbxGlbazs
	3xavDTzqc+swr2XxGyBA2RCYzGHqqU4eQay9tE2g==
X-Gm-Gg: ATEYQzytxdglK1WtFl5S7evdq6P5hzPHTKBGFRt1tOlVMumm7+JMzRywnhxlFQYhR8e
	2vYpL4XTXG3pmf6oad9qCrOU6UyxGaLnfXDORqRWZKZ43AouU8oP+VZ899Y24r/hIc2/8sKD2Gg
	V2kXU5ucdhq22vBgaMtNtf+feYUmyX255kUWl1LbCpgA9XGlMQaZWnaTsL0J3lcWXjKVGEVomcV
	R0uph6ACwGAMcl/1RHaxr/Y1IAfkGpxpWjekAw=
X-Received: by 2002:a05:622a:4d09:b0:50b:52ee:62b5 with SMTP id d75a77b69052e-50ba391933emr22125231cf.41.1774603692441;
        Fri, 27 Mar 2026 02:28:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4d09:b0:50b:52ee:62b5 with SMTP id
 d75a77b69052e-50ba391933emr22125011cf.41.1774603692009; Fri, 27 Mar 2026
 02:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326165345.762807-1-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260326165345.762807-1-vladimir.zapolskiy@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:28:00 +0100
X-Gm-Features: AQROBzAtzjmTb6epJEaAE1Tvbe_-Sctq_a0cze76MzHnR-ymwRbetX_a-DZvQY8
Message-ID: <CAFEp6-1v1fxTsB_6m_=F62vpzmLeUZj=mW=NWc7Zj78HssQ0pA@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Robert Foss <rfoss@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: WFnCHXAowfNfCEeXsmbvs1YfqXh-eIjy
X-Proofpoint-GUID: WFnCHXAowfNfCEeXsmbvs1YfqXh-eIjy
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c64dad cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0yNr40b3K-hL-g3DCFoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2OSBTYWx0ZWRfXxIP8B+qirdsF
 aaz3QSw0JvESmIHoURg6SVRAEKSr67o1ampCup8DBFwI6jHN92D+SHktcem0Kc/4toz+3eSmp6t
 MD127QcsZGacy8VeyH95o2TWqigRkhTXWYzjO+08raPCtLOGBH/HcDqt0ugFhgaeVPGcVp5IdAQ
 RJ3VQeZa8MayEf0i6syczFlm1qBRW3ypr2zdvo0MriBCDS0xGplg1ryXk+RZWArcPqFb3sfhqyq
 KA0vbCC5GiYha4x7oOXmiPS4rX8Z30uQhqHRvdyETKMtMhky9M66ZDDhk/eBIM8Uv/Z5Gn1QBJq
 wzMw/H4j6uY1A4k7Ne02e2FBZtBmTl2HXjTMAXOX3lbYx7QldHlSvovkPT/YQD8OEeoOYn6vgeB
 KAF4iuEgqPXP6wMZymxUizr7108O3VRobVpJOnNw+Kw6/M6WZF8YSoiNZMzkLaXYbcqJoNERdw9
 QFt7r/MarGx8wF0YFKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270069

On Thu, Mar 26, 2026 at 5:53=E2=80=AFPM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Trivial change, a never used macro CCI_RES_MAX can be removed from
> the CCI driver.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index e631d79baf14..7f146d02e5a5 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -71,9 +71,6 @@
>  #define NUM_MASTERS    2
>  #define NUM_QUEUES     2
>
> -/* Max number of resources + 1 for a NULL terminator */
> -#define CCI_RES_MAX    6
> -
>  #define CCI_I2C_SET_PARAM      1
>  #define CCI_I2C_REPORT         8
>  #define CCI_I2C_WRITE          9
> --
> 2.49.0
>
