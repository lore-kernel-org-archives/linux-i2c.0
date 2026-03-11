Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E631E836
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236078; cv=none; b=g2TcCTg5yXL6L+4BpX4IHYn/97WymgBeAZpssn8r8crwNpfBwmyLzoAovJi1cpNyiqcB5ZTmhz/WLIVHb+QxDI2wv9OnAl4jIxpVVZ5rVtgK7lE0xhceEjbNxH7FB1meBdnG01qY/MkD4AK6HztP+SX5kVXmYZ+xsDDl9/yFGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236078; c=relaxed/simple;
	bh=Eyb/s027S3nbHlmPYwW2DtYUUB5vt5wFvTp5hMvzCDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRgU+ibKIguSS0ucu6N7c/WZ21QxqX0sLnxRTUdSre79NyJIC1y7z9O3fNNRhthcXNGDCxoUydwyr2Df2z7QbVPfdJAybCdPGoDgf7vkyadZrd9GLYe91xo/tc5RMYfQC6ectzi3q3UjZCx1W7Fw/gtr654200Vn9wTDX1ocxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jD522WYN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibCn+rHD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jD522WYN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibCn+rHD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBoGn11439645
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cro7d2Qc55Y99x54Bc3qfwkwfUoRDVh/RrC5sik6Wk=; b=jD522WYN5VWkBukn
	ks5I1szzaA70zktpN10PKqW9W2pqnelX40TZArGAqlFGNb+2/4ajHonvSfjcHqu4
	rIYz28mEeVTl2IBxYfgRUJn0yF3l3ZSbCWOq/frFpXlQoMECN3ZVtWc2/ne2njyi
	8JNu/Q/g4G4N9vM8notqpQuCC6aIIcWhMgbUlGg7+FjtHM7J14F2Ki/a3EUwhY6U
	czlMNGg+ay+/T57PhGiyV9dTgpHhfIQ8/O+vdNjgUCnGCadYzMiQ5MvGg53msH6/
	NCn5cWzMpwiceBPL+me40sjekUC0vAq33odhbng9uS+SldrwTUyKlKAfyeHYbgn5
	bHhw1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu38yhgkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:34:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090189696dso28124161cf.0
        for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773236075; x=1773840875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cro7d2Qc55Y99x54Bc3qfwkwfUoRDVh/RrC5sik6Wk=;
        b=ibCn+rHDn1NwDbgLG62f5TZ+elICBzV398lxv8VREnVxXUx/V6BhZDygYbr7iFuQjl
         ynloWKUSb6QZ9eOEBMBwHwkon60y2kXacZ/Aqm+LKKF+o5chctRDKpZAnLH3gsuJGALI
         1m8gpGkWl42ueWtQfjyCsqgeR62ClajzBIFilKWo97l7yXqbaH+rISJah/xKYwLXvsh/
         dfj+D6U03HwklGMc0vcpFfJVkUyhmaO9l7CXVarCjOV0KS4SiQitJakSqT0Oe7FWd8ep
         Goqoh3hTcRXoF0CypYO3UXRwXjahJhq1kN8/e6ioYK/HhnfVsxA3B5V0SETXqMLVvduA
         6u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236075; x=1773840875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cro7d2Qc55Y99x54Bc3qfwkwfUoRDVh/RrC5sik6Wk=;
        b=dzUcjGRiJZ6uEsBk+Kw39m8r3SWNqUz04F2kH1pEnptmc9UW0wj6awU4aNS2pVYCZc
         Dz4A3RzoZYArtsewjzghiEJIKTP4pHm62fIsxh660+1uWi8GtpAYQ1CHxKcVhQPyInLe
         4cLFicoL0bz+T0gNy2uB9iXUlpL82J8d4Raby4YLp3jzi2gG8GwIlA3M1I+S69o8rAWw
         MFQL0zlRrBTAE/H6iatI18l3kcqshlhkCjTxXs0Rn7uPgBQ9wh1pEgTRzjVJVblgq0Fq
         I3zKwwzWg1awVNdq6olS/de2NzfqaE3ZPj0h0mlbkhSQm8cS+854z46tkOxXqxxl3sRr
         aJEw==
