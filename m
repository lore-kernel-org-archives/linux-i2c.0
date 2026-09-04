Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F3270EC3
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511793; cv=none; b=hNigSfR6JkpEWrIFSjfN5Eln7RGXFs1+gsgXK7r8byujk/dviZGFVuuzFsCsFrbK6S0y/jcAX9HzwjfEJIswPCtg7zECCYua8+9nEM48kTsamCUwj+iwMjPku2/t5OPyFZlTUh74QfucrlvXZGpvuYClgBmAWsINi9++6wZpdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511793; c=relaxed/simple;
	bh=i5WV/wG5Dqysz3kgPy8ahQVJUTCnfA7qqWTM0oCKVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1pmQTNgOnUmhlSqpDlwZuDpr3q8eoqnJH0cUGkRTd6JK05xliaGHqQ8GzB05MPQKzjLhmSTnyd2Xt+ipa0NSwFbLKauwSv5lGLLGh+tt8e75Lks/Ml4sIRsm3eIzRP++FXOdQeprNu+qlH6mzLlExgmJBO3UF26BCT623EmgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3rY66/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iw7AwMoR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rY66/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iw7AwMoR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mYoH2838299
	for <linux-i2c@vger.kernel.org>; Fri, 4 Sep 2026 08:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=; b=L3rY66/ZPsUMtp1m
	yZ5+t8eehR1pILzku+yzJTRv9c8fPHtBIRhJAtktnQcepeykDJVJPP9dFR2egT22
	WMOXcRbe7Va+vtP5a2Tw5XvojiVIYPLjk+2ee/Q+6MSvITBw/WKAjdD3LvXvVF26
	LHt+lhPazQ0+TsN/VttyPFw27t8eLdEf22Tlki6wwUyZl3ujIeNXuPW7NsMR+17k
	RBztDGxY7tL+s/J3A3kCF348jxqh5vXyDwFaa4WQ+fHJXk80JFxJ/g66dtXvCviO
	mvoG7dfdtvdRnFPa8nMAyyN5Din8JuJqzFYNdbhOwTPy2doKvYdhxWwtaGTwxuOy
	WGtymA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrn74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 08:49:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93495488976so12843085a.3
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511789; x=1789116589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=iw7AwMoREmB5f8MnuFC+NbL8r5xprSYF7cqYWPzErCnK1Wnj9/t3CYpi7UjIJrgBzb
         ahMU7iGrtWUvWx1AE0RHEr1/4n9KzQSSklDlIOyFG3mtRGfSf/axkuxpiawxfB6U62r6
         xQgF+ymMnfGMLjw2s4wWHkTvw7B31dvrhsFDyhAAbdvEV8RRUjCZSr7GuduMSQwfus7w
         nH6pieYFmyljezx8ELFtkFNnLBIMhCY94sjUBbkxCnVCU6bZsrooF3WgnY7W84SmlMni
         ATkzGy72mOilY7+6RTp4Ay/lrfZYl49b5EA0f3z/IpnUJ1Rcv0hc62GvpjeueA1xZg8V
         D4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511789; x=1789116589;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=m7eCtiFT1In0zqbI68FCE3J/OAnrDJMWG//ux0wZdqZWoayYDe4wK+XJZiSu6cfTly
         5RakaO8zQxRedmFxkbMwDy7dsutlWLWWwX4L33maXgoBaDxABWzw82qvmzn0JdfkjeMU
         ZlbefRXSQ8bTktpBd3GpOy1QaTI4jelkXSA5uJkihvBQbEgyiUUKTDxufnlBDdzhxv1Z
         ndgqNxKU/Hmy/bTQRyi0j76oIIIwGT+ykwnxAuKaYEvuTkaXfzq7LtRuCVcY7lUubJiG
         +zf5ePUe4hypn0bfs6sorC434oluIVGL/Bfn3xDy9Cl5aB5HD1O2rNlzzwmYlM1iAI+e
         hLpA==
