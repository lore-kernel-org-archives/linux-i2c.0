Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658254EE85E
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894280; cv=pass; b=Wu92Y8cHGXKzKkfVw/8L39UrWpGosqXr5UAmyKsbqtRVR22qgPSBaiOj/wkO4+ZwSwGN1q+nP5tY2JiasMmvdOBefat5jfu0VBjlHPRnx0w6mjutKkboWrVAHSDvwIIkqV5XXZ5kuTyclOBX127T7dc5Xsvd/jGcwxmaTmT0xyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894280; c=relaxed/simple;
	bh=jUlJOAGscmKzGahwZhW1vZi2twtvH5CpgUlhI/gE7gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qP2Ls3MyqvcaC+YmoQSG/w+EeUhtOHPXuNSrfg+lueXMhYsEB23UKSNSFUtJntTZ638Wk6HnJ1NObi7kD7+WQvFW2zwyoBx++E4zgAUV+jS5NT5OKg10I4b9dQo5Tpn7wsfcPzfTVYtFW7uM7+QONOfUtvO1GlZdW2h9Xwakj3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jp7m5aax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FaSzJdDm; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jp7m5aax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaSzJdDm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8dGB43054806
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 12:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cBHSeEg5m78MeGq/62DbhP5UimRnwtu1lp97yd0gtxo=; b=Jp7m5aaxYj2xkdlL
	M7R8sMwZwwJMzHikLYlGEXwmc4Z4MQBVEeg0ZCnfSXIxjKxj5b1k7WxeZcDZ5nIJ
	ZZ2LcpaeMz0u9gZpZiH9LPEJ5qYLCB/raFiSeJr0wczRVeVyzwNbh5l/630XOVtN
	IV4Q874QRojeN2KAQWAZjR7aw5fJ6cipK9c318fn+iD6RB9RG6gTcpkBZL6fvMTl
	QWWAWly1d7Xm+iEEx29yKpK3cAod4ncsZeXlxi5ZX1sy80+HMAL+ucqentmfXQF+
	MApnxasg/u01iYFGniqdZemDlXvn2Ny5s39a1hEIye/3oABV4KCEtjZF6yrFO092
	lSNIgg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aev8sm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 12:24:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5337b591609so33148621cf.3
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 05:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791894277; cv=none;
        d=google.com; s=arc-20260327;
        b=oDJKgK2targldLxjbB4VNL90ZVyRBVEZ1HQ19/qlZdfBBMQDSIne5R1VOTs26a/uD8
         bix5TQsjHSswdvigDzqob2eiOYyakLgo5vvcWF2MEn28ng/SsTZ5PiGrts2ZIr+RjqKw
         mRyxuBExQdT8lWTeMubxdqD9ERCJMq/in/8pxXGYVLAPay9YqxeTmhQZuiHAtFxY4SFo
         +HnFKjn2SU3gMEt/oXZ2LV4AcdQ/7hyfgwN5aTAOfYZw27ilavOSI1TYnabZDEE2ofPK
         0vYY4t/gNVOaNROqItrIJ2a6Q+slJ67/EYCl7TgHE4hqgDkkaS2YUfEf08pNKcaFc98j
         INBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cBHSeEg5m78MeGq/62DbhP5UimRnwtu1lp97yd0gtxo=;
        fh=8FZjm+xGddlnpVPuUtbdlERApwnmQkHVJYnS5ZACUUY=;
        b=pRXMz1LyYcqqBZF4rTxMOq89/h2NNnxO1DpWHLesXD1s0gJqplW/XL9PJKIdy1xDW0
         N58lF7181nwJ9jmo2L8PGlG/fEp6hl2biN6d2usSgLnjbAagKPC925eepZjdbI915sUS
         ome+fLVcy7m/2jYrcj5B4MwPcwTukYUvDujfu/XfhdoFB6VY94j79OD1SBWXWIpuQE3W
         IuIalVZBre5qoNwSF2xgkB8DfkIhJC6VTdP1L/S3b4MDvGR73vVD0/iBudtGygXCKSmM
         WVqJV5+fi6Z88/IMwrvRlpS7MB6Xq98N27rDDIBAY8Zr+6kinKMPP0tm8gVrFDOcS/fD
         mvMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791894277; x=1792499077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cBHSeEg5m78MeGq/62DbhP5UimRnwtu1lp97yd0gtxo=;
        b=FaSzJdDmaGXSRz8AuguXmkMcvJF/tmVKvq3owf9x+iu43sFt620LOp5NUlKOZS7wyH
         ak5hpiYFwqtvHrSR34eFdmgwg+Ngf1e3Iehseu1bPE0V5FaN2EIZRNvNUtzzuOENDSr+
         5lnwdV2ZTU1DFon1QBTgQ5mg3/V7i+1poHzp3vgWGHWenbsSyzYFHdCjFWKo57VQ+o4u
         AJClVIGBAiBHSfERt7VczPwX48IA5EDQbrIxHf2XHhsPstSFjFnvRN1GhhOpfLx+If0r
         xWq6AdbPNJqC6YNF3uzOZJGSYaDCvBUP0tn9zaMEZoVCXnZHR2e9ImpHPzC183IwUnkt
         oOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894277; x=1792499077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBHSeEg5m78MeGq/62DbhP5UimRnwtu1lp97yd0gtxo=;
        b=EQ4ewmgTuDthnI/RsH79U6Hf4SCAX9ZcHOYwUpHt0NurnpamoAWG2/zw9OCOTpmjja
         WU+0QoCDTdrmgOMTo6z8kDp854p3jqj7S+yf+KLcNJBfxrTbgRWH+GFV8IS8sdssl5g5
         PRsMOedv8uPO/0o1FOd5ymLAAdMhBxoQgR8iH5edZtk/NHsz0zvjAs3TG4CuKZCCzGnD
         Ag0D23R8JZIzoFSY/Yyk7FZZUYySP3Smj2scxoGO7nq+pYNb2Q81z4LqcWy3RVHWCjb/
         JQpWIQ9KWL15vFlzBTmZH4+vGYTwXrKbdWdLSfeKM6Adz0fM4d2gIEm8eXrVLpZsvFZS
         NWJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWNMwOdbb5dETgc7PgvLaViF6mVuPuscTLm5/Gal5cTqvzYjUqX1pRwVc2O395Ff1nJ28TifFVI/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFdOAqOFntKMQQgfDrx/iWEMepNWkds4T205utSXOZBlaQZSrK
	SzNMbxToKu8lA9LqtN5djBI2EYEBr5c2q9FWl1WCyoEGdGBS05X9nEk1QVCtiC1umDTRH/xkViv
	C4Jd3Hko32TBvScWUQT8zyrUNWgoFfh5Rh3wcmmKMYuo9TQ9Atw4Td0OZkgAn0uQTcnK+76X9Vr
	hfNVVU+nxJwKy9ufXOZEDhcNCRLh1fn1rr6CEa3A==
