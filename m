Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD683ED5BE
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145860; cv=none; b=lSmc/lepjYfxBFPdqThBRRS4aKUu3ftxMhQ0fqxri0GOfiF+dOINFM0sk86rmppxNcexjTXkLU2Fmc+5Dy6NvOULrjZEAxQq/sFjyhWpfVjInmCN4rKCniRn7A+dSZW64JzpvlLpvAau3VmAQoOPIxElKZJYI5rcR+23Hi7x3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145860; c=relaxed/simple;
	bh=c4RqjY6KZF9m67IHoI3DmJuEKYlcA0wH3I4H2KYFB1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGqGo7mhPGfNhbYNg3gRZt0QYNiQ1kfaC/KyaS2RljI+yDCTdWvgDzfKmgyOgh66cHHPAgaQaHju41BsMpv1oNOKeuioTyqxXMVlPIkm8EtCsvZnPrgmT6niUcZkbo3dqxK5y1KoHABDTH6lUHmHWwtJz3rEWlEPUlNFgo90RRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lXXZW8Tc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCUzDMs5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lXXZW8Tc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCUzDMs5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9XdOb3460824
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFwS8dPPBX/iwtv/BEnalT5oLdkzhW1l834RoovjLDI=; b=lXXZW8TcxUOvERm1
	VSlD0VtELDYugWRaxAenx04bHWWSlRir1qZSZDBSQcXS5HxwUgWKZde/6aj4ZPnk
	vsY29I1qwFWlyXqcQ6fjJCRnOAK2N5QwGsuCFny2l8ZmNeISLmZWFSu7m+V3QRqs
	MAPhMVFekH43ckwB//O+Od+vlRRJ9ectChw01nbDLRMa6S4izmbKm45LVHZS3ONT
	wlgzKJ8QFKtI1wgbl1Gkw80aB0wqLyh688N0uV06WLq0/e61fzYMvqg+wJPAemh+
	Km8nY/3srSsPLxhzYNzesVmNDSn7V7ExlucXaiwbBwRz8siv8znWIpVcNvQw1/QU
	TFJ86g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g0ma4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:50:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so6724238b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785145847; x=1785750647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFwS8dPPBX/iwtv/BEnalT5oLdkzhW1l834RoovjLDI=;
        b=cCUzDMs5MuAUiOFatX7gLDMAzxeyi4WFylaD57KJcz5hmjHhq5CH47pzaPnkwpRJbZ
         fyABBtz0Cw5spt60ejuK8FT1oE3uJa8oQ7MBEhvhc1atyJ9dZ8aFDhB4Qh+CXmFme74P
         Icwd+SuVd1OhMq5G6Tn7Ao8XMTt+bP5nNCf6w7GmdprmoJ+MAN8y7qd/yka12kyohesC
         5J4ztZZvY63sLrlPxVQrw19w6DAXfUAlg7mue8zlrWR/oIbl+XZf7zk1hMjdlKumtV89
         OZO+vnSpGm83qAZODoOLCh5anpyLeCyPJwpoDXcj7SGDCNHX4aXC+aQLpbwuw+5Ot1Ps
         wEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145847; x=1785750647;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFwS8dPPBX/iwtv/BEnalT5oLdkzhW1l834RoovjLDI=;
        b=jVF28MUjYjTSxaIURuABF1YrsM1+ryndD7m8jzUZnyLYMmkDnQlq0N+6g/uA4qa3yM
         e927KnpxEuvvL5evJKiMcx1NsGLIsQqLEQjr0LXuKhk8Y1d/ajJ5aPlcuvRT7a2TWa0t
         Y2ezc7mc57SbvdY4XCZbFj3iXvQd/99IW7fA/WgMw/G7QWEDecRHK9qlcUZtu7ASRB5w
         oIp4KFDodtn+i5kw2tYJNjX0a5X+UkXFZQNutddu1n4UahF+YQLD78iiHAu3ewBTV3jo
         p1TO5eqcjT3hl3/uZxmWVZ/PhVcNGE4KvNUTuzD45/hQzpaCAkdTvxf/nAx7ucu5bNZe
         Su1g==
X-Forwarded-Encrypted: i=1; AHgh+RpAGO8JLgvE4TLUjmJhXMXwPkGVwg9c4jGxiQo1pjcuSRgcOQtp45HqDvfBJQIs1U0hBD6bSwBujFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FJc1J35Vu8uyEeYTO03o9UeY9BXgDfDXnTwgNs11uMEpnGw+
	A5iw4z12wDnUXloJdOD6au5p2gf3fgTX/Qi56w1h3+dwJeeWuVTeaaHGJQZpwlZt9TkJi6unCtD
	YaXyT0L3CkCaREAHs/I9odaOSM5cGbwrb/tkkWLVj3n5+VFiTp1KmUPw/ti3kBjc=
X-Gm-Gg: AR+sD11jtKKyiICpyrlsDyxUMeo7zkfajS5Whm8RlfLP1eyupWJbdxvuuRsQwFZB0Mq
	nG3EdBLATYrO98PRAU6L3z/BK62LUuy+IJGRVOwgGs0owIZ4BBARVJp9BfEFRxAscbupolgNHy4
	HMANUjuzNdgd7FkAZ3tOb81l9dGxMe/kI1UvLzoFXcYpQYTSACmSBqkDUrXO99FdPsoo0bnN5vF
	a8LPSxjs8aEdGzcWWYU2SdWRnFLR0PzeDq3hDw94qWpAbyNyk369AfY07ULiSkSCCzfFmhlwyrg
	UGcUz4TvIMoXB5tr2VCXOeo+365TcUi+0/6lHpsZO88kPexAwVEv02iXpV73XZkMI6nDedHNP2+
	f/EUOYlOudzbevQ4OLGvBN+LshIs73cB2Vw==
