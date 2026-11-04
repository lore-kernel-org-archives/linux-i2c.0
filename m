Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834370;
	b=kMQ3liJ8G7Robdw0AgJACoy+CeC3CG04umbMPheESJ4SRNV3OoHg2AT5Eqar1X8uvs3k
	 aE+5KopeBzo9OpcHo4DSfQPYsik+s+D7J3e7yUwLuIqYtaUAtxi7u84EDXtt1fo33/Hd8
	 ijYZz9DWvOJxh37aDXA/2M60yKYk5RxT4HznkjPmGIkRrinZ0doHlr28PNLS/ChTnOQ1P
	 zC2RgRFCQ1H8Yy1Qq63hKAXOBPr1X8DHPlhksZYQZXVwrekcTmrQbKovvhcblucFpkezT
	 x61CaSEDq04+x/nzaxph3ybEXFE5L6vP+qvbjpXICQU45tF6A+wrcJWXDnw08Ra59Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834370;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0ig/7/QrdpCDxXtWkwmfBcbB/v9MdGwTTP1BzaPF+ok=;
	b=TXYWZ9+d9xLjcvv2FrgEfm9k45iuWI1OERSUCtUBgkftjxz4cjc/lxaYMTDmUJljPWe4
	 UkbRBRyI7uuYR3+K4BojP3agR9szKmLGiAcE7LcyqIdLfa5p4Omhk/odn1LACwAncmIpB
	 c5iKekEol9Olift/Sh5ilo9bMbH0xRzCEHTMTuAt5uvnXlmZzZulTjsKuR24v7SAy9bH4
	 l7XDNbukVAL3AJW9sTtDX515wf7tIo/A2HeCCbN20C5m1Xd3xklLByJBUeJWG4KhsG3Ma
	 rzeobD2cwxPHYFm9LVgicGelEH2+W8lmDiVe3eybwQxSGBZq9WAPQyF3xe70lEr3YgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394D606A31B
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 23:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A394D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso1012135e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 15:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834368; x=1794439168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ig/7/QrdpCDxXtWkwmfBcbB/v9MdGwTTP1BzaPF+ok=;
        b=ihebUH3fMP5oRD0HL4MClAyBRtSl2SNNvMu9rMW03LJNA150d/gwQjd/crWJWTKldB
         dREgrGDE7vNGpKCRuVHNu9cxwgJgj8GZVLAgTLw+s93cwZquc5abdfxRQi2asXUkIhbn
         AC4P823c34r3PlEom0NmGryefAB8kx2WMRK9VCBVZ/+iAPrtH+7BHtxdwsZGk6LNs59s
         7PDH8fiol4JcZ7V28QBdah+kkusZ0BixnM/ZpJhRYbGsxLO7KfFr+h5/Q+eAQsnKNztf
         tepEF0KoAYmXPA8rBH/dS3suvkGWL2hXD6NQTsz+NuIeItnCwEeYvNnRp2VW5D8JIxB1
         oXeg==
X-Forwarded-Encrypted: i=1; AKwUvBwv2TV05jiyoKFgkYXx71v9C0dBil+7DATsf7vWV3YkiEIumJF66T98WeEbvxcmPVYRpMIcRlknHVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nDkULbl4+fmGRf8m28ZJeu/O2C3K0HwMz4A7ftrI3cjO6wwJ6
	UzLUYobtgBZUXXYhr2fceevmmEYII2JQnk+x2VggxcXMAml2UsG8tyzuedBX/fbxWmc=