X-Forwarded-Encrypted: i=1; AJvYcCUBCJvx5k6mjrocNMyGuoOVSMqvaSMqHmE7k+TrrFl0cxAR4wdTcoWZk9RisLIQi7yS5T6yP2d7zsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIaZe42O2nYvs3csaF2zEcyDoGf5SkIDR+74+p1SBzCuIIsf3S
	ucQI8w3Xr5onepF2dbULRTRJd+D/OhD/lZo3ABU7HQHGI/l7MUO0ILUOh0L6THMq+fnh+np3c+A
	Hk5zyPhol6BZhy8xYGKM+Hlj4sudIGYc5H0jh8foToCnzfGV9b1aNyRfZCUrU9PQ=
X-Gm-Gg: ATEYQzydmOEnqgP9GZoQLJzbfpl73vIlqs58ctckFfJb0h70XlUJCFzQUxEXf0xbKg0
	JITR4S1OtIMXcu480IL7kZuaE84Jhfy9D+Bx1A2ja5Yl9ZnMsZjYN/XLJYRgQ3nYZqLa74ErW33
	XTFJ2vUuNF6FdyK89DI6yPN2ur+n3Cx3rkw1xiqC9ee/t6zRJO4vAyswZpPMzlp5+jNudlG6Xw0
	3IwcQVSdCghYB7ED5VZZigUpY23K1WjySxxTTq6WZFEzX7gMKB3Du2PdyVE8IOTFn53Oe99U5Xx
	7WGh/GHfQzEFy/OaW1X1tVrgPcuIbEzjA9vbZWJk4O98dfj49pi9q+zCU3tOiubB9G7K1yuNwsk
	p2Te8WupYCUaurd1kCfRdVbRqbkAI1L2VDwjgrSw0VKUo6YxlD2SSjakvVzDjPSj5aWSBZD127A
	52xIg=
X-Received: by 2002:a05:620a:29c6:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cda1a120f3mr232199485a.6.1773236074958;
        Wed, 11 Mar 2026 06:34:34 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cda1a120f3mr232194785a.6.1773236074499;
        Wed, 11 Mar 2026 06:34:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972db9fce0sm56501966b.0.2026.03.11.06.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:34:33 -0700 (PDT)
Message-ID: <8d585d53-ab3a-4302-b0dc-8a9f21690cee@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:34:30 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <20260227061544.1785978-6-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227061544.1785978-6-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX4iqxP7Vc4owm
 /YhzvesJ8RzhpCIzKsEpyl4ptAC4n6wqHSWePeB62Vk95DXxWAXzOmTMXSkWNu0/5R0jv/38Fp0
 k6SM+og2aQeBTGCEhE2BZ1/+aH0d9VG+7g6INyn6qB4yup+z+hv6jqRXxdCZZ7H+p5hRQJ8V5cs
 shYWUQ9L/Jtt0BsXYTuLN/t26ezj+32/k+emHKMSvv5OKV1uYaj6qSarm6MKUjHXXaZdK0M/sCi
 Em1Z2LK/L1w38vdIUUpPtdBzQHH9RKGkhskTyXF9JBaEKUaqDzMqUxN5n5yhpMH8D67Rc4QCTP5
 5CPHSCTP2HRTCqWLTiLONvts9iS0ZT+ujtV/63ZR+HEPcIh8HQRr0Txbk+tSac7xGTOs3zGPk6M
 em/2CpVWhu6xD8ZtAt7xDKnsjFBY0AC8WKU1wuZm1hfTUmzKYoCtn0fan6FOyeSwkxD0h2Ja/Pz
 Y6CDTDYzkgAJ05nHfLA==
X-Proofpoint-GUID: XC8A5rSIu00_hgTCAGg17YRmQCTt_rIA
X-Proofpoint-ORIG-GUID: XC8A5rSIu00_hgTCAGg17YRmQCTt_rIA
X-Authority-Analysis: v=2.4 cv=Cq+ys34D c=1 sm=1 tr=0 ts=69b16f6b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=W3I9JGv7J1k6QNzkgEYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114

On 2/27/26 7:15 AM, Praveen Talari wrote:
> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
> activation/deactivation sequences independently, leading to code
> duplication.
> 
> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
> power on/off resources.The activate function enables ICC, clocks, and TLMM
> whereas the deactivate function disables resources in reverse order
> including OPP rate reset, clocks, ICC and TLMM.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
