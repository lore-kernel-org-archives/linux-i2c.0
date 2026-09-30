Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC834BEE33
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766696; cv=none; b=fIHdi2fVU5A5YzTfunGFu3bv0RgSzR8ZwlcbWRiAyqPmDmOvNjVsdog4TlPTtf2hdLqM/ySF6hUtXMOIwroxgn+I/7uiZubI0Rzl9zPeiSAs96q6/r0SMnK83pRJUfftkLt3h2USpvBzvhGtV/AbyP2AomseInFECn8649i6Ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766696; c=relaxed/simple;
	bh=XfAUpWIB5pFLDFRK6D7anzO+YIDlxesyQMaNA6+Mucc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLcAabopIsJpbDvQGLBsywffD2dNFwB8QLHyVQK6Pz3O1nOMIflft1xW+pUhWhHEyELOjOFq2IWKycVBiPr1WS/sHX3gkFDeRBhQZWl5IcjM5MDIlvq2KseXHeGMi+DhB66ELvtruyGysNeF8rIONLuceOcD4xQefM2B1ohidrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLkwqktB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCQ0+kng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLkwqktB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCQ0+kng"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7jl72678581
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvmbI9rgvTTA/cwhiqUJrtUvaPKNUBBZFDt5+C+0sSU=; b=lLkwqktBl6bGiQbo
	h5dL9QQtCebhNsajnpPsHsODUeW5cfr6ntMO5C23PySDliaygC6WqJfMqXrVXsoS
	/oIB8Wi/p65eyENGVoyjmHlVBz3wvxBMDpVPA83NgsxM9WjFoBVjCw05Vs+gQdKz
	aE7mj9UfBkuT2KiHmHNeKaLNuRw63725lbIdCGuozD4AtZ8278uLyINuyl7q1LCw
	GkspzAtkHzSAQ5w4H+1U9fNXgKX4I//BuaVyrD6WfliFaN8+SrEy1hm8uKEQIdWj
	jMDITwFlQWyFr5Gpwo8fGsAEcg36mx7Ff4lUXGuFHybLJBKAPgiQpKmUJo4p5SAL
	rIqd9A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjj5gw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9106bb33cdfso9652926d6.2
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790766693; x=1791371493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvmbI9rgvTTA/cwhiqUJrtUvaPKNUBBZFDt5+C+0sSU=;
        b=bCQ0+kngQExOA/9fP1th8eGyjyl8wROiXg5pYefbCUyT6R+j8an1c1Ka5XY+iKR4LV
         LuZwF3MGT0UpEI3Yq1bOihbO0OVid1WyOQiYs1iTBPvcBIuSMKehyIT4a1sHBiowEDvy
         ExdSjOyR13kscfqTtV8IVR3RhoUYgdwF7HA9kUJ8m65AdIPBjxBqgjWPB3ht8OiZyx6s
         ERORJ3/yof15t+67M4gZuNgp+HSp9nZrnXP/GAggdtdBGmSUFxTBhLMit068kbeerKwt
         wmjHMiaeR/ilGff4A7slseORtsG2szfNQL9hni0EIkMqsDQZ3Y5dutYyhyY6ouqUy+HN
         ls3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766693; x=1791371493;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvmbI9rgvTTA/cwhiqUJrtUvaPKNUBBZFDt5+C+0sSU=;
        b=DHdJUB262PX16E4HQXmdngWMFmA6fhAJRmiCj/F8efiy16nEWO+AiQhHeptmMnkgux
         qpCKr7P5mlsBKbe2ynd3soe00LU4V64viWRvoqR7byR3jXj3xl79NhKA1euV9EItPORp
         sJ6mFaDnyJ1C9knSqUl/fHta/msqdbOIzgavaoKgTDejv2kkkhYFFAci6K+FJacuuJ+S
         05dSY4xz0Pfw7DvUQg4xzZYS9n4nhLTcusaYal/+8806SG0dbIJfTXHRxu8ZykceZa2E
         zOZajrz0ENH0yC4GxKKj1HYerdas5Mn6cIgeFWJfX6hoNRMfgexe6IyEcU+LF62NqUhb
         FW2w==
