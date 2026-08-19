Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA07477280
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149269; cv=none; b=n/Pby2cdUiD6L4OP/vRXaHR6lV4dxGOyBNcyN5u3EWwtL9Wr4sUobi6TcLfLwC/yqq5ru3uhUm/YCSEYPicGn03Vq8KRidXnvx8ghrta9fYjKlUT4RwgfjJGXKNmhqYQk80IkwWQRjhgiCak9/CjqEigy8GY8HE6Ddrs/61AaaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149269; c=relaxed/simple;
	bh=3wpjqBnRA24pZMh5UqHMI9YWMbaUGaQndBFFvIiKqPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qo5Nk07ltBQU34c0NFa0MpL1QMt+3fHu4voY6bCJFpXK6QxMJbqk+q8Exh1Ln8q2hlD7Il+bqwCtLYSNF7cNQw3RKCjY+cTfxIGkcXlywEe92LPVHiHftG/yUFu1qZACx3RqU/llYoiIqW5vbvy0/LI/Qs3N0YVYXEyLlvg11rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q600KRx4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brqysGQ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q600KRx4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brqysGQ7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0GCL693600
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 14:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JajUSq6h8dMddtGWdZA9x0Ah38NN9UEulnuJ7TV2YjM=; b=Q600KRx4CNkIWZey
	kKZvltujHlHliCA9mtvm819toAqbx4q8Po+yNbHyL9aJZvsc1m6RdxILuN6QPYk7
	9Hi59+VfExOzRC9ti4glhcDBM+RSaoaRgkH6wOJ5CIgm3PYIQUJa7iFsGlg9VTev
	54s4lGJ6/z1P9l87gwtZZa+dgEC7b46wTwM7oYdHwoBGB5+iVxe/8XFDc09aCY1+
	824z61jrPsJBMjbPUhymr4DmfMFER2hPy2teiaHk32oApxiIzEQPP3+QAck7hwwD
	TdMQiqrojvE01zBApw6ca2qnAzMBTwz85z2nhyk76P+QS2AecwUV2WuLsQzf1LgZ
	HlWV+A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbmqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 14:21:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bfc08e95ebso42532e0c.1
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787149266; x=1787754066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JajUSq6h8dMddtGWdZA9x0Ah38NN9UEulnuJ7TV2YjM=;
        b=brqysGQ7YLaiukjUK7GkQQ2OiEGAu2gcKpmPADGLiqePnw2TklAZx44+wqUeiNJ99C
         jB+wWj73BRXLXGU+hocGZU0rzyMN3T6Yw1EFqaJ/jRo9ZKfTyaUVfRyV3sfPaKDIwNYs
         r0131fXcCd3HffOTY4FGHUEVbe2LBjqHC8LF6x+oTB6S/eIyG3adgnC99ovo5JV1k6Kv
         x7ZmbpuKVryxOb/j7W71aV/l+yhso3PXZjMXTMTELLbKoluvAqYZNH4jfs26/taocxOs
         4gN4uMrqjHkt6wlM5otinHFfTc4BVBKBE7gikUZseZAAAefSndaigKoJhEpKk4aAGvp4
         5sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149266; x=1787754066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JajUSq6h8dMddtGWdZA9x0Ah38NN9UEulnuJ7TV2YjM=;
        b=Y9dcuLvKm3qNjzTWIh2D8irRjNmRnLy9YpG326nFVtuYUKhElYJywDMfsDBYDHv/Dv
         rMTYdOb2PzZlsVTHn14DnHIZfiuRBzigtwTxX4VZ/B3XOXETZDYP6neu4JHGM9XDmAci
         o2eQ6b1iVo0jchJ/C+npsRXERq8DZKTMU/bbciEr8zYu4I5WQJRPZYH/0ks0mbjrqDOF
         BqZnAax/3H1uIbvz8e1rRbe+cARchLiiKRF2I1jjVwCOvBzIR68VR8PgilAoJFDLlRkW
         JUW4V8/iCH9gCyFSuRybQjgjZZjaB8OEDkrs+KJfblzQI+hLfYex9rpb0uJjKlSrKNGV
         EjoA==
X-Gm-Message-State: AOJu0Yy8CI17adq2HnLWjtT/Fv0M65+nZ3Eb5hVqfEHdHIsajR2cbn/p
	h/CCyR9yYvo97rM71Y+IDYEQOjKUY8cAHXVJX+spyk0U5zNV3gyV6Vr5Ak1kyD9NM5jiugyY2RT
	06S50hzBIWsKXCLL5se0deghqyQJO+Yd3/L/ewJ7kMi6xBeWQbcmdQn4zGTrSiX4=
