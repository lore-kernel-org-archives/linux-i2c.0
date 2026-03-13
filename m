Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E501B4223
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418740; cv=none; b=uj0FLkfdlBfgoRmqpHuq3oLU9KISwpTDSRFpSdp3uZmjkEri+0AF7I2X6hC5Rxp4xW/Cd9M4gJUo+u8iz/fQzP+SL1MUJIRwzT8+RC4hAtC2ZH83Cb7CbPoMsJcWsy9K3nFSQCqivCymXyMchNNrRHu3QNX5NAQFi6Nw4gYxOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418740; c=relaxed/simple;
	bh=LFGN8b/UN+R3YGgYN2Kc7zmaiBg8kLu7zVUTimW8sZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9DC9n+Z68IxCrkFC/01LTdr0JKhFVZLmHRLcTyBFI9gN4rRN6y/odttPKAEDHvicabxaKD0WtTxpj72vzBT+xOfltkUlzz+ySaP//GwM1PnyuSTHTKsdBI6+bY524zk1Xa6xuQ8RtaIDWhhmOV4R/o3JQ/cTE4JBaqnlucyaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ix64suS/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pk7K//sH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ix64suS/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pk7K//sH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9UHjh1500297
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 16:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GQjuBix6iYhCQlMb6tgr+32J
	f059Qtt6VAlaGOemask=; b=ix64suS/x1LtCZ8ezz41H/xXF6ASxuDRqS7OKyBt
	XchRVF9Q/eQC7PGjKNTLA2C+/wUSWD17PLHSbx4irfnM5vUrSy/8/Vs0JE0P4Q45
	3406gCrtjfAJs6o9NLZmRtaJ0/VQ0CBAsVS978L9NcRnomNGzf+La55jc9PBjhrH
	HNPzeF3hvSA+WbccPlvfPDzJTx4OZmpDNe+ug2CYgExd4F5BuN0kqHbRL3QccsCt
	p+LKhIwC94/FxN0L1s389X1vYeX6PssCtmPEhUEhwEnw6XEDFANlXMwIdyai2N56
	BR9EWmd9Z/6LtnAjI9strimOQHcWCkT0r0KM8u7W/as2iA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hhbg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 16:18:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81ce6fdcso2091345885a.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773418736; x=1774023536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQjuBix6iYhCQlMb6tgr+32Jf059Qtt6VAlaGOemask=;
        b=Pk7K//sHSKHiUHHn60LD/0sSC2r5BQXE0HLB+SFa5YwOmW51uH3pYfFWeJ+G1FE7fV
         3B1Tm0ypQZsaA+G89mN/bjHZU7qzVgwIhlfF9DmNGFtlyEk+5HP6ChfAyg+Pbtc2RtTu
         eraHrJ3w04T96+BKB+QaxB8C2ZnUNIvTA5NiftOMYyY3ppoQEh37HyOMEOVqpflb2d2i
         A1esBs1vtYUZ3hSvqkgKbAHidzZXoMfUBSRUGnzPnmi7/9xKBRY/WyiU30rQ7Wc+nEeK
         53Pnvp+twW91Y5a8LeEw8n/udGGyS3RKGfyITIb04GUNN3PkeYt9hslgFkQtkD4PfOWE
         nqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418736; x=1774023536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQjuBix6iYhCQlMb6tgr+32Jf059Qtt6VAlaGOemask=;
        b=DGbQlECtFu7qpUJLZ61L5xbB/ja11RfwmC4pAhY5KXyxp28Naz4Q7/Cv3OdunWuOdp
         l9ikLKV5lKrm6xzCBLTkL8EyXpVw9YjQb/eHfr3FWxDl/WRfHgo72evrhsYi8b49G+3m
         wv9O8JT/WWV2TmrxU9IHthPq6f7vR/ENNudDiMSsHEUXn9ZG86cQ/nvR3j+IKgZQ7f1v
         fB6OD9lISIyzHzJkEWAZ6mVhNZg2VWYJZ6cw66Ro38+udFYeramZIzNzrhgSJo++teVP
         ndq/d2BL1TQutfaAA3GLQJrsk49wvCq01+VKNP5b7oqMH5ZedA+MAtMgbC94QHwAaBDu
         c2gA==
