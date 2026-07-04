Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA921F3B8A
	for <linux-i2c@vger.kernel.org>; Sat,  4 Jul 2026 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783135610; cv=none; b=q3GOvRwYNoycx3YhpIA5OSrpBcBrR4nVDOmjsMkplirK5BO0GCBlEeeC3PZ6hj67p5DW6KTNx4l+mN4kdSwm6lPzTA0AEAvo+7Osnun7qmt+kWcLvITUDJdOFxFpLsWHGzZB2EfMzFAbFvI8SscaDSPfiXB9g81nBuQtiaRf4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783135610; c=relaxed/simple;
	bh=Z52KdIIrlV0P/pNLWwB1lBDK89sE2xDmZuVC79UC0Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzdVdA5ZIx97sKtVDHzhRbwpFXK9MAmHkGHywsFECmGOKtWkdQ+v6ItPFW3wKgVMb2HiF43NHBR05hnbSdJJGUiYzqR++9o1rhwhbY68UTEyPXjiCK5BaXxiDWFqjRhEdijVrXWKYbO9/i0RvbdqMb8AAyLiB90q0sTngbnMOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izniWUTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R46eMMim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izniWUTa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R46eMMim"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6643Pks61868612
	for <linux-i2c@vger.kernel.org>; Sat, 4 Jul 2026 03:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5ZzlMleCvK6/EpDoM9z20FLc
	dYB9f6a97RZUW39bIrs=; b=izniWUTaoQL3GAF91vbowfU7qUnLcI6UVV4R0try
	pSuEtS/kEy7GgOOj1MNyEXHJF1c0fJeVeEtoQYqpL4+OmzPYR6pFmUlP5raipd9o
	gFr8iLAGw49LRJJ62scOJERBeFlOuzKU6/BxEE3X7y6PA4BFNKMqorQDag0EHqXd
	UZO79Sge79rxCh+Sd52Soq8mTnL0xFBoR5WKLl7LKE4skOfyeSciE5k3M616c1pd
	ldAIf1Gsvz4uQpuE7TATxq0UJv8fu78RCw8eZHWfc5oI672kd/a/XeiapZO04oV4
	AoCLrhzY5XzmpS3WST87CPv1DNYOURaUD66mm+Jxgs0mFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8ug01x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 04 Jul 2026 03:26:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-384048e7e14so137762a91.1
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 20:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783135607; x=1783740407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZzlMleCvK6/EpDoM9z20FLcdYB9f6a97RZUW39bIrs=;
        b=R46eMMimnRsDsNRsj+SXoBNCCDMHcfGHKisB31lhM51+Yp3zOuzmyZWwxh/4mMBcdi
         t354Bfmd9BQdtGL+UQ+aVI+PpS9Ed8nWav/JpBf2Es9BEHanxLELoTAJWxMB598rquES
         mH/PgkVj3X9a35Lubt/SaklnDRHPOkZ5QOQ5irD/NFkzRSr/GXhYCRXfF835oD5n4Zab
         OUplVtGK2rsnug6POdsW2BfqUsoTJ+29bwzSF31PJ0FbQ1PKYlKGd5VO36izpiKnzfhD
         Doh0nn44IvJK0z3giKvtz0HQFkzF4sUiI680CtuKEBdkaklWz9y+RD/F6I+5S/dLNYgi
         EiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783135607; x=1783740407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZzlMleCvK6/EpDoM9z20FLcdYB9f6a97RZUW39bIrs=;
        b=TRxU8yLbwW/3Mfj2A991TcV5m/McqbmDZTf5p+PxENIKHNHKya+A52jNeiRmbS3s6H
         YrK51I3J4Z9kAA0boaCl57nbELI5Mw2EOTMF/xjV2Z1rYnCHJr2wrptLDvZL9aYJW9ir
         uoiI+9iV1T+M+ci2oMP9a+e3k7QbMZVbKEsse2ITVMwJs5ed4y+6fg7OTJUmkPnArJD9
         ZihMLhwz2SVQ5KGQEOGAEHyDBZny7ul3nwtd9XWDtAV8G9EEBSsaBeRR28zc/p78moDM
         QOqcyjBaKvR+T2CYcAERgT3WvVBVLCTPO4723in4JYlEAXgrWcCPxX2LshBAO4h+3DZZ
         S4tw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo7J0rRJrRKI8CSjPZt/IHZaHBQfGxs/od/iR/K+hO91VuTOwoll7Nhjn0Pv7TQtodAYJojGd0X1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqib+FTexLN9UtbdMtIG2Ubjj5LCLjpztYTGkhBPkufCXYkXo5
	eRqJxohrpeAizmunM046l8D4LeO2lHyfircjbSBQdPtDYZPdvyl/7aEn65OKFysLhMk4GXDGzw+
	M5awW/pHkH31tqohfdLz/2CHDb0H+0MTEP32V5DNkRk1yEq/kWYg7neZAGgtMk+w=