X-Gm-Gg: AR+sD12L2T5UPPXngBmUtnO7SliYD/vRYutVqopq55FsDlNvENDhsQGNcuMPKvLzzLl
	5Dc3/uDioOp5aZFZ6hib2RLRA9E9t86Su264za+be4LdcWt9xuNSD25CRB85eu8GFBkJLerVg4d
	r2Nm5XFvLl1fcD0KaTsrtl6zK8gBARAW3SBAkWADu8ekbV7OKYLRjGb4U2jbd3b+aubgzLROSYM
	6mmgz3vXvk6eoIUY+rAAL5wT6wYObJ8YPaLwMd4MN7lky/YX1LLNeszMOhbSdIz8CeH3Wrmv6YA
	e50ZR8ZLKEYnaJspT/h+GBuwBkoAt6m3wFi5WbbYoqK4YjLdnxmQ+8fZi30X+3tdENQ7A+mJ8lf
	5lIClHiJgm2e5yWoG93kSCqNh
X-Received: by 2002:a05:6122:6d11:b0:5be:146a:7b09 with SMTP id 71dfb90a1353d-5c5e3be6046mr778032e0c.1.1787149266210;
        Wed, 19 Aug 2026 07:21:06 -0700 (PDT)
X-Received: by 2002:a05:6122:6d11:b0:5be:146a:7b09 with SMTP id 71dfb90a1353d-5c5e3be6046mr778008e0c.1.1787149265812;
        Wed, 19 Aug 2026 07:21:05 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a189e436desm5677241fa.42.2026.08.19.07.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:21:04 -0700 (PDT)
Message-ID: <1c2ea441-662b-4dec-bfe3-febe2b1a70e4@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 16:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Liu Zhenlong <dragonliu2018@gmail.com>
Cc: linux-i2c@vger.kernel.org
References: <db94c578-2bfb-4297-9955-fba690ecfe39@linaro.org>
 <20260819030354.49170-1-dragonliu2018@gmail.com>
 <52580314-6c4f-46ef-97a2-39ee6ac4098a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <52580314-6c4f-46ef-97a2-39ee6ac4098a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rLSsNBnl6oHhBptK0njrWkcLvkFEohkO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfXzt7OtVO8M5lK
 E62spU3jN0B3FVCnTe1EEo6sY257r7reozJKXcSGmSnbVnfQpSJo4YujV4xlYRmh93VW1xKD5n/
 l4l1eDCagkGz3B/Z5p5zGyeKgU6YQdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfXyR5b52kdASNE
 Q4KbCBow3TWo6dpzT6VmtxccnlScbrHNeIX+ZhJAZjAMT+AUiMgtXHR/CH8Mq1ny7Zed6700g+p
 KXiWxyLCxwwwdCC2tTDn60TxIzJhN5yUi4FHs5sTXLX4Zor+zcIQs6ltZuz9X1NkL/7hrjxzVQ1
 ZVO1Zhq8Pat2W0gE9FXWmmg2LF190gEk9DPUcz0fTU4UPoQ/Wf2oRVxeJLsP6NDVA6SRqqCH752
 Xf0pOHCExmEZmsB8L4tGUD0rBn5IasHCbs5HXcHwGbfKtW5+cE2uQup8sbKcfXv+yEt2gT5XolX
 TUFnWpLHXFrA+WlCgnP2OMdnlhOIbm8oHN7mFJnZXoKIrzwUhMsge+okWrZDjOF34G2wsH4wfRz
 6JgckJL043xa4WG5HKJ+YUsREwCIfhp8ABFpXRjx9b3NcEsDLdIo7g58cKK1OvtDn082glDZAVF
 UYBL2sYbVnujrGUf2Rg==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a85bbd3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yjWCthIfb_-DAcdN15kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: rLSsNBnl6oHhBptK0njrWkcLvkFEohkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190111

On 8/19/26 9:02 AM, Vladimir Zapolskiy wrote:
> On 8/19/26 06:03, Liu Zhenlong wrote:
>> Hi Vladimir,
>>
>> Thanks for the review and the Reviewed-by!
>>
>> On the cast: I considered (void (*)(void *))of_node_put, but kept the
>> small wrapper.  Casting to an incompatible function pointer type and
>> calling through it is technically undefined, 
> 
> Exactly, according to my reading of C99 section 6.7.5.3, paragraph 15,
> I believe it is a cast to a compatible function, as I've said earlier.
> 
>> and tegra_dc_of_node_put()
>> in drivers/gpu/drm/tegra/rgb.c uses the same one-line wrapper around
>> of_node_put(), so I followed that existing pattern.  Happy to switch
>> to the cast if you'd still prefer it.
>>
> 
> I would not insist on the suggested change, as for me both versions
> have incomparable advantages.

Just seeing (void (*)(void*))foo scares me

So for the current iteration

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
