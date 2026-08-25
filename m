Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A33E49CB
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646527; cv=none; b=BOOlMqJSSOICOjH7lViFtg4ky6n0kaVYpMM0Vj6Qdv4jfxMcOeIXUwnBJ59nqOKg7I3a6dLogfd48DBmpBxU54/Mp9YhKJK/pS84OZVK/jpPlBeIQEgm1lK6gdYf4AUftYbX9iAvQ7egMkgw9heV7o/nKFp2JjVeqPlspYzvGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646527; c=relaxed/simple;
	bh=M6+Z/n2sPEdxSkumdm4fpxZDeQlqm0ww7+RLX0T8tDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSdQNEOboFukwhCo6jw+v7iRbeC/N7B+/0/nyc4l+qG0+vPd8GKmn2Hcx1jtrd3jiRBb4e70M5sAO945Hyt6+FQn/RkjrefRsW7g+bRIVb+Prr9isxFugEC632oUZ9hXUiIgEGyD8U0nHxw3WrOOHepsYepT1Rc5GT/pq/GC6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb9oUO/W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBXtRCwp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb9oUO/W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBXtRCwp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88Ipa1706700
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=; b=hb9oUO/W4rgIbipL
	mGFectRAfdZBqpJCcwpB1ofAMp8oW3JaDF/3oGnhjjRjyg2iyuqKO8sZObFeUYzW
	7XE0gnADDbK3HC628p4fbs6euvMI8a5pHQLTHFRdEUTtzDrjSyMl8nZt+7N17gNE
	a6Ag6K4qIJCWKEDkW55cbGE9Bb5mQN0xLyYxDpbZ3+xtMAicAQYhWwoBzYbBAnYd
	oJwJtB4UzeKUTFlm5AVzFHjTPEw4F5dMM/OUaIegUF5KBLFbnNTX6uozastRZTGS
	gnZWV3jfiwK+AQ9Q7JIXqTIyUAS/+mlc7135RIl7S8IhUUXRL+FzM+CQev6emWL5
	r1a6XQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93kvry52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:28:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52845bd815bso8760681cf.0
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646524; x=1788251324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=TBXtRCwpxmXRRev1Olbv/b/EPCsWPpbXDp82LD2cKU6aQD0fqrI2EsJ/dCLYiOu0am
         Ly+mxDvjYbEYJQzHhrVYwc2pr4wRi94Der/PHL1DahPMHN2BYKk9hft+FN/vapI88avV
         iYktJ5PT7XLqWQ5Ce1nVqjk+33mkwhDUx0rUJdyw1fZAEpJ6aZvsWKJrN9mhfRra3cvL
         NLZKN6FuSig3cPw3f0rpldS18vyoXpxOBXUV4Mvav0hIjHsxaUWoeSQe9pIUBrzPRJgU
         XuhVvRJBzVAGbTxoBB8ub9Q0SH7pNOdggjfYISndd0s4h4ZknlVkiDaVG95pUE1NPxEV
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646524; x=1788251324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=rtP4t+BgmkKl7ZWOLD2zFHgpid2nb9kov83W4IzKzTQd/zpgWcfBauiFI+/qhNfLyK
         IgFkDg/fi59Knk26N1d/FaClG7MZPfsmBD0Z2ldpxnw8cE9KLW6IIAxhQ6Aaq+zO+iMn
         Niv31C7Xpgv5vG0eiYzhMFVRzpJTjX82o99TBwd5Qj0z+Jk2NOLZ4CoqdOYpt38seVL3
         V7gUxk6gWOTjg746Pw0p0uiu8BnXf1JjQmxOkpw72GNQpARvhBF0LHpLC9fCVL3sLCcc
         lLcpZN+9G4Lw8HtpuSK+aFcOEDwkuyRmxil6O4xd+0yG63/Dh/aadlUrRH0GdU/IxVMC
         puWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpS3krAiT9wK0B/rPj0EZ0h1BJaBdYS+FS0cUU7dQ5MET/6l1Iln1GkLEso2vOiq5ON3zusiUBj6wU=@vger.kernel.org
X-Gm-Message-State: AFuF++kZndRkq282172cyCXqrZMlM+SPA0hwyx2ABL886qUy1feoWmbx
	t8X/zQxUr6MqzpjuEnjpt4x4zo5yjUFwj0AhkNCn9XUD6A+dh82jYtvjOE3cweodAYWSVOviQlK
	butwOxUfPfE/R0YexiTVnpTEeHMC8R/DCSkTsngRQs2n+Gnui9zkzIunxWVVBqGI=
