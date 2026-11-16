Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796760;
	b=YNQQbeQZ+rP4pL3rnbXPYTq2hqK5CrSEScOHGg0dMFwmcaklZgPT/7kPnwmkUFUrzsI0
	 fPhqlKzUtO/kjdPXiSEwC8By0itomlN7YRDJMJokRm26OQyvgwXQVEoX/LZmy9vhSPp5f
	 hZj3Y8sz+bZJEiN0gIRL3l/LKob/lXHRKY7ngqzzVyxGECZwZgvpUzGbpcN1nH0o3ecxT
	 /SLQJ2jg0UOOHDPFRakUc60TJR4/Zs9evn8el8Cgvsr6ivXjkIrDkUc5rmlFLrLdsCuqC
	 JBOSW8yg1DP09ZOEUXqUUprMPtaIRBdWz/peVG8SAsNvgP+/vJoJ667lTY155/nm+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F2MkkOjtOBMugVy6AnNn+LItc3X/brWtifolQLWYx2o=;
	b=SX6vbPc7nfenrMzoaUrka+xAlFpArR9cQZCUcYgNbL8t1Rg3uMJoQ6kmQs3+C6gnSNd6
	 imzIaV6FreMb5vKmAmgE7Oi+tsVUgW5YSQ7/8z9a+8xR9HNwKBh7NuUuUvCGig7HKg9KG
	 8fJAsYv+wunW7jop0gYX5C7Mv5/jay96YEzG8jsnuvGOJut3bConATZe5bDZi5a/o+eoE
	 EnjNK7tR1sWABYYB4Yqa2kg+VN6iRye2Kn3g1D3ftprU+M6cHVy7Z4IK5YNn8cPo5D+0N
	 yy5QC/eFoy5Jk6wTNbvroLyXnvFlvaXArhRW1ocA0RJx6ZgnCpY7G1tt5JEkCZN0Ogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YLWKz2pH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HfQpKjhF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE67606A323
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE67606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YLWKz2pH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HfQpKjhF
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG1L7uC3891647
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F2MkkOjtOBMugVy6AnNn+LItc3X/brWtifolQLWYx2o=; b=YLWKz2pH5QwPDe6W
	iem3B/1wBS7jDUWVIf/dQP57tMDzV0ZQ0FsCjVxQ58kQfNzmK8rCic+0V/Wce836
	a3zUO2XBuEJ9Hnboo6n81rpxC3roa+S3lIPhxCWFawqLInL64DU3Yz0qz56uiUiT
	h4nJmPvREgPVTand+c2hVc6lUi+Lz9/jH3F7TjtbXfznaj04D21X21tbAPYNk8Hv
	DJo/n38Vv885v6wAirHw7n5A9pImQz5Eb8QIGScgzEqi/hFEs7BnKCw/Vrqxq7yk
	KweXdaE0rp6tTW8CmeU0GF+BKHGP+o341A0V/UJvSgZu/nFKMiraNjN24L6jP+oo
	Xznwcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqmhn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:39:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94960131b4eso283965885a.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794796758; x=1795401558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F2MkkOjtOBMugVy6AnNn+LItc3X/brWtifolQLWYx2o=;
        b=HfQpKjhFzghzd68+yCTcDiTZPumg2TRs08LAVA26xvRkrcKeQyVHR/w3eI88gRrfxB
         +G8Wt3BMEPzgvITc8Tny2ZE25y6D06Nlqj5nOELHZeM/kj6AFKoYWrHcz/EOxAT8hXXc
         ZgGxwXw5SEwGeIh5w7e/DUexkdpv5jNwZB4A+aXFgu4BHAxzpOwvvzKfYcJktkhTIVKg
         TGzCa5adYW9I+45oc9ScdiL4jTTIqAF7shbErwuz5g6bFcM328Tt+vwwJzyPfDCwM/3S
         BD7IQvF++Q/PqZsJGdDouiwUhCWzbYc0a1WmvKs1+Eq6hZ+xXtaojVj0kbt4c4FXlcft
         LocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796758; x=1795401558;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2MkkOjtOBMugVy6AnNn+LItc3X/brWtifolQLWYx2o=;
        b=vaJED6IX0m9HZ3vqpJqvb8GHL+5j9qNhCsQygzUmoy/Iw2itUAvgiZD5FQp2ihzxmE
         k/zbzxfbMgsvQ0nqsDQYzppu0T0vlyzn1JGgsdGV+7Gx1bSCIY3MP1jZ/OpR9TrpTGlc
         VbQieT1R5DgIGdmSCYxBhNcAv9I9LUrmpMkNh7GdjBlROrVOAU0kYNeESf4nd2RBIlDA
         lykXnLC8LQREBgmuHHxZXyOdm0moUpCs9iiS/bKN+OA3Uj43zRSyEj/9ZmxhNB3uNiwv
         iG3OSdEtx+FSsTNLBXaNFVT/Xb1qG/8SF1CsSXF2drZV4K9IcOVJlODT4ZKSCwwTcITq
         +/rg==
