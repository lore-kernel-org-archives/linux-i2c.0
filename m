Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFB3DEAD2
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996622; cv=pass; b=BkL3PDrXiya3KRgQs59g4kmgxHllq3Q8jb7gYhVlmAknUXFo0hvgMP9hsRH4wHj+WBEJcYgxAjjGYSmIvRpsfQJZvSFmCRoQmqaAMau7rwqp1mkIQrtWhqHPnjHNwL555W5NS/jM+o5XLfpLBgFc//LnASCzOYI0VKCABjVzlDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996622; c=relaxed/simple;
	bh=TaJIKM3O2Do2Nt4kIaUSWB8jEWE1Qwyap2u8PR62hB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJX0X5pmE0qsaH7WJ8TAEJZ/NN+wBWfj9fD2j7WdoW62Vr3csatAcOtzcbKTIvHZbRafYLu6KlMeiB/JGjEal2XKQH8aFzjdNBGvPKslb0dZ1kU527tH9WPYwHUjIIw6iG/1XXQMVwwp8IesoTZdtnvCyQYT3lGV0WaVT+JRHhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiZHzBLy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+hm+IDZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiZHzBLy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+hm+IDZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rbQ12034662
	for <linux-i2c@vger.kernel.org>; Tue, 9 Jun 2026 09:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/EqyMxiE/m94G4SRX6R7mDsxcjVfUYvMbEvBF14uWFo=; b=UiZHzBLy4QyYM2Ks
	N5cm8P4GmceWbdMF1milaB0NUBQ8s4AgwRDCssevYujEjrAkBVTA4jO923lz9Wl2
	mHZLwHJZ9r9GTahp9dh4aqaIUTEyNiNYXD/1BiR1nRpKEwItt8gi/hY2+yWnGwp3
	kyDaQuGvCbrGquG6a87/sKd7qD3wBldP0Xf+ZCbT2dZOzOl26cLaMs2Glnpoa4KU
	CO8NGAjzC7sA+NRQxoXibKITV7Gj1Lunrh4O3pzo71nKvSo42DeUxG3zmdSyIc4A
	zWGSKMrq3mauzlsp5t4fkd9M8ITdZMiMRsQiJz8sP+KKviNRtBfXyj7JamLklmbc
	CSh/XA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeearejf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 09:16:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9156ceb551eso1010379285a.2
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 02:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780996617; cv=none;
        d=google.com; s=arc-20240605;
        b=i7fTQMdY3/EMWxpOupQb3kuArhENn3YIfB1ertU9KcDTWuz7w+uMozO+nkpy77+TbT
         4oHTS553iaUByMVG6ivvVNIq7ix26zuCsitUnqYMbVeDHlQtMacAGYy1JGLXYhYeBr/G
         mh2KWvC4Wd7iXoXuuL0zDwOMVDh+firoUx1hRFbfEK15FJPiXxkYaoI0ulf9S0o+Udxq
         x2qKd6hoxzw2Kb890fTTnehz6Jb7mHK+JAk4OSRk8rrKimqJ/Ur/yw/g7DfXooEPbV70
         nNqz++Fq7yjVj6cs4U2StawbUFZpW5tO9kXZkRQMk+7OyVbtD+V/uljBeRt5KD+StTeY
         Xg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/EqyMxiE/m94G4SRX6R7mDsxcjVfUYvMbEvBF14uWFo=;
        fh=yc3uzXUe3H8VwDlP4oRBj3pi06AQet3nlVwdsZsaf1g=;
        b=aE8N/sBWV6M2ZeAZVswX4816ezaXKO3B9hRWTXPSjG2AYeJ8AyMYkQJJSRt6Qk5Wbi
         DABz+RSgWY5m6mSmxjdFiZ417iFQ+SXRj1vfWsu3OgUnk+alQq71JfabkG6Ggl/yiRfc
         kErbQ+orevJ6494AS1PcS81L8eNdQf/U+iNO64EjjWDc05x6O5sq2Ga/Xwa7PpExEBCb
         IAak6SioyeaGabmCVngl0NykyDu7ku92iGJMWlXZyDIxz6B414dYN5L+FNyAJ8rJB+Uq
         9FSvHmk7yzguY+k62bf47/83TC1KTZc/iumSHXDQVPUojHSvYSTtXZtqSbNqtRp5SvBc
         ydaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780996617; x=1781601417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EqyMxiE/m94G4SRX6R7mDsxcjVfUYvMbEvBF14uWFo=;
        b=W+hm+IDZ+Te5QTlrcziMBKSHf0e+rSuwESM2TsPwcG2Z/KWKoFe84O02WEfYNwE2QM
         lxSgrnyOvn6+ZntqK5prUNlgMqBUHW5HamuVM2BMRB5+mXdzCLJCdY0aDXWm/Zbt3yjQ
         WG2IkRDXpHQuwVxwVYaVMI49M+cjRKGN7iQjqDzR5pTe4tdzAWJcfkD7SsHGRDL43VsE
         ErNsvW9ASPvqok0dDq5hvZKlNR63uvxyTs4yMCGajpOkfK9T9IqkiveErn0LSLgbmmZS
         8Xx1eYm2dyvJVNOGw3JCsSTIUwOSAudGTiH+xoiQ2FqXIpEXfDYbc5OIPMmQtZatDue3
         HBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996617; x=1781601417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EqyMxiE/m94G4SRX6R7mDsxcjVfUYvMbEvBF14uWFo=;
        b=LWY3OdSORwo/kStNKKvEQZSr2o0fMcJ6JtQAoBbPJL27skcnfCSMtYExyL+V3gkkyC
         9idTTrtjX2AIOsXl7/aKNBJgZugohhBypZTlb/Kb/KgL0ALSB1oBBnO6owwYF5c9dxnO
         GG034AEKEOn2PisgW++5HXpoP4qH2DAdQFFbS/AslAKhZoHsI9LORAXQI/ZyzK6u0Amp
         bnb+GIZQlRjY2JAZrk6MnD4M1E6iOYqL3pwNifLA/dECLsVDLTD11NILHFqyDCP+dTvw
         SaXll/dNpLDinxoR9fzxhLfQZNuzpEt1kD5cc1zlofKrauEydnVi5+3mfMTYnl/urDlb
         8mZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QmAfAylWBdqX4HyoDNxd7s+h1gAPe9LJlwWMEwjfz6jN9qVZq0b61TSWh7viDDJwRUx8y7CsuHok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAEW7kgDPhHvyEhFRcJ4mNdUR/tAHcutpQommsW9H+dpcKnjW
	zQGXhQJiIBm5jkc2bLhBQPP0BgefVt8INo3lO/hCCN2MCMptIDxbbnVNUJXyRPv0meiAW+qNYlh
	qUQkdINkLymKYdfex02mtjfR8Y69lxRE9N1yOam/8sLg1F+TB8hch4uxEDfGx4LxLwsDU12ddDy
	n1pc4ytIutGSqK6bSshzdMwTG6PupKdNeIUEUw8A==
