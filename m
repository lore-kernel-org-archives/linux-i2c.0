Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAB3E3D92
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525094; cv=pass; b=dyYHE7JF8f3KyDjpPkBZfIxz3bqVmfZFBpSc+CGecaAb0S/sxiY/+4cT2XWJ4OJ1U9PaNqGMBjv0DJlAlcYK6T3Vdgx6TAu3IjTzS+vbkMuDkjC4c0wR9BxR1QZCdBMhVEpTi1nK2dlpnQ3v28ViiwIOQ925IQ+K+9kogyEPYF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525094; c=relaxed/simple;
	bh=J0DBJDhPyKi4K64Ojy6y17lBqGHCMu6qO5alVMzFIw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELKzkMWl145TFnPKWJG99ZmGC2P2d8KAT2jBoVysY376UwETdZw1E9C0eVbAiq7O4PlaBCZSA58WVghZIou7mjv8SIPLNlP7yDz8vf3rWwvMkFU9qqhZycgRMlukgD6nx3IUEWR/BNsXoqlOx53lLcTr88Yo9kIc8QWMqnkXVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLN4Thzw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grKDoszE; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLN4Thzw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grKDoszE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YIG02987149
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=; b=GLN4Thzw5ppeE/wd
	AoM/dI436IbDimGs9DiOG5iPm7qlx7v6S7ZCsWR5VkX6AqY1pmkxpxFieue1OfwE
	uP6toMsp9mFWD4H8oo74JxFN9Uy2fTTcpLx3+PPSNqpAoRyV8on7fVC/V9hGkHEU
	jNl3i7/7rzkLABjCcbrgPjKcje0Byp9mHuIMQ21dnkMxYoMpUj6/sCSoshoJ0mGv
	sEebEGKjtdgAeNtkyZD6m5oYasD9OiE0K57Zn4jMExI5k71q7lRgP8Sfv0tp4RZA
	GkKGzEYPkJUm+7KevEH3JBqjtx7o6eEWMvOhpmg7vQWgQw50tIJngXLdC7yGIGsn
	jqnT/g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kmemf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 08:58:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2190255b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786525091; cv=none;
        d=google.com; s=arc-20260327;
        b=m+4IYrp1VZOF7WDOUw/vlUqEvLS0ko5KI3r3qJ56KRx2EnFyVt1qvZ+LonX21GLQvP
         EZnOZuiErZmjsbuJux3fN7gPHtSirjTWZAlDo9rMyi4gCiT4QJqmnHRhrrcWiiz+MN04
         qeN3BD9Bmgm5a7SHWLFNVtyZcAzSGwzqyBr00SDtGegivGTt957PNt29Z12aZzupTgCy
         GN58lpvpZ9qAMFFTjnLKf5HH/ypbUMjNjgIPYj+XchoJof6C6ENP4LrQB6rX48/KPBNy
         9iygir6B/NQFVQSJSI9IxMhWV2ms2Cq0hc5zzYMD64PexJyEq6V+4XudrMsv56db29MF
         ruRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        fh=nbGTUpupRw937qCthDMBSwC0wJcWRv9uXAn9GjjX0sg=;
        b=Wa9gAC1hQpJcd9oA/mt0hCZQI/VwtNnQzO15fXVDETXBmIewbwWowgMwDTXk4+5rWA
         hDRYU2YDZl/1b8SsAeEMzixL06wlWVjZESXSuORDNpXn3XD4AIyVSZ9HfJbK3sN0gm4/
         f+uh3sh6WkG+EwDAz3vzn6jwCEMf8zmJIDautoEdfVR96RZBdDRxfc1sAkixpm49lRyd
         5JR1Oyov+rt4+lLAFyAVsPi9f6dfr3CJvUjKddBVOwmUxYHTmHlyOfN7CoFrhT05aow4
         dBlWJZK/U5R9rp3BlnqIxnah8HgKW1zyi4aBxx5dMd6ILy/dKbj1dWZU+NjIlDSmlsXl
         Pc8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525091; x=1787129891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=grKDoszE4bHmiPL64Y6bp+0dIoBtk18FS4gYbk2RaWfNjKoQgbD5gN7YTKEdfUJSOL
         thFuj6H/U8RRHtEi8X8Pp39QgOo9tilaU3Ejw2VGlOvC+YKU4lMAWtzepYjXupybn620
         b4462p3hpwAZw/KIu8iNAPDX5qZBYARjnvMp4EVp4qrgMX4/ScMr5VtkBNaZYndxMOJq
         +Ur1Eo/EJdUc/Q1NjW6VewWS+iqW3T3sflf6w8MEnziw0h4adAK2q3bfTBCgu5+rwf6Z
         sqRvJYWUNIEF8e/h0D6dQUQJfvbR1A1wSNpP/hI3MJMb+0DzxKcgIQIqAmDi2ZCPRKwd
         tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525091; x=1787129891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=qEF1QSM9VYoHyZ20+uNunv8MgtDJHRIege0/Z1sF8Fol3vnZZ0+5Tj41c+4eKivbXO
         rRDUa6NbeQXj3h9/3dFuPVQsKVSxTC0AfS8VP41SM+C0IpfrMm6ujn0chh7rlh5vdm4B
         aG/DupCUdp9lk57ioSPCKrb2OaATm449Jy3BTumh1qXaTwvbcMaOiu3UO4D7nnRAkT9W
         fFZdFAZccCvqz+WtjvgCYdLFKaxelZCYLxVHfIn44IxLbhmlvK5iZ2lLeIS7uD4veBqb
         KDo8a9dZRElvgMM+A50yoDQ4Fkgk77iNozfVpQFtmcEqsLUUkeiVTqP6hFvNeN7ilbyi
         R/vQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVNyKKBbTyLWlPy2sOh+hbz0ow4exfbCnfDdpIrCtdSLNg/j+352lKHNo/pmt3NMrFe79E86Eo6x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1TOwjO3okx/B+6AeeBVa5QvXAGeMdaPOOS8uH9S4dupXD7LI
	7IGpx0fKJjs10Lp2OS7YOvxCBJRy/aGWSqcyhoeNHYJiQLDLPJuRfYOicAFiLxROYo26G0xtykV
	FBBmhtgZXyH1TEwDBqXOhQervdA2CwTRU7dU7Qs/MTbRYRtuYnLx/WAilQ0p3dpDXXlU/hx5m3/
	GgoDtttKXUz4ugDgR35cZbEGpgcYKmfxKKD/kLkA==
