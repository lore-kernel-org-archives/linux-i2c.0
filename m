Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808705;
	b=svYmJrZJzUWEbRplGkJXy+c2jMKc6nat9u9gLky9B80KSMQJv1LifxOJSj+uDyLJkxAu
	 HfJQC3VE1b86LOZJkv5vZWtrL9soGK1mLMTqwYjPj4caeep2W1Z/u6uYAPnoh+7rW+luN
	 ngjcnkKJ/B+3BwUjqjBjQK7yOuoi9kiEgri+0tNvHDd2kq8SMA5k2pDivIFpoJnL80UVF
	 n3AWYyUfKvsyKY4jVE7hXp9bhiXdWAsPMsAkRb8XPosXq+6kWX2q+5gZLqbUaWdWGRHML
	 NkqDI7C7v5NRYl/lbXXGfs1wgNfwASdFn2mdbTb3CmCLKN4zpSkwdM3HAXKD50F8oJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808705;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5QB6POg8HfhMxcRuf7nl0o7R4RuPToIyjSP8q7zFzGY=;
	b=PcaZt/IzSDQbnnMqNBXywWpAq5xZ7hWr2k4XtsXyvNLU+EjMWFkpb4KuuPn6psnfX2jg
	 8IfPUNOCcORz+WZXRhJN9P4W2lq3lWJJqkNxK7j0ocJuaejrT0vU2IQfLIXInb+GIeNfj
	 zZIgfMLcU+t+hakuRuDjs1073TYS1BRxc3HuRtjzFlgnqCG3TNaprc9Hn2rlLuqUbZG66
	 DHlRkJmuwjhnjWWakttHIQngZMyK4dn/N+bAk5Yp92Nbo58GHNbWEQSN3KCSKNGaNYHPI
	 k54Njk1maEtUO8pJ6G/ke+m02AilUTiSMrTVjnb5jyL6KbiccI9ikJxaFzmDaQjs13A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HL3zDrgn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=El2IqZXW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB028606A328
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 16:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB028606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HL3zDrgn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=El2IqZXW
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fj1e42250966
	for <linux-i2c@vger.kernel.org>; Wed, 4 Nov 2026 16:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5QB6POg8HfhMxcRuf7nl0o7R4RuPToIyjSP8q7zFzGY=; b=HL3zDrgnV5oO631M
	Ro3PaT8ie6EQfwqRoHQijSgOKcFDtH4tbxZgzZrLgfk3JSj4kg6r56uj6bnDRrrt
	ScyF0vqH9OisHcxgvpJae0MgpBXydaQLio0ZJVG9j3/TlNXrGtskrkqlmSW+2ZWo
	xU0TdvyezwBVy7vz0pI70oZlvKNb9IC48femR6o7Dqp5cNKgJh905dqPo1w1jdCi
	WDmne/ATT7DGWZMvChAmzLZWil6FP/bqc4iMtzaeY7K30odHjDYn9qZ/etBbN9Ja
	jqK4oYFVlMganJK7VG/lFM6J4I9nVp++FG3byp+UjzBmz/u8Ss3gjnKEAxKIZrTJ
	Koozgw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn1045-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 16:11:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f26dd2165so284575985a.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 08:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793808703; cv=none;
        d=google.com; s=arc-20260327;
        b=VfB+O/03fPqLACVga3Av7nK85lnWVVxADQkB9P4SZsskjeFfX2bOv2P8fRTtfzrldf
         O1WuSg8tpTDtXAog1RF+Pt5K5RB6E3HmqRTVllO3dTMIWXdzmJ4ZEkSLRsDICyfxA19H
         tehkbQjv1UaaWKGENqETsL3VyKnaBLj/OBzQ4Gqb87NW6EVzHYUJdTPupsAZmuJoxgxF
         iat8ln11wnCv25S/lDb3KGZHjB9du0jZ5HJUNYHd4ZifzznCNF0bMQCpCS5cKKURfblo
         zP/k0K+u0ykAj+51/CotZ7yngreNVP9t4H5trz3EvL1wisoNT6+lI80A/RqjK4Shqb7c
         WzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QB6POg8HfhMxcRuf7nl0o7R4RuPToIyjSP8q7zFzGY=;
        fh=hg1PWVW9aZx8wG3YZhstUGhmdocPX0/Xe+qJffbdxUs=;
        b=BLPeuONms2QueT2TU+fV6d0sY/jrYX9ocAqNa/d6IX+yLJMy1iPHBAiv7lqXrjU69V
         W/BfFKYOf6k7IuyzfQOxoNLq8Wlsf2tzeMwCfYZ1mx2Q0oftcM49DEdDXNzneKnNj2HE
         OlIyS2A+08Kple/AfxBV8CRSKmOUvv+C4GFA/7U7Y8R/PKydcd1Vn1ybbKZMeyHY1l2+
         8rjgZ+6t2OAtB6Xmns9EQtYscMHIrkEXaNCJiBFagMqSbiBOnoEl6ITd67mHbaemgmCl
         3VV+a9a41hV9s8KLNSD1/A+M0oqUGm5ZCUPZZl9hGi+byeQaK7/41CmqHFMENjG/OXvG
         rG1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793808703; x=1794413503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5QB6POg8HfhMxcRuf7nl0o7R4RuPToIyjSP8q7zFzGY=;
        b=El2IqZXWqkDNC57tidc/K9SGVrfNUsSastdQjvvHqzAaDZRkiyFrAuM/vMIVkTVg+L
         N+iMkAyBUdQ06Itekfz50jEiN2ymXWirP1+05uhuz2Noy5oMOlITxv6gF8NipJ7/010p
         x2uuO1FtQY09ULWm75TENf1JvyJ0Oy0BY8VMzLaHhSwFlY54SIAOMRBzwcNLaaRyoAY+
         T1K9YmEZgQGcaFw4GkFfyOLagtW4i2UvUoItKuXt9F6FUiquX/rzJIPWkSEDN9mRSUNz
         JAhMQSOgwiHhAkSIrVUIa6NkJGSK33AiFXMEyOZYHL+j0vdwo16VgtjOZN16c8sHHvoE
         AJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793808703; x=1794413503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QB6POg8HfhMxcRuf7nl0o7R4RuPToIyjSP8q7zFzGY=;
        b=ZswR3qmJreCi6FGCBpAHVDOD9ZMjleCdc9M7IC9bVNZZVLejB3t2xx55iKxS5PKdOS
         SKrCuNY4d2BjyBjo7o7h7YElect614KiQhmvmGlEpQh8ak3DurpI1VKZhVfoE83zFhE1
         5Sa7lGVF8EidccQhnmNOiviidP8P9WK75uYEId75UXABVhtS5snzY9rOJ0wiHBIoQ51C
         bv/LUzUG4JwEd6d1ZBZ4IRFtVRzvgntisUIueOiRh+DzWWs/No62XsNacV8/q0i2QW6L
         wc0Xlr+WoxGozvWSXSlhaY33mkTUjOg9wsh9OdMsq/I4eMs4GoS1ly0XSCJ/KoMEU6Nb
         YjYA==
