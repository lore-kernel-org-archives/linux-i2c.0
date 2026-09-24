Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B63624C5
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229682; cv=none; b=sono04ChELO8McFbAOvE2uJnt3wT4XURrqVkpQ/gg+eFamGkStot5s6ypWXgR4htrvjsKaeJekCsJmbxKIkgeIcmdLXphxzkJTlr66ksIDiJxglAaVy/4xmY7GSBX64tbQCzYWH3eznIoBBMWH+sq2Whiz5Dlihg+bK6pmzVKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229682; c=relaxed/simple;
	bh=sZH0RG9xYYcnMn17IqWz91Mvah4dkJO5Tvq7b04DPUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+QAKr0aSzYmTzdZCD5RLcUquOLBj2/ATnbKXTV7Nry8rrBAsJF4paKbz+or23hSM3e2dmHTlAbOtKmx+SEhW5yY30SQOimxw9gGZQrrQ/TsolPrLaV0j+arWE07NJVZi3+u2SyfzILmOR2TGlfJXAV06lhzF9e/kSExy2gXcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyPyZurN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JgZtJR5+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyPyZurN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JgZtJR5+"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eHlR4147742
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 06:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	36SCu595fBrAhzUja5qO5b1ec1y+vrmrZIti2coMSts=; b=OyPyZurNVLfEgYX7
	baIy/TY8ui3COJ1XpoQJJjMyEFxEU0uoY9zx8zNH7KrXnIqBe/eRJISRLj6O0WbB
	HdwfGHemPvsozsij7TzrIX3gLVFq6OQ778FFMReSHE1Hb1sgdrNg6YuVy9G40x9X
	uaD9A8gVSAZCdU124e1z2QlxNKehVEt99yXwdBS2UsCuyalZAjFnIImc72x68Ud0
	xP6J2qQQmnHBZa6KGB5MUfr7KRISJ9LMnzXbRpaDsSORs+2G+esEvtFzVXf17Vxz
	7SrjtHMYLC1Pt3tJgfGJYc+4LwFSz789AQQ1pI54Rr8ZJWORaYDzttrsSr9PEoBX
	nLa8zg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv3gnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 06:01:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so2707294a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790229680; x=1790834480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36SCu595fBrAhzUja5qO5b1ec1y+vrmrZIti2coMSts=;
        b=JgZtJR5+oqtleKd8OZIVM9Ofywn4/eoNlKzBC9XzsiKeezCePtyducTSIuE/gVJY5N
         4laLnjD6MTT0y+iy/2uRAkd148x3Yhjj8FD6zCp32JO8HvcdvLo8H02zUZtpsfTYpLlt
         OAu4obdAJvwJcKLUt2GScj4Mbkrq7Rk1aj+NA9h1Fr46mzpS2FlA9d/QlwdPS/KzjcIg
         D3dX9058Y1pIm8K/6/OxzJIPjP365qye7rKAvKiilwPOwrri1S3q/9ozQtOw6WwVrEnw
         H+3XVGGN8NKyqGnb+1kdVRvAI3ChrxLn5isSUXY5miew4lkRq87KZgWOfK6vr+ogJNbD
         ED/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229680; x=1790834480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36SCu595fBrAhzUja5qO5b1ec1y+vrmrZIti2coMSts=;
        b=Z76FwlX5tOlzqC1AOSoYNbbWhWewJjjX4+Oa6DbODk+Iqvfq8kQVDNSUpiEMpdr2lB
         fHnil94DYjxXxk7KjoQ4dVqWXJrCNUeCNl+j8CXkbgvDItosNtiX6xfTnsAyyE5CULes
         FSUBHydjIrl0w4b6XcW/IkEbGgh8mUtS5yvF85XVoK48NVCKZTV1zJ0DQqvecxF8ySqz
         Xa9K0C2hHaBlazgPigUPGmis3QlCoEp4iXEIkKjhe7a5L2txdh3nL3gv2Qwsg/HHd4qa
         Qcp0PQ3Y96hxVCchWJplAkPpD8xbOLB142bxfMrHlw1yfTxwmUL0Bqu9NjfSd0kEnnZu
         30Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwVXVyv0sJjx2YeuD2jO9nM5j+/w44MXfuBcgGuz0iNxJ+nL8qUpyR95mkbUU9QbtJYYKVVGdh0A0E=@vger.kernel.org
X-Gm-Message-State: AFuF++lbf5SrlrkhWV5n0AW6o1C1u6Sc1WbAXi+fHJBFapYb39nksWju
	6OUvB79CrL/yrGZ0bodTmczH8rfVmgNldrOr9VMa/N4XalkKtOmVGh6wJAp5dj+QGcgI+BKLmu7
	IH8W9NLhYSkW2jy8pEHbS7Kb2u7VBku/HDBuL3djMLLP0tm/whejwiRcn6kXMOrI=
