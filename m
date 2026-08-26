Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01493E2AB0
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749551; cv=none; b=OowlnISAWtKov186vdQeeYaWyjPpuUftjTCTimFHPvLZOmOJIxPXNDER0gQm0yJhYVgbiMb6U8vpjM7Pwn6XvmirAaT32azKCoBkaTEYHas6Ezbt2onVOEH/VhbH53TZ3N8nt6drcRRorVnlTve78SbNXU1UbRLQiTYLXRYidys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749551; c=relaxed/simple;
	bh=LijM8Pfb9EoXv1mU9m4EvRD4WSkKzNtw7DC+krWTGj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rdj5eX5RA94NhJNPq8tYqXOAtky7rfbdzPmfASY6Kx4FxS7bDGz9YVbfKO4JoAMYhB4Hj4ntG7eb6jwPqwTeyjmRkquH7avAmQgC3BqdOIm0gnFjpsYXLnWWq//jBOP3Obzmp5viQvP/l693Scn/cq37phWxUr/mILj2aE9ntLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NA6VaN8O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBXo8B+M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NA6VaN8O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBXo8B+M"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCC3At3899151
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 13:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6lZQSfth91J4kyFwj8xgnIzOpPdRb9+wGlLaKarABNo=; b=NA6VaN8Osl2+nh6Q
	r7rCkOgZ3SepqkK7AocvjjmSPt56mfx+UjH97ddBECTcSIOAJaIGhSJdL/YYWbwG
	U7WBAtbCrTsOMC44gTxfTgWlRsMl/mZR6XR10/rnFdf3w++o2P7JbtpU8dLY/78T
	6/Gf0I/854vZ90XWovcv/hNxa3/M3nZk0N+y3+rlJx4LvZ+skR8HonVmWuThkrxK
	SZW5H7HSXQk/KIbP66KgESp3uqIk35Dk1A6AakJW4YIZaqsVAoxw+VUuZ5uD0DRi
	BO12e45IeGtkIEe7oSiJlKzcgeuvEau5ccxPsyw6lCQovoXdVIjasw8CwLk07r/z
	qUGaUg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uths8e1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 13:05:48 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-977c5e92ec6so11640241.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787749548; x=1788354348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lZQSfth91J4kyFwj8xgnIzOpPdRb9+wGlLaKarABNo=;
        b=bBXo8B+MIvZ2HHDp5FXKDV357LAn96U9gcCfidpwYQCyxonpiGRj2+JPTd4yikRzVi
         hStyNmr8h9ov17pjFJWNNolefyha01l7m9NMubGECxwpfb28lI7ruOdLRYyqiMmIXd5H
         +uIcD8JZad8dZKAmVh/8c/qJbeAtNcO14A9MJtuY19XedH3o0UdshMoc82/HeRrNQqYg
         O+cfpLdLUFOYNbtgD4yoGEuA+jffc1SsscszJt+aV/ZlMvDSyyLPYdZXr/EGyTEYz1ng
         qIY849EhJ3nTXuTAjlhEN1ilybDre85BCV4qMU0TPlHvTulXJiTEInTfcT5Plc8QGFWH
         rRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749548; x=1788354348;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lZQSfth91J4kyFwj8xgnIzOpPdRb9+wGlLaKarABNo=;
        b=fg75CoR3Xpzk5PYhLLYXWRWfz3EVItQvh+i9Ge2N0dzytCMS9LTxFGDubaBWQxsWQf
         f5AjtnCfUqgpOaAKot4g3gtt/rJiziKQxE/54XonOBJpVi7766kgDTxW/sAS37B/QJ5n
         CFUuBo+KINoNNlxSxdZfole1sv7tCdVten/H2wgP8zusVCV4MkdCCSKArFgqOBYzZRgM
         uPzSw7gHDJcfU2hCXP/sNliqW5TeXVjfXd0Sa7JoHo0EzoLzP0y16TN7XDfy+/Aer4+j
         cZOzvadvqjFPaofWX33sj2AUa93r3j2CjZMauEoasxMvOPzaAJQU3XV4Q5i25lo6El6i
         9o5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4Vzv9oqjJDyo1XVc89uFDit2HotGyWpiG06DE4PNr0M/EUr9aZDs2temqV3ZKRjc6+P3g7YaeEKU=@vger.kernel.org
X-Gm-Message-State: AFuF++kyLnJ2fHcR+CjY5pwH0MAvvhFwYvceSGr1roU1vyhvPYruGQPl
	yUMUOKASTa2j1GSOXn+fSKO+9BoHRtVTdmhrATefZYcBHj2bGK2ZUp8vbXzkiKUNYPS5owKDpE0
	qTpVyzO4WfPqhTGx/TAkJhTYuKc7/RtWOvbyvGfK8TC5+UwKaRgCNxPAn1W7e75E=