X-Received: by 2002:a05:6a00:2288:b0:848:2f84:733 with SMTP id d2e1a72fcca58-84e5959cb20mr6015778b3a.70.1785145847610;
        Mon, 27 Jul 2026 02:50:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:2288:b0:848:2f84:733 with SMTP id d2e1a72fcca58-84e5959cb20mr6015766b3a.70.1785145847141;
        Mon, 27 Jul 2026 02:50:47 -0700 (PDT)
Received: from [10.217.219.72] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f23csm2821805b3a.17.2026.07.27.02.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:50:46 -0700 (PDT)
Message-ID: <77339c83-3fbf-4903-8ca8-824dc7f45839@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:20:41 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.zapolskiy@linaro.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
 <20260727-cci-clk-fix-v2-3-c3958f28b045@oss.qualcomm.com>
 <f127746a-6b8a-4146-8872-6790431b563c@oss.qualcomm.com>
 <CAFEp6-0bZXmh-2+ZKujZg+vbJc4ZYzVOq9zXbsbDwVGz3XLBHA@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAFEp6-0bZXmh-2+ZKujZg+vbJc4ZYzVOq9zXbsbDwVGz3XLBHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a6729f8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=f22_Un8MVmwWBd_wUBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX0sEuTlL1EaZv
 R4zoRY41Qv1pOKaBc2kYW7jxZECjrI8Ci+XokA9SBM/OFE4TntSh5pzYCAXpE20pkWbTC4gwpkx
 L4gITM0DPp5BPNgQFuI6BPZn+QhX/uk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX3rzpffjULjRo
 ATpmTnZD4K9oPX2R06zdNqJgA6zkOA+fJ5I40R7H3kKXKiMno5N/8nqGIjwiW0ODKAM6iRav9Hm
 VR0pq7tfbJ+QAFjFlzf+AR0BgvY5R2cNfskPQoXNG2yd42IlA9+NPn/nJVHhXIrc3MynPRuM81n
 1ncBkJfWDSrr80QEKV0iqvjMgP76Ojpkf4bijA6cN2l5rvsEjwhK+NpInwb5eMTvbxmUXeZf3CR
 y2khnIkXX7kzwCi3r1ii+zHxooNVSDfP7xgG+D92Lich5HiVjpM+idEElBP3iWUSgZtzP7s8snw
 4pv5m5dnyQg33okVfY8d6G/2wWBqdeAIh0NX7nxtyrmVSUyalYxxx3po+ZwH5Wlj1xFLnUNjefX
 725k1/ZYvdv91bWC4ZW9FCgR71cAcVuvQHMqUmtKCgMF6HiqEuCjEbCMsCv3XiZrJBR3U42Fn+6
 FOhKE1F+8RifHWyHtAg==
X-Proofpoint-GUID: Vw2suezmCY7H397tOGXfTevn7-NT9aAs
X-Proofpoint-ORIG-GUID: Vw2suezmCY7H397tOGXfTevn7-NT9aAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

Thanks Loic !

On 7/27/2026 3:15 PM, Loic Poulain wrote:
> Hi Mukesh,
> 
> On Mon, Jul 27, 2026 at 11:33 AM Mukesh Savaliya
> <mukesh.savaliya@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 7/27/2026 2:51 PM, Loic Poulain wrote:
>> [...]
>>
>>> @@ -587,6 +618,24 @@ static int cci_probe(struct platform_device *pdev)
>>>                return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
>>>        cci->nclocks = ret;
>>>
>>> +     cci->cci_clk = devm_clk_get(dev, "cci");
>>> +     if (IS_ERR(cci->cci_clk))
>>> +             return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
>>> +                                  "failed to get CCI clock\n");
>>> +
>>> +     ret = devm_pm_opp_set_clkname(dev, "cci");
>>> +     if (ret)
>>> +             return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");
>>> +
>>> +     /* OPP table is optional */
>>> +     ret = devm_pm_opp_of_add_table(dev);
>>> +     if (ret && ret != -ENODEV)
>>> +             return dev_err_probe(dev, ret, "failed to add OPP table\n");
>>> +
>>
>> if this is an optional why to return with an error ? IMO, further
>> operations should continue which are not opp dependent ?
> 
> The OPP table is optional only in the sense that it may be absent,
> that's the -ENODEV case, which we deliberately don't treat as an
> error. If a table is present but malformed, or can't be added yet
> because a required resource isn't ready (-EPROBE_DEFER), we do want to
> report/propagate the error rather than silently continue. This is the
> established idiom (spi-qcom-qspi, qcom_geni_serial...).
> 
Sorry, understood now. hence protected with both the conditions. Makes 
sense.

> Regards,
> Loic
> 
> 
>>
>>> +     ret = cci_set_core_rate(cci, cci->data->cci_clk_rate);
>>> +     if (ret)
>>> +             return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");
>>> +
>>>        ret = cci_enable_clocks(cci);
>>>        if (ret < 0)
>>>                return ret;
>>>
>>

