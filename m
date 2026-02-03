Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7833E37C
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120756; cv=none; b=W9BjtObxqo+KCwboE1CyxYz2GID259bmge0JrQviR/TYChOs5ASH2rIbxIYXRrzqQQ3iOFEcxK8LATV4a5XvfuioB23eh6XoMa0mg0+y7E+tTNprB7M1jIxt5TXrtbDToHFMTeZPh9okAm2smoJcr8OOz8l+rb079o4m8iuxHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120756; c=relaxed/simple;
	bh=LptzFJUyjpykLlcey9VFL00nRZ573wuxgKxYMTMRdZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzAKHt5mZZOm+ZhwrAiHm1Tk4QUlgnjOkzdG1pp1UZRd663oCC3ZqH0P5GP7QsKqDePcDLqMspXnJeIXUYaIHWuI+k038c8GNin+f646GU0c8/b23k3+pHNgXBtIpjcG9v7AY6091tNJyZpKr0yt+mLJWSoPftO1i3dNa4DSVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jG7XWJ42; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KLQm2f3r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jG7XWJ42";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KLQm2f3r"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6136WHCu277353
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Vx1+aGrw4+vH/imMb6fHNF9uGEkcIk4iAr7YXm2HhE=; b=jG7XWJ428mS4Paui
	AVuRZOsQZ1NH3qqSsZx6lppGrg9C3NspsYWjJuv2+PHmPMQeIyJj+DGusix2ouiv
	tHaeNpcdX3ExuUG1wGiDIrqy57MaC9kKkF6yRmKwq/XzN5VM/DDMf/cnN/MEKmGU
	9bSV96XM4b7LibLwLI9h9NJPuQtAMidiMF5S/8ibPIcTgnXW+CoDy7V3TjlcT2xY
	NWHDeo3MOAwlai1x25XMOBvTshUJD9DyGoJMiALyLO6UM35FDpzKVthGYg7D6DaM
	Ri+VQChyiOjI2G3THsOslwh4pSYfA6eG8qIqh5OLIvByt7xLZlbFJGW/sHTXElZf
	mMxQcQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c32s3ahv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:12:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso18428046d6.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770120753; x=1770725553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Vx1+aGrw4+vH/imMb6fHNF9uGEkcIk4iAr7YXm2HhE=;
        b=KLQm2f3r8yJ4lzOi8SLvyp5owO/DGdRhXxym1pf6Gqoy4Vv4e20Rdouvjke3NoecVZ
         IrPBFMz8p+kGycj9dThma0mZWL2DkLisD6AI8Qd4MRoyNzsxIV4DAiw9P5mEipWGsQP1
         +nParv1bx6Vj/qu0dGi7mmxHNNI/d730PqAV5xG1oo8IJ13R9pya7xf3kdw382OM+h2l
         EOmzkm/msH4jKsNV85HexaXj+WUDQDTJM34VrsI+L52R1/3Y/J0BDYJ3PxSm7lRyNDgI
         kcQvQ3Y/psA26a+2Ja7Nkr3cSgDuwh1/62W6lepuepoX8fZLIjinMQA5XHuJqNL5CQu/
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120753; x=1770725553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Vx1+aGrw4+vH/imMb6fHNF9uGEkcIk4iAr7YXm2HhE=;
        b=PaeOXvuXi5Da1OTZ3zA7LB72+3Lsoeqtni51DZ3g7vetkZSo4mEEB6wmSPtxoF5Mbk
         u3xBlfa3CUPU1tpw+ZZodUiNrLG3RPinox76OnIt/1xWqYsfKZBoY02gju+udedTPBrE
         5oXgo/NvAb8RpDau0SbJFMM/l9RD9HLfQVYU1XrpYm1p1SSE2QUc8tbuS/61SjOgx++3
         91MGRlhFlhY6MxtcJHbiEAdPr5ODFUQyL78wrJbHsLahjBrLPKZsgThqdRg4IG+uURkz
         U0SsvvojI1O2MwBA1kw6rWEBQStI8/TPB2m0A5y0xq+G/+YgkdzuTdrWy+g55OwbLt8E
         rgRg==