X-Forwarded-Encrypted: i=1; AKwUvBzfYpVxBFeqUDWb63SA++34XaFHr8eXWqfCn7YD0fOG0KSVY3M1DjjBKtzUG2ZLWjf+1TrH69b9+Gw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MPm4qb3gNQieZN97lkpOQ0NAU34XjrBfOjc77tCTz4S0uhz7a
	RIVBiAI1F3MCiNZeHdo8Ie5XVuvqdzVsS0jlpwVdVMHy5Dz4PQm2yBZ/pnrj4/vl05KV6BPKtsA
	LTZltZH/SUPlJJF3RkTkpWuF0+PeGwnE0hzN6Wqq/fNjG56LUy+hLsrPPaQk7dEeUo2bGdM7YN0
	rBPman9sQXo0alIv1GfNcRqVtEumhmrV2egK4qrw==
X-Gm-Gg: AYBFou2fFNUDUuFfchzrIHpyxZsszT+p28cGUFR6u+97OGokjZDfdy/vwg9PKLC1sHH
	UGpfqR5iPCozmpghorIspPtsLA9FXAUzzIC0esDpUrMBsG8At2COqaAbbLb3q75tXg8ojACdVOY
	HBEjVN8N1FOpb0B+MO1J0c3I6KgFWdnqKxk0m+WEEX01CpaJEjagXz/qiljEOTaaM4K1PkIpN+n
	vFKhItWHnweiq1QvNLrRmlY9Jv60Ukb+BaX+RIezjEA2YhfJIiDZiEhYcW6txfduMkWE+/G/YhH
	J7WM+oXTOENP1e4mOVrBtGr+Zwy9
X-Received: by 2002:a05:620a:8809:b0:93f:34c9:924d with SMTP id af79cd13be357-94421695deamr2551186685a.35.1793808702928;
        Wed, 04 Nov 2026 08:11:42 -0800 (PST)
X-Received: by 2002:a05:620a:8809:b0:93f:34c9:924d with SMTP id
 af79cd13be357-94421695deamr2551182085a.35.1793808702357; Wed, 04 Nov 2026
 08:11:42 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org> <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
 <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org> <d92a8aaa-5cef-4416-b1c9-46ecfc6b2745@oss.qualcomm.com>
