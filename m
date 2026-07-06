Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD941DEE2
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338075; cv=none; b=nMEfd0+Ki8ZZkJf+S42Q91Qiq+VyBnHDS44ysQBHUUzGtX6If0uB1WWRtdJETU20OVPLkNsDK3bykE3HkKd3GrIvtjaAGeizypeFRAenskiDDKxveVsJ5OtFH1pW8DSFYNlwsGnLWgKWdzXCSrDsnEN1k/k61/bwp2ioEwhfvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338075; c=relaxed/simple;
	bh=M2ww3vjExAjNaQO3jQvVY5phe/1Oft9gRD5oC/hyYXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrMA8uRq0HG6FgTEGhweq0oMNF5NYoJKPMJ/shOHuNluvJeJZV1CXl3FJHYkuy2Gdr+xcrjRaixv93i8JvonNy7gKW6mfT4tEXi/QqqqfJVRmeaRymwB1HtpvUdYTJ7/aXeqxlPJQ05TEBWf80HuZsM0sr9micQlGOTBK8FIO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsySMgQX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iHb1a0br; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsySMgQX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iHb1a0br"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxOjn174957
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 11:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=; b=XsySMgQXvfPgt0+a
	HXtcu1zM2rla/ZW5eTCxaMB6FICW13P1fwym0A/MsfBjDjqUGgXD1EHFUEySuOk2
	2z6rHOSeFOjg0Nyyc6VHixBwF+xqtTVaCt3ADnTB1IzhmU/aQqOPwenB2//RiLUm
	B+kOKlkYz6F03GNs7m211bs4Pr22Yuq9DZfFgJDYUjFMnF4mWSST9/zOrRBcEb9q
	n6vKECdJiMTwf5jgm2LcODgoUDnUe4767AbVeb1xNK1d92+uBCFBvMe85oFat7y7
	xZR2l3W1G+EwqCXOK7NjSKq0MIxTJb8OcGXxyUAjh0LR+gEqcXBvSvMPiveVOXbl
	yRJtqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs24x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 11:41:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c15c77619so6902211cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783338072; x=1783942872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=;
        b=iHb1a0brBVg2+V9KeolTwdnrO2vz5qW1WwCY1eDPQVml8uPOFCwx2+L8hFOB1SWbIP
         +j3/Ru94uC/NLkdpOaZQYt0KvdwFzaYHjnvybIILj3Nd1+nA6OCDqRR7rTZ4GZuVCYLD
         M5s+CAjLaxUmtN05/xdmNys56JK//8WfZ0kPSHIp8BHh51XtH3oSDbj+NnCjoFK0sFPz
         l38p0G63BvHWfOIDkj3m7yJAUcHiaubAsQOVXkVG+uzaIF0ys4QDMRobkbSG7uXHIWps
         d8TFJtxdS2AZxa5Qr9b4up7MoTpkeoCCh3K9h+Bxy+QtoFUaBZyHx3J18iQWPHziXcSg
         1efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338072; x=1783942872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=;
        b=GoxFyYdoNys3CedfLt/0By6R/9sKeo3G+XpAOMEt5XD5v9BNRjS9VhNCypM7qYgE6p
         Owmd8CyslZEkj5kALl23pfA+JqZMaPByZjk92/sJcp9QJDK9P1a/3UgCkeWVOQKy3kpq
         NMLLnlET3Hg4Gsg/gNVsUbRD0mRv+EIkngPd5FrPoRUvwz6hmPN01AvZX9zY2B4wdCTY
         gA2iG7uYZau80PeGx1Ap6p79TJtK02KTuWXeYlaAZC81gYF85oZ1/9aQciJoH1PiFbBu
         mozvekOA5amLKzplVJ5Wbthfv9U5QjwFTRX0JqOLyNfXnUgxUtzrNmNWf8b31PxU9xu7
         Ba2g==
X-Gm-Message-State: AOJu0YzJGHJkCJaZL8lSSaQZUh7D3n7A39lFebEMDM3wp39KuuzIPb/N
	270bHtg8Dp2P1xosPrBLJgtmu450kggrIcXa+IoO1WcgT5fG/Xg+Ak7ThHjxCRXMec2Nvs/bS4O
	TMUjS48DvLCpLgvEIEe7AmQhlk/JgYQBMKE6e2AMzyv2nNcgir7xMxt0coBl+DbA=
