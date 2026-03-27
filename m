Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3213A9DA0
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609041; cv=none; b=jl7Sv4jazugxNH4PeJUR62JjJvcBaaPDiFh5dYfhMpr349HPk/qy6Gi4XE9OpcIl9EY+ywIcXQw8zy9FLy7npbw3ZkMWrfYBi6WIkjEcRO6z/KcsWwvNhncDdcFKLH0DrFwHcUyiNm1D25cGuWNPmgvosyPv6ILDUk/j/W8ioqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609041; c=relaxed/simple;
	bh=fbwOX2zzcHRKp8ve7da4+zfsRmNWq6c3xen52T1LNiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHAzqQmbfZ9va9ATg80EMpYJZXqltKXU8DAWgD2S2Yynq85iPr8QeAfhtygkiONAErW54SBEk8Ec0eUPWpGBkuhCs+grQ7X7U7UJ4X/RcudaklN+CB4gDt0uVm97bZKoPk4zvk8axUKgvJtjU5z1iqkX4n/vFZgewnGBKo4ilp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XGFeLH+e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOL2lw7S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XGFeLH+e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOL2lw7S"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6vfXv2379004
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 10:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	258AW/CGwb82t7rrQ3QZJ0c/JyMAqcX5guCOIw/b9Cc=; b=XGFeLH+eQQ4HWb4S
	yrC3+70vsOF10T3aCG3WGju7oSh6iq4/jnkSL8Pk8K8H24roaMF1aU7/hDI9oWQl
	8kBYlvGtwaaI50O+lQVXXJgOopSkkzAAW9pRCjeujLxR2YH9Fd9u3I1ev30mh8Hm
	o16Cg8dQ2XdOJurI9VNukCBESWtdxrOywaAKD1R1Pwmg5bzsrr69Eg3zpis/0ql6
	/rZvJNGUAUA59vxGlp8dj9VHpz0TSQaPpBnBZ3xATFtuoglZZirYtF/GWg9aO0w8
	fxZ6wRzvufWdo4JJ27EhiQaGDLagqm9sboNAAHVd90eIFl5KSrsdKu3B+8OaX8QH
	q8Y2Lw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx1hg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 10:57:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c73c065dd15so1431024a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774609037; x=1775213837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=258AW/CGwb82t7rrQ3QZJ0c/JyMAqcX5guCOIw/b9Cc=;
        b=YOL2lw7S8jPKtHC8jgA94O3S/YhjS8NQBdEg32/CbONhZ6p645GSV5d0+FPoMqlWqq
         fndpeVJTNaLP7YSHYHIGDs4RSaKHhQJtDSdaXPqSIZHcC4hWFRvAvncoPPgkiykcoiRw
         WF0Z7RL7o/zrefmsv9XquHKRB4euQOn/rzh1tSgkossoCXj49XeaKGCZTGAHB/3WvmeC
         uyaJym3PtNe5DaiIjO7vBRTuowypxwc+nyxz95sdCtlngukK+m4S5JK0AxQDGRk9ORO5
         hq19fXk1v8LqMn7Xocy8MCCeGdvwnPdTtlABX5KLjDkanQskU0/nT2S1nLTFKA4iP7Qj
         kX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774609037; x=1775213837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=258AW/CGwb82t7rrQ3QZJ0c/JyMAqcX5guCOIw/b9Cc=;
        b=Ea8bvH/G/RdKTWK+N875gCcknfEj2RvFMcGIDzqIDP1iOcf3TbQfGFfgtzhH2po7qG
         +PznAO0LDqRjjOZRZ2okZS8nw9FZECbdMUhsfx/rjaPkS1qaFo9y1NxuOMlpvtdZkZki
         kldHOO6WnY9iNfsxnT7YaEscojJc2wqzmz//GYfRuWdc3//kPP8+vTa8FRWdI+iMAGtY
         1GOlNY7e48KbaK76UE97qJhcfBExDWSXqkxMFs2A4p+oH+CTFvuNLKOGUuBRH7twhUcf
         tqMpxCgSInIxBA8keqZFv0E8Dv49V1KYqxU+bhx7M5ndmjZkJ1DPKczIMjQeXkBGa3hG
         5gUw==
