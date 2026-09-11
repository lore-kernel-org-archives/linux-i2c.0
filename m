Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48E4A482A
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146812; cv=none; b=Nei+PKHufKpXvlFOu1DJIfBb8cKjD5JDUvvdFPhE5Jz5x9E8TKYj2aU1dczIaFHQk2RSWtdmvOgagEn9V6CJ5xmJuY/9hRHTPYAp+S/uMuap37s3HmgSuH79+2KDQfp0DqCOr7XXHPUr44sq5iYq9mXPWhwchER9KmNPEFn79NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146812; c=relaxed/simple;
	bh=GIg8Ee17H8uLahuwZG6QIu9IwUSfphXuVEckTgzzbiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGDWN0oMauvsMe9tbhugQp8HjWtbkIbic8keeIIqkTO8Iw/7QSes5c5/pFkWJkkcmqlcewnxQZZyBtKlKxnorPM9x6jTuRB11YwvOtUSGakk9WFp7vX+9BBpYwZ6MRlHABN4YP/0xGSPY6taxjsru6LRQMqvvBp+59qu5e2jqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbMJ043Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WsA2Dq90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbMJ043Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WsA2Dq90"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm0WK269302
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GIg8Ee17H8uLahuwZG6QIu9IwUSfphXuVEckTgzzbiI=; b=MbMJ043Qh3693KxM
	TC8kMQTkju8cjNkcgW0WulTHDisRDeS0zOWD/ntCNBIH//BMVQJLOwmHGnfrnVoQ
	we6dQdxk2dewXcF7hvbcGVMtcQyzu+7IrU7yfFFkhxWA0BLxT4RBARs93uNpWFfh
	psCq4Ciz7SXlC4Kr+yxAixZvt0u1AIbftjDKa5DNH2SU98Rg4Fie+fSyEIOIJZgb
	3nxRV46XfAERrERiZVDNEDd0G8cygfq6HCYuON8opaV5PrqvXD4d+sykhXziHZBG
	WqdZ3HZvPs5sCRC5KNok3cCunb/JVu5nUgZpOTrxivUvVl9vyeWKEIWYdqtnIIae
	RJeFIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd52xf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:13:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a43fc3527so2067682b3a.1
        for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789146809; x=1789751609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIg8Ee17H8uLahuwZG6QIu9IwUSfphXuVEckTgzzbiI=;
        b=WsA2Dq90HLFrqu66j4Q2H6a9nD7NPsx+o4m/8mN5hvJF932Mh0pc4kw7wVoXFniFOt
         vS7s6OCUoeDtCg6/7KSUksEAu1dv9RBcs3uxL/UvPdhQDHs55lEM7Knczd6u5byiHH/V
         VSqF1SVZqhAsoytWU4IuBMwWcnzWAlcGpZAEjIa3QFKL9J9zkWPSd5svchIO3XVqG7Ad
         Eg0FWIs170vg8WNUqu+BOLPaF2w4PzDqBi8zyYny9OqZJY6bhwA9RMQAJd/KKZC4VIOg
         diHrn40i7XV7gib/bdayQI9IFyKjMquJ66HaEgtIqBTv7qzFz4cZa8+sbY9aEB1eoShh
         EhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146809; x=1789751609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIg8Ee17H8uLahuwZG6QIu9IwUSfphXuVEckTgzzbiI=;
        b=E1MlOyHYLuolf6rCGTfZTKExVGfZduIDitSM5zCItgkXGrwf3KeCNTsXoe/FfES6g1
         305xkCjTuYohYUMDApZaAiEpQZY636Gd0RbE3WT0hGJdH2jFuzcVIDB/w/R3YKWCR+tp
         kYLpvTkxN3iRz1ZVzPtwSOVSWEWKqUXS4l3Vz+CbzHVHAvqYdZL9D6TKLJrrfabcVRxe
         gGgQmymzuSE3lIyJh3rk0aHW0H2TNj07sNeYvSlkV+N35z9Ib0OiOQ5AK4Fw+GDnHdbV
         33cfAAzsnYpMdOHR/rVFDerbVYqvmc+iWhRMcUgrH2+PGhLsh47J2SwdNMlvtBExf4lQ
         6XzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYyok+tXNHawh73mToyyuMuGgj4IghlIkocQtYuRPyQ5/6ZSEk6dinkjzdOl9vzk9IPgX8cDLAIXs=@vger.kernel.org
X-Gm-Message-State: AFuF++n1vuEJc63WIKH/OXVcuqXbSgmb6I5LDbT3/V9RcuXEcfaqVZdD
	sYpXgc2HNwAkDw8jkFENSZ8hRFSisaZ8MXpfBEuVwhJfmL7eCvR/I4gG6TvXQIyW19oM3a+bR8H
	it9NiisnBtkH5aDbFRrykpS5x6rivJcYJMWEEB2ZNRNlZxgjVmE+18F8cUX7XkQg=
