Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0053F6C26
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512410; cv=none; b=AyXke8F3U7DlPzcz5P+wPp2id7YvAshT4FV1Fm8C+dpd+ozP0iE0q6ljYjzi+PljAFyBsDmcPfLev6diDe1CsplyLQWYIeBfWuYxuOIaD7eAQlZy35rZZE/JifHozo8HVv8b9cuj+RxT5UMGFhAhdf4HSuHrMjKeydm9miSSjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512410; c=relaxed/simple;
	bh=TwdMkfkku+7xLhkQkYda0UxtIy+OV/r23+7AedMhDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoRXPGNADg/bWt7eEZZ533j4jNDzMIWNcnTFS2/NCeKL2725UoqjmWwWNO4y3fH1mtP1O2DmRK09C86c2p9VItfZpv2ZZXpl3YMWNWJeixUVWE6eaNOy+td17k7TRI8v7U3vTtQG5u/JEY/wyE7F+ouHg0EkEd/ogSilsQ271y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgwQcusi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/Hdw7uz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgwQcusi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/Hdw7uz"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mqDn4111326
	for <linux-i2c@vger.kernel.org>; Fri, 4 Sep 2026 09:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=; b=RgwQcusiD+sBqz0F
	jF2XOTgx2pvLO5qTcCp/KU57VdohSxr1FqohE1cUY2tk70/TPuqmFfLaMLktqg5G
	p4MqrQnqlWaHEFJUah4LmnpDevNJ2eLS/gnd0y1pFcnONHPfRtNjZQIVvRymxVSY
	v4R5GIk+wNf0LXbGizShkEWD5YmrmXmp0Xbd1PHNjPXeDphndDl8Ddm1kU8w8OZB
	/YZ6QQtzCG95q1v9KMPEviI16gYbWaZVyfLdO+kisFMjX9kKo1Ks5eGMfFdUZiSs
	rUPqZPmbNa63fw8kXGxpLCAHsjUTGkR52R5Qo/+UoO25SToQqlmkMr/Y2+Ue1T1w
	ifDMYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b1cd4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 09:00:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494b1e35cso14410885a.0
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512407; x=1789117207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=G/Hdw7uzC9kSxjTUpKvoU1GE4jK/dz2XRkpC78NI5vjF3hhQlTy2ZTG3xPq8smfCa2
         LrWRf+IGlXm6a1tAzfz+Zd1Tw7SXd1S0A54gB3vUChiPRnqpvrJRiOynY93pO8VdjjLf
         IzEEJ29csUX2/cqsiciEgyIsl1xqKLcdMbybvACo/G0DROHxBuY/LUWrC4kmcJafjEHD
         NiOm+7wAYTIa/wLjNyUQ6O4fv+kVOZeoXeW0VtfH9rKH8Q9D6UtJQyvYmeYfZF7W4vMV
         VHBj9m1H4AM4UtkNpZ/nckOtgOyDqyrjjLwroLvfNxzMdmHtU9zt8huLFAmsek3Q62nz
         4OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512407; x=1789117207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPrFnyRkQ5lya7hdY6VenELDRNtS6j9fb64j+zDHYFs=;
        b=gdTg1bvovBrIRzl6RuGMN5G2rm9jH9sRQd20m2HvHZetYLtnZzPY0EJ9WRM3E7FxUj
         hK5Mv0F++vttRLyCN3Sl70Tw3V/xA9c22hDuf5/AQJ/ZjvEaB4NXdtHxOm1+s+QA3mfP
         zoGPBTzrIM5qyTT8tRywaBnv/IPywtzQ0BlmKlX/0nCJ9qyjwQunJiqb26+iuBTWnzOU
         8Y4ffKbs7sCOB4My/PCNLCpH7CeRXIYlNn3Ah3YlRxksTh/nyBS6AKhV82B2YlZ8tD/I
         erDLjMhI4wlOovRjz+yPORJ2kRw5oVDdNffZMF6UGCHBESp+5X0lqkq7feZwAN1A0m/5
         9sVA==