X-Gm-Gg: AYBFou1xcgTMWq6nhgMXSqWv1DTfyf8v31JprL8sFN1GtrM517D8QG1vzcIlMkVocm1
	D9IzAfRoQ9KYiNtRDwR0fr9O6MFqpYQTTKyVY6m8w3VuiujKMI17r44R7Qq0WQ1yO0vKM92w7u/
	930/oviwRoctCXpMZd+B/ZjTOmJDuOoRqRNps632g1i5lA9I4KEE4Q/2lkyRC5dKz3lQfDZ+025
	1Sp5Ldg9j1C5KIKI7N4zKJ4UJa5nwAWblQPX7WY6ydGem8qwQLlMZFcusdWUw+bpHH9XrZzEIAI
	R5w6L+GvHWwfXSg+7trrrEjHsqbwmDJv2vBzJ1Rk6IjHVFrr7ZZqqZxoucz+iFMk2AXfBI0JcFX
	ki1dVK9EsxaT/mOmaGDXtRhptGHxGkX7mEdTn6H0Pn/+CkRJQuf+8DwuyeSBS3hboe1iuIoAxE1
	BWHSTtVrQ9cHdgywVGL/RLahGEGdWuc8AqFcKlhYdDqw6L5QZjm5wABvNP94wX6FNXBwnid5sfU
	IzavDtKLk+2uXtme/23HC1o+j3wABnNtDdb0/y4Nodr7LhQj1LUp9uu/TohU4EGZA/88rwp7TWO
	ZqQZsJ4DMDKORf2a29bqOFneHB0rhubPUcjVdtP+r5tJYtPIEM0aZvzEuAdp93wqNUPrmGCNwKj
	Mh27tuTs3rgvT
X-Received: by 2002:a05:6512:2246:b0:5be:4754:2297 with SMTP id 2adb3069b0e04-5bfd959d96cmr6260917e87.58.1793834367632;
        Wed, 04 Nov 2026 15:19:27 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38dde12sm564682e87.80.2026.11.04.15.19.27
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:19:27 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1207458e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 15:19:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzYmuDLMM+y8xcyb9x/5XjglGi2ULqOM+0NHDmTiQk/AN1dXndrdoZLDZD677mhmgk/9pwTqGpIkL4=@vger.kernel.org
X-Received: by 2002:a05:651c:31d2:b0:3ac:e4b6:b93d with SMTP id
 38308e7fff4ca-3ace4b6bad3mr1250481fa.8.1793833951678; Wed, 04 Nov 2026
 15:12:31 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev> <c5405525-78ee-4480-b482-4dedc49661a7@packett.cool>
In-Reply-To: <c5405525-78ee-4480-b482-4dedc49661a7@packett.cool>
From: Andrew Gigena <mail@andrewgigena.dev>
Date: Wed, 4 Nov 2026 20:12:04 -0300
X-Gmail-Original-Message-ID: <CANn8Ume7MfDKhjdZAc3Qha7_k=CFFzaxzk5nK9Ke8iNOveYyRA@mail.gmail.com>
X-Gm-Features: AclHuK9-uWrMe0XXfFl-zEd0pTQ8lUonEa8rXy8zxcLRw3JRTxzZbTIo1byB1YQ
Message-ID: <CANn8Ume7MfDKhjdZAc3Qha7_k=CFFzaxzk5nK9Ke8iNOveYyRA@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: qcom: camss: Add support for SM8150
To: Val Packett <val@packett.cool>
Cc: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Bryan O'Donoghue" <bod@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Val,

Thanks for the review, and great timing on the SC8180X work.
> It should probably go higher in the sort order, before 8250?
Agreed. I=E2=80=99ve moved them for the next version.
> Interesting, why do these match 8280xp and not, say, 8250?

SM8150=E2=80=99s downstream DT describes the PHY as qcom,csiphy-v1.1, and t=
he
v1.1 2PH (D-PHY) lane sequence in cam_csiphy_1_1_hwreg.h matches the
2PH entries in lane_regs_sc8280xp offset-for-offset:
- 0x0004, 0x002C, 0x0034, 0x001C, 0x0014, 0x0028, 0x003C, 0x0000,
0x0008, 0x000C, 0x0010, 0x0038, 0x0060, 0x0064
- lane blocks at 0x0704, 0x0204, 0x0404, 0x0604
- with 0x0728 =3D 0x04, 0x0700 =3D 0x80, 0x070C =3D 0xA5, 0x0738 =3D 0x1F