X-Gm-Gg: AR+sD12Nj7NgOTBqvN45D2ltUe/3/SzmRYAOgnCEf875DnGAM7fLykzzbFZ1YZ0rGLM
	TsEFUbTBgCDsz21ouNidcKJtxhzmtpvLyDesMFJ3WkSqvJJlTS/GIJdw1NIodznzcvacdYVSHwd
	roeYQ9n9j7PmD3TNEDVWpTHtVFsiCfym33ZzypkgYCTWkb8a/CBF/73d3Mlu7wsa0O7xW6czShr
	/iIpVSIcHePL8eNKnurS3ZwD/rXOANjCpIRfCwZeLH4hlW39nZepFu0Z8dIddAesXbI3KTU+22F
	jwCCLg1xdbOp2EZSqo1xAF2T0r71yNjKsHuq+3flCDAVez7lTou6MTYd4H72Zc1L2lmOumXnfth
	tReH8PP7izk3B2nIYNlVG/KF0
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835481cf.4.1787646523837;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835341cf.4.1787646523448;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1820302366b.25.2026.08.25.01.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:28:42 -0700 (PDT)
Message-ID: <8d8f7742-fd4a-4605-a9b1-153ace9e14a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:28:41 +0200
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
 <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
 <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX36e/MSIjqoQw
 y1gmEzzqVDPZ+rSOWCNM8ckGHoeHUb7oPMOVMVNSLQGxuyy8sQq7hra1phZEla9AmhdHwkhaxiS
 teMpJTvZHaIfNoi42wDGEgDGxOWuqsS5zv5oD8Bri6X1fWfUXDkKjKlbmBRuciM3hgZE8tcxbbM
 Us9+34ziYz9s+MPyg8JfKu78azo+ZJXqsYAh+Nwu3/HA6DHoCPnUoahEs0cvE8BG/qr/31tCHhR
 Na9Rvm+XK0lM2tTWdunpZ0OfR2pRueVY3r2WV4tLvjNFOl3mROBmZYLZ52RiYCDekwpKJpty5Mf
 dJTdAMagzrBzqOJjwneIFzFgd7ftDY0OVvhfYTNpsWs7pdieixosNHtMkF/ZTh0ZrHwadhsaR53
 bh3dR7vuwHW3RY55KXqU7LmPSNwPN8AT2tCl82X7bbzeZcndZ7r4Ypc6diAaiJPicbU1Rkv4aQ6
 MYQRZX6Uv7djxspv1OA==
X-Authority-Analysis: v=2.4 cv=aPHAb79m c=1 sm=1 tr=0 ts=6a8d523c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=CZKBZ6wm4gaK5Uy4Yf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX319onr55lBVx
 d/Qy62kYfOqw063eYQ6FO9MGZl4Xr5FROqwXoHhMGOGuNi7Prd3/5yPz2WipuXtcoCA+7LrHFtY
 P05lJMGUSqBNstOQQG/9aVsOjHSjbbI=
X-Proofpoint-ORIG-GUID: dPmu8bqXSg0vc7iJYnS4LV9HUsj94BZ4
X-Proofpoint-GUID: dPmu8bqXSg0vc7iJYnS4LV9HUsj94BZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250071

On 8/25/26 6:00 AM, Praveen Talari wrote:
> HI Konrad,
> 
> On 24-08-2026 20:35, Konrad Dybcio wrote:
>> On 8/4/26 9:57 PM, Praveen Talari wrote:
>>> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
>>> the computed source clock frequency, and dispatches baud rate handling
>>> through a per-variant dev_data->set_rate() callback that either
>>> recalculates the clock divider (Linux clock managed path) or selects
>>> a performance level via geni_se_set_perf_level() (SA8255P firmware
>>> managed path).
>> [...]
>>
>>> +    geni_se_set_rate(&port->se, 0);
>> This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
>> bug in geni_se_resources_deactivate()], which removes the power vote,
>> but does nothing to the clock (neither set_rate nor disable_unprepare),
>> which will crash the platform
>>
>> Both of these calls (new and existing) should be removed. Clocks will
>> be disabled by geni_se_clks_off() in geni_se_resources_deactivate().
>>
>> Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
>> to remove any trailing OPP resources (i.e. icc votes defined in the OPP
>> table in our case)
> So, if I understand correctly, the expected sequence is:
> 
> 1. Disable the clocks.
> 
> 2. Remove the OPP/performance resources.

Yes, otherwise there is no guarantee that the clocks have sufficient
power for a given rate

Konrad
