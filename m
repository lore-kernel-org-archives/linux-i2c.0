Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DDB3BB689
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324068; cv=pass; b=eTSwg7R848hWgD5QptQOSrFgauymgvqcYQZoUjReQeV2xcteugFDQZHVf9Aj7zumhU2lNc0+0I/uOv0YCFrglu4v7N5jidsMuba5aWt7GYUDuKBUa9g6LtfYOpMXTwvASviDq+FxWCUmq9rrC7REl355s+T3nEdmZiVXaIsvOG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324068; c=relaxed/simple;
	bh=9MT//ZKbS3gf8ba9ralh8FSRPAk+r4LO2VRLdZ5zo1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9F8Gwa70fghXS1TRnP1gsxFQC273senrmBvy+DE6kUerSR97u4jb9v0iviDWHAcS/gn9g/hHNPnKQPT8dvGZKzZkuzuiMZr2hjrRA4sZGr8YzLtCs2te2GQbIKitvp21Raq2m3vmxU61Du1p1UBtx5st+LKM9/arSESUpYyAAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYSeQywf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKFXRqJm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYSeQywf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKFXRqJm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fIsL1257639
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 14:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9MT//ZKbS3gf8ba9ralh8FSRPAk+r4LO2VRLdZ5zo1E=; b=eYSeQywf7FMxqrQk
	od7fVL+a15CjGgOjdKZ9JrJ6YgjM8H3b2KIHu1wZdwESi2mpqdqdk0gEILmxUiHd
	z7cILavNamfurl9wlRFX4dJL7LgBTviAm3kNOZa8ZsZNKq6RmiTRn466q+SngTqF
	MKkap1nUOcXGSGemv+DzXT+Bet7+QpfuoovnXJmrziUq3MPPtbOP587h5B7hJ09g
	w2R4AMcxbr/duIUgGGpmFUBxyAM+pcfI5jDVqBE584F72S/9lAbrV0FpLLF7+8Ix
	W6m3+2XO84Cydmp6MgZg4CdmVCBeXCk20G87YdSUah+HAZSPz3t5QClstxpP5fzO
	O/GUJQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6ssscf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 14:27:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156d10aebfso90059385a.1
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 07:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780324065; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7DpQ0yGqTWHSBSkvR4CYmHN9jzsvFUEgoC4whZ/qS9hfsk0fJia6aYp5VqM+r1RLx
         Oi1zWDQHSl9r1q6oy9pZbF5NbhQH+kAXV/ScHZ/rL2qVSAhg5cwGLFfYaKopHPSecVna
         UcdqzV33SFcspyqJDdC+zscx3SFL1GnNAr5CS89V17Tg2/Jc6MP29p4iJnboIETXm6Ae
         s/MXE/9yiOBe9wo6FemzOWmvOdgGJPIt7y4jP4qrTUizGcJWappKR9lztPTsiz63ftqM
         afYNBMKNREs3M5pkjZpnMUEYGiSQoWGqxXaVpPh5+3SpRF5WGdmNumYq2gEXwuk7y0Lt
         nF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MT//ZKbS3gf8ba9ralh8FSRPAk+r4LO2VRLdZ5zo1E=;
        fh=Tg/t+Fw0g60eGU5smLKwMBbfCxBU3xRaUXQtfMNM9Xc=;
        b=dgnOcrKWQgSW5xIZEp4vO9lxvDpCYFbnMFiTjJY5ntE6PFLNP8Fre2S77eMm4WjkAP
         G9E9vVwcvcm0ofPOBoqCDeGHxqONPnNPoWVfmEeWckaForHLhPzZkFTVtCtWB9p+eO6+
         5+NiNX1QAPW/JKbY9oAKFUsBIzba2N1VuslNyNCD6Z4ctQsb8zfbojhO4xbPDCUyZhjB
         bdKU+roEX9qldEsI3F6mFD4ebkyPDmCTjF1XD4njz9wf1TY6D5v8OZfkqSyQv9STHbk9
         1XIp/X5bkFHVfdwIr2LEzhSzIO3/hWYhXkKV5AW1G83k/Z06IEq1cdU7t/2rH4rdERuY
         d6rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780324065; x=1780928865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MT//ZKbS3gf8ba9ralh8FSRPAk+r4LO2VRLdZ5zo1E=;
        b=ZKFXRqJmBAgulbKGv/wfOvm/maOrMwM5ZsLytEhBL3KmJheLaHVfxANoL2gajheQoN
         /J13EibTMuOnY3eUnsuEfBlPSdSV1RxBzNmGTGR3NLyegByMwywSfiL3FKDqdqeuTg8C
         UjLTvMArxtHbY2OZUoQIut/vZk+pedCwq5++fBgKaAN3x0Xevp+ed6ljzAX7FZiQ9CU3
         ISbQMFZZLfOepM2Ln2zuwbW9K/Gdltfj1u0UgHqOc1Av2wKswalFHvI0ZbA8c/V5g5Lo
         LivHI1DF19JnjWNAOq0IbeJ6DBA3vbHz1ul7nxM4yOh1VuWjSgBk8O2aZ1lXQQPeReQb
         lExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324065; x=1780928865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MT//ZKbS3gf8ba9ralh8FSRPAk+r4LO2VRLdZ5zo1E=;
        b=XEIso3xgk/jxZedjHMQ0iCh56eEAsGRQ4CTVMX5BkEN3q/0WvpYieBpJ0EWqriYyss
         +KcULcdsNvk3TRxoytso2eHEdgQSAssDlBQJqOWDbOU+8R9IvyfDZPUn83EsEDao97iU
         NgXpj6I2RpJ8DY+qRoTnClZif+sfpe3ET91KELtp+/NHYr3xm76UugrnB7iOvUvson3k
         gx4lb907QXSWD6KibX796xEeGNSFBe9o1H2jkDu/eCE1s/X3mVEFsYe1e1dM5x1RQMFj
         QVB7HQnv9U3FHH+3LWiXdX6wiqF553w9Ms/a+JRR+/t4bs/zd5AigaEfaGGQOxBUY+2I
         1Kyg==