X-Forwarded-Encrypted: i=1; AL+hErFa5YOfF8/VSS9gfZ4tmyuHgu/LrT2ZdV2+j+F1g9UifXqsXB8SwVD55sqJI7YW+XNTGPKKQzpUYSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kcyrzcrx5LB+jkYNtjKrp5oadepkkNSAL/vdCmSUssKeAQ1PU
	3PTKteheFpJI5PqlDyEz2dwtpZl8QnoIkM9haW3GYpGwa+0uKsHI6ABhUjw6yp4hn4VO9oppI15
	+WO+v3iIIlTAEij2NLKcH7m4r498EewdURoGPfMiSxrO6coUx7hNv75wtA+j16hc=
X-Gm-Gg: AYBFou2ZR1qgJhlr3vFF+YGlXPYerYphL2rno/oQkJlYooPI1HIWTto+rGQ72PnWk58
	9VayZ2EjpW5o1ke7Ho/oJobsFrBk15T6dQH+QmXdnzeANUSvCFN3Bm3gau4g0YeI4Uqf8OMMfk1
	NiAaj5pc1PHK1UrYw+Fy2mDbRrwVX8Xy8lWUTPW8VLHLBkZ3InlbkqqQqQpvZEJGdH3h8R3Jgye
	Xmcy9wec6rLsRBSwnUzDtKiO4bUXhG5tJCstuzm8QZ9QkXBfiBSNWKmATBluAkcrfE128VMXX6V
	242+MYzMXfieYTzi1lJQLwyB15LH+EVlTYOyj7fB88+8XRdOje4Om5pJEOWO0GkmRbnTrtQpHge
	lsCPnTyG9E984ryLyAB/W2TEyX8ehbtQeyseqrL8n3yXXYZj9tf2EbNLWR2z4U6AmILCwTyi6xz
	na+ashW86YIryPpLoDWrStYJhY4OS/SwFizQ==
X-Received: by 2002:a05:620a:ac18:b0:949:5c62:e785 with SMTP id af79cd13be357-9495c62e9bcmr926217785a.21.1794796757755;
        Sun, 15 Nov 2026 18:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:ac18:b0:949:5c62:e785 with SMTP id af79cd13be357-9495c62e9bcmr926215085a.21.1794796757283;
        Sun, 15 Nov 2026 18:39:17 -0800 (PST)
Received: from [10.38.240.54] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9ade7sm75767716d6.5.2026.11.15.18.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 18:39:16 -0800 (PST)
Message-ID: <12a1c1bf-df65-4ed9-8d36-23d89d5013cd@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:39:07 +0800
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
Subject: Re: [PATCH v7 01/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 SM8750 CSI2 PHY
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
 <a4a3df2a-eb90-427f-8881-f857100779db@linaro.org>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <a4a3df2a-eb90-427f-8881-f857100779db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6afa6cd6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bVWuqmIr14v8cS7SW4QA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAxMCBTYWx0ZWRfX95PRL+1v01Rp
 AcUoSdkj9ye16F0ExsNWsHdFXYqL3WoVBiXp2Zkgc75QgSbIV+JiybflU44sr8euUIV571KA/XN
 ZTgIpx0CQ83I3HuQuQZJ1VvhRfAzDgU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAxMCBTYWx0ZWRfX4hXnSNQrGug2
 t7pwzR/SvWcdm8Su4pq0AH/EcwZX4PcafQ/DRYw57cRS+rErCn6KUvlSYuPvCv7cAfdPIMM/u2K
 QsTNUC1cgau7Hd+5+tG4fiNYkBmOMgMtuyAZyC96oIy8sKfCVpDvx6xhEIEODZQaMiPIh9Gs2dc
 K3OLE5PuOihMLN2W+wCj/6YmWNNkqxy0jLx8G8irUPb1gY3YIf+WV8Xpq32LZvnS3zZe6a1WnZ0
 9VdNQd9zK8jzOyY6AEaEdZd2RckNR61ci2UlR2jJ3F2Ac9KM1quEoCw2Zjh+WvvYmhfnm8D9Zbk
 HMSsLSXk/sS5ki2r/YJ0kwOjtkvSTtygNP3rhGEpw+CXMgrasYj907TPFWrwvvfYR1SOAQgi3Kh
 ilVE9bDwi0WPyIKebXM5jdnf4jXrCoPB79upIRBs35HFscFjpMJvoSHBqOywUSM38xkOdkGmsrv
 oYGxEQdcFshDA+g0xoQ==
X-Proofpoint-GUID: JJy-T6P7pGzpq_FnmWcJzEek6KW9e_xU
X-Proofpoint-ORIG-GUID: JJy-T6P7pGzpq_FnmWcJzEek6KW9e_xU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160010

Hi Bryan,

On 11/15/2026 8:05 PM, Bryan O'Donoghue wrote:
> On 14/11/2026 11:29, Wenmeng Liu wrote:
>> The SM8750 camera subsystem has six CSI2 D-PHY blocks. Describe them
>> with a standalone "qcom,sm8750-csi2-phy" compatible, so the CAMSS
>> binding can instantiate the CSIPHY nodes as separate phy devices.
> 
> C-PHY, D-PHY and combo mode ?
> 
> It would be nice to get an accurate description.
> 

ACK. Will update in next version.

Thanks,
Wenmeng

>> Signed-off-by: Hangxiang Ma<hangxiang.ma@oss.qualcomm.com>
>> Signed-off-by: Wenmeng Liu<wenmeng.liu@oss.qualcomm.com>
> 
> ---
> bod