X-Gm-Gg: AfdE7cmHZnqfb5/HE7Kksm4YXwf0JSKKA8oJLSmbJwllmDtqXA56/BnkHhf7jcWS1eE
	UMXgy4eRgF13uyd/qYqCHW4VU1OmDTnfqJdrZk9CbMsKa6wOar0ktEC+QzgXXOOSkgncp70CSqa
	AzEKBdRDLXQCNgE87o0xgPmfLvAei9estvF6GaLQMFJ1IE0r0nXVaFauTCQQzQO0p6ObzPhtASN
	yggWPYr22kbqlHLRmVTSQMWMfGZWJgfffLsrkGkupuGg+xW3kZqGcbdkdTBt3ebYoc/13U6AsS6
	IcgNzUBXo2KzFcUNv8rw54aZMGOTRvFnXUeoZIk+M8/MG9O6/pjBTjHdfR/XzmstmrMnIjFVPpE
	ts6zS3xhzyN7mxW6jCVTa3krHbqmncddS23c=
X-Received: by 2002:a05:622a:208:b0:50e:6311:7380 with SMTP id d75a77b69052e-51c4be99299mr82579561cf.6.1783338072062;
        Mon, 06 Jul 2026 04:41:12 -0700 (PDT)
X-Received: by 2002:a05:622a:208:b0:50e:6311:7380 with SMTP id d75a77b69052e-51c4be99299mr82578061cf.6.1783338069294;
        Mon, 06 Jul 2026 04:41:09 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cf68f5sm4059006a12.13.2026.07.06.04.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:41:08 -0700 (PDT)
Message-ID: <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:41:05 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OgxrYAmedCEOFoMw3_3ds-lMWZIdGiXu
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4b9459 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QdFQMySKPoxOC9Zsaq0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExOCBTYWx0ZWRfX0kYzxO8EtXm1
 2ax/BMfCD5WE1KkjCljNcqWMurM3qFHHIeigBPTSJeIh8lyT7c2CGO6gJ3qHDWXx3RRRZJSuH6l
 UaohUN4B5ooL+smveSnz+YzL+nbky78=
X-Proofpoint-GUID: OgxrYAmedCEOFoMw3_3ds-lMWZIdGiXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExOCBTYWx0ZWRfXzIi/cxxlX5Ca
 FNp8JoqWO1SBrA+CJxpyTMoSx080ipv7mlzwStpdl7ApG0GfZie4q4qoz5Xotgf2QvcKBmo76Fu
 TA843x8jIBdbG/A2MkwslqU+oSPQ0kD/cZzFeHKWNGS6k7BBtC/Ty8fygKq2xXIQ37jyUvN1gq0
 IqftHfyq32wH3hlq8dLSh1RzRBdTBWv7Mdvo9r/geuRUSNJk6GqWgnjXXC7/bXn96BXubYHsSKP
 gLm5t2Is7YtW5xGA8IL//iRjEJXk3OuFZix25hanoca52HFHoVsdUhHb0DOsBMHjZUZBUyn+11p
 5Bscb592uMSbsDG8PD8d4HCfmyYq26ydKuGQzLE+O4qSLXPh6NGV2YXFE91cON5pL7F76F6YuOT
 cLzHgctW07+f77ANUPqWXq73mOX0R4Ojh0ppJZ9+Kh5l61UPX+Ocq5ABRWlcOP3P56fIlFQXYOR
 +qZY8nY7BCXVh9UmmoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060118

On 7/5/26 3:57 PM, Aniket Randive wrote:
> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
> regardless of message length or bus frequency, causing unnecessary
> delays on error paths.
> 
> Compute the timeout dynamically from message length and bus frequency
> with a 10x safety margin over the theoretical wire time and a 300ms
> floor. For GPI multi-descriptor transfers, use the maximum message
> length across all queued messages as the per-completion timeout.

What's the reason for a 0.3 s floor?

Why a 10x safety margin specifically?

[...]

> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
> +{
> +	size_t bit_cnt = len * 9;
> +	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;

mult_frac()

Konrad