In-Reply-To: <d92a8aaa-5cef-4416-b1c9-46ecfc6b2745@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 17:11:31 +0100
X-Gm-Features: AclHuK9u3BNMbXNzSA7AiOa-yyai5dEWKspQKV0NGjgXsr23U39BsLgUr6rq0Ow
Message-ID: <CAFEp6-3ka3ZKzCoLQ5BNv0YR+yhYXVRwV6G6rM8Lx_9hZ0RqVw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfXyOwhAYPgn6KI
 9fDIRYKWOyfhGCkkth4CIw+vfGFK/8jRshf3FMy4yGjM88LJTG/sJ7Hm+pHxPru2wd9mQNQHz5F
 jEK0p7B5Zbw2x9JbUgXB6X70AEell/ZGfv8cUNOyljJbZcv6I3q1dkwYX7a1r+Hw3EziXQrr2HF
 e803TvBm0IiIzgzNBRhGNRea1O6h+YqW5Zb75t/wvpWSEx/iLWXWQJ28+HTnF1P5lLoqpPN9mPj
 LnNYexj/pGFGq9LgH3uXDkA999UbIUBjTpWG4EGcPNYaICcNKuhjzgXxrBFxLpOqRM+UHv+4ncR
 jkE69F17ErDQ5QtSTR2J2oKm8q5yAPw/jwnJ9fUTOl9+PwklKlpe/9ncfqb8fQ3kIk2K5HhrpdU
 XkLxkVhtWO77s1t9gnre1XRgNIpIAJhpRagvUVzaLQ2za6Hij2tDJOP3RDlFQ+02HKltPgFw/si
 GB9ZWopvF2zwdvkX8Tw==
X-Proofpoint-GUID: o5mzxnS6Nk8PfeRwnayXyKivImcQYtwm
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb593f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=rMQDtz2esI8IZeRrkTcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX3V6QQ2nnv+pp
 ujvGPFtzL1LGVftgYcHfHsqb3J+D4Ep+VZq99XXWaGwPdXwQz6Xu7h88V2yA+lGYWwIVYV7oB6M
 24sJRCUcl7IRxycklkiVgT3ac0Nk/1I=
X-Proofpoint-ORIG-GUID: o5mzxnS6Nk8PfeRwnayXyKivImcQYtwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040064

Hi Bryan, Hangxiang,

On Tue, Nov 3, 2026 at 6:29=E2=80=AFAM Hangxiang Ma
<hangxiang.ma@oss.qualcomm.com> wrote:
>
> On 11/2/2026 8:58 PM, Bryan O'Donoghue wrote:
> > On 30/10/2026 15:25, Hangxiang Ma wrote:
> >>> On 30/10/2026 12:43, Nihal Kumar Gupta wrote:
> >>>> +static const struct camss_subdev_resources csid_res_hawi[] =3D {
> >>>> +    /* CSID0 */
> >>>> +    {
> >>>> +        .clock =3D { "csid", "csid_csiphy_rx" },
> >>>> +        .clock_rate =3D { { 480000000 },
> >>>> +                { 480000000 } },
> >>>> +        .reg =3D { "csid0" },
> >>>> +        .interrupt =3D { "csid0" },
> >>>> +        .csid =3D {
> >>>> +            .parent_dev_ops =3D &vfe_parent_dev_ops,
> >>>> +            .hw_ops =3D &csid_ops_1190,
> >>>> +            .formats =3D &csid_formats_gen2
> >>>> +        }
> >>>
> >>> This looks strange, why is there only one clock rate ?
> >>>
> >>> ---
> >>> bod
> >> Hi Bryan, the current CAMSS CSID code always selects the first
> >> frequency listed for each clock in the CAMSS resource table.
> >>
> >> In camss-csid.c:
> >>
> >> [...]
> >> } else if (clock->nfreqs) {
> >>          clk_set_rate(clock->clk, clock->freq[0]);
> >> }
> >> [...]
> >>
> >> For the CSID and CSID_CSIPHY_RX clocks, the hardware supports three
> >> clock rates: 200 MHz, 300 MHz, and 480 MHz. If I remember correctly,
> >> 200MHz and 300 MHz is not sufficient for the sensor's output pixel
> >> rate, so we need to use the highest rate, 480 MHz, to meet the
> >> bandwidth requirement. Thanks a lot.
> >>
> >> ---
> >> Best Regards,
> >> Hangxiang
> >
> > We have a series from Antans to address this though.
> >
> > We should list the clocks the SoC supports not constrain that list for
> > one specific sensor on a test-case.
> >
> > ---
> > bod
>
> Good to know that Antans has a series addressing this. I agree that we
> should list all the clock rates supported by the SoC rather than
> constraining them for a specific sensor.
>
> One additional concern: if the clock selection logic still always picks
> freq[0], listing a lower rate first could leave CAMSS unable to work
> properly with sensors that need higher bandwidth.
>
> Could you please share the link to the series? I'll rebase the next
> revision on top of it.

I don't think Atanas' series targets the CSID clocks, only the VFE
clocks. Ideally, we should make similar changes for the CSID clocks as
well, but for now they are not being considered here.

Perhaps add a few comments documenting the supported rates and use a
single rate for the time being. Once the CSID clock changes land, we
should be able to revisit and adapt this accordingly?

Regards,
Loic