X-Forwarded-Encrypted: i=1; AFNElJ+MU+vHO8P03YIKUMf1A/s+y5i3N6x2Gz7kjn6u4diyHSo9Gx9bwAbVV43u7JEwQ4kgisaizYmedXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gMnjKpq2iXCnEzm7JN4ALEevk6cM3i6bsYgO3F8HGYSwvfEi
	DA+SUv+qtgHvf890jAA0tr+/GaTzkkaRiC7jbsw7PTT3+Lykw+BlT4ZZIGPSHnI8AVVks5bdw2T
	GeRv/s1wCwb5lSVXouDZDEQhdu+A75ydgrTL7AFqHm+98DISBclUU/w2zfJwKG/jfBuI/THn9vS
	OYljx0zXce9Y+SdbYtksypyztMlH0DEuLGFPZErA==
X-Gm-Gg: Acq92OGvVg8GM5I5zkmHXeLWdrzXnpkEoalB/Y6VePYuGG2zQm+Mmo6gV5GBtPhw9fG
	u1eFkgIrfxtX8pm4EnHsDv12BAMdHmMbGjZ3BxKg8QRWJL2UkRGV092F4wxisRlkEt7YLFDtH6o
	Ckt/icfiNXuvCbDpelBfja3kHQMqyvCWfkftjf51RaJsZFe0uPpFjLW5dpUhl6J13FLgMLs65Yd
	mZfeVOgSmw3+LBAyId1nzz6Ul3WxcXMinroTFVe9+FH7A==
X-Received: by 2002:a05:620a:231a:20b0:914:e3dd:17e8 with SMTP id af79cd13be357-9153d938aa6mr1215101185a.8.1780324065170;
        Mon, 01 Jun 2026 07:27:45 -0700 (PDT)
X-Received: by 2002:a05:620a:231a:20b0:914:e3dd:17e8 with SMTP id
 af79cd13be357-9153d938aa6mr1215093485a.8.1780324064677; Mon, 01 Jun 2026
 07:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-4-645d2c8c75a7@qti.qualcomm.com>
 <178000689150.4557.11759359941436928903.b4-reply@b4> <df00e8d8-21ab-415f-815e-608eb7ab0967@oss.qualcomm.com>
 <23d2a824-e894-4c26-8bd1-02bbb8a7c6d1@linaro.org> <f7403443-3c0c-45d2-8235-46c70883a296@oss.qualcomm.com>
 <203e09db-ba37-4d75-b984-227298f55d80@linaro.org>