The SM8250 lane_regs_sm8250 table is a different sequence (0x0030,
0x0900/0x0908, 0x0034 =3D 0x07, 0x0010 =3D 0x02, etc.), so it doesn=E2=80=
=99t fit
the v1.1 PHY. If SC8180X uses the same v1.1 CSIPHY, the SC8280XP lane
table should be the right starting point there too.

See https://android.googlesource.com/kernel/msm/+/refs/heads/android-msm-co=
ral-4.14-android13/drivers/media/platform/msm/ais/cam_sensor_module/cam_csi=
phy/include/cam_csiphy_1_1_hwreg.h


El mi=C3=A9, 4 nov 2026 a la(s) 6:19=E2=80=AFp.m., Val Packett (val@packett=
.cool) escribi=C3=B3:
>
> Hi,
>
> On 11/4/26 5:54 PM, Andrew Gigena via B4 Relay wrote:
> > From: Andrew Gigena <mail@andrewgigena.dev>
> >
> > Add CAMSS platform data for the Qualcomm SM8150 SoC. The camera
> > subsystem contains four CSIPHY, four CSID (two full and two lite), two
> > VFE and two VFE-Lite instances.
> >
> > The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> > VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> > layout. Add CAMSS_8150 to the version enum and to the shared code
> > paths, then add the per-block clock, regulator, power domain,
> > interrupt and interconnect resources.
> >
> > Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> > ---
> Wow, what an unbelievable coincidence =E2=80=94 I just went looking for t=
his and
> found these patches on gitlab in order to test on the similar sc8180x,
> and half an hour later you've submitted it to the lists! :D
> >   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
> >   drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
> >   drivers/media/platform/qcom/camss/camss.c          | 262 ++++++++++++=
+++++++++
> >   drivers/media/platform/qcom/camss/camss.h          |   1 +
> >   4 files changed, 267 insertions(+)
> >
> > diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b=
/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > index dac8d2ecf799..851decb0691e 100644
> > --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > @@ -1141,6 +1141,7 @@ static bool csiphy_is_gen2(u32 version)
> >       case CAMSS_8650:
> >       case CAMSS_8775P:
> >       case CAMSS_X1E80100:
> > +     case CAMSS_8150:
> It should probably go higher in the sort order, before 8250?
> >               ret =3D true;
> >               break;
> >       }
> > @@ -1236,6 +1237,7 @@ static int csiphy_init(struct csiphy_device *csip=
hy)
> >               regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sm8250);
> >               break;
> >       case CAMSS_8280XP:
> > +     case CAMSS_8150:
> >               regs->lane_regs =3D &lane_regs_sc8280xp[0];
> >               regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sc8280xp);
> >               break;
> Interesting, why do these match 8280xp and not, say, 8250?
> > diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/me=
dia/platform/qcom/camss/camss-vfe.c
> > index 2680a9914765..dd28058e98a7 100644
> > --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> > +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> > @@ -354,6 +354,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, =
u32 sink_code,
> >       case CAMSS_8650:
> >       case CAMSS_8775P:
> >       case CAMSS_X1E80100:
> > +     case CAMSS_8150:
> Sort order here too
> >               switch (sink_code) {
> >               case MEDIA_BUS_FMT_YUYV8_1X16:
> >               {
> > @@ -2010,6 +2011,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *v=
fe)
> >       case CAMSS_8280XP:
> >       case CAMSS_8300:
> >       case CAMSS_845:
> > +     case CAMSS_8150:
> >       case CAMSS_8550:
> >       case CAMSS_8650:
> >       case CAMSS_8775P:
> > [..]
>
>
> Thanks,
> ~val
>
>
