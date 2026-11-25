Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608131;
	b=Pogv8yIwkTKI+D+uXM6s2pknE0gykdZvJvi/g5yz3CzxARDSYuyyOqqhJayxkvHvTZ5M
	 9A4TyhHMCxqa2EDuTe8hEIRfI8tZt1CpKDDHpBlVAD4x4lWQZoI2jNn/prbSA214/zRAj
	 19ZfwYmzxiZK3lf7hwJMSKM5qd6nlxWd/QGXAMpMMlRJr8u9jJPeB03U4xLv0ViszJrJD
	 YvEVWB3/WvA30Gcwv28ayMAoq9uLqe39oFLkBKgmrb2p3Np34QDEq7rHSjch/Apm4/VZM
	 d6dF+vCn/hIc0KEX/YCIrXl0rDZYKfIhgvRDJOSm5Od9iSKu/DkeLm9UrO+xHmD0kEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i3jYSnSdn2u/GLu3Pa6dvx+oEPdp+Zst7Dskdp50SrE=;
	b=Jvy8O6xigYv48pqE1OeOyZgfwF8ir4Bzy7uYGBxW7g4KiSxIxr7Yjey0TL6eXQmRyyf/
	 GpH1u4fonN0rfg8PZAnafp9ZAOXRfJJASbYwhBxASeAekogTTuPP6F0jSlKWikV1+XaBy
	 h+lGjEHbV6E7xTkuUB5SM1jaC2p1/kp+Y2yF/fPG7BLl1jRQrddG2tmV1OEzvreSZ9OGd
	 yL6ISm4W67kgOmn7M4xxrsHDXusOQ3ZyhVJ5cZx6Cj5UguLJBhLkXHbwhZhMh2PeMRXFV
	 cGFSsV1oPEF1v8oKqCVzV6tUSYxpWKquj4d9U715xHqvATcFtcGGYks/YgyWXTg1nTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWZlc+cD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XbHjhbtL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67A606A329
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE67A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWZlc+cD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XbHjhbtL
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mQvP2121282
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i3jYSnSdn2u/GLu3Pa6dvx+oEPdp+Zst7Dskdp50SrE=; b=FWZlc+cDremacKft
	cqyuED4wIryfBVbpSPhjMFZ/b68Mrl3eIGreRGL6BWues1c67G/LjonhsTQi9Ojj
	pv1NENGBoJtxsViOjN6OWXfWH6BlHdzIQGTNmfyFu3xVhHUvYODgvFCfClQBwXV4
	+MKg2zUFO5uPTyydfqBixUp6WoluO9SjBG/r2feDeL/JV6+NNXF/BL7hL2eqPI19
	Wgs2v8cyhsnyzNJujss6cHH72c97N/bcIYIeCdYqxW6h9nvCLqPyb0ewOA8HskSB
	CfNAfEvJwLihiHbxVQMfuZ/Q2pGI8VvLc3/RF8BIvoM1BMGWnpnMBqSfVMVvRHDn
	IjQNww==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vukrq5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 12:02:09 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c97957d83bso243563e0c.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795608129; x=1796212929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i3jYSnSdn2u/GLu3Pa6dvx+oEPdp+Zst7Dskdp50SrE=;
        b=XbHjhbtLJfJMCNTHQAZt3L5oqLHkmdq1b1dA+4GB9ujriHR8MzSDoHRlN0LnWTj9NZ
         BaukfZrnQ6d2Ixi6KqVboCJSMYD8LOp1TWFLmU2I2qZ2AVgGJOE4A7jHM5NB2oaj1owA
         FcrzrXyDxX9sga1/+9I0o5B0+nG93tnpnznZAYZ6zAE8CI2C03/aFwTL+K2Ya6GFLwr/
         M5rAu+D4sNsr863b4glNaoj0cN6i10rp5dxWn0QYB1ciL/9ydfUiKxdlCxgqCjtZuG3d
         jmZfeok/HKLSImfqy9ZnmbKhQrbVk1a3bFyG9M0d5tXRvz8O3VyFbxpTtQUNThp9PCxv
         uT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608129; x=1796212929;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3jYSnSdn2u/GLu3Pa6dvx+oEPdp+Zst7Dskdp50SrE=;
        b=C+mG3z4+NKtr0C+fhhUnF9tZw6IFZmNKi5eR6CSE/4VFmUf6GmpUL7WNHEWXAWiiRf
         819oGzwRnah4j/kr9DB8QkcAwX+n/EmG0bo2VENuYiJQeCxLcEboF4gQ7JAbuVq0XHFN
         5fotWP0VFaPdVX7OyRW0CU+EIPSM7fhaSGdETWY9bCm7lvPsgC3myE/Me/w/ENfTw+KA
         zupw2DrZo6li5EwOmF7v9VbuRgeED4kSHfxo76QXhJ75zcp/f9DA8MUKdYESroXdzYCn
         HQpW+4+wKZSSENS0NPdGyF8GyuqdIvaXOlYhT30AObhvG3hXBrjNXBC3R8xrJu8dlVcD
         WgqQ==
X-Forwarded-Encrypted: i=1; AL+hErEdUtgdVgRG3MvvIucAqn1Q965titJurz9CkxrIjeVpUUM1nwSLYLRRfzRyqWYkP29mEnifD6LboPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tImz3QGsvADDKpS+eL8jO4atb+BjQ6UwFrMWBeDvdlgQArZfW
	DCPjLNanFvIFwamHeJcfsI5NkzOk7k2aHoHzzGZ6WzDF7gI8haZHuH9zLmUsZ0/WznX5cmszpNO
	41WDYm4cwUm6krcIGs52zBbKHU4gCByG5DPpkMfOTn5JaiEE8rLsCZGTZ/lleyQI=
