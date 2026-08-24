Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E363803F8
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571640; cv=none; b=rgXWIm/YoQLRI8yMDBDig6OWosIAJYnvukO83n2pEiDSLJ9UdqAjOuRp6iAo0TDETvkIbpR5sUl1MAw7Iliw0cZMOy9i+YGXZMpbg0q8NELs0J6bgD81RzGKqiTnuLR8k2DmBdYc9q4lKLCe/8uT+yr3T9uCSqZX27/WESv8zVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571640; c=relaxed/simple;
	bh=ckB25BnMw7XB3ZZL+1QBBFAP7gwZc1IxYgqGinjpLjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH7T596WkbQFZkU89Zjc58iyUjqwDLOpOk/nZpPKc7blydTGkHFiWJdfSSZINZZVQQzsAw4z+XqW9gzoT4gogAXzXeHI8CGdj+KZXwR+Dn1WGljoHtDb9haI5BU/u8dX+v5OtyrEJxjqVUt1SPoTnLkgea8wFfcF+YhLjpLosBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiL9HoP7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2AyDRzV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiL9HoP7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2AyDRzV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMRl12274752
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=; b=UiL9HoP7JETaWO9z
	e3x7AoLwcfNEXuvmrFHr1Ou5cX2s+rI0wEizv/+AhhMcRizfBM3ADmbtZCadAwWN
	Y4D5AGkCYlieTuu6TWI2SslAl4WYCu+5g5jQrVSOWkAeuHwKtyXfdFNw6J6QygKG
	R7BZ+GRcDhFJV7F2ad44ZMOMutZO52Col7FVrsflYKCPGYybDNICli3UAKe3PFUi
	mbaI4v0eRMj4idoLkBHHXjfYwf03SqeLMyFaM164aCTf24uSTzIHAd0MLnkZ5j3T
	9e9/M5y+H8S03lqspb6085u305g61F5NIMrW01PEjKXrL8YStGt6O1GGybq9zsnZ
	xbAekw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsge5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:40:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so8576196b3a.2
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571638; x=1788176438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=;
        b=K2AyDRzV83uiLR6IfKcmWF426uAX1ZH9fQ2PniQyE1mnmgeFsV+iukMP1e14xmKXRC
         6F+FOa/86NmPttOtKLq92fppP3TzXYN7MpFTNYUsutdsGA4StT2KyAXPtYhA3g/PARpB
         WSMSEQ2m1g6YrX64m9k/Ys+ZErQahkXW7ENzavyGC0Gy/ZXB1+4+qrbNcskLA0Zg6XuD
         Wu9Bbcc4GWlf0+cupljYK0Pq93fvXYmCVIYc40qNA+/th7gStFNt+wKQ6cr99LLjODfy
         AwFxXaqktar/Al9JuFCG/ukk8bwWvB0LfGxa97lnbj8RUBWEGAAMGWjcBCtYfSPPUrNL
         ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571638; x=1788176438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDK2q8jEQBsx6u42K6XSBrp2/fHnP/dHMqcLRjUxZpE=;
        b=AO6riIukfW+uulFWw69N6+EaNO8gA4RScqJejW/noD4JG8pviOEFTB1BN0mLP6YGmA
         aj3ZFqP5yiJqKoDyk/OTlDdqshP281V/db0GvB73/LiqXKzdHMxgYoe8OYMrKa/0s74r
         Pm1nJ6X8Ry3zScdBB50gsvwbt8h/4rEGYve4wjxlPVAfzwvwcVETUj+hM/i+63gjphLF
         ICA5cEQl8jWOT1+q0vW+VES1DEGcMrKIN8DhqoCkXybuSdB3Nk+uTmgt/s841EZPYqc6
         Y0CPXlsi2uJY00okK1QErnzmC1MXSnvQIOchyEwG479G6i7espdOLcBI/8InFFBEnEYY
         YsRA==
X-Forwarded-Encrypted: i=1; AHgh+Rpy+s/YqhSOq/T/y8de9VeTYCvw2i47e4q8R5OYktXiNA6wF4VyT6Ytw3bIFvjLCBELQdO6yE3FUmM=@vger.kernel.org
X-Gm-Message-State: AFuF++k/pVO4u06Djz6ACMG37Xe7SXhaUOWHTrrnPpGVeCE+9fQdf5et
	MHbo/DXClsvfUoanaMeDw4fJ8uS0X8HITRM5VO46+sDYCugomPz/SRVmWp4JlFUyJyRoIHsoM4n
	gHvHpVZuev1xihMvWFwqoJLIgjFvMurCP/oHAwAcgLp1RX5Y4Occc1V3bZduKtZo=
