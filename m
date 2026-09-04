Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C23FB055
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511951; cv=none; b=Ge4sJnDhuvlcKbiQPpugB/9L6v06/AHRzQwCQvDHCXEMNbY8UZVV87ERJXYp6tNI6uhgV5X4jHprvq9rmAka6NNjMTX7Yd9w1aivTPIWTgzUbBmViU9XsV668RhMBi8deRsUK++KhEP8pIvDm1g+HRcC/yiwFN/uYm1fD3fq7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511951; c=relaxed/simple;
	bh=u8emeScZ1VxCOwdH8jxMxsFHL75wPiRAAT/6Jj7JFYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCC8yiWo9TiOAOWVfXn5PBHWoX7Kph4eLHRhbkpkYgVfO2xUgmxNaldFtU2huNoBvfUFxu4kFtcYcBIBCiZmV+gZNWdnbP6zXKCT0RxQS40DlyTU56KhJGyCM5III7bFwTcidFdofoB8aljRuyZZaCy8vQy7nZdiGbkfkH9UavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gp9RnXbt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a6J/2ngq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gp9RnXbt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a6J/2ngq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847nV3L3236951
	for <linux-i2c@vger.kernel.org>; Fri, 4 Sep 2026 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=; b=gp9RnXbtsidWyTJ8
	cZNY/UT2P0V+NFDYRFzz2J68xJ1rm9JcKlNlnaYAfnnHja5VKKxwyJ/NzOKJbWDW
	g6Ih3xK90ZflwVVd/BOCpP6lJI5WE2QTNagaBs1ysG4Z8GPEOyFBL6WekZmg8czJ
	4syRIeuKE1VJORmbgGnUZKEGX8WLNl9KX+Wmz4/qZuCop3uGZ5qGdPRrN0GoxpR2
	t0KE/S2LpQopgjYYpn9jVhyo4M8kzFxZd64HOQdjBJ8YAJH1peCKEAIo6Di+KW3u
	+QbCWyGj1E/0TriRNcAafN+sGTg5T+o/wLnkxOPTkDGXz2jjQiPKwb5rrK6DM4VU
	Jz3O3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r0y6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 08:52:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9310484c005so12457585a.3
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511948; x=1789116748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=;
        b=a6J/2ngqipS9J5NCh6+sgN04+JE4IfBsdSXLB+Srv8SuIBNYWrqGWPkahMb9E/J7eg
         yPn/PxedNk0tXQb4P89otAVm8heYi+J0kZ0vf64370lMAbuvxeDOwLgTGJl5gyK3Kmxu
         dPuLbU+sehTFvNoGaCHzErH5JyyFDkSW89mAGotu8yxRP1bbju8P5vaSXqo8ZXZWvwXq
         /ldcpKPAbs43xHlGypWAcVbk729iP5mPaswCtb4V8Scl6YPeGhEy/DXgnMh7DAQOcGqC
         hCZ8VyR8sVew8EaJaC9XgHCCemqK283D7y7UQyAYQKsti7cASIsQP4LB5fkgkUZ4ceW5
         HwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511948; x=1789116748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZ/scEjeUFKQEeVzgH7yc5/BjZu/YvnYriZvaWHljSs=;
        b=fomvfTkMQ1ogaHyhWWC61WQA+WDQOby8bmOePirmgsvJdmV/JD+WuHPs6+8SOXi+Es
         mzg2phxnnbvW84qtZkiV0eCL4/SNBolZmSRAJFTbZ51ud4eXj+IqKulKDMz/FQwqGnKB
         al0c8wHQkxQcXcd7pWkxGLS5cnIHvYKOM9Z+1vtO0yvLlJEMELtXqXhfNEeTpLSkjx/I
         +4t5iuMBHNh04ydSMZLcYU+/8IO/ZdEgtUfgWXJghjDRK+ROrBVGwpAq6SCH6EAX2uPc
         GUvZAF1J7YmIwNohGr9WOGSZn1N9k34/d/TQiFheYZ86gLuoGpIcu01ovqwkdSQshRyf
         +YzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXSUFfWJ1nfTkFWcWzORSi/0U0hGdkaEnJm823x4ALU8HTGKC3w3U3+aT+HjrEJu4RsFgJ+HoKHr0=@vger.kernel.org
