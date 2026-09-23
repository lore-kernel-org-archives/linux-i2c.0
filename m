Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322404A21
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141487; cv=none; b=K26Pnng9+H0XAB8uaZpBFnH1rlcJ1L3CXXtuVBJ+tZhcr7lElMHc0fZbtQVs4OMxCMLMZ7wbF0KBj+FTI8RRTcnUWdx7qvTg6s0DoIwjCAcwDlg1RCeJa9nLZFnXAC+U1uSiYdauBbC27j0kebwQNA9kC3NXEXzVjZV8qoFAEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141487; c=relaxed/simple;
	bh=qyxPaT9VL3iggKLsNgzLafbVD6NN2QNY/OEteKHN5kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM3iCsmJ/QuHp5DjxQXQhfiL4nqxXMCuZx0BWNCMKe38URfV7Zv4r7lUEFSzZyclgoZHsG4A6mWaIA1oBzyNNk6xjelKZZ9IL+j1RJWVsxSrQ+xK9fpMisM2rWXWU9f71r1zBt9159IsF58tXHxREYwluXHG2u65ZqF9bOKrMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwjJS6Lf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZNKs1vg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwjJS6Lf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZNKs1vg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iSCe2728454
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 05:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+LrvhrC2M28wUTYTFfBdvCnZV3wVCma94KrYLJhrE84=; b=GwjJS6LfpkFyGPv1
	cSMlzIOb4VZ1n19tY7T4XzY3OS5H3Nqz8tMyJ7nPKQbWcm4FC2c5ayEI/IKRBHm5
	uOGy6XlObK699LQ0l1HXIPRNkflWkZ1u1IFKgtrGBaR4YZYPQDIGggTujWsjwMrZ
	Fxz2NEl61W0/KXGIudcft6cqJnfrjBQQyEfW2Rb+txcHkDU9yIxXuH+d/sYtXOZi
	kWh1qBGLItWRDxZzk8QPXAnKmlNqs77F7nWyiGs1/2qBBJ4CKhQ//pJP9pRudYw1
	LRxaKmCY6gc/gG0/K3kiT/gIwGJcZkp25t4pb9FqKoCpdMQ8QjMy3h2AU+DdBs8S
	645ong==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux7xtnmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 05:31:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30f1b904861so705758eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790141479; x=1790746279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LrvhrC2M28wUTYTFfBdvCnZV3wVCma94KrYLJhrE84=;
        b=hZNKs1vgaTvHP0Upg1lvQ3/MUskyT+XYVCtgFogkZEMyg9T39ukgoDew4EMx0hD46t
         17feKl7m63L4hgHNd3UFwEv7ZRHuBxGL5VTCYl2HOo/ZnU3NPdZdnhe1clLMirvT6TZZ
         Jtx/+214ZYVx8uyK50InHYDlODSLK910n3UOzOb9c57sbQLtQOWVx+wZbmfLMed2h89C
         ptNMSY54R4ExZUHS19gnjxeAr7tyJc6lNITx7yHbl6bxmFz2LrBT+eR8+X5QWs5gPhTQ
         ej+MDpvxnN3ayJLPMv4g4Off2RVRgO57LRKtw5oVSvZOJiszMJSevJIG87tkLEHYaPNl
         ilAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790141479; x=1790746279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LrvhrC2M28wUTYTFfBdvCnZV3wVCma94KrYLJhrE84=;
        b=tqWl14rH2op+yNeguO/FNayUwQChJtSXW19ojaj2hywhDZxn+t1xYXUaZy8gMfHbdK
         ESQmN+uU1OA65oo5QfYUWyW+1bOb5agLj78KvbKTjg+s/uX7oI0mqPpFrLnH9iNF5Zqg
         tGqSbiEKRUkM4VjWb6eYzFczhk9DjdccbSFj/fKxQXHvyUWFkNz1S0McNHJ3yskrtmL6
         j91AdnHBWKJ+++RgSVmAvJ3f9fKY7BroyRfGNG+IROLZ8TRxI1GrpI9IRakG4D0MwCQl
         xPQK37Yet0v8YuXOBIQC7Pq9Tz8MOenlXhBxWTZy6QGfw/lfjBUEf0Llv6oLUw15L7X7
         rJxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBr1zOioNJP+NKLKSY0EwnHsRW2/gwRjzofbg6T5FJwNVCHybmx8mpNoiM74FApmBXPccAPXladPM=@vger.kernel.org
X-Gm-Message-State: AFuF++lxK4HKT4QUHVBWRTvZ7nPGsSoh/ehIXZJadU6WI8dungetSU3M
	7PL8Zi9m7CF3JBciJpJK1no8Vr9Iv6rxumK1JO6BtvE9T2Rw9hxwlKvR0xKf8+jYDa2nwTeprXc
	1PpEn3MKdBnfVJvAeBe2M4gRA0ETBw4upeG6zJENh5EnlEKkk4c9Lz+JBlX2HV3w=