X-Gm-Gg: AZFdTZfbrKWk7kyy7hAzn4QEjYk6NPgr/PUy4MHfSQwu+F/JyBpiyv7FO9kftdOdz9E
	Nf98LuMIMMDMjPFtE7OfJVT98s4kZdtB6lV178hwiAAyb8L/7aaA1/pKK7UeEwr73JZyLzqh1Zs
	54m5ibDGnyiqlTDyjxmk9DOTHYiUK27XweFnKvZF9MwbXRdxTkPOB1rdrbs4xmHX4TPNTN9VrJO
	/I/hibIg9yNoySSYc2S2RTwYA6Uk/efEbaiDVlj/Qc0iY/irogzc5SPB394pj7H77w+fw4tWGxq
	cLRBIIctFbumLfjRFygTTu9xJpEJZ5zby481guBwXrjiSb51wRbxM+Dz7o03xZpAnCyNhqtCK/E
	/Gbr7Wmq15hlIvO/WmyVUog7MMISubAOFNSCT+UiBeGuzKyXGdBDAFgNBqWAD9mJNUaybJSE=
X-Received: by 2002:ac5:c00a:0:20b0:5cf:ad27:3a67 with SMTP id 71dfb90a1353d-5ee8af8d7bfmr11581605e0c.5.1795608127979;
        Wed, 25 Nov 2026 04:02:07 -0800 (PST)
X-Received: by 2002:ac5:c00a:0:20b0:5cf:ad27:3a67 with SMTP id 71dfb90a1353d-5ee8af8d7bfmr11581553e0c.5.1795608127342;
        Wed, 25 Nov 2026 04:02:07 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acff65bsm648949266b.4.2026.11.25.04.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:02:06 -0800 (PST)
Message-ID: <e1b4fff2-d7f2-4647-bacc-df55343031ea@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 13:02:02 +0100
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
Subject: Re: [PATCH v5 3/3] phy: qcom-mipi-csi2: Add Hawi support
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
References: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
 <20261125-hawi-maili-camss-v5-3-1483b7f68dce@oss.qualcomm.com>
 <15cde6af-0b9f-4a0f-9d21-4e5ca9107a67@oss.qualcomm.com>
 <e93eee16-df8d-4d49-ae56-3e6ba9c31167@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e93eee16-df8d-4d49-ae56-3e6ba9c31167@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06ce41 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=yOYrsbgnHfbpD3x4ck8A:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: HbLJI2yum5f9fQGACDz2I9M4xg7l_kL8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX/hkrSldGIrVS
 UNIDkCIvi758tMiJ4F2IxaEYBrTqC3o4a17m2WASKIiwVsVD0mGmr0NDM99VJ1C9Vdt6uZsjP5x
 vU7iP+W7IQE5ZsPGvsoZEnTH4kE+q/8=
X-Proofpoint-GUID: HbLJI2yum5f9fQGACDz2I9M4xg7l_kL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NyBTYWx0ZWRfX01NywAOuRd7G
 Ph4rw9l8d+BBGdxziDJmQTkouyWW7nYxdw9AfMeH0PdWuvF/ygKa3qWHCu31RMEWhJe8Ts5PlgF
 a39nVkO/cVJ1fLXnW1g/ljrGpubQatK4rscazwnl5jssItt0n8y1HjtYH9SN6qGWfEHHIXIMhoM
 O8v80+qV9ybZRQP/QX+FrUx6Puk8dHuwzeMbtScYtGckmcXpDFWvMxEhlXUmCuGYQRHwZkLkRit
 tJjoggJKJhFVaJGizefB5FBMkyfHBRg1o/1AEPQrsPQW2ndNe4swx8tfuhyHfFVHMT4DT/riBpI
 M72ugmMWgWJ4Xyflvq3U6QKKO6iyih5FflEYE5fCDVuX4VyvjUj1VSW4V85KVaOmHV5dhPOmVh6
 nDd2uDDn7KAZ1/ffwXKyd5f8AHB0WNwBOQa5SXigJb9JKeYK/+pnhoumjYoQgsR5Pkcai/7gaXF
 znZ8w8dRijkv9YmFqYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250047

On 11/25/26 1:00 PM, Nihal Kumar Gupta wrote:
> Hi Konrad,
> 
> On 25-11-2026 16:23, Konrad Dybcio wrote:
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>>> index ed40934d67eaeba0c6ac7ac75324ac6292fe7d9e..5d91303e0df2e8c5bca3ea8fa2bb831429a8f1ff 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
>>> @@ -162,6 +162,126 @@ mipi_csi2phy_lane_regs lane_regs_x1e80100[] = {
>>>  	{.reg_addr = 0x0c64, .reg_data = 0x7f, .param_type = CSIPHY_SKEW_CAL},
>>>  };
>>>  
>>> +/* 2nm 2PH 2p5Gbps 4 lane DPHY mode, Kaanapali table with data-lane CTRL0 0x8c */
>> nit: 2ph and DPHY are synonymous, if you rename the struct to something
>> like lane_regs_hawi_dphy, we no longer need this comment.
> ACK
> 
>>
>> As for the override, if its meaning is well-known (the difference is bit1
>> being set or not), we can add some sort of a booelan override instead of
>> duplicating the table, maybe
> This is not a boolean difference. Bit 7 enables PGM delay in both
> values. The difference is the programmed delay value:
> X1E uses 0x0e, Hawi uses 0x0c.
> 
> Since this may vary with other PHY tuning values, I would keep the
> SoC-specific table.

OK that works 

Konrad