X-Gm-Gg: AYBFou2TkbVE1jjUGkybxbbbhYQfFm6GDhMS2NdRMs6aIJCDgxOsX5Q2qT9s5u8SCKM
	HdEn3wy1dPC15FRvf1YxO6ncW+gz77oIr6JsD2AWmpKW//MF2zvNH6xD9GjSjR/7IUFYIdSTTq4
	A4vWsE6zJvikWkr6yDSC35c2k9wt2oYQ3oM9bipmjWe27wiMko8zRMKQILUHRdX4MZC2j5EOgw9
	2zSTYOnTlp3EdAqfltAEdfbDeBjdXxAc5Oq2UGv2bak/SYELfJRq7PUJsxpHt6TA5M1gGNyq0Ew
	AmWt9VBw7waxtYUcG8Ndc90K31DT2XlZlexlkddnMKfGTHAuO5SO7kdTcxHIcuqypDYhxs14D5w
	rivXDhcleqBU5dUj82lBwJ9F9+TA+GyqM
X-Received: by 2002:a05:6a00:1786:b0:84e:354:422b with SMTP id d2e1a72fcca58-86b6f55356fmr3892854b3a.2.1789146809342;
        Fri, 11 Sep 2026 10:13:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:1786:b0:84e:354:422b with SMTP id d2e1a72fcca58-86b6f55356fmr3892808b3a.2.1789146808816;
        Fri, 11 Sep 2026 10:13:28 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.105.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291c1601sm1492832b3a.31.2026.09.11.10.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:13:28 -0700 (PDT)
Message-ID: <e43b8af4-011d-4896-b488-1a9c790718b6@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 22:43:20 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
 <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FJIs_fKHUlcckg9Bl06Tq1FcmJfnyLMo
X-Proofpoint-ORIG-GUID: FJIs_fKHUlcckg9Bl06Tq1FcmJfnyLMo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0MCBTYWx0ZWRfX3hnOewIw5YFW
 lCiDjOUMmY/m497+uAb1GGg8bbE4Njt5U5OdytaPGHqOjX5plIQeTNamtcp+x2BoZWqY3vmufKS
 uSKgEqKUIqmS09bh9pVJoKIgF+FxSKk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0MCBTYWx0ZWRfX6rHNCZFA3SUL
 Ox4PkzSjEuuoW82n4rDVtIYoTDcOW4VMM+PzKOFPdowy3Z1vtDpMAGvzyy362pyWYZRShIqTSD6
 5Rlbqs2JdWwJohZjs0bgcvZz818Z/XIOCYxV/NaP2vcWmqgVgFEKVC0eDZhf+Eitn4l0aOHvIcl
 xBP2Lgw0ba3JVUZQ4w0HD9gDXcZDrc8w3oRkxJXuE8erx0Xp1kCsc5sbozGE7jqcZfHSqZVMxFz
 EFQqHOUGRHRYZp3CVFvnH8uIw7Ape0aR3G0zI8kJbks3rvZp3dfBOaHuKAQ+nzsI635OvytMcxN
 ShdOo1O31USfTPusryEA8St/ADix6iLv3xA20X19h+i3vLFALaV4dwln4QXnijs+P/gXczZIdgf
 M+vvbpNCnuID0A2YFAIztMkmITI/csuEooNxruqlpcixRloXfzCu7fNLXOreG6VyMaY//OHZ1dI
 P/YyXY78DnQ63T03Hzw==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa436ba cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=KFINdI5Z0390/lZYonNNQw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Bcqig9hN0zFNc8VZEzUA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110240

Hi Konrad,

Thank you for review.

On 04-09-2026 14:19, Konrad Dybcio wrote:
> On 8/27/26 7:59 PM, Praveen Talari wrote:
>> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
>> geni_se_resources_deactivate().
>>
>> OPP resource management should be controlled by the consumer driver.
> I believe the opposite was the original intent behind creating
> these helpers..
Previously, resetting the OPP rate to 0 was applicable
only to Linux-managed resource control. With this series,
dev_pm_opp_set_rate() is used for both Linux-managed and
firmware managed resource control.

Therefore, the reset should no longer be performed
unconditionally in geni_se_resources_deactivate().
Instead, the consumer driver can reset the rate when required,
keeping the common resource deactivation path applicable to
both configurations

Thanks,

Praveen Talari

>
>> Additionally, clocks are already disabled by geni_se_clks_off(), making
>> the OPP rate reset unnecessary during resource deactivation.
> That is, on the other hand, a valid reason
>
> Konrad