X-Gm-Gg: AR+sD12G+FKuoQ7DgnRwzwl/tvkNPYL3Q03WPJBkCRUUuLtqXX1iWrgGhCTT7eGhtES
	6jld60csdxYxkDeiKM1WjdSAep12vg4sdP4DM20YA+Pz5rab5KwpuOGb6zG69G1qsOGWOjX/6Hj
	BA/H8SxnVb/fy8yvh1w46hHilpt6N3TRlGXluzAAMH3ArMzJ24gJUApWbven2qVutaJtmw3KAEM
	/C6f9vQ+0y6h811gum4VTVYYImgcWlIh+rEi5HAgoyc82GxhDcV32ZKLD4TECYuXT8KSYltlH54
	6cDsYu8FxuOqLEzhDVp6Vhd+YK+zZsP904DpCmEnI3tVTazTiGbGb4iJ7Tjahx16dbe8I/Pa1u1
	IQiDagFQgFzsu+ghP2KWN/fkD
X-Received: by 2002:a05:6122:8497:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c66c2ca6f1mr71830e0c.0.1787749547928;
        Wed, 26 Aug 2026 06:05:47 -0700 (PDT)
X-Received: by 2002:a05:6122:8497:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c66c2ca6f1mr71785e0c.0.1787749547145;
        Wed, 26 Aug 2026 06:05:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d647dsm450943766b.13.2026.08.26.06.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:05:45 -0700 (PDT)
Message-ID: <6cf9db07-e46b-4037-b7f0-03874b62b36b@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:05:43 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
 <9c8e4e57-135b-4f24-97b5-dde9c0418efd@oss.qualcomm.com>
 <41af9695-44f2-48cb-b5f2-8e779f7366cc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <41af9695-44f2-48cb-b5f2-8e779f7366cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8ee4ac cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=-uBuh7dnxZ-1HGoY8H8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: nguaAkEf-6cKYesL8lI3ETU1cBjQFb-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfXyKAH9DDkPf75
 obMSEzaeKK8/bQXHFln/cWixlqCrNNtsNEReb55/xdHJDgqoIJZLDAfdgwDyCr1x17/dMEVJfvS
 SHsj2RFRRADKSe6TJxK+dwqDFBIFNd99jzNANtvN4DsVhOyRr2hiZ+RX2F1RtM9L1egaY00IqSY
 ytZSNY3y9ulwdfSD1LkeyHmcQeLTrWDvkKjuoEmjfmDoEDM2edqOpWZUw31mwati/eYCRbpueA/
 1EOGhQRnF9wz72/Vy9a3ZNDBOVAMqyD3eltUM2l+iFOKW78rcyLX8Eo8+f8LRTORN5AXlRfl4oK
 h4qyqcxq1KQA3jz3AqM1vA/yK0LtZFiepwNrpTVGeDkg9yoXjmm0NmsMt3xnYcc4Pe9JKz1v00+
 35mYuhK9BntgI3YxsY2yDqwzETnPVCg4sS8gw46yfgfwddttiYizX3iD3LblOuLBdlSR7bXxp0H
 tqIDBcMtyP/0n66u5kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX5kyIYhiG0yqy
 P6OeZGO1vT3RF2NvMEm+0+wrS4EjcIcXoVaxtBh/9lFx1MuG2mgWkwUp6HPFLTfHWIh0DILXbxV
 xDvYQmIKTWVRqMJPL13j4+/d9YyGQ4c=
X-Proofpoint-GUID: nguaAkEf-6cKYesL8lI3ETU1cBjQFb-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108

On 8/26/26 2:52 PM, Viken Dadhaniya wrote:
> 
> 
> On 8/25/2026 3:11 PM, Konrad Dybcio wrote:
>> On 8/13/26 5:52 PM, Viken Dadhaniya wrote:
>>> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
>>> controller that operates exclusively in target mode. The existing
>>> Qualcomm I2C controller drivers (GENI, QUP) are master-only and cannot
>>> serve systems where the SoC must respond as an I2C target on the bus.
>>
>> [...]
>>
>>> +	ret = clk_prepare_enable(target->xo_clk);
>>> +	if (ret)
>>> +		return dev_err_probe(dev, ret, "failed to enable XO clock\n");
>>> +
>>> +	ret = clk_prepare_enable(target->ahb_clk);
>>> +	if (ret) {
>>> +		clk_disable_unprepare(target->xo_clk);
>>> +		return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
>>> +	}
>>
>> Does this need an OPP table? Presumably we need a power vote for each bus
>> frequency
> 
> The xo and ahb are simple gate clocks with no rate states —
> xo runs at a fixed 19.2 MHz and the ahb rate is fabric-managed.
> Since this is a target-only controller the master drives bus speed,
> so there is nothing for us to scale. OPP is not needed here

OK, thanks for confirming.

Konrad
