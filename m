Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5F3BED54
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723808; cv=pass; b=k4p+Har3T3ymtpehn519HlRSpnjtJXu1VQFvZbQxwNfFoNyoPTebkpNCb+lkm/CGBvxwQ6+2zWPN1m8zeFE2xmk3nIEzh8wOIxFmJa1K4OeZtWuUqHKZfm8obyWnx/AeNoq5eDHijavd7gpx/OLWSy34VoUi1BTvY5GLcme88zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723808; c=relaxed/simple;
	bh=crHb5t9mPgAi5vYjc7XDJchLr+niSnAlhOrnEM7Lf+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukYbGsvjvixr0Oa9B44qeoOqkghH9PlBIij5zSpUNZYNpcET4pDpdaJ+WDxJhjAPXWh3kC71ytl6wZF/nry18Dbj4dlPHoGGfgCBwXuSXrlptJfVoWxLAnbVmo5Ys3uXwHkMx/mcqWb0zbZ39oUqTYjE/hUOZy3lV3igZiG9vms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGKuwQU6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P93iFh5g; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGKuwQU6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P93iFh5g"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFkBk917166
	for <linux-i2c@vger.kernel.org>; Thu, 5 Mar 2026 15:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	crHb5t9mPgAi5vYjc7XDJchLr+niSnAlhOrnEM7Lf+k=; b=RGKuwQU6DOFKhp6l
	6dghomZ0tp/CLz+XHH/lmZ/E+RUEW9c41u3zq5L5M/UJCWXqo+3fowHrsxw7KQIx
	zkhT8/NZSMn6mDoSMgB0h++rk8qjUchFIYj7E/s0TD0iJYt2BWhFz0vviPQYCGwr
	FVCzPjtMyrensDOqAQ+8notrnBAzBgZdQyBIiYeUYKdcrktOzD7u3A/hsEDweZ9s
	8obb9y7POvg0xPzyLAYP5q25R5t3BVX9XheLlSX1c6IRncruWnBRXwr0y7RHoDde
	73ScNiMu2kWQVZftx96Jk25rkiSdnIuHcSEpSgfIOwo3ClZWC+2ZXqdeE4uZX3iD
	T6cPWQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380sy11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 15:16:46 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79868381229so158647167b3.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 07:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772723806; cv=none;
        d=google.com; s=arc-20240605;
        b=bgcJLdtxnzlnU7pEb/mwmF7MixFX8oKEjOGHofeBKc9nPumDFyVxcbl9Fk/lrrto+P
         vGgi5Ie7tvD36yvvvfTLFfjwXxQrLb8jQuJntTuGfaJv9dEoN+CUf0kVN/Cp7/xZlQ3G
         weSvQorncEfDatejhKCRxi/O2TfCo25a2cSmVscySCImpWDoGguyvn8nkzg2Vt9MSruB
         o2ui+DN14PsppsW4CuNkVPCEO8M48C3YqMWLbwVwM9WXV+Qwsdu9x0+KKlyF7xFiOA/7
         9Xryk49+9vjK0CjvogoaI6tGBENxfU5CQWNKfAlZN3VgY2xrkxc2yB2PUHP5LRBVSkae
         wxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=crHb5t9mPgAi5vYjc7XDJchLr+niSnAlhOrnEM7Lf+k=;
        fh=64DK6dCt3iIzY2owWaCbbSWkA2sax065Y8C2DW7iQgQ=;
        b=DzWtoqjT1C3HOfuCopvA53QhMF+BRqaOt3kw/v26ta5wFgCihC9fnP0fn9MbhEWtFD
         tEHFmMikJ04CvNtHN2QXrDAFp1iITn91p8Ix6x4SAeyWzRUeBFqBcqV9Mj+e3PqXdKoQ
         zF7SIvTfes0mUudHbhOuvwbHIPL3pWsJnHjv1vD630zwDwkfWyiWB9ernWOVtk0Qvp0F
         lAgyvOb5NnadEj7pSnJl5vlfxbZ+28+adHKcyqfh1Zha3PvfnIXNnCoepQ2j0WUUc5wj
         w30ogwPH+V7n/Lu3SeAWohHrvol/znn2ohV0/wi+qQU1/I1kvLDBSNn6pawUvFsWTbtW
         3xYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772723806; x=1773328606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crHb5t9mPgAi5vYjc7XDJchLr+niSnAlhOrnEM7Lf+k=;
        b=P93iFh5g+Nadt84BAPmZD8PYkfWg2EJkV+lH/NNDt9Jnl50KV3H38EtbSRanqYpyUu
         /rTwK8gxUabII+LDbwRdBpwLBooO4HfebjQGfk+kBk/XyvoqD6tGELyU0/xs1wCAxAZD
         nqIR+5lytqpyRkX+cwuqCvLvo3GIukcnWJA5JLGFli+h3GFpazJtyx8a6sp9xebS2Rbk
         FsZXCr452RNmyBubV55RB+/LPHs92KZsTV6Dfz0EgiMhHrZ3MsEh1yu5M4vuvNe3ntI7
         vSqk6Ti+AyccmUTHhXA+SngGKoi39jA8Ix+ORi8QDrFivoQqjulbXjpZa2934eDalvpn
         QgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723806; x=1773328606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crHb5t9mPgAi5vYjc7XDJchLr+niSnAlhOrnEM7Lf+k=;
        b=uFY2GRGvCkJanQraw3u7e0mnYiX+sxicf3eE/wHH/I1U37VWkwGJVYgbkyoudWjynC
         hIToqSPI33TZ7AE2FAaaDiSvDmuZB8LeTZr5IA5ptieuiGfAapGqIJqeO5NTPmOiziA0
         B8vp1eD1KMLilkr7q1ve+/NqMXUhLD4HnwYi7v/6GpLE9g9NfifY3I4n3qPxP+R4ZjHi
         bXaTYr0ri5A62QkHuThwZaty3meNbIbA2HoTo1PcharcB/UDM6Ja5p9tEPQLDzjQHENr
         QNZYY/ngWHfbGgKAhGoNYdNsBO1KvVc8qAdpxKy5AVp5NE6EvyazU6hneHtd85Mi6lhq
         Xa4A==