In-Reply-To: <203e09db-ba37-4d75-b984-227298f55d80@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 16:27:31 +0200
X-Gm-Features: AVHnY4LtL5VPWicujYWGAL868BWzmKvPSaREWLjiMCcMMmubijXxiTOJv64_r_I
Message-ID: <CAFEp6-3prh88NTK5U1HAARmQr203LVcbW4hoo_zuK4Qof4BAzg@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: shikra: Add CAMSS node
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>, bod@kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RkCrXge7k8DP9UVblMbTZ9-49dFcqa8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE0NCBTYWx0ZWRfX5pV5CIP1O47j
 GjPr4fcVbUNaN/Zjvdu7tLui//z2Ek3jdcdUm6tAO947nx5HUnCW1vDp0JEUvwlf+RMslxOX6ef
 aQPnZVmWNMRsngWtBMndb+bieFb2DtYy0mPOMWofND+JOo9ZKraEbjbhW694lY8ggRL0mKdBowK
 AOvt7UdgwzPCUnh1HET8O5DjCq3H30laljQ+luDzcvwfy1TE6GQfcMCt7K/Er5p0Z+j8nawHbip
 3HuH58BfMz4iMkfKkqZ0DR8/hmMj3b9qzvzZx8VV0CAZ/InA4DAWIyqcXSabsK6Il8Cu6oxvPmC
 dAyV/4meYi2hZHguLuNkxufQa0MT9DX1AOqwLb27LwMpUnDt19uufUES2/TxmSZzUUJEIHxGGrz
 p2ugH+djOBlkG5XwgK/9B6oOsK5Wjn2cbrEpUQvUF5WkQM6sWtNFiVDA634q7FiYU7T59VCleoB
 qBDcsqOEvW9dibpJcGw==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1d96e2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=6RP30FUjIQ2jcUxmk7IA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RkCrXge7k8DP9UVblMbTZ9-49dFcqa8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010144

On Mon, Jun 1, 2026 at 4:15=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 01/06/2026 07:42, Nihal Kumar Gupta wrote:
> > Here is the full IOMMU SID list for both platforms:
> > Agatti (QCM2290):
> > - 0x0400 0x00 =E2=80=94 VFE non-protected
> > - 0x0800 0x00 =E2=80=94 CDM non-protected
> > - 0x0820 0x00 =E2=80=94 OPE read non-protected
> > - 0x0840 0x00 =E2=80=94 OPE write non-protected
> >
> > Shikra:
> > - 0x0400 0x00 =E2=80=94 VFE non-protected
> > - 0x0600 0x00 =E2=80=94 CDM non-protected
> > - 0x0620 0x00 =E2=80=94 OPE read non-protected
> > - 0x0640 0x00 =E2=80=94 OPE write non-protected
>
> What this tells me is that the Agatti binding is incorrect for addition
> of OPE as a separate device.
>
> > Only VFE SID (0x0400) is shared between the two platforms.
>
> Both platforms have the same IOMMU list, its just that you are
> correcting a bug in Agatti's defintion.

Yes, Agatti is declaring too much if we want to go the camss multi-node way=
.

>
> Again only IFE SIDs should be included in CAMSS...
>
> > The current Shikra submission enumerates only the VFE SID.
>
> Great, this is what we want.
>
> I think for future submissions we need to be commenting, naming,
> something each IOMMU entry as we have a problem now in Agatti and a
> legacy problem - already - in VIDC as a result of misallocated IOMMU
> entries.
> > Should CDM and OPE each get a separate YAML binding like [1], or
> > should both be part of the CAMSS YAML binding? If part of CAMSS,
> > please confirm and we will add their SIDs in the DTS in the next revisi=
on.
> > [1]https://lore.kernel.org/all/20260508-camss-isp-ope-v3-9-
> > bb1055274603@oss.qualcomm.com/
>
> Yes I think CDM should be a standalone block and BTW use standard DMA
> APIs with its own IOMMU entry.

Interesting, so CDM should be a dedicated subnode as well, and not
part of the OPE?
Then, If we want to use it from OPE at some point we would need some
'cdm' phandle in OPE node.

Regards,
Loic
