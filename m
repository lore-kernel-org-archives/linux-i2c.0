Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1D1A2C0B
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681009; cv=none; b=kb706/P1mAxoQM1n5OUH0SazaTn4LUJjb0+ahpfsiVinzd8gbdkUF0u73NQAakK4h58U9XuIQqDzw+Gee2oA1m3ElRWCGj9FCTavlo1WlkywFy4XWzYuVuGvNMoW/WKw04V/3bGORfgnmYLgtxpAUnf2mIJcqLqDfGHc7oExt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681009; c=relaxed/simple;
	bh=/qmvj7oQP9+hee2C20TKZdFcP+FMqjk6v+eNCfV8brU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbfKkYNzHllIIx7b93U7wLvpluCHOiwp1q1J11/yDZD2GV7CnUjPiNLnlKvQbAhmhSHHy0aNLBw/sW4vBHgYBOG0YkyMiAMbs5E9eALPjNU1WDCDYNns58ZMAxFY3G3WzILtxwHpSKPmaLslsbZ9+W6IOadBv1jcLSb0LsvZnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LStShXil; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khaUJU89; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LStShXil";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khaUJU89"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PHdF723672887
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 18:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dAzvwPMvS0QGNlY8eB3tLuP2d1LA5UE0AZDeb4igS9A=; b=LStShXilBn/N/NVU
	B+zJ086C8sJhHVWLd+R8rKiO9UfjZ0740/W+UGfDVPq1bKPENeK4jFfAyipylQJu
	BVHo5R1jDR+u93GetjgtVEj78/zpeMpkezZobvZcP9GvPdAdpFo4xz526CB7J4/L
	wPFFto914JwtFXJGu1jM1yJ53TkHeSG+BI8vSo/ENi2hzJ3W+en+8vdrL2/bwVXl
	kJuIV4gj8mFE7uBeQYpZkJxQgJk5IOocT7/JvB5MDsMUsmsuP51NgRq1E37cVd3H
	wwmoU+biGU/cZYb4Y03MkYOB3Di92t2XG3svLhIS0lB99KMrFzTR7kXia+r5OxvD
	F5eR6w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnj9bgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 18:03:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso124423a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787681006; x=1788285806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAzvwPMvS0QGNlY8eB3tLuP2d1LA5UE0AZDeb4igS9A=;
        b=khaUJU8989VwdPaqaxaIb4vL+m2uYEvkuniKfELujRysXiZFdFXLp4eQzfOkSObr3x
         +RBSfF7VgsJQvuWepZWOZPC2epKOjHigeh9ffy/coSnMEtnkw00RRmObr7YzFfPs+kz2
         DW3FNzWdbOGJ6rzpZsk+x89Fu4kR0GnJA2/ijeF4GQgQVz2MZRsreN01gOD/sjJmFaVH
         vXr8bOBrO3GBqlFDotWIrAW+fyzn0MNxTfc0KuSdJP5NIqpsQa1HJsV5bH+OxHli8juq
         L8gApFt/e77lqENBvfrlMCZamwX+pPx+OXFZyTQVt10wpj9+y4o4XTHHtcbMxk5rokUq
         qbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681006; x=1788285806;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAzvwPMvS0QGNlY8eB3tLuP2d1LA5UE0AZDeb4igS9A=;
        b=Htf38j3bPN85iRYf+oSXEvN60I7sk9AqOUXEKCkUfDkynGLhsW++WsXtgYttiWNLZw
         56Ka/z/+vGkElklBuQLvyZLBh0e0xs6RLtNA0GtgPObSMUXSbDn8M1tEDLR8+88XO+V7
         IhSJQ+DdoKSsQDA0YutkS8Mebc5/5ne6asemgHnu2ZRh2p9ALz998MnA1WTn7sqs7Obr
         LhsxOy/AkoLBdGVqWAlAuANWCS/Ut7nr/lXPQk/hoXBNetLtdfTs8Oag3N0r0U6vR75U
         5uBYDpgwXPPbBf/IImGCUGK+0PLx0PjaSw3G/0mX11fiD5UTtP7CAfEOSJSXZEwlG/j0
         y7kA==
X-Forwarded-Encrypted: i=1; AHgh+RpIoc6KPSwTcuzWLkFIdMT2ojpO1+cuvqklUf7U68ZPaypJmT3Cg/8ZIZyPi4p5rJj2ltEcIojc+2I=@vger.kernel.org
X-Gm-Message-State: AFuF++lBVKkyzxwOv2Eze6JhIzxV8LeVyC4duaV6zH4pPuI+48/vShsJ
	1ofmLI0PEwRWaRwsdRAW8A5ihBVz4pMofGxv3iTedvBizvE8XxyGU2Q72MupJ3I06TxWZkjlZ4P
	TtVJibJcAFIPS+qoAhJqRRpHEyuQ+xzX/q9I8d92TJpaoevEVDH5eSiJaz5bGvLs=
X-Gm-Gg: AR+sD11UXCgFEIpNfr5abHzkEN1AIXk3qoXz2zxbDvKX8hr+GfvxtgI3gfj0C2yy1rH
	O5TGS6BgOoZaYFU7lGsq+Qkxvr1jlnIfS9i9SGue0vH+FFSR6Dcl1aHtABlR5+fki+ZN/IDyWzF
	zC7EE/sM01dfl6uxN4wVMjJ46kmlAWOBeibp8fWLW1Q8zGHjadsosznJCDLYBrbc6G4k1QhLKDB
	xqqbbcX9ReoAMMmNpwkNgk+5sgAsLhPnv6k2t9xXdoPisQN9/2CGnmzjwN8q64PoybjD77w04Kx
	XELE3Hq0iOMwvuXaGEZcu+MJfy00WLru0eEXmO3JNg7CJlxrRlWdFFBTXpoH6OeFgn8EFbi2Gvi
	zBO3dIAc5kuPeXg0qSo/WHaT46v+h/BAB