X-Forwarded-Encrypted: i=1; AJvYcCW/xBK2NdFk3TDZXZ3yGK9semkPvIUUrKHcbQEDamqoxZ21V+Ww9Tg4HPPQitPiLBTovmM6eu22dh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeFPG4Vi6kCuVlX7Yh2Lkkueyv6EosBH4EL9w2mtauA20eIpP
	gF1wI6Dbcftz4LovsbFmEM0MhCtRRDD7vIiF1xgxr3GtNmYxf/Pgjjul3o6t1znWzvpjo1uZ55r
	QCHVB0kAiu9YAxOJJYmnZJ5jAUO6XbtU7svatT3h9Wuon2vRzrL0pVLpO6cPaMNT6+Y6lkvg7BE
	v4aNXxyyiCXAmCbQmpfSZ7u0QD2zUGtJMf+jfB6Q==
X-Gm-Gg: ATEYQzwexkczinZ/hsIEX+S5rIisyUkgFJVC2znargrotTZ46f8YtqNIfIo9Lt61zEr
	/UOasEc8x8su48WVPfAIoTb7bM6CYaJqNq8Xqz9wcpJTs0eDZeNpuJBLCso0pPqnAUVAO4aDosz
	4YSVgo13rMT6M0x1QhQsfi5uM4GxDiTSsYsbpJwHYM0DX/zey/xqZe7q1GoV7ubOkjgGSDFalfD
	ps9lvTpUdkja4bMlxvFZygQYQHtCcmpekcYek0=