X-Gm-Gg: AYBFou1KG7s/apOBSheVff2vnfWxxnv3LxM9cevcUyrZEMY0BBdOK1NgMePg704tT0a
	ChSIOKZYtGHdjdU1rY8g3rK5nKeVO4ytNTTNKTLuTUDFn66jRIoegQV35pI++5qDCqKsYu4lT3F
	ULWvmCUGB/0Dv0onTu56gGLfBS9H6vF3nLXLWL2UXER19gyai5ZxffwxbQieQgEXO2zn1YgeZyE
	aeJqy+qLZcS12A21TtAI/0YbTG/MvJB5Wd0w2/hVI7WxeKxrJ5oPzns6umvV+Trhf4o9u4gJvIh
	w6YoV3RQ8zSXX0zO0THK4EM47D9GFtP0kb16gOJx2+/ERp1eapSp23fElaLR9CtDaFDPiPjDszL
	cJLyKTcazBwh1UmQeNBYBRonzcbzBYFFrzTZJeYvUUac=
X-Received: by 2002:a05:7300:1c13:b0:33e:6d14:be9e with SMTP id 5a478bee46e88-33e8d2ebdc2mr1499165eec.23.1790141478922;
        Tue, 22 Sep 2026 22:31:18 -0700 (PDT)
X-Received: by 2002:a05:7300:1c13:b0:33e:6d14:be9e with SMTP id 5a478bee46e88-33e8d2ebdc2mr1499134eec.23.1790141478269;
        Tue, 22 Sep 2026 22:31:18 -0700 (PDT)
Received: from [10.217.219.38] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684d643sm7003888eec.18.2026.09.22.22.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 22:31:17 -0700 (PDT)
Message-ID: <2a50b64c-148a-4d44-a2a3-3275982eda60@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:01:11 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com>
 <5fc58faf-dd51-4b7b-a2ce-5acb0ac6bbd6@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <5fc58faf-dd51-4b7b-a2ce-5acb0ac6bbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HVtVHDLFC9DclbBVeA0FVkC_bR9Ghhvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyMSBTYWx0ZWRfX3o+qnz69FdDU
 wQYwUErYib1NRlY596Vu08GkrOV+7SAeTOMIC0uc0Ri/YrtBG3yeJ7hKx/Hv2ta313YkXXVHd+4
 5KY5fH1pZmYZoIjt30qsoFdhDySg+LoI84kDpffjIUxo4D0GqIqHWe5OsfEqERCb6ZIo9NTduQ/
 30Lh+lOSPDTsb8TmnmyMWLS7c4CEERieSfFtoRqariB+F0T+EtxlPA4I9nJrDg/pI51bhEz+soR
 4MBNej+fUO/IzT5N4aw4eJkacxCf42K5D+0kUqURIt87/qbKeudErgRCuinrqt+Orc6+WuxhI9u
 82YJtTwmhjLFWG1AS3JUaxmpyWnGScyfI7mkkrx2xyBhxthguZOGztgyTouNePtI1R+yT7sBwZm
 3jY/Zhi1UBH1/fgFMig1wQ1J+bWg8UubKhkB4T+4bv5lwtYve6/ESTn6IyvGfR4IvFU3s6Sx+Hd
 YaBxGZXum9WYuuGNhwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyMSBTYWx0ZWRfX+a001otAdW9T
 6BYZRZ1AlMqEcjiHOM1iGqVH7JtGarCHea5Pdg+unUu/1sEgLvCAQseHYQhG29UNPuXfiJdA0cf
 s+BbSPWZLFslC8LEyOQihvZiF3dMsjU=
X-Authority-Analysis: v=2.4 cv=QsDLTlyd c=1 sm=1 tr=0 ts=6ab3642c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ngQ2yLvfpiWeLRerOt0A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: HVtVHDLFC9DclbBVeA0FVkC_bR9Ghhvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230021



On 9/21/2026 5:33 PM, Viken Dadhaniya wrote:
> 
> 
> On 9/21/2026 5:17 PM, Viken Dadhaniya wrote:
>> qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
>> selects an index from the hardware clock performance table. This always
>> picks the first table entry regardless of the actual source clock
>> configuration. On platforms where the matching entry is not at index 0,
>> the wrong source clock divider is active and the I2C bus runs at an
>> incorrect frequency.
>>
>> Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
>> performance table index for the source clock (32 MHz or 19.2 MHz). Store
>> the resolved index in a new clk_idx field in geni_i2c_dev and write it
>> to SE_GENI_CLK_SEL instead of the hardcoded 0.
>>
>> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

>> Changes in v2:
>> - Update the comment describing the source-clock frequency requirement
>>    and the rejection of higher-frequency multiples.
>> - Add a blank line before the final return statement, as suggested.
>> - Link to v1: https://patch.msgid.link/20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com
>>
>> --- b4-submit-tracking ---
>> {
>>    "series": {
>>      "revision": 2,
>>      "change-id": "20260807-i2c-fix-se-clk-conf-89f6f92d373a",
>>      "prefixes": [],
>>      "presubject": "",
>>      "history": {
>>        "v1": [
>>          "20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com"
>>        ]
>>      }
>>    }
>> }
> 
> Please ignore the --- b4-submit-tracking --- block; it is internal b4
> metadata accidentally included during the rebase.
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 38 +++++++++++++++++++++++++++++++++-----
>>   1 file changed, 33 insertions(+), 5 deletions(-)
> [...]

