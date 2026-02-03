Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1A33E369
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120890; cv=none; b=qlHZRj4ls/lnxLXr5K5Bw3YUY+FtLSHeXKsmQMrBjjvrI7J4Od4oAOCA22ZIBN8j6fpQBsm6IM6ibOUC5QltOq+xon7qpbuN8pW8ePoiq2A5GodOQiaggzP8HwewekRPXuuEK0UVUOtgOa4fc/UycB3ts7bXHhE7Nd2pE4hTxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120890; c=relaxed/simple;
	bh=f2jxbDBMXSZTUZA+fhe3W5fEXPcXuzuwd9OFbZFi+aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO6W+16zW4vhgOH79IepwI7v4aTnku+2hW9vTRcM/WltmTzP8Po1CFDEcw1GtA1YWewdDuJ0y2Q/z5ACMFp5/fPRENMhmaUdEQeKwwqFq/k6+0M+htua/NLa9vnpujovsgu99jowxt+kyi4gIrj/za7NyOxKhTUGsRGSiwrCAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRKJPBxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hvPQWST5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRKJPBxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hvPQWST5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613Blptj2419467
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J0sfhluVRaK+7nfABb5VFYSmnKNequ3uhG7WHjNhsCo=; b=IRKJPBxXK21Kbtdg
	7/lM3CvcoiOV5N6Q3zMnyohn3kwx45Nwd9F1+fxycsMwkP9CbVlrfYPOfJgBsS34
	DHgtcsRrdnjtgC5Ux7DZX8mkCHXF+qlHIqUgsGArJCYD6Zk9YWL2Xl+R3H2sKTfc
	i+KJPCpNYG1kn6grtx1cGJhS9NzHpqAMX+wzBh13PSxraxGszLRQRFY4OcRHf23+
	jQuD644CyFvGE1o+LEgBo5s3Gt03EumpnpU51Yo28IhOi/78biWlLJQ40y4KLhVp
	YCfz2ztmkcexSDWxHHRPk/7Fr8FWsPuIczzNb0wiPA3Gaqv7u1z8ftxJahWUhgbe
	Zc+2rA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3gew82f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:14:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52de12a65so108566185a.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770120887; x=1770725687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0sfhluVRaK+7nfABb5VFYSmnKNequ3uhG7WHjNhsCo=;
        b=hvPQWST5GI7LFpa/YGhFB/XBWKmFhyr4Wm2NGt6AWavoYky00ufSrtLT93lnB4CvX3
         YdMWd0F7OhBP2iy+aclF01TQGu+y1bZvmDT+5ZorMjqIoJa0lbUpSuU/ASHm0BZFCYk0
         4fBrRPqWM378M36sArl8d8eHMZZbdKVP1ptbP1wxJXpffhVeuXIPUFMZGzmfc/ECqXe+
         Bs06dKSZv0drsQq2WN7DP8IxWs/iPphs3eVEgHiRuBKgZoYpElRbT0wMRWWpou06+1Vp
         jpoR5EzoKo5V1d8fsASQUBLzpWWUu309UizSe/SR5avRY5NyUBgP1LbimMHDieE1dcEm
         MG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120887; x=1770725687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0sfhluVRaK+7nfABb5VFYSmnKNequ3uhG7WHjNhsCo=;
        b=YFjaWRqBOGkrMXu/xW9V7/A1r2+Le11oe2grzaV4tARfpwFb1N0l/e8ACNm5eaggH3
         xP7rixt8OKgCScXqpcMvfx+h3BF79zvaJd60ZCxN31DduEWj68LBCsyESftFvCEHuhNP
         DwP0W4pROgnjL4iCcWcFaBYdBA3b2BWNfehiW3W6Z9lw6fAtulqXyRFQBic5iVbk6qF5
         sUpA8H7/7mli9WpXBsDogOHbz9KTQIIgYYIUCjmch1GdJcjIEvb77tCwtMt3SQ9np80f
         hZOXIUaHiigIxnB3LOoh8X46HTiEqZIWzdmNAvmqR3vsNR2fSaOiNyOF/K0HHtx00uzO
         Ol2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+cbmWNdQoBtNxXajs1obxxBDl3Fg67uSWmr2m7dzTw3l9/tLhB4GDx1CN5XE3ujVAV1HM54ncPGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrjCD/ARrGLOOJsRVHFOHJb8pMI/YlIABNZF5JJQogmFlaQvR
	engWXlhh7HwvYAo1VKOdI+7WRi/WITSsu8jmKVgvuWVcA6ZJYHwhMca/Qj7J4Kp5JweRMmgMoDt
	WIo390c9wCa8M2S+zYoEsxV7sKjly1iqo4RzeJWByvwwxuT9Mm+InVotsTlqUKVk=
