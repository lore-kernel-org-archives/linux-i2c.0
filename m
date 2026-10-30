Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369134;
	b=FfoIlkk/CpSpvH6ghFPbQH6xwl3EHk+H0kokv505+JJIO/v6/dOxHnD6t9bB3ZCZxaZu
	 wOPHKeG5LHAgqHRtiI6IAk5zWDyz2aqgRLUSZhVic0Z3a+XP6IeTrf6IYqOb/AyoSl+2P
	 zAVmSmUYGv2y4J7UaieBhzpHiCB34ayO6QK+MY1G7wGRSdM5F13HfC5rqi9r7tfWUAu+Z
	 ffrV2eQgbQVh1/bbavsW884aUkVeUwIcAvDVU+YqlAu2T7rrWdJ/48wVDEZk8IpA0miz+
	 nphW8VbK8DnBCHVKZcPTR6YvRr0vEDV5JuBJfzQLPwbWdHo8tCv+utmqnrer5ep45/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369134;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rbV34oi9cJeVMXAr54dz5VJbd/j+Zn5ocM7OggS00LE=;
	b=tLSmTFBWVeYGeNPsI9qmyUh+uLTfMsaOAMv6LyPhemDwGEMY8dMkTJGwWHcN1/AaCoFt
	 QK01EfS6t94HP0QKPMll7pKyHLybSpSpRaYaAFfxIUvfYN3qSifTbEsdUw2cP6JYfD4iQ
	 oRYzeImIZHJp32pP2bfbAggaHcINXdxd46JO9Oh7ndmoiDjhc5YonBWBFpY4+Yi5pk8WU
	 KV5mGOMPdrvLlnRrx6oWeVgtPlTrmYmre6YYz7aw7iynd/W10K8MQNN/g2oHbS/nRU9qq
	 JcSn9LCHuecfl+zLhqeQ+yVSL8oDEW3hfuDBkf3YL2nckEC9vMHBJMZFeTm/OIg+l8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="I/B4aZSU";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxBmYtt+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB8606A325
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ACB8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I/B4aZSU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxBmYtt+
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDn7r92409212
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rbV34oi9cJeVMXAr54dz5VJbd/j+Zn5ocM7OggS00LE=; b=I/B4aZSUbex+VvzH
	UGsrZ/7W+JVAfwK8lQqdrmfv4UkM2BuKAZKFE9Sm/HVI9Hi+D9fmMoJtXnah+iIY
	Up3vBSjW7ogvrz+TMhbMZNVxup2cRbceEQxdkP2GRUCjfrD44Ewx07Q/9HC5YjV1
	0iQfqKLuNrj/ec4SQoiTraQWtUci4WUAyybJqwQDm9p7B+4tXXdKfG7tIJ8qt38k
	Ht5gd5X5tsTeuRaO+vcZpAYUOnecBG2VaFwK9QVyO4nfKIQY68/Os+vGiAOfbeGR
	cy4zyS4CAwiQtVoM9a9kMOWKHqoB1jMGpIdJ4ZOjf0NytbiJJn8XaO53ZochKWiZ
	dQ4zgg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3e47-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 14:05:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb061cc4dbso568555a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793369132; x=1793973932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbV34oi9cJeVMXAr54dz5VJbd/j+Zn5ocM7OggS00LE=;
        b=CxBmYtt+9JA0tzgdpQiWRIKtMLBNeL3HAJkpgs3vC7+W6ggITG6S76iMjbui451+oA
         2cN303WLhFG3hkUfplHFrw8XtE0VFOAEPa0wIJRe7eC2DFt2n+jSbrTZntfyE5Ewg6mi
         tmnuOtqouxtHbuxIJnnn2NFhN4hGRS9v8DZIVPZQr4cGII0aJhfNQDci8Z/KeH8FDUk5
         UigkvEewJf/wyDf19FJVQKiIo+79gdUqePWlGxuc3uBu+1iGfUaB7B1l07eWbl7rShvh
         VyAoxTOvndI4aNvihI6vi62yMCcXTvdSffGGuTS+XG9FPVWGobi5XrvobpryFNN5W/WF
         D1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369132; x=1793973932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbV34oi9cJeVMXAr54dz5VJbd/j+Zn5ocM7OggS00LE=;
        b=hUWLbA8YDTMe5J6VRtOiB271ve28MPMrTghG4ZNh5wVzrYAhNXVxEFEfzfx9L5ewZX
         sGTiyBng1FSaufsE3U1dzKxMWx8QGBFusgpqIkMuHXCZg6GRAlN3szfq8cUNHjWHjHfM
         HGeuxoQc87iMoWgQj4rrzszQYtPRnobQ6hL6m6iD/Fr2r8AHiZBvEZCgm+Z1/ELQyMng
         LcEkX6dC5vWoRKBYXstHGbO/f/trKDrVq+8h4dKLgDsnsJY9XKoIli79eGOUqvi/DBiP
         tQtOZk+4mDpCgNsPtugru5NB6n6YBtYw6wggvNFbXSLpyTzUn3tAPmCyZ/FsJl9thxe/
         h6Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxyy9QW9a+AD8MVHQxD111qOeo41h78fBfMDkL4LuR4u3DAtnWHnb117F96fqhyBkbR0jN0tJeZUIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkoipkF7IRf4QYWyIArlwWFCidhN39C44yrx/aVTzcaViq28JC
	zJK8T9oB15Lf1HJju5fonB4bzNGvv4RBnTXMG+ofFmH8wkwR3WAET98re8ORxoMmaa/ZrbAFfuN
	s0l3Yn/FXrEOFGL+pftdplw1kgL1d7VOtU31jG7WBApeNs3cik4XGckGdaKJ26rE=
