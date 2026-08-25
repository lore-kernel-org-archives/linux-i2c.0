Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183313DD856
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645975; cv=none; b=Wbs/8vas/Bqwn4uzj3P0NlDlWYAxgpjlUMxCFT/DAhmcWmY6W+GdD5WTHBWP/2Mz7mmxNFTMSlC09rD1GszvhJkgnF2Pnh3oWslcKNG8ZaF0jv/upj2uSQMQ4nV6xGYjkgRQTbgHmze/J5zjGHLZwYSY4/+r66LutytoQBqWpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645975; c=relaxed/simple;
	bh=Ot8jIiii0wOPLXsN9OFHxPtvh5gzgjm6lZFKpTOJH6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewxbwClQXjaOqMKyuOTP/+mjFabzvdTMKrjRFXqd7vzvTbH5MCbn/FHVKlnoJFzTCrH+k+bxTItsXyMwL3otSaApnCU1GEs66MK6HiVO7nOnB0t1OI1nv+AZd2wmffgpSmIff4Of2iovt3R3mdBdTlbYwIs4/t11FHPpQMovYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7Rc8kjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wr80EMqi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7Rc8kjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wr80EMqi"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P888b8771414
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=; b=j7Rc8kjBAo5ttSFF
	a4Zv3pZeYdtIKXkG4JHEeDDKnKiKSSQj0wg7tyKNUIJu5LQSLwEGxOSxXslnk8PG
	h8ZLEiADGwfzm+T6fx6SqN4DEgTv/gr8h0+zJqklIrULq1JmTRJbkQkMbD3q2hhm
	malZb9VMsaNEC7RTMvZqtOh4so2ExbdzcQvGKOqhlUKbED0Y4Ka/b4bjedduCxI1
	csCE7XF3ccE/bAjDrVtzDfW2f/vSyGlUY3bwabmuG2leAIQjpQptjdpNGF3vKr5X
	KcfRz0oQlAUjRSZdqEsAvCdV2gKDwx7WQiLP6rfJAiiInS52/O7VW0qT2+F8ajEP
	RS1nMA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93narvxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484ba00601so5129749b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787645972; x=1788250772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=Wr80EMqiW3KcyFAwopQGGYjYZuix0275KGRnvwM6gWpOXfiDCC2EqpFMeCcTRaPiEi
         luMDvAvmnOVHXVzyNbi9UjXkh1IRSPvakx2dWdEurxtPjsjSu78KGeSmQB28KCvxfyjW
         gIfTEm0fI3FloMxu/0MK+YZRgG3DhHEXF242IG93bIZ8E1CJIZY2ww8G3s3+Fa+oW5nW
         RTvhj/0wEkLil00SHq+/e2NkhWlBo83OPGZLvuzljXBMMwWkJCb9xemGwWTIF8oz0xqO
         zoNYW3UKDhfWqMhYQQYugiiROBRVHGPybtKesOARMY70Yirn/IZrRrxdBikT/2Q5RieT
         z49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645972; x=1788250772;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=mRdtWtHf2mTlYfwttlMqtFp6vu6ioQbiv+ip/8yv1941Se4xC7XsL7vtkygJg4QrxN
         jnuX7dYx9dxADDR/msSgNpGE/kBrd0rSG9tAglrWgNmbKFhGV+jM/JxrF2o5VsE0rdHr
         4Ch3Z3JTHVqf3LAzYH8zmMIlg7SpV7fGp0342xxQOZxAGo65eeDbgKkcvH6AuXMDvyAw
         LXOUzXV1MCk2zHWcZ733E4tKm8p9umUtH72Cs1VQoF0KeyvACaBXPxewDDOI0zlz4+pj
         ZaUKHNCjTylsOhioPIBd8s1bHaN6k4Ncdc3lG3hRZo8TfyiA2pUVGf+KTxt/nBsWofOg
         fD3A==
X-Forwarded-Encrypted: i=1; AHgh+RrsA04JB5xNFCFjXhe5Ikfi8qetkAjJaCSomwDnbq0l+bAEPMs21BzAJEXMd9s/KYc47QlyWwluuiA=@vger.kernel.org
X-Gm-Message-State: AFuF++knGHmbx5eO5kDY4Ss8UmzW3tsrvZq8Iyu/pMo+Y97W50smDuzG
	+O1yG6m0YNXNxd+IrXLsSpO6ZrCrcRN9zH8Ajp8QnEleOSiUXhuiVLUkupJCSf8QSCB9hhi2QoP
	2TPeScy25uW5rXGt4Il1MFoTm3ATPvIP4lk1NtDVetYKfILiBgV9eU1ilzu4xrLg=
