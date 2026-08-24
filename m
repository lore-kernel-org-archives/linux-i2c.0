Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FA42E8F4
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584022; cv=none; b=Xw4QsnR+AL1fViR8Zt77p5D/qDm+zSvi23y/eihwGHDZXwHpqaKYSGOfKnnW8p73RExfyZ6vRsH38YJBunH4bQv0ix1CtwyMmhqe9EllJ4DpNSYuoOLD9A56IHcyr/NjZZIxU70X3q3kqJho8Yx81U3yE0w1ftdmOJmk6rgCz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584022; c=relaxed/simple;
	bh=WsnfpTDfkMnaQf6HEL+ttL08frhpgTwPFvG7hASiU0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCbyiYl3wB04FIKey3mqTXJQjio71CzA9/TNtEgfp7K2ylEiNBrJfet23TSimLEzy5woaq7XaOSbhgU0owwVrnEZY0teR17Hz73BI9ZllT0KKOxsM2jWDZk2X+fsDEtADz0B3WWjqZhHEMS1RFSzEYtowj1DW6wALz0UlsXfZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ateVbhtm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gc/upujG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ateVbhtm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gc/upujG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCvHQI2006969
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 15:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=; b=ateVbhtm+14kvfjM
	DGoIJjbkOeNppgOxnkxhmXJ0kbvA+4O9h0ks0U2b0R3CsgH1wLql/YWPjzR4tWSA
	7TjtpvVg0AG4rj9E3PrwO/kqu6nsrBY98YB8aV0l3dHa5X8ylVaWqHvCPQksfTt+
	9lWerPMdhULTye/QlBOC9fGCDkNZlFlBZSYEWFE1EDVVhLm9NyjEeoeVKWJGQ6LJ
	wcgpbcIryQXmQ8iX8yQAmD+qPL2reEpsIzj3XOk83mZHUMlR0JscrwzHMXKzKTzs
	xsCp0SxIz1jyAPd9XQy+LGaae5TmSz8mgT78yrcbPagsJ57560vifAqFVrSVNGbN
	kWzALQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv799t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 15:06:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97752c2acb7so52103241.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787584018; x=1788188818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=;
        b=Gc/upujGDOUYRfD5bn3XnKuj4By+4y6Jn4r5dYb85u08JZR7f8itr2LO+wB9XIBLjL
         yWTlVHA2h012PgmQaWeKdVl9ybAGpJL7eySgoMkeEUS30pxX2uaFQF3/wpzd/v8eQK7g
         9jMluDgM/IpZ6Cnkd+lB0f+Wk24ygdZcgB/vvhFby/H9Gz7GaORE2bVh4NlwHuXbvN8k
         A6pOtxfMidjSLAkuM+apj16ZZvrgRcwV5KJnnHspcKRXgOZ7Pw6GxE5GbX9ZL5WntISX
         5zdaCGqOEbuFreGH1cICdatIabZBgTbrfwfiHzf8sbF2zmNW/zb3YZraftvwGv+N3v5w
         3i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584018; x=1788188818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=;
        b=IPTrq1S1tqcI26zADu+zJDV5Ax3NQ1axs8eFGyYXGF2nEvmzraEiuSbtX70VFqIRLS
         dmH+Er1NMH5uzqqTE1/bOZf/8UDsJu+j1D82jYt8ljdNyF2b+cPBY3x+Q0XQpB5j/zn9
         COEgp/wilWfaJhVydKYLVaJeHXCApvpazziXwRs1hliwz3SFMCn7Yczjjtiz08mUDbHu
         gjiBpiJIfPqe88g2dsq+eBc9kA6YnnBqL7IoOAEH4doG4gDsL4X+Q7Tv0pp8TAEGlAx/
         LQv5Ry9X8hqRTIucJxbEljlZBwee0xJnjwSD+U2CkccRS+zpTGlRAAUmJz9z7mZfLcGE
         05Rg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+UQNljhHfGL0x29RLCZlmkhhGGLtE0F7fgASUjd8rKHmqQ17SLvwzc3QyJz2A/mMCyuN9m54OxLg=@vger.kernel.org
