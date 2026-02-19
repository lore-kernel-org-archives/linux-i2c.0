Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9326D4F9
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512497; cv=none; b=uyFXQqNLcuA5pEELn9AXeYdennvX3D9B9pRJOHklF8MHGBV7lzTBO/KoHNunUuoiHLRgkWznwJ/2g6CYcJ2r8X2G1aGaHvXEldu4FiZY5Duvn9/r12yRBLhBk3XUjfKtGkIP9XC4iuyKJrTJgY+2jhg4R24W6uhDg5R34Iaa8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512497; c=relaxed/simple;
	bh=agSplSd/enGrqJJZuVigfbtb3Q3utxBcL9jwX2fg4Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyCdpmKS951jKEQZX7Wsfb+1qapTIStWBGmZS3LUVPMG4ES0m1ftJF3kEuTtF4tUi6M60PY6a8M8oNjSaUGgUF2mmYWAoRMBFWzs/HtUDsFuRBtX6OwGpPEYe6KGvB/ZMiShCMsOeorA9dT92prnzdyo7cyvM1PCzSl82Pw/SmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zv7xyDP9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AR5xnM2a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zv7xyDP9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AR5xnM2a"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J56pLG3319800
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XBcT7y8QhFDm4R6m0oBnSylOPPgufl79tiD50UABjfk=; b=Zv7xyDP93EjGOkeb
	cSjqOX61nOl24EJwgwhtYmgRyuYF7/V85GvmfY8vjYI6rMNDrhdpQmr6/Uh0qU5v
	4Qt85FLrvmHq/ndjQvsdfJjeoX9UP7MPifmOQzVAXnJFz1uG2yJK2ijN+vDOasUV
	96zs2/V+TVxdrNi5JVJT5Pq/8Akk3OmimzEInXdPiA+vVZudFV5SnvU8jOR/mJIh
	/M1fm2MBZOdO0JrjFCOvTpGi3s8OzMZ1dCa6HgVgU+3BWlR8np1wO/PsIKxIprXi
	tFp2Fot6QxWoI9FagV3X2CzrIyftkF8jxj0IK2QVHYcBO19MTHNE3DTuJ4B1lHuM
	ELiBbg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdv389fx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:48:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6dde310601so667630a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 06:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771512495; x=1772117295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBcT7y8QhFDm4R6m0oBnSylOPPgufl79tiD50UABjfk=;
        b=AR5xnM2aW5PxcXfI6UYKJRldPf2EkXKcYzGiadoSS6QJbNqmKS9bZ6ZmzHSXwiIKAN
         c5Z+i57Q/6Qch2d/d7/oztM+qmCjRsFhUpsXmmxrImlG8CGmf88laQU1LCkRlxxu6J3L
         OA32cxOTgZgQE/EjYVl462uNabqQ8MoV1RUxNqmWYAAO0MNqImhrNoyseD+nG6zXUclj
         zQFAvsOzMvK/Nmlw2MGCM1GD3On9mDrP7v026dDrY0b8MfCvbs8CrV1kSRpth4sV6ERN
         r9OeDDqutufGNnhRrYX0RPk9zl2jEB/ATXI7uHVquvKLDW+fMH8yNUo6i/eSTj71W668
         Kmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512495; x=1772117295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBcT7y8QhFDm4R6m0oBnSylOPPgufl79tiD50UABjfk=;
        b=sg7bqGdbbz+P9KyuviGQ/KdYS4rP6UEvDxmkoEUyh1bv0UnnJhpwXc22zjs4VOzEIm
         I49ecbhLZnMlqy/DjYtS1xvk18Qcstgg2YsrQZSnI45DDeSyFqqT/xe6ktoNefNBLu5m
         4YM44rMuPOzdrD4rSKnleyd5wvQU3vTcdmKXbKwK9cQpMeMNE0MBWpw9s0PioX7Zmtyt
         PddsKneUxQqb/MCzjWCXKU0vymNo8q63u0QK2VQTjXSs/zVXFFGNTXkfW0kORvbh7yEj
         NzTTepXwsDEVoakvc5iqaWZFz0TZLz2x3qnU7fkMj7524WFJw6LCxKDVg6EhFosUVtDl
         MTgg==
X-Forwarded-Encrypted: i=1; AJvYcCVWy9xGyssD88FbCrT2S4DD+zeSTUCz9e4vBQZNHgdUdjwcMJjcPLfk8RAsyOD653VS/5iic4KKE98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqupKe9PMzrlD9o7IDJktbZ8/AKisdEMI2Los76dOq03ZB5+Xi
	+xdWaEwCJWP5n5d+OVAnpVj0l46Fl5CBg+F/CSxw8vIgTnJ49lQmPRt6J6ge+bm+JG/M7+LujSB
	Eah8VSgYsrUouRbB9wwAqpIxdg0dSItb0XjPihqr4E/pa74k7Axd9nr6XINzgMCY=