X-Gm-Gg: AYBFou3NijoLlY5MUq9z1d4AvnTJFqCGCXm8eTI22mvzNdMdQZe89/48DZTN06B6LIr
	trX6SwkwTRaofuJKGqPUtgYEAaWtAbyk2ixfzCUcTntMWDqmUa8NNVCtGllz6pT3svY4k6Psi6K
	KA2V117QYRxLeK6SsUgFDxodBKaNVXSti8GjUD6mY1c0gaoaiMZlzrJa3R4YThNK2YTQMylUlxO
	+TA//Q2p+y4uxTCcXzLD2KaoJDB7re7zJpzycFgwswJF0nhD79eOq4zYzGcU2hrWUVH89T7WBLy
	p9q6v/w95tKAv3vGbkXKY6oBMJJUA501hdclgcmfjQac4T4Sg9Q2pfcESWU/2VMRorD9M6uauDh
	GCDc8QDOdZrwXwZ80ANcw1S7ISt8=
X-Received: by 2002:a17:90b:3c0e:b0:39e:4c81:6c95 with SMTP id 98e67ed59e1d1-3a098dbb040mr1336698a91.27.1790229679593;
        Wed, 23 Sep 2026 23:01:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0e:b0:39e:4c81:6c95 with SMTP id 98e67ed59e1d1-3a098dbb040mr1336662a91.27.1790229679096;
        Wed, 23 Sep 2026 23:01:19 -0700 (PDT)
Received: from [10.206.111.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09733f48fsm2861152a91.11.2026.09.23.23.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 23:01:18 -0700 (PDT)
Message-ID: <233a246c-1cb0-42d2-b752-aaa208e1ffe4@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:31:11 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/15] media: qcom: camss: Add Hawi compatible camss
 driver
To: Bryan O'Donoghue <bod@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
 <-SfKe1h9v_GKikJ1GpSP9vCzngJ7rE-jLyFCc419KBCuxpKK_kH33Xd65VtCIyoH80D_SMZP306pJZ7aKnpxdw==@protonmail.internalid>
 <20260923-hawi-maili-camss-v1-5-cbbb42e534ef@oss.qualcomm.com>
 <df6d93bc-b0c1-489f-9ca2-7de4d355ceb6@kernel.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <df6d93bc-b0c1-489f-9ca2-7de4d355ceb6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNSBTYWx0ZWRfX6bl19pBG1klY
 t5nMAsWliVK58Anmfxazjv5TLc28CBNLvb+z7tFcLpNMbXHv+NPw2f1XBYB48LRoroS7C9FY7va
 ruXCvOMFC/xpB0q3tUNLQw6RNuj8gzYVHRPzIeHbrZFZpfZyfM8uk3mQ64VGgz6kb+EwGy8suK4
 QqsEJYBi6OlSnsODgPQWhi4tpLJRrAgSPV0e0XjXzAw4c6a0wWLKxJXeKgdBalt6lTa90WpDU5g
 A3FhSmyWYO1q4bhIDq7NA6sGTjNIkxcjEqKDbAiV/SnvZMciPul6odVzscjAKQ+E8iNjUov+iUy
 FaktBaF7br/ej3yL4Jfa+r4d2ATstf78tV+GlhKYcVSjNHXdnqlfcnFFTHMgP8gtRdpLWC4BGYU
 RSCC8wZcSc2fjdooTJot15miz+HprN1em7lN82s+BAk8xfU5//ijqzKLbdYzbirGRwBnMI8JIei
 QXfLTMzNKKudkdMehcw==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab4bcb0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1yR11Y51etnruO7JmzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: y-r8mAiaW35jv_Cl0AwUI4G7HXtPkqQS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNSBTYWx0ZWRfX3qeF3IHA/FeE
 YgMxOElupCAQsWnSbCNtlQ3xf8Z3VAxrnvgx4PDzitQGdxl88n90ia7suRI7mPdl8cfi87kcjs/
 BkHnAV1kPrDAwvzE9oOlZGqtxrOcQM8=
X-Proofpoint-ORIG-GUID: y-r8mAiaW35jv_Cl0AwUI4G7HXtPkqQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240025



On 23-09-2026 18:00, Bryan O'Donoghue wrote:
>> Add support for Hawi in the camss driver. Hawi reuses the CSIPHY
>> resource table from Kaanapali and the TPG resource table from
>> X1E80100. The CSID and VFE resource tables are Hawi-specific.
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Missing Co-Developed-by:
> 
Co-developed-by: is for authorship only (submitting-patches.rst). I didn't co-write this patch —
Signed-off-by: alone is correct here.

For patches where I actually co-authored the code, I've already added the Co-developed-by: tag.

>> --- 
...
>> +                { 0 } },
>> +        .reg = { "vfe0" },
>> +        .interrupt = { "vfe0" },
>> +        .vfe = {
>> +            .line_num = 3,
>> +            .is_lite = false,
> 
> You should only have to set is_lite = true when it is true.
> 
ACK

>> +            .reg_update_after_csid_config = true,
>> +            .has_pd = true,
>> +            .pd_name = "ife0",
>> +            .hw_ops = &vfe_ops_gen4,
>> +            .formats_rdi = &vfe_formats_rdi_845,
>> +            .formats_pix = &vfe_formats_pix_845
>> +        }
>> +    },
>> +    /* VFE1 - TFE Full */ 
---
Regards,
Nihal Kumar Gupta