X-Gm-Gg: AYBFou1/a3paTBCxSde5LH2gejanmUW3AXUMKCzIeMVyG7hLhv0jaaNKG+uKRUED+Yi
	gqD0rx4wP0LO7qBr/wr8ec0aIiit0oOq/jGdkMsLTcuVvEPIJWsUQOb2LlSfkpW7QVmL90C4Hg7
	C6jh/sfCWcxyYr1YYY/Znu8n5P3Wky0bx0jsis2sM40bz+VzmWWNZcupL6nBo/U/sgkLxTDudXm
	5izNdZHoBSmJWNVHsszOxkjHN3vtAoCFq8IBxlIHKMf4RHWnviTj+Zyw/g7J3CAdZHHvu06hzqy
	iPFHIj4YQJo5mgvdTgdhGH4K4MkS
X-Received: by 2002:a05:622a:1c15:b0:533:21c6:f4e2 with SMTP id d75a77b69052e-5359fa9087cmr195111201cf.20.1791894277430;
        Tue, 13 Oct 2026 05:24:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1c15:b0:533:21c6:f4e2 with SMTP id
 d75a77b69052e-5359fa9087cmr195110711cf.20.1791894276755; Tue, 13 Oct 2026
 05:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com> <20261013-hawi-maili-camss-v2-1-fc93222da89c@oss.qualcomm.com>
In-Reply-To: <20261013-hawi-maili-camss-v2-1-fc93222da89c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:24:25 +0200
X-Gm-Features: AclHuK_DsaujXZKzgQcz6fY7MANZtkJtyyIAn3Pjdl47YmkPjme6QijlN0LMNHM
Message-ID: <CAFEp6-3LXSdAd5seGb1e7OZVYq1SFR+8RdK1Q6mM=2ZeZfM4FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: bZKAiAQULb2VDzD70FWs1B2EMMjuEIL1
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace2306 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=b40KZWPJp5KrgtGOUacA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfXzkOQL/uUgeYq
 k27XH7V3uPG5hwLPQo1CFPbLaWHfqhaRjhZE8ICmAUvfJmNNMLNYYStjqoJO5cx1iv2BhCUd8cL
 OuQGXZcrMLgtIJHRM9gaPR+f/UV7a9c=
X-Proofpoint-ORIG-GUID: bZKAiAQULb2VDzD70FWs1B2EMMjuEIL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX4V6OkHRUkUJb
 mWArsX/rsdNJ4m4Vl4XVKKnnfHVKhP4sqLRnUILCDLSq3ecgRALPCwrJ3FvuoE502WTscuGvSC/
 2+i1Yu7ScjpSgaBaiw8WgZNMnZYN3OahZSUq46g5GrRvFux9t0FUZRPuRKERRmt0Uh1MRU8aAQv
 GREGC6i2sclk4iewVUgOAEs1DBg0r5SFXElJtusgFZy6+XbNQTBzA19asgrICf5p26XeThue2R0
 hESDiPeg1CRxSRNOqhrrUphf03fz7LfjLplWYL8Yv1NzhWOSrVmew0PNJL8ZSA1fDvxPpex3Jbk
 6/izUKC41lFMMvvwZixazrBBr64ZlGhptpkbLBMpBTUSutix7FzOoPEETjS1bFXwpLEjXmGE3Pk
 /UHY7tYV9y5LJNd877ngMrbnuh3O6O3Q9t3uzDD6NvuswmzQ7r67XkRsSIZAmuzlRt/Vpf8JtAR
 2qILXQ0/KLcDZiuvOoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130049

On Tue, Oct 13, 2026 at 1:03=E2=80=AFPM Nihal Kumar Gupta
<nihal.gupta@oss.qualcomm.com> wrote:
>
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>
> Document the Camera Control Interface (CCI) compatible for the Qualcomm
> Hawi platform. Like other recent platforms it requires two clocks, so
> add it to the corresponding clocks constraint as well.
>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..b2b4d4bcf780792515ec153c8=
73bace1764fb3e3 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -27,6 +27,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,glymur-cci
> +              - qcom,hawi-cci
>                - qcom,kaanapali-cci
>                - qcom,milos-cci
>                - qcom,qcm2290-cci
> @@ -137,6 +138,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,glymur-cci
> +              - qcom,hawi-cci
>                - qcom,kaanapali-cci
>                - qcom,qcm2290-cci
>                - qcom,qcs8300-cci
>
> --
> 2.34.1
>