X-Forwarded-Encrypted: i=1; AKwUvBwum0Y4wkRbpY2W4yem1FujHx1yqW2dSim03qAyvcmpGWRcIbojRwtW7H9XCqme8kbkP2w0texiKsA=@vger.kernel.org
X-Gm-Message-State: AFuF++keFf2iBRKv1S4EolRs9BdiosCJpCgzEa4BrYCj+RhMB8T4aokT
	oZxxKijQlu4aOCoLkFu3BrXWEn6rMNnyVs9yYL/4yCXYbDAhcDXe/WpMeFLjz0agma/8v/y4Qpy
	rolSe+WwEVUYCejlkjxIbkQQlhNpBNzKYJBFzCI4u1Nx17LB56DzZSVbbgnIBXCA=
X-Gm-Gg: AYBFou1+V1IxeDuVxQzM3Dh3p6ClJcGsnpSSpSPGcN4N9lXn5Qckql98SlHkTSbMqef
	TPgPLb6XThxnfcyqv1jQGoIcO49dPWw4yGkqQ6+bwPVfLTxwa8Dpys50nzT4oar7a0b9dQUf5Hd
	Ax+hwPQINbrQ0V6KSM8DoLsgsBe9n5D2+venszeaMYcwU1vlwti3+1XfaXoxMJU1i/pwMcohmeI
	tQZ0xauquQD0uz8iQ4/JZdWL+fcu+3xyNT8F9phaiyC8EFDDrAAqyf4UMRhq7LDCAnPEIK+wuOK
	8OW8v3HIT7V8lJI2uJG9WLmiNBWbpSYJDjCrzP7FQPhD2cZqutwECUW3pCLaiknoCD6782+vkad
	NS83+qlb0AsL1bSUpcwPQiQ==
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146195985a.6.1788511789689;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146194685a.6.1788511789302;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6a1dsm867795a12.7.2026.09.04.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:49:47 -0700 (PDT)
Message-ID: <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a862e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gr6wjo3fgCfCHpJ50bP0YXh44YkGb4ha
X-Proofpoint-GUID: gr6wjo3fgCfCHpJ50bP0YXh44YkGb4ha
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX41vYw380odH8
 9um9nNsjRF6iOVV+nowO5SslQXymKfrnUw9KmabmvrWCxZ0TpqvnBa2q1eZiBKHEWv4/ZpcOYPG
 1TliqAaq7cbeuT8y9Y9s1TR+OYrb/Bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX0PnUPz35+l97
 4mbro+g1Fctjrn7NnLnV7tf/57ZZA3jn4mbh6u1ft9HNrvwWFjqQL9uXGe/5nyd+shxKG7rsHCJ
 JxtzQ2fuyc3sluH3qGiNlCoexRUb7qfw2R6wJdHuyfNw+vUP28cyObij1xJ8mnAKkF/IZCVB8D2
 JY7ewYLDdEVmriYmmOAd5FSvOE7TAqStAXn6nEEcOiYwCmsV0CcOrOuzmaPfIHegYb9DTwBBIS3
 iawyPqXhqYHVuZMlHhSDe5fbH9jZNiYI7zRzs3MIWRxcMG0W2AfoUU/aMMerI9Us1ZXZZ/IChcG
 c4K3nPUMccfY05eYzN275V6wy/01k5iBc5DL7X2/EeX23Y8uSs4FeoMT6AUA/zk/KTeDhrJ7a9i
 twCSxtpHe/8qqyES3qgkVziQlpv1tqdKqqmh6fccJR2HQhuxFc61qOHKVoVYPn7XVQUuSjbCN4t
 abZ5WsAJYPuVFenEFbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040080

On 8/27/26 7:59 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.

I believe the opposite was the original intent behind creating
these helpers..

> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.

That is, on the other hand, a valid reason

Konrad