X-Gm-Gg: AYBFou1gRwVktztS5jSKbTktohLYg4yTQL9cHnLn5OUjPhH/mQBa9dhAf7vHl7bdl6B
	Eq4ifERUkSn188TtffrrrxxrY2uHSdS7qB8TJ1LB3AxVesBRYhMuQ2Q+m2u+fdmCDbgr/YAc/bW
	b6NYeVOsuezuYFcIqBn7t9UONaJBaZFwK8S4uyI1DC0B0pODblrEA6A+GGwYf/rcgVyr9PD1Nla
	67gr2j9kflHjVssieoet2m2RkoA7oCDdezHm5gFNWt+cWG8Sccfu3Ndqw7cxCnaP5nysEaPMnj7
	5RMlHZ47YGvCa073woy0Bft0qOpFor9je181FiwUtbBAzOjcJW8BNKMZxc6Nhr7KzeQzoqtkqTR
	FJAEtg1ymIZ+nAfe0kVzFgHsWdJ9ooUBpC/lLRsfk2IuqMHwIVa5gG4kvhaHIrJUlHZZT5FjTX7
	rywwmk4s+75RRPPSDe9PsubrMrhIrMtCfTMEad
X-Received: by 2002:a17:90a:dfc7:b0:3ac:6e91:3f1f with SMTP id 98e67ed59e1d1-3ae6f00cccemr3780122a91.37.1793369131959;
        Fri, 30 Oct 2026 07:05:31 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc7:b0:3ac:6e91:3f1f with SMTP id 98e67ed59e1d1-3ae6f00cccemr3780080a91.37.1793369131298;
        Fri, 30 Oct 2026 07:05:31 -0700 (PDT)
Received: from [192.168.1.6] ([117.143.160.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096fbfa9sm739707a12.17.2026.10.30.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 07:05:28 -0700 (PDT)
Message-ID: <10c00e3b-bdbc-447b-b8e5-23642faaa4d2@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:05:18 +0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] dt-bindings: media: Add CAMSS device for Hawi and
 Maili
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <20261030-hawi-maili-camss-v3-3-9742bca8cef2@oss.qualcomm.com>
 <CAFEp6-2vN5UEbSwDH91eUzP_w7DHd3WtuLnui-_k7az2oQnoHw@mail.gmail.com>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2vN5UEbSwDH91eUzP_w7DHd3WtuLnui-_k7az2oQnoHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX97IEUt9/eSd8
 lP7P6zp0++QTpSLr4KIc7kVLxqpzqkwhDKKaE2PMWUo/TkBBp0luWzwnw/vRL8G4uGzB+YEIlmV
 OQBQKYuSG2vjOO9vWNHUqeD1cx6XML08vBktSW3AYGbtnvikOy/cK/5kYpTOpbE/7Q/JRWbXHcH
 hGPv5k8l16rL/DcBlxx1OzyEtN9fjNoSmZwbHAoRikWus9wOc9JPunJFXXf1lg9MkcnhPLaMg9h
 NcjWLSZaRhy4KPdRvdofD/nEL2RzJPhLdfOBUenwHOpFpGy54Johv5GHyXxkmrWW93C2A5mXZxG
 uoNy6pHHS77kUUQIKQfGjT4AQ5iBZoVCGqnNn046JMwaAqE1bP3eD96jizSYKg2S62bcUz4MfcV
 OpvbwBBpxEDwWgCumqOUwz9hE6iGfwtxpQuauZo80EPbau7jfHyTdQS1yxTqE1Je8GEBhQe5PGb
 tksyJJWLycd+RccBV5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX8Y65ybL04zKV
 +z5OW7FjX4h/30f2zu53bd9dyXjN7E/yv8k5zrvqhuUkWLDx4s6cwfOlpwSpdHfyMv7ofITDFdt
 xFHEtOGAb/vInVwlfDnHBwS0+1XmPEk=
X-Proofpoint-ORIG-GUID: 9L29vRCjc-LauSrHzkzDYDTDlgcoWpNF
X-Proofpoint-GUID: 9L29vRCjc-LauSrHzkzDYDTDlgcoWpNF
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4a42d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6d0oVIyUxUng7TJeo7N4IA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tb7J9fPpy6OZh8FWujQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300056

On 10/30/2026 9:38 PM, Loic Poulain wrote:
> On Fri, Oct 30, 2026 at 1:43 PM Nihal Kumar Gupta
> <nihal.gupta@oss.qualcomm.com> wrote:
>>
>> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>
>> Add bindings for Camera Subsystem (CAMSS) on the Qualcomm Hawi platform.
>>
>> The Hawi platform provides:
>> - 6 x CSIPHY (CSI Physical Layer)
>> - 3 x TPG (Test Pattern Generator)
>> - 3 x CSID (CSI Decoder)
>> - 2 x CSID Lite
>> - 3 x VFE (Video Front End), 5 RDI per VFE
>> - 2 x VFE Lite, 4 RDI per VFE Lite
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

[...]

>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
>> +    #include <dt-bindings/clock/qcom,hawi-camcc.h>
>> +    #include <dt-bindings/interconnect/qcom,icc.h>
>> +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        isp@9253000 {
> 
> Address should match your first reg addr.
> 

Ack, thanks. Missed updating the binding accordingly. Will fix it in the 
next revision.

---
Best Regards,
Hangxiang