X-Gm-Gg: AR+sD11yQnAIW0ds04JmXvMRJuDg+QdahUxiJIcRO9XoLURyUEKG272FgZMMGZ+lhxT
	/IdY6vqmyz/6p8ppJIVC3zyh3Y7iTrr+e9RzuWqCxeVsL6wDaouMP7srd/3qvOuCSeGLCED2pwm
	/8hVHNny/FrK83MvjOrNYTR8GXxq6Z8RZVI7CJgg2mr59TSLSWDPOhulwAFp65XJzrKxwzyLyDC
	ZNtACpcMiV3rFmOPg==
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id adf61e73a8af0-3cc3f913cbfmr3419260637.16.1786525091115;
        Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id
 adf61e73a8af0-3cc3f913cbfmr3419211637.16.1786525090708; Wed, 12 Aug 2026
 01:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
In-Reply-To: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:57:59 +0200
X-Gm-Features: AUfX_myh6JDkLkJD-gnKUbWgAMFmmHbyR3eCYV8kAAVu1iWiCFaF1Y5_s5Z16ro
Message-ID: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: m1ZRnALvT6cnnIfBNU29MDpEvzYpNXTI
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c35a3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=4tH4gHCIEoDemCCG4kIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX/iH1Zi91fzu0
 OITRtVLEa3BHqlENOFFOOqwCvrLgZLRTgYM+6weaUClhAYgYXKaLRUZqY8OJowOb+j5RX1BsDww
 Un0selLBDuJen2Oi1Ma/aQA5+pu7/l1t0T218Au2V9t8z+3ujlEZrDOuT9iWhhl26N20tV6FNt6
 szyJY/kRpZPCg+bK57XIfEjP3JW6x49Qck33W82gvWbsJ//F03B5gZJ8qJUO6fVl2GX3TYT73kG
 vcYdyQZuVbBrUF4gpvX80spiCoknI4HY61/W0kkAfdzulNcB+HW8YToGf9/68+QnI/mEB+dvQav
 baaMJ1EKe6/hjwnnxcoWX1daxbdIHO6VOp/hskbGhgCMHMCS29XGEmEdXMOW6+3+s8J/MjewkW1
 cxUEmgpJ+elascQuPRTOk/DzbtgAg3MuRgdHjW0FAn858JZiWEzz9rZgQmGKqKq7UEQajsKzQjR
 BLagCXBCmyZVc5VFGjQ==
X-Proofpoint-GUID: m1ZRnALvT6cnnIfBNU29MDpEvzYpNXTI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX4TxRMD7gZrQd
 IAwK2NGCiIlvzqUokQ0NelMk29MKroG+x6DXYAafOATmKEO4uO7f781phMMecbpe8phM3k1zFDm
 KxqZCq2ELpv8DWG7/3kqAJuaZFXXVUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120071

On Wed, Aug 12, 2026 at 9:24=E2=80=AFAM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
> [...]
>
> > ---
> >   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain=
/arm/scmi_perf_domain.c
> > index 3693423459c9..e390f902a444 100644
> > --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> > +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> > @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genp=
d, unsigned int state)
> >               return 0;
> >
> >       if (!state)
> > -             return -EINVAL;
> > +             return 0;
>
> Won't this cause an issue to other drivers ? how are they going to take
> action based on changed return value ?

I think it's rather the opposite. With the current returned value
(-EINVAL) the driver doesn't really know what to do. It tried to drop
its vote, but that failed - so what can it do?

Moreover, from genpd point of view, this fixes a real bug as the
aggregation for the performance state becomes incorrect during runtime
suspend/resume.

>
> Remove Acked-by due to this till i give back.
> >
> >       ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
> >       if (ret)
> >
>

Kind regards
Uffe