X-Gm-Gg: AZuq6aITN1fFqKsIAidisUamEYUXw9gfvomQ4uX6D2QfVhU1QP1mmp6RTs6svyQx00m
	jIxpZno9Jsr8arsJfqorkcpDqz1UDkk43NPpvOXyno/dLfW9vZ52wtoVOXejeJYlWuUYRz7+cYp
	42O9ThI1+8ojfD7PS8e8Ag4H1kR6gXX0cq95Qlweb/EI0YRu2hHXJzcKXEmt7TCw1aq3xx/vGR4
	MBUNJ56/fkVgiepLmp7OogysGiIlbluz/onGttYzTGAq0AEIY5l1aolUy2KnDUAis/1bNDzJuYE
	gQ6yesbsTZn9cegIAgez+ZbqU6DA9IdKToVlp25haygWIw9XsqeNA7/zgfWnTgAjgjyklbv1uTa
	YLPzK2Tib/z8RM+EaRYRhMDsNUzq6dFfDtvPbgGF/fEnoFooRPxtwQMQ1L1hUWWv5BiI=
X-Received: by 2002:a05:620a:17aa:b0:8c6:ab77:f95e with SMTP id af79cd13be357-8c9eb352ba1mr1354436985a.11.1770120887418;
        Tue, 03 Feb 2026 04:14:47 -0800 (PST)
X-Received: by 2002:a05:620a:17aa:b0:8c6:ab77:f95e with SMTP id af79cd13be357-8c9eb352ba1mr1354432785a.11.1770120886907;
        Tue, 03 Feb 2026 04:14:46 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de8c93c11sm849299466b.28.2026.02.03.04.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:14:46 -0800 (PST)
Message-ID: <540cbb53-1028-4f17-ab83-5ac4cabe3421@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:14:43 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] soc: qcom: geni-se: Handle core clk in
 geni_se_clks_off() and geni_se_clks_on()
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
 <20260202180922.1692428-5-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-5-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5lZDQ5pMxg921d_E9IDDxe7ir3JP7x7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX7OlCYdKSOiJb
 PVL8KL7NnuTPlS1cznJDlnXUmkGCByU2MiVIKdpNvrJNQZw0XQRTRXLW3eVtsWhu5JP1FlfC472
 feOfYKnddIn6GKjE/MbInV16tUiSazJNqxACAPyrV5/tdKTAVoHbiqNO4x6bxxi4I8fht+seOYj
 UPYwsy9+tlxD69Q9Dtsmhgs8hoPT7hikKgChZkPYFSU/ZHgO3p2df/cEyQZVYIAeOFsnG0d8icq
 9gEF6Gz5crtMqD2Q7ut2+ak/0OZ8qmV0HA0spz44pTQQSCNKkz9Ctnj6dASghd58+IGLGa01Z9e
 nPx0vn/UYQ4wq5muo+2u4Yh9/6pdReR37oSEIsIM2cfpiWLErULYhdeh2Rx01Jtg5k+edHnqryX
 Ys+vlfbPDuir918ryUlAVB0x25gauQ5tiRBmjeELcEbyNPEuF4wiwGM8AlRPDqp7Qh2KSoMQrQf
 WuUOdtkm/jpXpctQpkA==
X-Authority-Analysis: v=2.4 cv=XI89iAhE c=1 sm=1 tr=0 ts=6981e6b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qVim3Os-OfJW7Cew8TEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 5lZDQ5pMxg921d_E9IDDxe7ir3JP7x7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030097

On 2/2/26 7:09 PM, Praveen Talari wrote:
> Currently, core clk is handled individually in protocol drivers like
> the I2C driver. Move this clock management to the common clock APIs
> (geni_se_clks_on/off) that are already present in the common GENI SE
> driver to maintain consistency across all protocol drivers.
> 
> Core clk is now properly managed alongside the other clocks (se->clk
> and wrapper clocks) in the fundamental clock control functions,
> eliminating the need for individual protocol drivers to handle this
> clock separately.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

It may not be obvious from the context, but this core_clk ptr is left
uninitialized (because it'd only be assigned with geni_se_resources_init()
introduced in the previous patch, which is not called at this point)
so everything works out

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