X-Forwarded-Encrypted: i=1; AKwUvByx+WWjwwxZbas82izmxfyf+SIXKOykc+L/OYVWSyVj0GPRss3pwTR2lrHTLPpPG/E/2Mge914eMp4=@vger.kernel.org
X-Gm-Message-State: AFuF++lbxPVCJRyLTqdT4CK2DuEn9pr8uTJ8ZRvMt8Xk48yl1J4sZRs+
	WtiTf65lVuT9hep5dGpQAAPoIYcxRdOLdsjKWJ9Llvj7hZ99Yy+4py1J/K/R6KE5avo0KAJBPZ6
	xBbpn8xUPawQggPvKdWg5EhVfo2ZjrmZsKYgiFyT4DVheC0uDQzZWp9jjP6mblOU=
X-Gm-Gg: AYBFou0his9MfGCgNICPfMvyzJBhWrcD4nk4TSuXzQ/k+wHqr3yYH4r61oA6ka3tLfW
	k4uccHwlM6Vc2vf89HziCKzXdtIoBBcX47+TOPv/FB1QZlParDsdIIkt3fR+ycF/P2W+YwdEV3i
	vbrsj6rlcdg5ziDaTJ6hlNxrdkRBBNEUhhk71it31fyxqzj+T5lflfUqaB7yyrINfV18pwTT7Xw
	NuKmHdZHomLn4hhJE7EgsvnEvMvik0FO7Jn5YhfKl2PrWQ5Vx36YOQuga4sWglOZLJUXnGQaMBL
	sTbo6yudU6urNHfUgzLwvMRe0YTzw28EW1aZya/wM1OSTpzHY2fU94GPo2o1ARlTMBe30qYPfJ8
	M86RUeNlV2WUkIbszCJWzLw==
X-Received: by 2002:a05:620a:700a:b0:939:9ef4:79eb with SMTP id af79cd13be357-93ca97d148cmr150770085a.6.1790766692869;
        Wed, 30 Sep 2026 04:11:32 -0700 (PDT)
X-Received: by 2002:a05:620a:700a:b0:939:9ef4:79eb with SMTP id af79cd13be357-93ca97d148cmr150763985a.6.1790766692337;
        Wed, 30 Sep 2026 04:11:32 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f803b3sm49118666b.46.2026.09.30.04.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:11:31 -0700 (PDT)
Message-ID: <c61cfe2e-56f9-4b82-a9d2-a2f5dd7bb45d@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:11:27 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/15] arm64: dts: qcom: maili-mtp: Enable S5KJN5
 camera for Maili MTP
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-14-cbbb42e534ef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-14-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfXw4FLZiNvVjpG
 FlRo0PjaY/X0KxZ2i5KX1YhcAMMSa+NWGlVqdSp7zSTnlglumT4VRU4vpwXl3e9jvNbgLQLZyFh
 CIvBNKC0WKPueSxtANE44r51GZfg6kE=
X-Proofpoint-GUID: qgKIBikWgpJeR8h5jr7n2GjTMRSbXT1O
X-Proofpoint-ORIG-GUID: qgKIBikWgpJeR8h5jr7n2GjTMRSbXT1O
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcee66 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=lfXJP-rXcfLZvGY9UOkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfXxkwGfNIJjmqs
 cH54O7LjGAKj8UyvK4ROQ3Dd6THakrSbBQ92AVJvL1ehzAkDgobS78KgmhDV5QSjHK3b6iAe5ac
 i6YTnCI0XW0DEc7TLRnFeXWTScGTkgFt8ID6To240hB9YcpHoJRGHq1EGzu7vNCs6dCyPFnf92T
 f5nFQDYQHVJMY1iU9o/4WkXU1g56bXe9l8FQm/6a8/6L+W2K4fGd5xo5KQXNErOnTGe9FV4souh
 xwdgr+ylzohQImQo1l9IBUE58hiFK1teMDhvGfOjzPUyZIwoghWAzKj/9+ocO+hgasZ1TLWG9rc
 2+adITZK6Bil4FWdGXyIRxJkvpkLd3a8Gs7yfDydrQqkm+K/VpoQ67u2RdmVVU1wIYA6qJt35sb
 o2b96fO5do1a4NtfeJUq0D2Z7WT8y39Zx8ejzAklEyuo5wTh14zDRmAJ1anliDu1r5AHBZ2AbiF
 T0a0QmN4NGIz9+4itJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300044

On 9/23/26 1:02 PM, Nihal Kumar Gupta wrote:
> Qualcomm Maili MTP carries a Samsung S5KJN5 rear camera sensor on
> QUP I2C9, connected to CSIPHY2 via 4-lane CSI-2 D-PHY.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