X-Gm-Message-State: AFuF++lk48s8wJQHwuCJNCtBaiEmgD5dJVonaQPjCdDWtmMFN9PNGe+K
	NqYH2JIGc+9JCf4ylQlLNpWKjkveVE2drW3g5xpqEUgh+YGXEiKU+8g3cAz1qlPgQQt5odNRJMz
	Ehtpxy65mmdygyky7QmrYIEb1mlldwtP7teBbOYqp6ywY5GD073uPoUEAYAYe/8g=
X-Gm-Gg: AR+sD13mj+tXIGzkOELAVpG6MkQG5zUGdO0oxd3CwIdbXv7U8Mlfd4/sLneiC3HPrpw
	98lu+ajDAP/EfEPCA7NSZVBNSkHRnAFNEMxpsWAJJSeg1LSNF7/3jAlrcFuZ4O/8asSBDUzvKXX
	25tfhOrsG/Bsy/5PDh1jBSTQfZYQiaH72LYMgqsTAIlWt7V++WglE1+Ouz3RiDQL736QB8nUuN+
	PbigNZUr/cR2XPFEMCn0XggZ6RAX1kfgzHDYSLuCLGcyWNORPhONKd6Bu8r6MK4kefzrh4wVUjE
	dV7SfQlAbtj+gUEw5Y0pZtUSxLo8CPn9b40GZz/FFJr9M7m+uyxacUzSyISthSEOo0vH11mJKrE
	BNBaRadfVfDqslMd6TC99YTSp
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3704109137.1.1787584018234;
        Mon, 24 Aug 2026 08:06:58 -0700 (PDT)
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3704068137.1.1787584017657;
        Mon, 24 Aug 2026 08:06:57 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199ad5sm9278440a12.18.2026.08.24.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:06:56 -0700 (PDT)
Message-ID: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c5e13 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7mB3cpwZ_riAn9QYn-4A:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfXx/EuSeZyLJ8x
 au8goB/drHIFHEw7UiSrJGs5qsSJA2/H0sHn2kiSpI2GqqWku55gF2H4sOpMJgyAGVlUikWNufa
 f+YzOngk9kn1SyCnh63H6l1+y/OKzwA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfX3yOEvJAagTy5
 7px6AAwOtahOi1F6jqvoMUf1w4i27+E9jsepNAr35zxcck1vyvrOhfzpiqUSqZ+OK2deoYD03EI
 4sRX5gm2Jf77GwssAecA83aIAaSklw7CoKW4Eto1m7XA3Sanh4LFiAqDHzHlagnAoGSTVZjmniD
 i+Vv7gy4gdGYr41zXqtQtT0qq+Wqg/w7+4dk9fYKB5nnA8xOCaNq10mA0/UHmuqBELMleWNNSm1
 sD4q53eCSq/ZHxjaGNxvpWXvoYP5BBQ9UjvKg5WCEsffbdTfjm9AZUaWHlrIjqDZanePMVJsfn+
 7YSmhJ2pyGH73nsZcIzbmAJSoGHw0vy0AqQ5Nn2k7TZSR/MfqZ8k8HZBBitdLY9/ucrI6d9lGso
 WtsLiRRZRoyEkhYwCRWBO4MWScW5IQmDbIUbJHyNapqJGgOkNkpksXtqzU6arm2+1oZIBN53fYu
 rGACfKtcx21m2igZv2A==
X-Proofpoint-ORIG-GUID: HUVaDJJSi_FofwyhB26oUTLBB41wELU7
X-Proofpoint-GUID: HUVaDJJSi_FofwyhB26oUTLBB41wELU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240127

On 8/4/26 9:57 PM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE source
> clock; resources are instead managed by firmware via a genpd performance
> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
> fixed 19.2 MHz source clock frequency expected by the SCL divider and
> counter values programmed by qcom_geni_i2c_conf().

[...]

> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>  				 itr->clk_div, itr->t_high_cnt,
>  				 itr->t_low_cnt, itr->t_cycle_cnt);
>  
> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
> +	if (ret)
> +		return ret;

This wasn't here before and the commit message only says something to the
amount of "it's necessary" - what's the difference?

Konrad