X-Forwarded-Encrypted: i=1; AJvYcCXTG2+mojq6Pa4f9EKk08oLNA9RgeeYGtbRnduqS+Kjw9VnMT/pnjoTrW9bJooXjhjrWAYfJkR9Bh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDT41D8+muSMOUHRY2ubHqdclgZ8DejS7I1ZUnlnCKIBlpCri
	iENJd8Kxwen2/QOKDi6fQu7XZx6HtdI4hJGiMe8iV65IAq/PUMbI8mYu/Ck+GX5YVE8edjSv2Qa
	rgIspTPwVM3Lnic5C+DANMc9ypl76WV1lNidaeuBpNDg4v+baJB3Ab8YUqzDeWyA=
X-Gm-Gg: AZuq6aIUQDD9YeZ/Ai0YXiZbO6B7ABKJ30usyxh8TjyUUtOPrzwsz5Gl7dpFjogStI3
	PPaO2blfBd7uajniL4nbxzKwQztZLLE26wydt4R5I78iEB7QEBeOz5Z94LvXG2OTxrw4Sr5llEc
	e/W30bDhbgsX6ygZoBLllkwfT32i3RcikzvUGL78VXFHAc+SkDrmj/3jl4Z1zw/FFQewfAgT6lC
	cOttN7Jl/J/sHnTD1rExVxh+AvAoVL3/fSJmBFWzjxCQDH5p7znyermkZPMp5Nsow3IZgCXdhTn
	r88T7Qw7MG9tM0t+RhOA6TS2oBcexBc8C0oJI/VHs0XrJlcfXnrJ6ldvNy7AFakFoiityr6pqkE
	SXhrKFKYj9z6Oj9MV4DKxlEi8+RWdGjogr/e6lmSwMR8ID3jiUeVvK1Q0H7kCx3PsI5U=
X-Received: by 2002:a05:6214:810b:b0:894:7135:8fb3 with SMTP id 6a1803df08f44-894ea0b070bmr142778796d6.4.1770120753131;
        Tue, 03 Feb 2026 04:12:33 -0800 (PST)
X-Received: by 2002:a05:6214:810b:b0:894:7135:8fb3 with SMTP id 6a1803df08f44-894ea0b070bmr142778516d6.4.1770120752729;
        Tue, 03 Feb 2026 04:12:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b40efb01sm9177383a12.0.2026.02.03.04.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:12:32 -0800 (PST)
Message-ID: <044b1634-ee5c-4438-962b-cb535e35c135@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] soc: qcom: geni-se: Introduce helper API for
 resource initialization
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-4-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-4-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zc4Q98VA c=1 sm=1 tr=0 ts=6981e632 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=eLxjEvbIFn9X0h5zv8UA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: E6LcCssIzERPb3NvcEJ6MgH6hzl3KPxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX+IKlZnymVwmY
 JSflNnqsLVd1DNPTW0G6i1TnihyJaobYgYE1Xm3YWdcCajWcpYCtNEGjCodPmo1ymMqTuc/7tag
 +mFrNTMv/Erv8JJ8NDkF/IPOx5WqUxesF1/T00MOpgpyYAmuO9bw/FewsB9GqWG0p85ianqjJx2
 km1u2dcZoWoMhnRX2Hyj++MTLmzNcuhueuc7a1NXHpNDH0dh+URPCm42+Pwq5634GI1MG5DAdyP
 usnN01dMtph0/a1VF2NjaGKJ8S8fdDM78YF2w1kZig+SxkP4IHHqALobH/2DzJ0CsKMsYjT87xZ
 unAspqPCEz1rhkrJoZZPndFYqhQPCyoA+H9t9ktt/pGZXjl93H7Q7rvCOK33iYXh436YQ3BjVRc
 cLsLKcnRRrUqHwnABIMdzQByrr6VhFYS0p1qbfSSuKrn2KkIO93m2sdfXVAXqB2Ys73DMs98B4e
 0rYad91GKAwP4nAXEVQ==
X-Proofpoint-GUID: E6LcCssIzERPb3NvcEJ6MgH6hzl3KPxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030097

On 2/2/26 7:09 PM, Praveen Talari wrote:
> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently duplicate
> code for initializing shared resources such as clocks and interconnect
> paths.
> 
> Introduce a new helper API, geni_se_resources_init(), to centralize this
> initialization logic, improving modularity and simplifying the probe
> function.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
