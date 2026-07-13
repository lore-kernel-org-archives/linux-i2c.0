Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF13E6DC9
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938560; cv=pass; b=dMQrkxQtkgZqkWVtBEEQiqNtia9p87y0Gcayz35hRwrzwZqKw8/gO2Fzc/+6+5d7mD1pGIaF02dFJKjUyVm6r4UHv/z+yYeqfsekw2IbpWG4x5IH3W/sHsejL4oAQfnVog739QnrTBYRh+zwhWz8SBD0cK8h5dEuE4eaTza4cL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938560; c=relaxed/simple;
	bh=g9PH7rit3zO//u5Hq2QTKSHhPM7nodoH6Z5rCiQghkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tez0b+4ACK3dxtJwiTKsk6em8nFMaoNHz6TPJJhZNh7biEu+TG4CQ7xJl2Q6yBrmvLUeL/Y19zUqOQvbnieHUio71MbiNzXPhUQHnvI/hB5Z954x5CSZLTRLRd3+544P6XYVctwYO6KLk1aY2Md0rTgPqt7KYIz5Bn0OsuGBPXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNFOxgh3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G7kxtqMe; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNFOxgh3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G7kxtqMe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9dxJf955934
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=; b=QNFOxgh31F+aQwWH
	ovN+MuWYrQupUnEJ4E05qCBe2S9rP7KHAIzWX8QuWwVLkBnQCTy1Hz9uUXC1S7DF
	8ziWPWrYXfAPxVQX7yIQ90tkfXiCc0VPr519QCrHicbq5mx/va6EOAY8OJvHnMC3
	RZF+ARzvL1gWrkTRgAmMOSEPMRMgnJsk3tSucarsmgrls/L4q+xlgyoSuIM/bgkt
	B+B96eVD2U0ghoOzlEzmHlymMGN9Zy4snq+v8VItrjMOWQ4hjzJIFO+xwOz3UgBn
	1yZtKxrH/rfPDe0dXOHL2JQMVO51Kqi381IJox02JTjVELMpumm0HRsXH/c9hr2z
	cyqT8w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9r5hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 10:29:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0f45415cfso49161596d6.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783938556; cv=none;
        d=google.com; s=arc-20260327;
        b=ZSOar/OyEc5XLluvePBmpdOeEFFXr2EH/W+sXvHo+ApC6fMsCO0gSI1KOyfGUl+C59
         BebBqy5rKZKKnLbFI66h61JAjdo6wF1tNRJwjTPJiZoxXbIjVC+C8N8N/0g3FrhOT0sp
         D+yjPtos+OsNP8I2OdvZDQlaBFtrEd2ER7hk6xr9OIjNalFTuDM63mqehTDNVg3jKZZd
         SWn3nTIkOc0ESmoZ95xL7gpYRs5/azFnoY08280mp6KMZi1Ubd9E7dwkgD2tLcV4TuEH
         kZxM5ifsfxqfBD9kkhRLMPbmmhFSyyyhF+8Ayx4IGe4Cn7TVPjaSSeayuTrcV5Fhapvo
         Y4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        fh=E+cn5eXaznwXRWQ+NnTXsQ2T1Dyo1DBe6mrucP9F0lk=;
        b=I+5cV+WnDtkcCpLsYvQH144at0FhbzDcLCIGjc8NbiwJIn7B0GlHROuvuwUPWwFqxF
         pr/24YhLakEicvJPNtcQeg5YHEmsiNl2mGEWtCZTnAL/5RBUVRrhz48fTbfJMnl95kd+
         FExBG2ZHb6TyHhaKiuUa4rQ6KniLR3Q4Ko6wkR8HXBm4V45YsOHC86ACYQtLXFm+eX4h
         Dt7qLgixUkmaQ+4sGbf+szL0uU5jMwqizZBjyrO0iybwnENy55XfPlQPIRsqxo8GgR+w
         Z520twSp9I8GztUZaz4uMz9lcIGoLSKbolHrlIV3VSxR43+a+Li3BwjJQ0uyVdQzvL6W
         gu1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783938556; x=1784543356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        b=G7kxtqMeECI0wOjoeOfWjKvWJYaxKH8+o/+b0CGIY24b4rLI8qDRn2gIv6OE/ADOj1
         XlwAlTi0gwkccLwXnu+CRigYuCwy+6AJ/6B+TkPFlVhA+taQEGm+YvbxTwchEJE45Gq8
         L8fsHp9VnxaakJLBLhDvesJzRb0vsSofarjdE9evF3g7IzpWRTrZP0awjtr12lS6nHAj
         hRuS+rJAHKSP1Js83ha10t5eyEERFD1/6mtETfNKxhVzYlRdaeaJ03pD64actt9fwo1X
         oLIr0yJkOj6jBWsAUK9FSujDVn8dDqWyNJ0H73aI5ytp/ZbiSBjeGDwJfAYKU+vrfh0O
         ZvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938556; x=1784543356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
        b=rsli1BUD97vpGoCZtqmfZ9I6LTLbH8EOhmoD7auNkqsb8lxH3dXnsYCYIjUTnozSYb
         KX88xaXtw2idtlIKZsrsU4wSc0aLSy5fVGPo+oiM0w49bgM2q8hQEm4h14cgPm992i4b
         8tiI49I+8nZAZ8ahlmkT5M0ogf2hZ0AS+DFMo9UR5t/oVhkQHKpkn+C5U+AGtThdZvJm
         hBHi1xYo1gbysnThsqrPnx3P8lsHomCmQfJqepu5k2GOzc16XysLsN8KICpOS9jjEEx6
         IdL0bxLV+UB+WqaAKl8ingWQBKPe+15rGhepthaWaslgQkq3H9u5PGjtlEBgc1pXkEMg
         WXHw==