X-Received: by 2002:a05:690e:1443:b0:649:4f58:5cd2 with SMTP id 956f58d0204a3-64d0703ee7fmr1901176d50.0.1772723804457;
        Thu, 05 Mar 2026 07:16:44 -0800 (PST)
X-Received: by 2002:a05:690e:1443:b0:649:4f58:5cd2 with SMTP id
 956f58d0204a3-64d0703ee7fmr1901121d50.0.1772723803824; Thu, 05 Mar 2026
 07:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
In-Reply-To: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 16:16:31 +0100
X-Gm-Features: AaiRm53DAsBS99uru1n2DlZ8zMVjWH8FImgxyp0FBOXWU38dtecZYRBCGYS7V2Y
Message-ID: <CAFEp6-3ZuSOW4apj2Ww2DJ5_5Gw-CDXV_9Qc2=wW-JLP8Vbatg@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: qcom-cci: Add DT property for SCL clock stretching
To: ckeitz@amazon.com
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a99e5e cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=S_SDiGbfBHtK8l1EkXUA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: VoW0-NBMRyDkZ7x8T3r0bA8B0QZ2asyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyMiBTYWx0ZWRfXw1IVqyp0gZxk
 U6DWIovpOXAWKU9esZekcBYKSwC8VYII0tT04SU/w3K/zkK04tIKuG7o+/5O0lyVqCMsGNW02q8
 /28htl7PZRV3wp4k0JbNQ1ZzUqy5JSjd9ttpIh42hvdZqbTa7gHsFLOcrHIpvEmt8a86IPHz0sg
 vEnPRIPv9e9e9ayFOUw+ZJWnivhMWtVnm+89NtSRo6NGU72kSti9woOOuhgJTTNeePLnqrd6qOX
 WCh6n9xEzy1f6mIgv3C6vsDZXJUQdUH2hTxlSgHGjCa4gmkFbfqSi/34RDu7w0HbJMY8UEC91wL
 cgmAB1gIPu4+vfweqMYs/zEFkuc4Gzs4dFWpbGX8QVWzGpybllw+17kyA3ABwWpymUqMlLbBCRG
 MCNcMWrM7px2abpc0aHjWng4L3eiZiZ+bBSZlJZOD/gN7+lF4t1IL547fNkej1x3eslbw+p3jWB
 YEUB4aAYsKuPGwquEWQ==
X-Proofpoint-GUID: VoW0-NBMRyDkZ7x8T3r0bA8B0QZ2asyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050122

Hi Cory,

On Thu, Mar 5, 2026 at 3:40=E2=80=AFPM Cory Keitz via B4 Relay
<devnull+ckeitz.amazon.com@kernel.org> wrote:
>
> The Qualcomm CCI I2C controller has an SCL clock stretch enable bit in
> the MISC_CTL register. Currently the driver hardcodes this off in
> per-SoC hw_params tables, with no way to enable it from the device tree
> on a per-master basis.
>
> Clock stretching is required for GMSL configurations where the
> deserializer uses it to absorb the latency imposed by forwarding I2C
> transactions across the serial link. Without it, the CCI master exhibits
> intermittent transaction failure.
>
> This series adds a "qcom,scl-stretch-enable" boolean DT property to
> individual CCI i2c-bus sub-nodes. The property ORs with the existing
> hw_params default so it is purely additive and does not affect masters
> that do not set it.
>
> Tested on sa8775p using the qcom,sm8250-cci compatible string with two
> CCI buses connected to one max96724/max96717 GMSL2 pair each. Enabling
> this property eliminated intermittent NACK errors during serializer
> and/or deserializer probe.

I'm not convinced this kind of hardware behaviour belongs in
devicetree. As far as I understand, clock stretching is part of the
I2C specification, and slaves are allowed to use it whenever they need
additional time. Masters are therefore expected to tolerate
stretching. Given that, why not enable it unconditionally in the
driver? Is there any downside to doing so?

Regards,
Loic
