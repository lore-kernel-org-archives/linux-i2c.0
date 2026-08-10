Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632E3F39FF
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371578; cv=pass; b=CtHb10pfua4KnerZFr3pnQAhREBCHMIgnSKwrIn7qA5p+COZIl9kRSJg/pYn1IdBrOkoW5Iv91C57ylzeCAZNHjp/bvavzuv1dywOCdjWUy1zR+B2IImfCdHXodlex96ohECKp12bk8S4RGoGWO1Lhk04hkhsjFtbgcHIR7RVIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371578; c=relaxed/simple;
	bh=n+Ksvu/zVWPobgx5KX7GBu9XwArpcsGtQQ3SBCwrIrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KidlBoDAEefWYpJAJAL+f9mldULPJZbEBDidh/VM49UFHNdfi2vJ9cNjgA2K5c+OQ+k/8sOinjjW0msuvbJse/kzKFl2IM8tPm4um/3FZ0uy+XyJQEZj27aAD1vioMQCm3mAwdxZBqypRU7sDY0+xDcx/8Sx93VK6vZ+SoIQf/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ev1TpKH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEAzozgO; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ev1TpKH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEAzozgO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACjUos1959986
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=; b=Ev1TpKH3ebEU1fy8
	g+4xebhPHPUNEgczi4RSZlAAra5Cj91TiMJid3WIyK5/K42u1qxUcjk7uUCBQHoM
	D8o21YcfVK1/Y97choME6/qa7CdDIhuHrlaVEOIr7xgiuVzpWUQGLsJRHjecc0X8
	5OmdKvdY1UX2SdEE6NQg2yuWzpmvtnJjOYPGFJ+VOPekQ4vxFoORjT1aoxhP7vvV
	YYapTAPpjm+7JFbvSNZqrR5jaeN6QyO+1y8HV8IIM1yy0lsfCMSKDFY5nXQLSOGp
	AE5sKxscyBtkwJygu9QY3Z06kIxGDzYvIbVbErm3jiF7vYdIQvt+b22j8wAU+yxK
	2sR7gA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xty81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 14:19:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso37966511cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 07:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371572; cv=none;
        d=google.com; s=arc-20260327;
        b=SCB143K59oSfrSsxkGMBcK1XxlWcZxihZvO6GGFwgp1NfyV5VFFl/XoHV6FLqWPPu4
         leZN0lEqJ52Bo8IwRajtOmz7Ol/ORVRtlXhuffMl+O6bKLYrI/4i5sKmvsiShERGmr35
         A6073Nu82djC4I7gdayWBrtqO4uoA8TAFC3wSQB+2Xqb9pfltEL9z8nKZiiwei0OoP9m
         dGl7KDtNsNnAAXfVUQBF7nnndxWAthtQ+V3KYTNzq+ycB7qgaY/vrf+GJQ0aWWe7MxYW
         6KuzeoOULfT+GQpPXcOC8hsHZdX9ipBgfoFnLTD2bRDp/lH/Ai1B1DrHwXRrvTAs3nRf
         JcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        fh=CPPPgN20GYbjFsBrN6XmY1b6pmT8zAcpkzTE7zP+w6o=;
        b=SGlVSXEJ9qZYQ5v56D6KccI4sxhTZi5JGLwGfFKcq5SQOyK5K8oL7nsbcPG125Rmsl
         wmlH/FHHq+TDKQppTvcS9BGbV1jAVkxaAv8A6wzTUBVYcZBqSa1plGrEHM7U/x+J1Lkx
         ChnED6HwVi6WRfbHShrMa98EbNpW9p0Zzq8i3P1wNsVUg5ZlBe9zC1iFJwraE+IOpYvm
         1TuUnvnmcXL50EUyZJG68227gxcY4bZOWWULdRXG8YwXbPcM85So2po2BLrD9aRwp6gZ
         BRl3i9lbORFTqLas2V7pltcFRIEZvGeMS+FjWoHJMRkX7E9+d49SIBwz3Ks6JWBkAl4z
         7pYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786371572; x=1786976372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=GEAzozgOmQKGnDJOTB54pKrS4gTOJXb9XvWOCFy1xQs/iKeT7uyIxCBW2GXaWJswq8
         l98Az/4GpRWSdN3JUhq99HprdSYSsDIqHBHm6SrS5JtESQmVBg7CLlQskkqYaNH9uMo1
         SzVX6KznfVQnKMVjUsEzxDivNw77RkvwmIs40SwJd6f5ruvbTO3lJkWvleGEAHdNrZrb
         mNRd7GjUyjJppyB2+jfUf/Kym5PPXfhAySeP98CzCnUvfJSNn80CW/FJ3PHYIVymwqPL
         z9zf0/gfl9ZPEuJ0Bp67f3JkyvvWYkP31RBpRSOyo1n+tjPFhc6GB5mflj1soPZPgtGA
         umUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371572; x=1786976372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=AHNkv9kNqlowbyY9T3GJDKrpwntNVpAC0Gayl9+2kuP9XAmOo8o5rrkwrpOdYLMYnh
         4I/d2KnWzjZIN7ziE1bl5+qmfFY8irkqKM94rOkhKruRwS6VM5YMm5LbZlRju/ybrTpc
         B0oBmBz049BeFiE4guW84UWA2dAf2O1zcUMpjpdFu4aqKOSXSgZ5UzuAvPFtJPwTG7ZG
         Yd2O85HX1ueMwYN2v13nt+fLnXEhSVVboonys/3IHtXL3c+ZXewBatzzN/7zzVFnoN8u
         g+Gt5euItL+ghR/52nf5kbAJqPyoqpoq3AJLljfHvq5ESiB+zR008abLx3gLJdUL6zCF
         +thw==