X-Forwarded-Encrypted: i=1; AHgh+Rrz64OFuhu7YZdgtAwsGClfMjzicSRQUVVYGcbkE9b+BwXK7a/uGmzaeYehQUmUhysfy5zkgxThHek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcHZ0uHDeKKzl4l70bS2B+onXRXS4jNHhKC+JteDaNqF0xFma
	l4b1mPbHhKDmdZNYLLQZfazu+Ten0vzoDo7Cg1rbQdRoEogzweWy45rosbvYwTxa7Rezxnr865r
	HTDQ6dNljFPRWZnLmPjsasVLPHX3HM76U2iGKC3VGZZNZpFKfzgoCB24QeVCb1K/gMGJ13qTQed
	nw/Kcx5DWeHKC+9B2XGcyINxaWBaheuO0LDL/pUw==
X-Gm-Gg: AfdE7cmV5A8hRij57KE65LuNIptXQVK7wjiOpvRWFx1Rx64PyB9cR7Eki892B3lW2/g
	Acfjm0TBWWOE1e4hpkbDevPhxBvoyW+kx8lIcZ5McQy8t2NhZ89/sfdbUet7H85UfzperTTc3yk
	06pH2fvuaZ6/GnmBoE0aVsTmh/An8p9IfB0X1y0SqL7EIyusEPPnYT2jBTwPBQd+kv8wC7
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id 6a1803df08f44-903ff76144dmr97564346d6.1.1783938555885;
        Mon, 13 Jul 2026 03:29:15 -0700 (PDT)
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id
 6a1803df08f44-903ff76144dmr97564106d6.1.1783938555502; Mon, 13 Jul 2026
 03:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com> <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:29:04 +0200
X-Gm-Features: AUfX_myf4-1EuuJEsM9iEruoBmhvEE1_shBmpnLHYi6rPSO8vgxEgiRb5eZm2os
Message-ID: <CAPx+jO-P3Yt6T5Kb97MjmMB1mYeEgjStCkSACM_wsrqsBVFEvA@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] pmdomain: imx: use platform_device_set_of_node()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX4sQTeZg/w/lo
 7ngCHuV/PNk1elPgLA5+4Mt+huzGTOd+I+2HF5SjKBx6JMf0/6x4vhBRtlCbCfSWCIzyhjVptsy
 Y3pufcHoACxDi6TrDtllapXtGDiTMVSQmN6ejwp0epG67B4aaciDQOD5XDBh+mVxwqVI5/03ayR
 llGuoPKIEX11UNlW9LkDsh9wI2WINSJhrr0C9NZ0KS75l/2JzrLPplfw/fmZXJWCkSWalIMIn6o
 4Vf1nn0M8A59dKcJ/BQtdYNXb1u9FYYel8YnuZzzAWoFncn2F+t6wIkEzdDzE3tJ2PNJ2SB71H5
 Ip6w3gOCf+GvX18Avu5EzNjLgKtcLvfNvyMxYGa5T0qTaCMyR0j/dGWm8t/B6WuBYQGpASJFGMZ
 +HSajUs4tdAxTd49ZSa7WghzHzSdsAlMcyva3wwVrWCoekuy76BFb1NA8pbnLfRtF6veZyMdMlk
 6Cn8Ju7AImBwjNFJbUg==
X-Proofpoint-ORIG-GUID: 8rHWOdGwstwoeo43bnivqoENF-Kgnq17
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a54bdfc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=-ghbRyKqcrg4NgclPfMA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: 8rHWOdGwstwoeo43bnivqoENF-Kgnq17
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX9rGZisY1EyM6
 +DOWdYACQQoQeedhPE3ZCxx0d/ReQTl+b5PwPOMHBLVEbRuPTNxmCHKQLqcxC49Z1dSQNfFnifV
 i85F/0wTk3oZHCkQv2bYnHCh3r4kDNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130108

On Mon, Jul 6, 2026 at 2:45=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e=
1395c413160c950 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D of_node_get(np);
> -                       pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
> +                       platform_device_set_of_node(pd_pdev, np);
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