X-Forwarded-Encrypted: i=1; AJvYcCWmP8VgnlwNcRNZTQCAfkYNkLTVV/9JR5T1Du/EOmCygSCp83KVMP0ZAHaXUWj0lwb9qJBhU+dQE4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsxo8g8tf1fX8C8V9YRK2ib05PgQdhJxcST/f+uxCm1y0JWpXw
	+JbtNnCk0CQhkCOldJM1jwoYlXP/r7sBGXhnVaddffHiJxOE3/bN7ColDxCcB/V6hdMpZXG+Wmo
	cwwUmVLx2vWHumMjoIDrc1Ti5aX2V2IWj19y4Gj98YvhJkv3IhqYozSXmm31fmCU=
X-Gm-Gg: ATEYQzxpnrZe0gdvCGcHfjxPYiyzbSsQce6hTTotbvz8l8LOQuin/AxbLSezuLFrtwx
	kWX9Gq87TBLmErz+1DIsBf6MgMj5aF29ywhLghCxeuGykGBvF34NwTyZ5DrMJrLYtRf7BpQboCQ
	zryyd5kNmSq46mxwQYN7jnp9aSgRJYesgaJ3mAGUrDnCzzCiXHVSDgZ06AxYpmGPAM+/aNcf6+V
	1wvHj1hjHtHNl0Tien/93lLpc0BZz0N3n8fd3OS5+GMuIpl1tHgFDLOo6ByrxsUiWTeRF8YSuG/
	LmUpcysnbBuofGrzkHW4LHCLPqyg785ODk/ppYRywbzmXyW1OFoVg5AczPC1l/hO2nP68+cX3Gr
	c1O4pCfWiEDCl/JXnQT99czhMlYWEIphQ8oZCggDoyBg2ZZ48gbJyvScMSgTkQHtUKMp0awjfcZ
	qtLsshK2Gvn1kal7mmw8UK86OuDJiHreTeqv0=
X-Received: by 2002:a05:620a:4493:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8cdb5b5b043mr496054685a.39.1773418736242;
        Fri, 13 Mar 2026 09:18:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8cdb5b5b043mr496047785a.39.1773418735704;
        Fri, 13 Mar 2026 09:18:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1563775a2sm1598057e87.89.2026.03.13.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:18:54 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:18:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: i2c: qcom-cci: Document Milos compatible
Message-ID: <jexys4ypbizesa3whuvtq36t6hpqm4httlbwtzkulz5pld4yul@lf3joaistvfb>
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
 <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
 <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>
 <DH1LC0C4QD0Y.1XKV1PWFCBQRN@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH1LC0C4QD0Y.1XKV1PWFCBQRN@fairphone.com>
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b438f0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=6H0WHjuAAAAA:8
 a=9zw7OpybwPviLstg948A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: -tgJxsFRczmyJoa7Su3YsHjLvEcQd1is
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMCBTYWx0ZWRfX6ev2NZedg0/W
 ER9g4e+4K65jy7NHRwdA3v+dEtmF4mgX2xst80ZPHvGsVVvvJz4P2wlSgVEUyCgQWNDBTva0sb8
 kvIBm7JnUGmHRrG5vhXSneSDA3Nx8jx/GamUBcawr8Cg8So7zc5lwDVLZF/rVxlJB9kSNeXFYnY
 2YsTP+/OTF1vzP1hhTDCvEUdvGacXyrQnCrZ4SohRtiH/Cx0PqQxlt8a83jCzW16Y/nfXxxJ34h
 J5RBtYxug1LkA0GnvPLSb8zzYcw9BnLWeaZblKmiPkpXzIGcaV3FQYuYwmg3v0RbrdhzONoYfwq
 nkm4mZGLveSl4ZWXPgWzv9MOqJ4w+VQ1rvCPmmy4cQxehg3oJeMyCSYZoR4o2LEaw9mkv3EMx4/
 eDG+3VSikpGnCNQvv6n33Wr8Sng0w8c3mQdbax0TYLDbxrStYKvh5rKLthx944L+xDvsovRiFlC
 ZtWjjwnj7rapGwNVw5A==
