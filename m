Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFA448BAF
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905629; cv=pass; b=b432JQMZTWQjOcdtj1a2YeCY3zZZbCoH4ClueKzz5UN5ckYucoTH7SUEaJGYM9nlZ2aTnkKoyqTXnqvG2RhEIKEfaAHt19kAOjO9ocsT02NWxG0JDytL+WL9R6tfLXiSGeJkG7Y8rxq/RTvwRH9chBUheeAtgFdJdUIiu/0HsSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905629; c=relaxed/simple;
	bh=TqF3wLHIA1jAdZt0Tltgjjcw3xRF7uJIwJwkCK9UGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4u74Lvj1mlW01ldHmYUMahIPinD7eyhxNomMoRIZNmQLgt3z0NHMMLWLnwvxzWkgIZ2TfpDJuatY3R00fMpOJQRR7i5W99hSKGbfIa54Et2jdgvoYE/+CK6Q/1EuToolxqllPKiYkhRfdQQy9yQsFgyo1MjKKjX8bJmVY/uOpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMNYH8YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxpEU75B; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMNYH8YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxpEU75B"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbDVL3487371
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=; b=CMNYH8YKsP0vLnKa
	kg5kejSOcOGDDykg6w4NaAMhIZjMwg5Hvpg2qVVAeGFA6SXIkFXHAI/V9jYZZTSy
	RttEgtp4bwm6aE9p1KGLNE0/MB+O/oivlVfzYqqXeDZ/TYz39Fv1fPEUWjQMmKmB
	ZOhZL4fM89UgzYGiONz5xZQQ8LEp9cpVqsU7E9WNOiG8/iFseatouKgfxZnlVqh6
	rWFhOjCyVDJkJyyzui4Pk9uGykx+T9GFLHJOTV+t4bciz5za3v7JZndxoHiqDk4w
	c6pEZ4xZYfHEQPLIJ2zTQeesRUAuDTSkH8JP6vyj4qfAeEMOO27lPxff5lNMPRVs
	QuKvrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0cagb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e632390d2so75677985a.3
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905624; cv=none;
        d=google.com; s=arc-20260327;
        b=W/UTPq208PZvROxoyIZeaXGpudQqRSANyFH53hTup7/BwbpU0PuJucuBnA1rWLfq55
         4wlqbGEpT7a7pgNjX7lY9x2sBHcNNsXc32JWyMAsbGZijR7TrY5+OHHTRGcj6+tYUh1B
         s2G1jZq4uOt2b3cjmHHvW7XAvG4OcPBOdAgqOdhmdc9I0ZdGwRhuA1GGWAvMjATIO44X
         WO+s1mXB0MnKPomLwIBxI4JBLk7PADLvjvoCW1aq5lYgO3qYy4yZKAgecH72deiX0KQ6
         EvDQ8oEZvbY5fWXYTOIaNoYr87k38rk8iAiQmNVI6bvy6F9ypCyF0CBGgd/a3Wvtt65w
         TVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        fh=BQXRm9iMPp6IFi77VVT0GGyL3wO6FK5mQQZL/eIY0tc=;
        b=dHjHvdRptqVmmVFG2qgulELjDYgdR6rk3HaeWhfxLMrR2qS/QQ7zv65QiJWD4hRM6j
         ZD/Pf1VgZo84veT6Aj2U+l8VuF/AyrAYRUgRs9Ge/R+hdmvxalucHNAlmi1BfM7RliP4
         6OEn/9uU2+NV/DxLk64lB6ERKVzwp75f/+QnGm01F3LAHWepgePGWVuBTNg6P/48xaTz
         jK7gDKFdt55Dqf/RDEYaj96Up48ao9LDS/h6L9mAFsgeL6+e7xeMGSjdY6CamOK3R8of
         fHQQAcDBTzqm5JTc8bFzGL6fGM7Ea0m0yhv/fGZiGI0BchUla/ABDkJIgaGscp0qU8vB
         SRug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905624; x=1785510424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=JxpEU75BJcGFAaPUZ+/wUj6q4yHKXfY+srcPSOK3Ckb61ZNhg6GD4cHqefnm8+C3Wt
         AVBnMScCSDWTsDiCqZMgzmpzO2IabglLt7S/4izdAo5QNYmo9lPP1qNYTCB55nktSkpl
         PEOlnhRQm1E8t7VhCgg+OcAs9P12PJnGc+LQ2Ax9H9a7BprU6n14k6UuyLWBc/4P7QzC
         segY1AS+4t+ZAlWyPN3TzL4REiGQ1GNX+QqC/pAhZt1w2cnLBldPjfG/OpjZty9TMOvj
         yRx7jll5WINMV755kkXIlQwftSOHHiV31VdJA1WxamHS6Bl1+dIMApug/WLStHu2Lc+c
         VJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905624; x=1785510424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=pZkl1qexpvw3TAB5ao5GEst851JWiUimxC5TCZ+jYZTRrNEYcz1+B2Q0QH6CkD1H8Q
         IsA6edmi2quT3RVcExQgLtObIbiAPcm6Wuoi3roXaeLDKWHVSpv2eF+/HHcOIu6x51Ck
         jTHMhw2cjyeTVEYJOGz4ZvbLUep8fJ8JaUmX0W1uJcXNS0V46Q6y43UkovPqJ8WYv3qt
         sEGh6sYBosMc+N1iy6TRHTTVLPbAmEWsrIvUZ5wQx0jWg2/e37LHKG70K5PfX2oSBV7J
         q9wNr9bRgRWqKciiGBxsYW9K88pKDXhtVb6GjbNOWkdD1NDASwWjRd+nZ/mC4OLq4nJW
         +ghQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkzYCBhFgbIaFSFqz+0NzcdtuEs+8fosCCFSUo3InnlhspMz77zY2wuYKYvMIpotDr74I9cSP7vUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQO62CqMO7JmVt4lbYL+iSkNkoAcAD6UUUGANqs1Q81znenFAU
	BDiRms44qenXRP8Py9KTSM7u3awjm04udTRXQdQy9FceDFIhN23XQxNxBfWLRJDEh96+71k7aZr
	GdJXY4b3HwKBSubmJsF/yQw6fjP1CtuSZ2+E95Et0CvPsABT8iHWhryq5CkCtTRkR2lCo1amxnI
	u+FMGhlcCAudPpiYTCoGLkUpn/rijRtTqasYf92g==