X-Received: by 2002:a17:90b:4e8d:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-3966d400334mr1832598a91.1.1787681006063;
        Tue, 25 Aug 2026 11:03:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8d:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-3966d400334mr1832233a91.1.1787681004826;
        Tue, 25 Aug 2026 11:03:24 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.110.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm914906c88.6.2026.08.25.11.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 11:03:24 -0700 (PDT)
Message-ID: <29b5226a-d403-4bdd-a114-eeb2fd341ea0@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:33:12 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <8af7a34a-da4f-492f-a51c-cc420edc5e6e@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <8af7a34a-da4f-492f-a51c-cc420edc5e6e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4hqIdD4Ho79qatd35LobGvH3pF9j6f_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE1MyBTYWx0ZWRfX8wFFRqkJiu/H
 bXfyyNCc1Swgq4YdobibYcqZoVR4xXjYMXUzNes6ZT2u7I8Hub5fM4iO9MnSNZfHnphlJG5ktkX
 romshZBNGhasEXqhiYk3YgXNk35wJYstS9CyLC5xf/dXy9Yqt2S4Rg/JcyvOGFfSosOwQkUgJla
 LWBWCqkt+hRx1GQRbqH8tc8Duwsdiz1U3OZvz/+97o+23zESNjOxBrYgNXmvmGhy5Lw5AGotE5o
 pn6cnWwqJpalPaKpecLzsA5ffOVCoIHMqi0nu87kNBvoofBS4gRa4sJ1oRCJUaREp+jQ90WH+Df
 q8k2OkXAAm9aeRM81njHjOs16cR1qA9JEVOBrJQHsnLGEtV+bxPjaVpvYeB4VF5dDzeQccaGZ1k
 dQE8PJwD/WBpKM0UqE5zber3m28s6sk2VLQj9n7UdbxN6I15adlgxyV7r9QgaZFOsah4Jf/+dgr
 moeUbmkY24W+s1rHAww==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8dd8ee cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=T2iwtsF3Qoe1cvxaLfjbZQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=s8i-5AHMM79FQocxpXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE1MyBTYWx0ZWRfX+d9RSR8Kv/us
 ABj5lLdCCE+kT2quN+kFTayuohRPAEKpNd2HqCcYJsALZjdXkdVqnQtSwQqdo3NSfGTumr9JA4L
 Bg5bSOQmjtemScNVCxiUqvL74ppojFM=
X-Proofpoint-ORIG-GUID: 4hqIdD4Ho79qatd35LobGvH3pF9j6f_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250153

Hi Mukesh

On 24-08-2026 19:11, Mukesh Savaliya wrote:
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
>> On the SA8255P platform there is no Linux clock handler for the SE 
>> source
>> clock; resources are instead managed by firmware via a genpd performance
>> domain. The I2C driver therefore relies on geni_se_set_rate() to 
>> apply the
>> fixed 19.2 MHz source clock frequency expected by the SCL divider and
>
> somewhere it's 32 MHz also and this may change too ?
19.2 MHz is just the frequency currently requested by the I2C driver.

Other frequencies such as 32 MHz are also supported and may change in 
the future.
>
>> counter values programmed by qcom_geni_i2c_conf().
>>
>> Call geni_se_set_rate() directly from qcom_geni_i2c_conf() so the
>> configured frequency is applied to the correct device (the perf domain
>> device on the firmware-managed path, or se->dev otherwise) without 
>> the I2C
>> driver needing to know which resources_init() variant is in use.
>>
>> Drop the now-unused set_rate field from struct geni_i2c_desc, the
>> geni_se_set_perf_opp() usage on the SA8255P variant, and the unused freq
>> parameter from qcom_geni_i2c_conf().
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index a23554d101fd..4561e2d235d5 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -213,11 +213,11 @@ static int geni_i2c_clk_map_idx(struct 
>> geni_i2c_dev *gi2c)
>>       return -EINVAL;
>>   }
>>   -static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>> +static int qcom_geni_i2c_conf(struct geni_se *se)
>>   {
>>       struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>>       const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>> -    u32 val;
>> +    u32 val, ret;
>>         writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
>>   @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se 
>> *se, unsigned long freq)
>>                    itr->clk_div, itr->t_high_cnt,
>>                    itr->t_low_cnt, itr->t_cycle_cnt);
>>   +    ret = geni_se_set_rate(&gi2c->se, 19200000);
>
> hard code ?
Good point. The 19.2 MHz value is not intended to be a permanent 
limitation.
This matches the frequency currently used by the I2C driver and 
therefore preserves
the existing behavior. If support for higher source clock frequencies 
(e.g. 32 MHz or others)
is added in the future, the requested OPP/performance state will need to 
be updated accordingly.
> May work currently, but if higher frequency support added, source may 
> change.
>
> Also you have added in commit message, but add a comment also here.
>
>> +    if (ret)
>> +        return ret;
>> +
>>       return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, 
>> GENI_DEFAULT_BW,
>>                     Bps_to_icc(gi2c->clk_freq_out));
>>   }
>
> [...]
>