X-Gm-Gg: AZuq6aLplmsa25Id7/MUWD44jMn7wmfy/OXU1WfrNc34EZWGJz9td+ZRpDSiWhy2Nst
	HSxoA11x9/NvdMVGVPDKWMR38XKc+MXK2Dxp0atMhPS17IS3fKme00jrPrZOzbcS1rPsa+6D4BE
	ZmD5NxKhgnfrlmSX9KZlLXHeT/Ov9UqlEaumAKcvzTcDHpLLmEzpOo8iwsjfIk3+PdYAnZQDHm+
	H4SFKFVBWXvaRlXmNmmWkLO5qAWcpz+6apF13s2pEPlpCtquMkQ7l82yCQkEZBvIqZDua5wvKOj
	7q8FxEHGzxnQDrimyiMnOrpnZ526RkjllQRVWwSVkhgeF3oMyvtq+UEEuC/Cje1okWnntx7la5A
	bBMhbV/93jsMdmjb6MeAynP6qCcT3eyIDzBzHpm4DEzYG+DTeQUDlbw==
X-Received: by 2002:a05:6a00:2daa:b0:81f:9907:e503 with SMTP id d2e1a72fcca58-826b662ebafmr2671985b3a.16.1771512494590;
        Thu, 19 Feb 2026 06:48:14 -0800 (PST)
X-Received: by 2002:a05:6a00:2daa:b0:81f:9907:e503 with SMTP id d2e1a72fcca58-826b662ebafmr2671952b3a.16.1771512493953;
        Thu, 19 Feb 2026 06:48:13 -0800 (PST)
Received: from [192.168.1.6] ([49.204.108.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a4316fsm26731201b3a.23.2026.02.19.06.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:48:13 -0800 (PST)
Message-ID: <84f46d61-ef92-4a44-9420-a29afabfb5a6@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 20:18:06 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] i2c: qcom-geni: Store of_device_id data in
 driver private struct
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-13-praveen.talari@oss.qualcomm.com>
 <3b9821b4-68df-4f2b-a384-912a2dc98bf7@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <3b9821b4-68df-4f2b-a384-912a2dc98bf7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ceffb3DM c=1 sm=1 tr=0 ts=699722af cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=SEi2w9hYDuVaAARFuk79KQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=bzct_qqClQXo_WY-SnsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: G0LBA5LXnKNLjAPWA0he62BqC97aGBN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNSBTYWx0ZWRfX51eQPDRFsup1
 i8PVS63n/kzS+no5VO68Q/nLCsE9M46qK/Txw2J1SNlIXZUK2e8Pkqod0DD0g6cRwZElXYmgelt
 KAG8ePEcUKyDMjr9j9Lawi1wX5CuRKD/Da1N8BGasfswvZKk7jZoFPFKUYFzbq6ES7W2l7kppIS
 bYMy455a797rbEmkPziMM5+6JzfUxYLI9ckulC5/zB2JeijZuUVyLDCQRQYBTymLdWdSuw+GChL
 hNPK24tOfGhriA5iXQOaKmANAN/bah/bZj9Z1mhymEWU5kkrm4qODQRSsoea0k1thbGvy8i5tp4
 YG2Vy8GwvgYqvf1HoDPPYdT9xLtYTGtdGqXgEMEz34qRX90Tw0AaxmEhq3oHIa/lxcZ8bnCP53c
 k1C/vwF1oga0R3MJMTRnfzwBIzIGkDNDDAoJaUq5KtU8gSslYRqO9KwgqGJiqsVS0/a6TZ0C8y8
 7DSP/hX8I2WVMAejMNw==
X-Proofpoint-ORIG-GUID: G0LBA5LXnKNLjAPWA0he62BqC97aGBN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190135

Hi

On 2/17/2026 5:16 PM, Konrad Dybcio wrote:
> On 2/6/26 6:41 PM, Praveen Talari wrote:
>> To avoid repeatedly fetching and checking platform data across various
>> functions, store the struct of_device_id data directly in the i2c
>> private structure. This change enhances code maintainability and reduces
>> redundancy.
>>
>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> -	desc = device_get_match_data(&pdev->dev);
>> +	gi2c->dev_data = device_get_match_data(&pdev->dev);
>> +	if (!gi2c->dev_data)
>> +		return -EINVAL;
> 
> This is an improvement, but you still need this:
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index ae609bdd2ec4..08e5a1917933 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -933,8 +933,8 @@ static const struct i2c_algorithm geni_i2c_algo = {
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id geni_i2c_acpi_match[] = {
> -       { "QCOM0220"},
> -       { "QCOM0411" },
> +       { "QCOM0220", (kernel_ulong_t)&geni_i2c},
> +       { "QCOM0411", (kernel_ulong_t)&geni_i2c },
>          { }
>   };
>   MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
> 
> for this check to not fail

Sure, will add it in next patch.

Thanks,
Praveen Talari
> 
> Konrad

