Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E4339A04A
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273109; cv=pass; b=g3OW/bOxdzyPoFIFW1EmTNwk4YB/Azix9cX/4/rcMGrF+97/UNNOBZ6/OI048E9NnZ49x4FcUk3KGj6nX/jfW4EaHGAseCeBLgrM67YIPyHJXmLuRjSrMZrZAOVwBoiqSpKomlYJhFjyIemTrjq4yMRX9kqBU3YOqLBuaeb30OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273109; c=relaxed/simple;
	bh=CL+Fm//7PJAuTWNWRctOu0wP9tKrbcMfws3PNuylb8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGjmer4yIDHft5/9Jh/dh8Ud3u6POaG9DY9KQMeN2DeXv48gzHAiMmIkx6O3FBBUescvlwZzYkOKBbGWB1Ca+lj78KA0guvFQ0krf10jWYla7qPEU1yp0U3bHOC7Y0z2EmKZTf32IldYuU+kctu12x7K1eSGcGplUCt88p3L/Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWKV/Sbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHUJpS+J; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWKV/Sbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHUJpS+J"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9N7A3004249
	for <linux-i2c@vger.kernel.org>; Tue, 1 Sep 2026 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=; b=TWKV/SbgV9p0gmBq
	Ix/czCMtVc6C+fPEUJMX/wN5rmWOaY2sWrV8k3FCPsPVdBHPZds82x79UGxpCqCp
	/pVpjTMlX8ruOOfAB4pzE0il1Minieoe88KD9Sw4VJi1bgOh+zoS/6IfzDz5g8KM
	J4padN2WR4QivG/XXxD+bL//mbXyEPOzB4v81QzF5er6+cvoinwDYAqvjPEBlKjb
	fjX5HcnJIoAASFUUS/1g6Hq2e6QJhqKeo3LNE8Ut9OkR3ueWUadOU0OQD4ljSMCK
	j2mGoFWfUxYrnESW4/FvIxt6z6yf87rCmLVgMvOg92INvotvppxD5od8KkAFNDZv
	mmzjXw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh2k1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 14:31:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so1123773b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273104; cv=none;
        d=google.com; s=arc-20260327;
        b=VBu8g7M0l51ufsUBlbIiosa/oNb4WYvRvKSvWTexKgE45vlO0hkLfzQfU6OVI9vT+n
         c73oADFSDDlKgEcO8/XNiBeJbzd9EQwZhCOgnvpTEsVx6ZC+mViGgPrEblGcgYMh6IFT
         UkZsd2ZvvrkdnaA0p/zyo/IzkexNXpWf1GNO95kbDmNxVwbp+0rve4YPaemvligIIqJR
         mScDzuw2LwSpjE467RDy+bmExRCfIq0/ZjX1z2rhhr+xJ4VEc/FXFftCm/NQay/duSVK
         s+AhMkIzA3NQbjrVaSZzU0XeNjaR7xepoRw2zjeAD9EITCMI12h0OyVPSlom2gFr9nJc
         P5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        fh=IFGhzGSV7rmrOczpkzg1cqdnAQ2FH5Iq30CrS29m6qc=;
        b=s4mqLV6DVFwOGGuo4qWhOcNZrVfsF792YhkocvsrDwdzg5+KK2YvTuDl1ARvr1Zi4w
         tC5JqvG5n7Pg3UNhftRirrHrx0dlu/y9Lj2bPnh1ugdwCjSyoGaDP039MuzUGXKIyCpP
         +UDOEdeakZ4NGXZkrayWWUrEKdX41NXC6Rp4phL1HSGiYyeHlLELIwxGhoCN4IKBQJh1
         b8NndbABHQQNPoaoPowDXvu6XvvOlqihuENJ0XaAYjeww+lECxpmOJ9mBMtcOXucZlM9
         0YRlNUqaXr1cCC/grTp7DHLaxBYNP8lSO927pxVLU2SMp0iQKA/opN0rgZspwDXac4+1
         rBTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273104; x=1788877904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=MHUJpS+JNG++WoSWrEusvWGQMqlLb+1WmCAkp+miG6kasuPoeE49mS8n7EzTVE2WUl
         s95CVfOFKfNjrElcCawac1ADbMDyc8E32+S0feYuZoYFvsar7b1F4KT8ixYVsoGrEzSh
         6VHSl0jYgm+3WW8E9FjvQFb2czYam8VpCI3nQLMCkz5xAqEgDHkFpfuIQph89MTzBSC5
         E/cfUPjZuZkHiZUfZdXQrFo9OD56US+ILdg8evX8Enajd9ij5XyZLZM/Bs91xmFiG62B
         UJANEaiKgCk3ahQGG3i6rxwj5D+ewO0pdoTwlIGI+54ea5lCe/vO+BTCaZeyBW+Lo2Do
         FSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273104; x=1788877904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=dKaBI33LwRoI0PmT3qh6NA/EAP2yJacWoBoAfbkR9WRymM+Hj4ID6rC73AG5ah6P3Q
         q395Y21/KuedrhI3XSlVozWWbR+BmXQra5XhDxQtwzOrA0Lxo05g7sFQV0zi9TSl0bDD
         vXEAEPmB0o5gNbs7cxLOI/po1DlTNAzTSb4G6D1TG71HHEam+Djcd8vwcJTqUBaqf+SZ
         04kWHxLGIteTC02JZ4aa6oIZ5ST8ymFnBodjBcJ798IhTU8hoKVxVHNakDlbJp8S4Ahc
         S7ZXcExakhKRliw2tJAWNLFhGo0AH1PzNrygPA13CVmCmC17g8j5BQElrFZdQgzb2C7Y
         5gsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrk4qny3Mff33Fruh/EVigFK1QAxEneQpKKZ1+maugALcqYQ0ASIaSqKlwFSJqImhWOVf5CFfeXgjs=@vger.kernel.org