X-Gm-Gg: AR+sD11HzWVyNtSO7zsI16O9vOT9Za/CUN9Ch1MYDoDywjaYrU0NG8B+WimUCYoEnxW
	hUP4m70TFgqIH2zhC6lrlwDVhjLlquJtNLgNPz5PRdRY2JpcmGI4Def0lhefySFtZfjlnGMZS0t
	3bqMd9MVXRwAd+Tz+87uPaLH2zX9/vjrOkEVWJkWBhcjX2TpU1pnqL7N1B+8XBd3X48WBGqQdwR
	27LMmfHfsv3gobbIm7vcGiRPnzpzrYl33yk1VCSHACbWyyq59O2YpZ2wxLSbtzHkaBaYisNdYWM
	E49Z/EzAAZ9kuccAz2+9RBRdSUSU5KsKoREAM0W8bMLWVrFQjV8WYq5bp5INeQEqIGA43xWx3EI
	a3CaHn3Nci+uYjKC5pmBMxWa0raUXUEE=
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113642b3a.9.1787645971598;
        Tue, 25 Aug 2026 01:19:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113505b3a.9.1787645970964;
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161701sm2725924b3a.53.2026.08.25.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Message-ID: <956ad5fd-7710-4731-9796-b03dc21cb2a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 13:49:23 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXwVsvH+DBhD5X
 5iCAE74txCLdUvmdLRcELKM/AXcjqGKuw7V4WQV2HMEPTENwzPFq8bgAGHwzHDA8kVfiPi5+z2P
 OiNh9g3O6gOAY9rVfU5/kU4u/FNf0rA=
X-Proofpoint-ORIG-GUID: w8N5-_LBFqfk1CT_jG5c8tr2V_aBFDSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXwuQH20FL6ss+
 h4LxYJCjnQjpy9j+f0BXpJjn93HLdNTOOyvx1P0U2WHELGIrNIIkDTMqEHntpJxH4wBPyjgLLZP
 9K4LvAjkBHtaqVt3n4I8sNanrzwA2LH2Ybt0tfG2hn/R6sBBZ2IThiaSPz58ph6qSQJUNjeFe3x
 b+qcod/UegkPKBQ+mdjtpW3NglUT6SuxFdy2M6QxfL4vfo4N3egrAgz9IQe6vr640LaOnvlmjn7
 Ps96fnMJVIvi0DeiM5/bzmGRrzCe0lhMcXLMlHYddjtjSZ3bFLc7QlRH2N/XU/Dvpqh2wMp7LGY
 X0VR89KSApblUipd8k5SIRAf7Y5RqABrHo7zqfJHNrheB5879hq8Dst/rrcBJyLRKH3+GN/JuZy
 oEMtUsSUYksXhP0/jUCXUznefyqSXSJix3HBNXGiLn56Rx+2EMhF7ZpplkyuOpcN2o/etLvVJXj
 mmtmzYRRK0KLv5oaroQ==
X-Proofpoint-GUID: w8N5-_LBFqfk1CT_jG5c8tr2V_aBFDSm
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d5014 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QDFqMEhmg62cRBsMz60A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250070

Hi Konrad,

Thank you for review.

On 24-08-2026 20:36, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> On the SA8255P platform there is no Linux clock handler for the SE source
>> clock; resources are instead managed by firmware via a genpd performance
>> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
>> fixed 19.2 MHz source clock frequency expected by the SCL divider and
>> counter values programmed by qcom_geni_i2c_conf().
> [...]
>
>> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   				 itr->clk_div, itr->t_high_cnt,
>>   				 itr->t_low_cnt, itr->t_cycle_cnt);
>>   
>> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
>> +	if (ret)
>> +		return ret;
> This wasn't here before and the commit message only says something to the

Yes, it was not there earlier. I have added because of Fast-mode Plus (1 
MHz)

cannot achieve the required timings with the default 19.2 MHz source clock.

A higher source frequency (for example, 32.5 MHz or 37.5 MHz) is required,

along with the associated voltage/performance vote.


Thanks,

Praveen Talari


> amount of "it's necessary" - what's the difference?
>
> Konrad
