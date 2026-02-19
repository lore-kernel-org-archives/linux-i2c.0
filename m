Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BB341062
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513128; cv=none; b=k99DAIN7nzgOiQJ1EKKEY9S/vyMjiDd3gNKoSMUrRqNWcNl8KSyaUzhV1wr6heir2GiLtmpKaeLZw4MZwtbLDwE+tnSlZLNmCYBAJ+tWd850JKc9KonOR/CT619WJX6Q8kGkMNULRxAMi7XM0ufhb84MJmfOJvwZ66R7UBYdo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513128; c=relaxed/simple;
	bh=XSqg71SAS4s2Mq71PZrvscXdeTD26R0DGY1v33l3erU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH2WYEnn3bQQl6eS6q7Va4uqw/3h14m8NPIcasMgGJ/CgqNAr9Z+aJql+Q/F3LHCwS+MH2JM19l1WcouwqnSK8hhyKl4hqH0+/kqxMIK2nzSluBoFFBa0jP+EIhEUjQSzzeEz+Xpe/YmSP76XhvtykqWDgRJsCq6WlGc4TbJPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICuGd9uK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U7x5Ah6W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICuGd9uK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7x5Ah6W"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J8WbZE4055318
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BZMRtc+BiF/gI74TfCZJc35g7vW2H2eXsMdnM71fw60=; b=ICuGd9uKb8AsrBJw
	XLuYJN/+IVf3a6FIm8IYbwfjCnWOjoV4kvpIiWgJgYG8NBv0Pl1qc86DmBLle4dE
	kV8lrhcvZ/d3XFq80UxrFTB4T84QjP7SgkiCMrvDPL5BOY+gR0KZbYLEKIcNvPES
	BVDclVv2d9eRugvLvp1yRPrc4kycDTbra1nuFgGjTAhU3vu4b2dplK4c89YROMZz
	jMCaeHGaoG20Thg8/N51bBijsrREhWkcwBMwASUmacYqjurLEqzrr/Xe51lQtmxz
	yvhzIZiq9pFzl1KAHsvFQe1gx+s/IzQpdtRoUyZd3VzijQJf6r+F/X4CSrQYYXmB
	0PD+1Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdv389gv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:58:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35658758045so729158a91.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 06:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771513127; x=1772117927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZMRtc+BiF/gI74TfCZJc35g7vW2H2eXsMdnM71fw60=;
        b=U7x5Ah6W9Y08crlSOiUQGcRFb6vnfR6afL+q+9Ax5IX542s+lf9lftvjcLM/zbyc+T
         qSkJ5lqV+iEPcgjLNJg2BbcbS/2FbMXdp2DVSuUkawuR+rqG37plMqj2MWRJd+S3XDML
         EacsoFUFiWSsQXhThxNiP3n7huUD2Q/SSQ6tnQmjX5687OzPkRkN71S9VQfldFWgVuRt
         j4nj69ySv5IWuSX4dU2MeM8+J3OdDBXsrDYWCuiyBoHyuEP9W2DL6Z0xHIDpImRoo6SO
         8uRhZByJpnyZx1f9zxrKBo/MNupXddsFQb+1EM5GKB/smiT0ykpS7ysCOU6IcFhFvFZh
         X0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513127; x=1772117927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZMRtc+BiF/gI74TfCZJc35g7vW2H2eXsMdnM71fw60=;
        b=MuP2jg1tZ5SDbKZ7AuvjliBbRhK7Wgib/TCCkSuz5OmDilX4683El+AcBjX6+19dIs
         lc3JF6kcZlBoe8myDhnwyas1/MngTAEmnhHy4+8dtGk8WY1e5Us1iizVnHgQUBp0eE0m
         Lm+qC2K0YoSSLhgXqR5ODihg7ShvbRbYVZbFM7DDuh4Mv7sapX1G3JsjLyKX9oggQiYq
         4zyO9G2XNGAotuh2k+r8pJ0NjUlWmZuSb9mPwX4SW27WT2onUq4H2oB03mL7EwP0CkBv
         3CRVdv8eoptxb20f8zjWesZwnP+YoC4nHvFyyMJS8s5kMRkpPcZ0zZkG3IGQoEOsGg8Y
         JVqA==
X-Forwarded-Encrypted: i=1; AJvYcCXvU/nyAhfK3CjDkyFXE1xy4aaQ5eIVIHVJKHABVl6HCcDf+mf7wnOJDEtcN38bLEB43FLfWHMoeaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/S7fYxfKZ9/aTRQ3MiPXOFnnsRKonaIT+yB9mXBnJrBYkBgD
	br/+CZrW2lWnu4JAgPiQJu05PIdomGQ06J82vHNU8cDaGdF4Cq8CRlDyJq4h/sQyTXmEoFCwLZx
	j3ztSaeOLykZXmkf8b4p2SEmAKPbP/m466btupdyrjFb4ctQkNAkFcoLk4DVW1n0=