X-Forwarded-Encrypted: i=1; AHgh+RrAFg0/g3cGMPZLRMmCctahc7q0po+OAHm9YavaFdlaCC7sumsmmRX8/2XML8iz96Paqi5sPXY5ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwAXIqyuAOiVqQ+DwWQD0Kt75ysiukOMCwpD1RY4nCy4qJPlm
	GO70FLKb8OTseGuZTtAR6le2eSVIOyvbJolP+h44VD88m+J0bvtz6WfHS9G9p0HEDDJlYjLs/3z
	VvrDpZsT4rfDJV7u8IRebdktqRXcgjnwl8580qHDRp/o5a1UbQoUaaMptBgW2CkfnxNILHBhCPZ
	W5lRPfKS4iOjJsIv7+WW0r0zPUXI6zUvGKEVEAxg==
X-Gm-Gg: AR+sD108zmT1kMIcWvsCyeBlURB77B6HjfHCjbj4YZNdd7FIMNvicP7EKvlQfmrwVoW
	GkdM2/f1hGYTHwRbrTokpDllg8Ei/gzaJaCleYjEKLyw8Hx/sASGqyofj6fY3e3Xl8iphrJ3QV9
	HpywL0kXFmzcc5ynfOrsxuIr/8wfudLx+aequEnzIrIRdLa3UUcRjGF6uxjA==
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-52d4bba4201mr24354851cf.17.1786371572223;
        Mon, 10 Aug 2026 07:19:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d4bba4201mr24351481cf.17.1786371570441; Mon, 10 Aug 2026
 07:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:19:19 +0200
X-Gm-Features: AUfX_mx3R25JFulSxbPIMFamz2pIVHYPn9K-rVq3DlUVa-mxAozC_itBBx8G2xk
Message-ID: <CAPx+jO9MZTsDpofZ0fR7FxJbrfuAV+soqN3x7ttK-F7o6MkYmg@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
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
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX9B4MXqEb0OW9
 wHf1Fuhfdg59nqg01o2+4K9OR6OMYys2qrarpSaCrbo5vTjGql8AASriHnMBsNVu6HSVXZCV8a0
 +sRHTHW4aprfF9vuW8x3hUylOR8+etY=
X-Proofpoint-ORIG-GUID: eD-i_APeNDcXvan4cNLw5RNuBtpEPxvL
X-Proofpoint-GUID: eD-i_APeNDcXvan4cNLw5RNuBtpEPxvL
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a79ddf4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=IN2mYG8luz48gvOoqwMA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX/bVWZK5G8rS1
 ynC06RiF12OwSFV2t8U0MpH6MY/dfrWdCtc8CIGIK4lEvBQNAk3guIHlj/AIUOT3Uf4BCQ4DJm9
 /2HUpaqGIj1rsmNi05EepMURobl8Q3fExCzSeM84+0QiNXWQALKfcsNTHkMEWvJwuv7rE9jwqz7
 lHN0dan4cFJndImNq2EfFOX5QvvfMbG0vzDbYA8U5rfTVwMkQhc4kuTyQXKWpCFJLXmE5lKydPT
 bcEWvZAika32lW7aQvtDivJe+gugPj0zOKkWay+zijf6HbQK2569VUqS+TdCy3O61/zib1/oTTM
 PulyHiluR3mXBqJWQjKFTLmDCIipf2h7lSrQmFr9jgEyd/PWWksBkc3mpwgdOV4NO8DnCTtYm6n
 GMsMmrmU9RKLjFO/5+J7M+8CU1EIsP3I6hlWezmIlIZcYgA+eVP7XVtPq/CqoGFaU7cZTG9maUU
 fQoFfHW6aiNJeN156ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

On Tue, Aug 4, 2026 at 9:58=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.

Yes, this is indeed a problem. I recall that I hesitated when deciding
what was best here, returning an error code or 0.

The reasoning I had for returning -EINVAL, was that I didn't want
genpd to believe that it actually succeeded in setting the performance
state to 0, when in fact it didn't.

However, except for the problem below with the OPP library, it
actually also screws up the internal performance state aggregation in
genpd, potentially leading us to running at higher state than
necessary.

>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I added a fixes+stable tag and applied this for fixes, thanks!

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