X-Gm-Gg: AR+sD10gFv94VJrfvbF1K+Qz6ODBAcvgSNgrsbf6KvG7B7CiBtk4cevlhm40vuNE3U5
	feojG4zHLPYICNkG7tvbqwI/j6DPfo3hJoOVC3ixB13fN31IRfHh03H69NAiy2ow55BvGUTLFqa
	j+S8ZrsEy0DOnTnV/8V+7uIvd/Ui2MQhQ18NyFH97CsO/sh3LhkWjnGZDmY8e+C0IAb/WAsK2sy
	FasOxTva0oH3wAS8nWNgzknNFHL4+wg0ntVyiYDZW1CxfdySYtns4EagjZg4/pyH4c5ykn3LRTK
	h6N3EeXSd8ylwaXTY5xazl96aIsVMhkYDjNYNrgPH5Dbp6UR3VUM/56LYlcQmv5KmWst2rwmScC
	/RB9vqk9ql3GU+wXvhzr02icqkH72UP35QUE=
X-Received: by 2002:a05:6a00:194b:b0:852:d5:d0ca with SMTP id d2e1a72fcca58-8520be70013mr25620805b3a.9.1787571638286;
        Mon, 24 Aug 2026 04:40:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:194b:b0:852:d5:d0ca with SMTP id d2e1a72fcca58-8520be70013mr25620717b3a.9.1787571637790;
        Mon, 24 Aug 2026 04:40:37 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f14a418sm1883825b3a.47.2026.08.24.04.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:40:37 -0700 (PDT)
Message-ID: <e8856a22-0060-4720-9d8f-ee3b7498f46b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:10:29 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX2ZW8mLvD5LJK
 ELgDGMj5x9vgF19Bf+VnkgBH1IB0dIP1v882D7hW1xpnqc9bTzuDM8NbCswtQp7BQ92pI4XdWuC
 nZaLqYFtqGpoYn0qPwqhSPC3buQqZoo=
X-Proofpoint-ORIG-GUID: NgltGw1Ur4ni_XYZUnpT3GwPpO6JPy6a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfXz17c5RxZcI+U
 MtPqt/c5YPpP/8Cc66QLM7mLaWQ9xcds/Trv6jQHtYrPNJ7OLuimFWLshmO52qWxta0/MqR/v4c
 VSEZ11nggu1icqQmFNFj7Jg/WU/qdf4RzbPVR/P7owztok+GnvtJdSCrwpxetDOZujfCG8hZUmb
 j6KQayT/Tcy7Jw7zT2LuWfeROslrk0MZShrgmktQhcoLXEXg53XqfzNT2UmezqGJK7jagpCt7Kg
 R+puvMxHaIWl+TLd+G9JZUvbWtRHVSrYIRfRJ2ttTS6QHGGhg2EdoufSMMgjJ6ROUj1FVs9zBbd
 0AcxSrPH8rJPhPAwKkInbTmGQjJdE1lAmyQl8a1Pc8nPTTqN/xxtniCvAmS148wwW9wP381hB4H
 zNLj9rJLbmBI/W8P4DyA1xyALvoAQbtmlkNolPSZp3CkOeUWIZtleLLm0yoaYkOBrOoiDm+4Od7
 9r3/NNojoa0mZWZnTgw==
X-Proofpoint-GUID: NgltGw1Ur4ni_XYZUnpT3GwPpO6JPy6a
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c2db6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2-yugF7U08GihXn5wV8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240097


On 8/5/2026 1:27 AM, Praveen Talari wrote:
> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
> the computed source clock frequency, and dispatches baud rate handling
> through a per-variant dev_data->set_rate() callback that either
> recalculates the clock divider (Linux clock managed path) or selects
> a performance level via geni_se_set_perf_level() (SA8255P firmware
> managed path).
> 
> Now that geni_se_domain_attach() populates se->clk_perf_tbl from the
> perf domain's OPP table, geni_se_clk_freq_match() can resolve a source
> clock frequency and divider on the SA8255P path the same way it
> already does for the Linux clock managed path. This removes the need
> for a separate perf-level based set_rate implementation, so
> geni_serial_set_rate() can be called unconditionally and
> dev_data->set_rate can be dropped.
> 
> Switch to calling geni_serial_set_rate() directly from
> qcom_geni_serial_set_termios(), and use geni_se_set_rate() in place of
> dev_pm_opp_set_rate() so the frequency is applied to the correct
> device (the perf domain device on the firmware managed path, or
> uport->dev otherwise) without the driver needing to know which
> resources_init variant is in use. Remove the now-unused set_rate field
> from struct qcom_geni_device_data and its per-variant initializers.
> 

This commit message seems quite long and repeats the rationale few times:
1. removes need for perf-level based set_rate
2. call geni_serial_set_rate unconditionally
3. use geni_se_set_rate instead of dev_pm_opp_set_rate

Review, if below makes sense, tried to shorten it.

geni_se_set_rate() now abstracts source clock programming for both
clock-managed and SCMI/perf-domain managed GENI instances.

Use geni_serial_set_rate() unconditionally from
qcom_geni_serial_set_termios() and remove the per-variant set_rate()
callback. This allows the UART driver to configure source clocks
without needing to know whether resources are managed through Linux
clocks or the SA8255P firmware-controlled performance domain.


> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