X-Gm-Gg: AfdE7ckCoMyEAKxdd6SAdLcPOgnK2VsOGubonDcUZaH4ipEm+NgdwO5CgVOGzeqRGSd
	EZpG7jmkT5ZoVOeE1EEvCkho10uB7tORBCN4Ydrxd/VKvvt6p0L3whyGF3wXuAMA3/dP4uig/wC
	wLKehRD39shQBdrqMoq5kKedGrQ4d/rc8stFn1RMKIkQWcEi7SN6Ftvl/+yWI6jUHye4g0HxSkr
	3RuC+KRVnztIzBwSnAgqwkJ4BkLICVSl9AnFalLC1WcgKfYeuqNykHVZ6lDhC5hwOLUcJvw6evI
	sp3pCOj1lC3tpUs1eqDv6jB77VuThkQoqaYcdmcKJTK/a7eQoFX9PKmPGYM9JZG1kifKI/AAKsI
	KEh/nEkjw1BnHvxDtZ7QwsGYpSpokHZcXlApk8MsvjWt9lDZYconK6g==
X-Received: by 2002:a17:90b:1802:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3829f007711mr1968782a91.21.1783135607307;
        Fri, 03 Jul 2026 20:26:47 -0700 (PDT)
X-Received: by 2002:a17:90b:1802:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3829f007711mr1968751a91.21.1783135606815;
        Fri, 03 Jul 2026 20:26:46 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm43793015eec.9.2026.07.03.20.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 20:26:46 -0700 (PDT)
Date: Sat, 4 Jul 2026 11:26:39 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mattijs Korpershoek <mkorpershoek@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        prasad.sodagudi@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: i2c: Describe SA8255p
Message-ID: <akh9bzlP12sRM4Fw@QCOM-aGQu4IUr3Y>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
 <20260617-enable-i2c-on-sa8255p-v7-1-ad736dbeab57@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-enable-i2c-on-sa8255p-v7-1-ad736dbeab57@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Tt4gNNYh1cCHJFbYJuo1EncTQUaPlIXI
X-Proofpoint-GUID: Tt4gNNYh1cCHJFbYJuo1EncTQUaPlIXI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDAyOSBTYWx0ZWRfX9SW6K6+SI4ph
 RISK3I8NbnVdxGGzOVGY3ItqhDvteFm2TwnwnYR+rYBp5kyvT/eqxrgaqlUH+c2rb3NOEXMPp8l
 aEVjQRnIFx3kWOPAUOOR52IClFvq+SU=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a487d78 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=HYhALLXNZ_QuGUvz3fMA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDAyOSBTYWx0ZWRfX3HRqxmTL0RbN
 AwwUobBh81nUaagVCQ/DkvB+IbgfBySLZ1NOzNI5JajCE9YzzZzAgC6gGWtMSkUYXHbvdyqqO4q
 1YibEKIpx0WEZ+bkzgcoUrEWyu5aQrt8niwZKPJUtdGElorvJmBAeT4QAtEquZxoKKvshWjvrPy
 8XTPrtkusqPyFzmIOWlPZEPfwbon7KEnb5SWoEwh24nnZ/p0s/vHTxNNwEhbm/aRIy+t5DuwBxg
 cgdIXXuGmyc9ykdh/doI4tqD2ryHWoSRq9vzeEqDH7HEMtWh6i+hszTjAas5Mb0eT3C52hiB8DM
 W7E1brQa1ws4ZcD3gcDAq0a8nxxNxZOQ7tYNbX+6HWTNCREa559UN36/O51KSSqoK7TUaky1Xms
 BGrtHSO5Hdszdz767hrn+WbmKbvHV3E4PBgfKttoUVtTHWpoPTPxGzMkqwwOXqs6MF5mC+PTjX/
 +FtfNNAG2sKrvmyh9lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040029

On Wed, Jun 17, 2026 at 10:20:15AM +0530, Praveen Talari wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
> new file mode 100644
> index 000000000000..a61e40b5cbc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/qcom,sa8255p-geni-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SA8255p QUP GENI I2C Controller
> +
> +maintainers:
> +  - Praveen Talari <praveen.talari@oss.qualcomm.com>
> +
> +properties:
> +  compatible:
> +    const: qcom,sa8255p-geni-i2c

The compatible had already been defined by soc/qcom/qcom,sa8255p-geni-se-qup.yaml.
Now we get the same compatible defined by two binding files.

I spot this because I'm running check_dtbs for Nord SA8797P and getting
complaints on "qcom,sa8797p-geni-i2c" compatible  which is already defined
by geni-se-qup yaml. But check_dtbs seems to be running the check against
sa8255p-geni-i2c yaml added by this patch.

Shawn