X-Gm-Message-State: AFuF++kxGTB9Oae2qqybQ+2xlgsACPmpSjqwdLqaycmlO+zJgu24MbsT
	xsZkGtY5pUgvE4EeXZzeoiQKhWkx04COr9KFIbDMZZQDTFYv9Bie5/72m5wUhaVicOGVXWrOzeN
	HWauDW4D0DuICQ/PuSGqE/sPP6FZA4x4/s9fCjtS6m83QPRixIusxCdK+RBBcfH8K37C9Fd6Ej9
	NgPJIeYeDoaRUQkWioY2x0Z0L6AMt1pdEzx7bsig==
X-Gm-Gg: AR+sD13rtNHoBg1K3mMyURgKd4DIMzNaWkv1n0Y9zA8qNDLbDka9O9sAuYIjO3zNYM9
	OVm5crEK+HiKwYTpWJv1+hHI9+YJSHgQL/9jMK/Cl6AOP1lJKDHeuPz9WV8OVAWnZecsD6GoALg
	z+GC/3doANFiSsUZr3yEgwRvOKK6nZE22biH7j4OzqFe2r1xl/vPySBB9IVQ==
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-85bcacec88dmr5179008b3a.12.1788273104264;
        Tue, 01 Sep 2026 07:31:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id
 d2e1a72fcca58-85bcacec88dmr5178917b3a.12.1788273103642; Tue, 01 Sep 2026
 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:31:32 +0200
X-Gm-Features: AcwNN1WwQtMTDpu5tktdI1Fc85e8Ltr3tWd5G78kHHK2UXE66ekj0IR3sGBbeCc
Message-ID: <CAPx+jO8HQj4PtBScf-w+nQz-9xe+7QxZLMtp=J=sFSwEHVLL_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfXwJxu1WykVcKR
 hNx7f7K+aYdi0Js19m6k5/AxuUGG7+mIEdmzYiIJaGDY2s4yh01au1UgOJIQn+dUTcahe6/nNET
 VCa7xwZiXBDhHKHn/TIl8xFJ3xp0a0w=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96e1d1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=iiyz0f3IVUh47B4zfGIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: TVUGII3glMUjvjSl6enlz1mXUZNFlnCT
X-Proofpoint-ORIG-GUID: TVUGII3glMUjvjSl6enlz1mXUZNFlnCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfXzcyviJSlBLZm
 EgwnNoGAjnyWqHZLAGXy4pszuRufj81t1A97KXSRHjMYX10RcGZp82q0kcL+Taxx03NHSN3FjOq
 STV5+nbYWbsMOjER1ZhwV6cQXDYJOfBDagEEPZ2p7ngs9vDHhHM5791xU1cdqgVIawJEFqCFWxE
 LbYjaQcACfj3zP7/GMr9vld/BKsxJgJYkl0/efYjypPrqTe2rs70bj1sLzlhLEzpmTj+XnJbDso
 BERLr+jSR9hYEzErBudfCFv31pWHNjstD2l3oujQo7KUtMdoo+XqCkuKgJ6bhGMXPnwbRqORVkY
 9V9hpRjMV3Zz5477PKxBFH0FclchthQIYugMYfGfmL3DygZw2Jwl5wAAL5QNJIrqItkVNfA758i
 /Zd2dzDZ+spm1Z2OGRAuBe7M9GJGqWOqL32fzdHjjTiKiuRXYxA/VkDr30RhJUKdWg0avXG9E6n
 sg6ulDx2iSMDmfWuEYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010129

On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

This is already in v7.2. Please rebase your series.

Kind regards
Uffe

> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>                 return 0;
>
>         if (!state)
> -               return -EINVAL;
> +               return 0;
>
>         ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
>         if (ret)
>
> --
> 2.34.1
>