X-Gm-Gg: Acq92OGBhzcRxFNFd+3tLOO86dQWwSUNMY/onD/tSvChSLXPJnUPrlrHPPahvpJNwTv
	mvt0zfPwdnnUzWy6J+rQQ2rWGVHJq+gqnOZJL6mVV06Uu3HJByvo4dfufj8MuxK8J0XLTe3KZla
	Hm8RCcpMwTYayrwZyotY8OYW4JR4/MHIXwVk2ruRBuJJGu1VUXoKmU9jDBzOe1+Db26FqwrePev
	5Ufk/IY4hI1V1GrmVULnFpJsI4yMa/0XOlyM4y7l8J9WlvuzgnMtk1GnIOx/Dv6H96FlKChY31u
	mkolbsADBDNqIizqXB08ndlczkIgJ0xfAbAOAeseAHqXx0gUPyuln7wkxiQs
X-Received: by 2002:a05:620a:1a0a:b0:915:40ff:4e10 with SMTP id af79cd13be357-915e822bf5amr252716485a.4.1780996617390;
        Tue, 09 Jun 2026 02:16:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0a:b0:915:40ff:4e10 with SMTP id
 af79cd13be357-915e822bf5amr252712085a.4.1780996616898; Tue, 09 Jun 2026
 02:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com> <20260608-shikra-camss-review-v2-2-ca1936bf1219@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-camss-review-v2-2-ca1936bf1219@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:16:44 +0200
X-Gm-Features: AVVi8CcruF8G3bHCMvT-UUyCre6c8b-WOyhsQAf9gtMqJA6eGNVQ_TK2SNIM-_k
Message-ID: <CAFEp6-2V_srCT=wWFb5Pjrhq2-pzTG5QCd90Pf+0s92qC6G8LQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: i2c: qcom-cci: Document Shikra compatible
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: z8yTUK-EJE_rgDn6TCtllWHzqJinjNbD
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27da09 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=LDBv8-xUAAAA:8 a=KKAkSRfTAAAA:8
 a=b40KZWPJp5KrgtGOUacA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=DZeXCJrVpAJBw65Qk4Ds:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX8cF2yjskrMaG
 BYRBTrh3hKNci6LFNlBpEmxR3cSCJrnO/nx8/uoiPFkPYUSYtd1QM+hqdlTioFz5MKTFvB5BJe3
 MOR5ifPOd5DCCv2ZXx2ZcRQm64o/PFW1Mk7OuxTVsvHfZKbnIzJCc621x1c+pM3u0W1OPUM9PxH
 EBQcEC3gKcXZUnfvwO77ny4uk993EbN9+mZpjLa6BJxtqW6nKzUgbi8uf/3jSGgmJJvdsYxd8/U
 lmNQMw1dFmyESEZhv3qjisC6hCZXxMr8+93diA8+y5iHwP0YgnHqotrx+8+Z8NP3QHJPpTumuFw
 L9c9nAZGI1Rhe2MT1zwM6Q3VH+X5p3qTI25cdrKR1pnBB+2q6tJe1ElURbLxhCTp0ZHMlkYwibV
 Dv0TI8a5QU/r3EzoTWQzyGKogAbBKtoon5GzBWmcn+9e64kWXvfAyK46JHloHQBAa8yx9kwkmmK
 3dE1mOVD5NLXYAZeT9w==
X-Proofpoint-GUID: z8yTUK-EJE_rgDn6TCtllWHzqJinjNbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090085

On Mon, Jun 8, 2026 at 4:07=E2=80=AFPM Nihal Kumar Gupta
<nihal.gupta@oss.qualcomm.com> wrote:
>
> Add Shikra compatible consistent with CAMSS CCI interfaces.
> It requires only two clocks.
>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 7c497a358e1dc8cec8b31c17bfedf315e4e00606..c94069afd8d06dbb08ddd6b49=
e2de7dc7acdc29a 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -35,6 +35,7 @@ properties:
>                - qcom,sc8280xp-cci
>                - qcom,sdm670-cci
>                - qcom,sdm845-cci
> +              - qcom,shikra-cci
>                - qcom,sm6150-cci
>                - qcom,sm6350-cci
>                - qcom,sm8250-cci
> @@ -137,6 +138,7 @@ allOf:
>                - qcom,kaanapali-cci
>                - qcom,qcm2290-cci
>                - qcom,qcs8300-cci
> +              - qcom,shikra-cci
>                - qcom,sm8750-cci
>      then:
>        properties:
>
> --
> 2.34.1
>