X-Forwarded-Encrypted: i=1; AKwUvByE6UTJhQJ9yeyN06Pm6V5IfELotSFLZWbzBbuGT2dT5Nz+nNFvxIbJCN4s6KTgJqgK+c68B/JYAdA=@vger.kernel.org
X-Gm-Message-State: AFuF++mqbEK6mCmjzBBLaOIcR/ol/tDx8/XsyVUTq5lUwtilSkFLIYsL
	3nyLrLZzrhdYDvH4zkF6Si4FFwff97DTdZUFOmKRTHTV+wATUkJNzhArGjyMGWHjd3IyRij8FZJ
	tC3Jz7uWrQoBJr8EYgmsr3B+0XldUezNV+sIh/JUiGq6X1O27KqlCrfjqDotTz0w=
X-Gm-Gg: AYBFou2Rgw1YWRiyS9lpXBItxN21cQoVoofdURhnKw6iPkKHniCIDD9Sw94KFNkxAcL
	+Qn8JzNhxO7nma190MIOJvSfunH8Un2W9iJ9uvTW2bqT2dQFUi8paarXgGXnGwDPoeU6MTeYKIb
	itGGjVOATbQE1ogh2XulkSEH7fgVpIOiIr5UMp7CHqEYUnIdH6XXbAzl88NhHTYR9QMX0slY1fN
	mP/73Bh0z/vjKyOHCJ1R5QHyuaCg1gk7A5IEIMTiW9yX6DpyB9FFazwysAPpP6V9iIcXmN1YK4V
	R/K5X4z1wh7hWnUHLeaNcQl1rzAwzRD7fI9pGCRtk4bLRDKf76/8RFbShIfjenu0RmbsHqiZUyU
	EH3dAvyMd9vmT1xR6wVPQZw==
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285927385a.5.1788512406205;
        Fri, 04 Sep 2026 02:00:06 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:939:4a24:4de4 with SMTP id af79cd13be357-93980c5c987mr285923885a.5.1788512405649;
        Fri, 04 Sep 2026 02:00:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20c0fsm895767a12.30.2026.09.04.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:00:03 -0700 (PDT)
Message-ID: <0f5494c7-c3c1-4668-a09f-d8c43d1c58b9@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lD9KBJ3bHXlio_Dq3TkexJ8JUIMJ0pjI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX9BqaMW1WOj9C
 s9MhmdEKGUipfTpWBZv1a2bfAAeGFa2Z2iMxEfGabYHIlcZI5pt7wH5kGWBpWIj251RMhuT3L+W
 tLNqbPoGtWGzbaIdZb0vwFp1/8LFo4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX5R59qQOfLUrB
 T8MfdGh8ypkOJSf21C3s55BXOcLYupp4pagaIA0kpFfVb04n6qVgSxEFbpXwytRONEJ8H+wKlUd
 ubptZZeYgnAdDlJbS38ZkLkyMBsXV1EKoiV02VkiwLHg4t/I1NpBnHve/g3dAGEuEvOqnsN9GWd
 wwdRfDmF5C+utOvhzmtbQZ0SlAtzSrsrQOnqB3CX9+Bar8UT1lvzia3bDMwLotxQ5mF5W6PthjR
 QD1iPnXod4amGw6NvSFs0C/ebLwjcrSV5W45lwvulQMmdsZEHFNa6KG0u9KA2jQ5CciP9SdyO0q
 aP3rTS9UOD5zVts+dusl2X9SqBeGgy6oOqik91uNtsMjMxEQUR3fDQ51q9sIz0xDBmpeKhzLeKK
 299YFarnk4YP3dz02SF7a0c6RhdETISQqI+9ycAP0eYZZcKD/GS51ou2DHkP1ckufibxvhTMfh1
 ImWh7BLggV2xw1QAIdg==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a9a8898 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tfn4aQiUfrmVOWBwnpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: lD9KBJ3bHXlio_Dq3TkexJ8JUIMJ0pjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 9/4/26 9:56 AM, Ulf Hansson wrote:
> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:

[...]

> So geni_se_clk_freq_match() is used by two consumer drivers today,
> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
> 
> Beyond the $subject series, there will be even more consumer drivers
> that call these platform specific functions. As I said above, I don't
> think this is moving things in the right direction.
> 
> If this can't be solved with generic frameworks (clocks and OPP),
> please clarify why so we can figure out a better way forward.

The way I read it, isn't geni_se_clk_freq_match() more or less
dev_pm_opp_find_freq_exact() called in a loop with an increasing
divider?

Konrad