X-Proofpoint-GUID: -tgJxsFRczmyJoa7Su3YsHjLvEcQd1is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130130

On Fri, Mar 13, 2026 at 11:43:07AM +0100, Luca Weiss wrote:
> On Fri Feb 13, 2026 at 2:16 PM CET, Luca Weiss wrote:
> > Hi all,
> >
> > On Tue Jan 20, 2026 at 2:18 PM CET, Konrad Dybcio wrote:
> >> On 1/17/26 12:54 PM, Krzysztof Kozlowski wrote:
> >>> On Fri, Jan 16, 2026 at 02:38:56PM +0100, Luca Weiss wrote:
> >>>> Add Milos compatible for the CAMSS CCI interfaces.
> >>>>
> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>> ---
> >>>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 ++++++++++++++++++
> >>>>  1 file changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> >>>> index a3fe1eea6aec..c57d81258fba 100644
> >>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> >>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> >>>> @@ -27,6 +27,7 @@ properties:
> >>>>        - items:
> >>>>            - enum:
> >>>>                - qcom,kaanapali-cci
> >>>> +              - qcom,milos-cci
> >>>>                - qcom,qcm2290-cci
> >>>>                - qcom,sa8775p-cci
> >>>>                - qcom,sc7280-cci
> >>>> @@ -263,6 +264,23 @@ allOf:
> >>>>              - const: cpas_ahb
> >>>>              - const: cci
> >>>>  
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            enum:
> >>>> +              - qcom,milos-cci
> >>>> +    then:
> >>>> +      properties:
> >>>> +        clocks:
> >>>> +          minItems: 3
> >>>> +          maxItems: 3
> >>>> +        clock-names:
> >>>> +          items:
> >>>> +            - const: soc_ahb
> >>>> +            - const: cpas_ahb
> >>>> +            - const: cci
> >>> 
> >>> Same comments as other discussion these days - I guess that soc_ahb
> >>> serves the same purpose as camnoc_axi, so this is just last entri in the
> >>> if:then: blocks.
> >>> 
> >>> I really find this binding terrible - around six names for AHB - so I do
> >>> not want another combination...
> >>
> >> I dug up the CCI doc, it talks about the CCI having a CC_CCI_CLK clock ("cci"
> >> here) and a CC_PBUS_CLK (AHB interface to the rest of the SoC).
> >>
> >> The CAMSS TOP doc (for Milos specifically, but I would assume there's a
> >> pattern) says that for access to CCI_0, I need to enable CAM_CC_CPAS_AHB_CLK
> >> and CAM_CC_CCI_0_CLK. CPAS is a wrapper inside CAMSS that contains most of
> >> the programmable IPs on there (notably not the CSIPHYs, at least not on this
> >> platform)
> >>
> >> It further mentions that GCC_SOC_AHB_CLK is required for *any* register
> >> access within CAMSS. Perhaps it sits right in front of the xNoC-to-CAMNoC
> >> interface.
> >>
> >> This only enforces my imagination of CAMSS being a fully contained "bus"
> >> (perhaps somewhat like AxNOC on 8996 represented with a simple-pm-bus)..
> >>
> >> +Dmitry, myself and a number of our colleagues were deliberating how to
> >> best represent the hardware going forward and I think we at some point waved
> >> the idea of putting every camera subdevice under a "camss: bus@ {}"-type node,
> >> which would hold the reference to the TITAN_TOP_GDSC. This seems fitting for
> >> housing the SOC_AHB clock as well and therefore concluding this discussion.
> >
> > How can we continue here? What change can I do to unblock this? I can't
> > tell whether soc_ahb == camnoc_axi for this platform so I need some help
> > here.
> 
> Any feedback on this?

I went on and checked. No Milos's soc_ahb != camnoc_axi. They serve
different purposes.

-- 
With best wishes
Dmitry