X-Forwarded-Encrypted: i=1; AJvYcCXfREsckLdXZkmbeV40RgxUbXpm73oSj8GaVX4m9gPRs2U0OU2yocGtLMWDB3Ph5DuvnadN6Tz1uxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpfXeIuTvhgIFjIHkhBS3tw6rDkfx+93dok2y7RNfNZKfbZnr
	Sgr71/IyKj8on9h+JENal0W2Q5nVsljvWZnCHbfhGXkq6r2JYTz6hqM3d3DiBCTnaghO+A+WdgK
	u0k2p1aff9gwoRj84pNsVR43vjUSIsMM6+uahGtiPn94r4qYcuoEjIW+w6TdcsPs=
X-Gm-Gg: ATEYQzysoIw+w9LpIwoSAGtovGF2mKrvPh0Kyn4EjNskCsfkDb2VXP2Z6rmB6fjZCx4
	4BuzN4G1vBoDgEmzlIIyJ7AoFH+EerQ+LH2rvzL0TYcqn652HcZ83DoBGidD2IGpLIXsfOXsqrg
	U+IqqSQEUylAUbPcAcRn0oSISAxrhacbbxwq7Y4YJvjjocQwaOHTs09s8tj5toGBGKD20Xd7/PH
	IgPkjeALhTaiquglS0WMwGQ1X3f5ayCoRnB4GEzEHqKIxH+nZ9CYhw3YqRS9LPiuNUvqSvt88SF
	DS3J2+Yx9CPyUrLuzhixujeA72/9JsrYm3MTTyOE6/6ChCKFmM6cl1esxg2jYseDvZjWW2ujGPI
	FU/X2suuUMEYUz9FSJWNJdGuB+QA8O1OKbzYfTKC9eCXOF1EiEi7OwA==
X-Received: by 2002:a05:6a21:202:b0:39b:e321:63ef with SMTP id adf61e73a8af0-39c87b64f7dmr1848096637.57.1774609037284;
        Fri, 27 Mar 2026 03:57:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:202:b0:39b:e321:63ef with SMTP id adf61e73a8af0-39c87b64f7dmr1848068637.57.1774609036530;
        Fri, 27 Mar 2026 03:57:16 -0700 (PDT)