X-Gm-Gg: AR+sD11aqN7pay8MSTb1q7ANRJCrari3JHm0pVQuvG69pCO7K1Yq2RFI9DnXlKsgqgv
	P7ccS+5RSTCfMIRjkfPanuH+caxkDgUESoZ4e/ocSVwLuxbPRbASI2mU5yiyFs3IlHQjLtALMT6
	EKERiaEoRAteq5f2H4NAJr77PlUXCILY1iefv8NKpmTNrybX7D3MSVdAX9lw==
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id af79cd13be357-93103a65117mr772235985a.92.1784905623962;
        Fri, 24 Jul 2026 08:07:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id
 af79cd13be357-93103a65117mr772229085a.92.1784905623517; Fri, 24 Jul 2026
 08:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:51 +0200
X-Gm-Features: AUfX_mxUpEE-_djVPIMU7ZvWbbzhCFmItK3_9wrfK5-RcRFUSwGHiGhMmnFjL0c
Message-ID: <CAPx+jO9=HWwr4jGoCcWAM6fKTTrg3TphgPiNX+4yvfnyEZa_pg@mail.gmail.com>
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0w4yM6lL21ZnMylq3gu30NVj1pnGmwau
X-Proofpoint-GUID: 0w4yM6lL21ZnMylq3gu30NVj1pnGmwau
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a637f99 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX57Fk7T9tjZ3p
 f0Agjv4AIFg/cJj8HQA+uRIF46VLSxYCXMvwc2gO8cScIro0DTq/hoebB+07FSI+2R58LOUCMfx
 PgE/8F4rQzZUgk7yyB0uJEAtObXotGFtM/xKKU19Rj4DEZ5lpYWfsMwdY1xNsO699quG/wb7UiV
 CuFJ75ez1e9QfH3tCbvVn1d1FGf9GBTEZgBJY4MvzVtipx9/jVLI8Hq4nFGB8cjOZXZAG4RoFfH
 3Y/Zs/ho/A2wtT2Wo7sm0fjmWrzALiBvHSQNhWGr1pJHYktmGYGv0MJFLCqMriu8NOm+mHfR5gQ
 pv38V/L+Ic4yHjEZ4azyWoRyDBGlNWtV1YcLur7nnUwJsVXYSQ6V440RKcMZsHA0dhM8NRDZLjS
 qX/yYtnxfbFWT5tX1EK/6/daaB5rExh5nJvDc4ZmD3q+5QnVW4tRJLlyK1TgrOupKpzB8cqfPfB
 T5awIsaQF0dBIKoscjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX4/gqrtVuht2P
 +SmlnpcgckZ5qAkeZqgOvb4pXgglbJGf6BrkYKymyQMIdOWntt8GAB73KyhvuhTm70+mTcLKzHl
 vlbmMkdFyDyoCYMj95q7Ffgw6HFATHk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240136

On Mon, Jul 20, 2026 at 11:25=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec870=
29420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       platform_device_set_of_node(pd_pdev, np);
> +                       platform_device_set_fwnode(pd_pdev, of_fwnode_han=
dle(np));
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