X-Gm-Message-State: AFuF++m53ZtvgBAnjnUnZrSpLt6sYLxBs+Pc0C35WHKN2pKEqRW/a35J
	7mTIKt1g+HnvoT1jvFMjUpSfq5+RdNjTjUrvmeVio7dgHGs3kXHzbu+MetGOMHQrcCPCDk2pn/0
	C0qPqL5AG1fSC80QITA/h3vo4kvdRstVjzRNdEL8aH5XHVneydoSENvqAbTynmvk=
X-Gm-Gg: AYBFou3UHETsvFNBHr9+wA3OGv2fI0YKgAlUseJu75Z4dknMaAKwWzSWOtVbmmqPyVy
	GYnZ2oI4PEMQTzeAzcXVNUABF2djB3At8aCm8UHfUX4IZI0PwzKrpUsMKp52cmqO9XPcy46pZtF
	///Vs+SxbwmujNrddvBDf9aIS9zqMSb8plJbIc8AuWzSApsJ+MRXo8mqdkriILiGFvV+7ijZcsR
	rhNVMqEjCdByqNrHB7LpMP5ruz7YJqCQ/UWusTlbvR/p0Xa16gi8VpE5M9IPL0y6QVR97FohDvq
	zZDI9KmxNa2j9SAaRTRm643kuCgNvYKA2ydu74Z2F7+vFA79SAHnvxNG3JtisFb2GtxhsUZjEdr
	JVoygHRhgurx1KPvjO7g3Rw==
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr303192385a.1.1788511948009;
        Fri, 04 Sep 2026 01:52:28 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr303188385a.1.1788511947490;
        Fri, 04 Sep 2026 01:52:27 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b72sm76908166b.18.2026.09.04.01.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:52:26 -0700 (PDT)
Message-ID: <fdfbd73f-8739-4845-ab18-c5f59898e192@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfXwsWXM8Njs/FP
 jO4SsvokLJqzuAMc/R2mX/kGjsSAxv3LpGi4aGn8/DP0wZvAsc6d3gLvV5TuMhyjE9jxiKGPTSR
 ZrstHNlMY8FMWJ9+1dOGQMo6GEWVfLY=
X-Proofpoint-ORIG-GUID: YpJbX7cy0fZLxMhAhLnaTmpGca5ogZOf
X-Proofpoint-GUID: YpJbX7cy0fZLxMhAhLnaTmpGca5ogZOf
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a86cc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=eEzEi8mspgMuG-bTNdcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfXw7owL+tGi+Jt
 kbmLRy3a5QsJohgLRUi/KGUo5z4iKXVaQKmO6RPxXwjHpdjFwnJ7CxktJ2A/KBxDdNi1o2YckIT
 KXOmry9lKKaDxLvEfL3GJVPFgIF8DTWVmyiODlQlw/JrW7lSMqDvPIqT+CSeF/sjVnrVQJil9t+
 waVY43wn8G5bTy+6keTQ6ImYSgQ2Ycakb/VkN40xINEI086t1uF4wJeqLN0Yzbtuuxe+QkPkX4y
 dbrz1qoQGS29NdEyxioeiVZU1LQq5sshkM61zrYIGoh9xSR4k1bKFlynhOfJrXeAEk0hj65afwd
 zZKibXjKDXsVx+ihlcARoWnJjlEHAb55oEKF7M9TiSaDsrcM2ziJBBmxFIxTEzarKqXVKhGMu4y
 XNcqYOpZMk5O35SNivp5UwL+GI31PCNtA0WUsmd1DLMpc+pvXQZyiCzcCGOw1EPwWE8EeaWwQqP
 jxya/7vDghOdKZI5btA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040081

On 8/27/26 7:59 PM, Praveen Talari wrote:
> The I2C driver currently assumes a fixed source clock selection and always
> programs SE_GENI_CLK_SEL to 0, which is not sufficient when the controller
> needs to switch between different source clocks.
> 
> Add the source clock index and frequency to the I2C clock map entries and
> use them while configuring the controller. Request the required
> source clock rate through dev_pm_opp_set_rate() and program SE_GENI_CLK_SEL
> with the matching source index.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +	dev_pm_opp_set_rate(dev, 0);

This and the below call are unnecessary, rate and enablement/disablement
of a clock are orthogonal operations

Konrad

> +
>  	return 0;
>  }
>  
> @@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
> +	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
> +		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (gi2c->dev_data->power_on) {
>  		ret = gi2c->dev_data->power_on(&gi2c->se);
>  		if (ret)
> 