X-Gm-Gg: AZuq6aJbUa4y9Y6szpOJMz9D9225xImPAmoqaAv4coEmQUpXvgZbCDUiGYZprKJ3a9M
	saWXS0DZ49eN801T0VAlCKDTpHfN+yiGkhnLhMJ6ihtw9QdM4Lef5DwVPRex+jvXMhoVZZ80Jds
	pUGBzn2QBu//mTr2OAly8eAICIn0bZBIsCsb+Sbr1YHFpVBc7Fwlw9i3aSHUC2uEtc0LTQkOcBn
	ujl0Hw3kuXVcQGdXwwgw739CFY6eU7Ow+ChprT2QCRi9sY9FekvMavCayBhpxvVJ3xXkIlu0l8a
	8AArcqK+tclvAfn/gKUSCsSZIicOLwt3i8A4cuBtfnhQVLLn+QsweVUp/+krUrb43gsT9LYmxny
	ua1cjeyL6uWjv0a6WLdHu7OVx9tavvUjPZPhfHQGxrvZ2VBTKfGyttg==
X-Received: by 2002:a17:90b:274c:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-35844f85b15mr15779179a91.19.1771513126564;
        Thu, 19 Feb 2026 06:58:46 -0800 (PST)
X-Received: by 2002:a17:90b:274c:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-35844f85b15mr15779151a91.19.1771513126008;
        Thu, 19 Feb 2026 06:58:46 -0800 (PST)
Received: from [192.168.1.6] ([49.204.108.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358970484aesm1301630a91.4.2026.02.19.06.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:58:45 -0800 (PST)
Message-ID: <6acfbc33-cdeb-44ce-8f80-90dc18573464@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 20:28:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
 <20260206174112.4149893-7-praveen.talari@oss.qualcomm.com>
 <119f619e-9f3d-4c21-8cf1-a8b4e1024ed2@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <119f619e-9f3d-4c21-8cf1-a8b4e1024ed2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ceffb3DM c=1 sm=1 tr=0 ts=69972527 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=SEi2w9hYDuVaAARFuk79KQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=RFm3ULBN9CpRR-2xPD0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: bWGDogAHhqlgiW-9sfmI9G3DLdHW4y9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNiBTYWx0ZWRfX/mE+agqOvgNm
 VVbDZDQjnaGNI7IE6XqZdNBXPDskgaQe/iDP8p41MTlFOGpnfJ1pJMyW4YYwEhwemKpTxlXd2cW
 LRMIexTxKHLac6s34cELHUxxcwXoDvuzZulUFMKJOR/4D8UmmMz9xP3X1PjlqUMEItU7EC62NwU
 tWjz/bsYsdwRLPO4MYI/l8VDJMdBvNE/SrgF5UnUUgdkYIP8XsqvRmPuwqqs+rQNPTIL+MDHw9O
 qcD79BCZMoUhoC/jYLnF2OUktnZzMjcwjob460EeA6CB4efApBGrE7FW5+GU1xg/AVP2CD/RD7B
 qsqPpPYMrX6YdVoW2X7TyJE+rPVxp4yn88gnXgEz2PqXlpX1aOa+iEGCckbIbSAys+Co8FrnXcV
 Ow6K5PBE9VY1Gn+LkutUwbeaRWCilRpKTw0XzCYFL4vIg+g7Tz7ik/5cbOyiAWYnpUzzl/UsFtq
 HaCa0Y1vijv8VcRGebw==
X-Proofpoint-ORIG-GUID: bWGDogAHhqlgiW-9sfmI9G3DLdHW4y9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190136

Hi

On 2/17/2026 5:09 PM, Konrad Dybcio wrote:
> On 2/6/26 6:41 PM, Praveen Talari wrote:
>> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
>> the attachment of power domains. This often leads to duplicated code
>> logic across different driver probe functions.
>>
>> Introduce a new helper API, geni_se_domain_attach(), to centralize
>> the logic for attaching "power" and "perf" domains to the GENI SE
>> device.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +int geni_se_domain_attach(struct geni_se *se)
>> +{
>> +	struct dev_pm_domain_attach_data pd_data = {
>> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
>> +		.pd_names = (const char*[]) { "power", "perf" },
>> +		.num_pd_names = 2,
>> +	};
>> +	int ret;
>> +
>> +	ret = devm_pm_domain_attach_list(se->dev,
>> +					 &pd_data, &se->pd_list);
>> +	if (ret <= 0)
>> +		return -EINVAL;
> 
> I think we should preserve the original retval for the < 0 cases
> 
> For == 0, this can mean a number of different things.. but in this
> specific case (where we always set pd_data.num_pd_names == 2) it seems
> that it would only be an issue if dev->of_node == NULL, at which point
> this function would have never been called

I hope the below is acceptable.

+int geni_se_domain_attach(struct geni_se *se)
+{
+       struct dev_pm_domain_attach_data pd_data = {
+               .pd_flags = PD_FLAG_DEV_LINK_ON,
+               .pd_names = (const char*[]) { "power", "perf" },
+               .num_pd_names = 2,
+       };
+       int ret;
+
+       ret = devm_pm_domain_attach_list(se->dev,
+                                        &pd_data, &se->pd_list);
+       if (ret == 0)
+               return -ENODEV;
+       else if (ret < 0)
+               return ret;
+
+       return 0;
+}

Thanks,
Praveen Talari
> 
> Konrad