Received: from [192.168.1.2] ([49.204.104.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c768b649a18sm479116a12.0.2026.03.27.03.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:57:16 -0700 (PDT)
Message-ID: <3d3f51e7-02c1-4628-a381-5a1ba67b5bc1@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 16:27:08 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Enable I2C on SA8255p Qualcomm platforms
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <873425m329.fsf@kernel.org>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <873425m329.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6628e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=1ey5pj550HX3UePapPL9UQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=d3VRfvEVtl9Zxjpl_kAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: YZuD2EJ3bOwyfzTTWDgE3vzUbJk3D5dO
X-Proofpoint-ORIG-GUID: YZuD2EJ3bOwyfzTTWDgE3vzUbJk3D5dO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NyBTYWx0ZWRfX5RO/F2AKiZtl
 aPB6V2otYjjFs45h+Rd4TsC2o9hTufW2FUNERpC0LeusAOB7jZ5vQ25yFN3go5AXLHYhA+j09x7
 ybE+rdAVd3hj8HsLXO3WvkeNPh84u75DXG45FQ6dRmhN0KjyYV51ZrINFsAQhsuKXZcjp6kXpoJ
 /CW4w8XXwYfn5BfMromPJNioI1/i43zzuJwjgBwxW1Nkh0D95JbJnRI7qnauNxY2W7uK0xMr2if
 qGSoWxyUlOPKPUyw+sryPqvcb3ydK+dIZ/d5/+35rgfaG627dOr+lttwnHdEHticNZyKxFRggo3
 YAoMtgF/evnrerx7GFySSxNlQWMUVes3fownmbIV7s8+yfwTnfAJAMzmyKEkZ4KLoLfYiDa/tV0
 C6odc1sP3l3AugH7n451cWCQN0PqNvT+Ke244Z1ZtUybIwSCcQ5/06NON1+0Q/ey5du697ZR+7j
 WMVb7HV2HTGii9E54Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270077

Hi

On 3/12/2026 9:51 PM, Mattijs Korpershoek wrote:
> Hi Praveen,
> 
> Thank you for the series.
> 
> On Fri, Feb 27, 2026 at 11:45, Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
> 
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM.
>> The driver requests resources operations over SCMI using power
>> and performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power states(on/off).
>>
>> The SCMI performance protocol manages I2C frequency, with each
>> frequency rate represented by a performance level. The driver uses
>> geni_se_set_perf_opp() API to request the desired frequency rate..
>>
>> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
>> is obtained using dev_pm_opp_find_freq_floor() and the performance
>> level is set using dev_pm_opp_set_opp().
>>
>> Praveen Talari (13):
>>    soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC
>>      path optional
>>    soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
>>    soc: qcom: geni-se: Introduce helper API for resource initialization
>>    soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and
>>      geni_se_clks_on()
>>    soc: qcom: geni-se: Add resources activation/deactivation helpers
>>    soc: qcom: geni-se: Introduce helper API for attaching power domains
>>    soc: qcom: geni-se: Introduce helper APIs for performance control
>>    dt-bindings: i2c: Describe SA8255p
>>    i2c: qcom-geni: Isolate serial engine setup
>>    i2c: qcom-geni: Move resource initialization to separate function
>>    i2c: qcom-geni: Use resources helper APIs in runtime PM functions
>>    i2c: qcom-geni: Store of_device_id data in driver private struct
>>    i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
> 
> I did some basic testing on the Ride SX (SA8775P) board with this
> series using base:
> commit 80234b5ab240 ("Merge tag 'rproc-v7.0-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux")
> 
> / # i2cdetect -l
> i2c-11  i2c             Geni-I2C                                I2C adapter
> i2c-18  i2c             Geni-I2C                                I2C adapter
> / # i2cdetect -F 11
> Functionalities implemented by bus #11
> I2C                              yes
> SMBus quick command              no
> SMBus send byte                  yes
> SMBus receive byte               yes
> SMBus write byte                 yes
> SMBus read byte                  yes
> SMBus write word                 yes
> SMBus read word                  yes
> SMBus process call               yes
> SMBus block write                yes
> SMBus block read                 no
> SMBus block process call         no
> SMBus PEC                        yes
> I2C block write                  yes
> I2C block read                   yes
> / # i2cdetect -F 18
> Functionalities implemented by bus #18
> I2C                              yes
> SMBus quick command              no
> SMBus send byte                  yes
> SMBus receive byte               yes
> SMBus write byte                 yes
> SMBus read byte                  yes
> SMBus write word                 yes
> SMBus read word                  yes
> SMBus process call               yes
> SMBus block write                yes
> SMBus block read                 no
> SMBus block process call         no
> SMBus PEC                        yes
> I2C block write                  yes
> I2C block read                   yes
> 
> Note that I used a downstream device tree which has both
> i2c11 (i2c@a90000) and i2c18(i2c@890000) enabled.
> 
> The sources for that dts can be found here:
> https://gitlab.com/mkorpershoek-rh/downstream-dtbs/-/tree/8775-upstream-i2c/qcom?ref_type=heads
> 
> If this is considered useful testing, feel free to add:
> 
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Thank you for validation and Tested-by tag.

@Andi Shyti, Looking forward to the series being picked up. Feedback is 
welcome if anything further is needed.

Thanks,
Praveen Talari

> 
>> ---
>> v3->v4
>> - Added a new patch(4/13) to handle core clk as part of
>>    geni_se_clks_off/on().
>>
>>   .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   |  64 ++++
>>   drivers/i2c/busses/i2c-qcom-geni.c            | 324 +++++++++---------
>>   drivers/soc/qcom/qcom-geni-se.c               | 270 ++++++++++++++-
>>   include/linux/soc/qcom/geni-se.h              |  19 +
>>   4 files changed, 491 insertions(+), 186 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
>>
>>
>> base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
>> -- 
>> 2.34.1

