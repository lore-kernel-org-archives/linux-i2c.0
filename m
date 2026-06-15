Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664913BD228
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508435; cv=none; b=Gbnjcb6o2t1jv98UYkWQxvWE8mnfa3w/QGIvYD4eQUHMM6x/Ch9Xj4ueSfgWOYbDlEll4YLcPOES8y6Q9JOjsmCxNtCgkHZ+oHpiizufYZfqokZL3jPt896TgFrt/cWjgFixMYyKo5RELLJ4coJYxN+EqabHX7x4cOnVj+cl5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508435; c=relaxed/simple;
	bh=pu5aKp2dBY9Z7bUFYMTRFGkF7Auzc9XTr1kXTHyu/yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGRilqFIR8I2yH9yZaoVrUhg3DapGgknSlHFfNl7YZ29R2Nj9xcbcLJDoq12KJc7KVfRqs1X9AqLTpO+v2eVePtUKqRsnnaZsC0Ah/nSiCNFZ3GpCTzXsrp7duq7OS0oNMGxNZzSls4CNgFlSLkYge8oNdQDxlnGc6P/BKlW40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eElLavAq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9/ptSjL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eElLavAq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9/ptSjL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Kset3710247
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lV3PsszzF0e8PSHEQWQ0iIE6jGmvm4gXnL8CM8FMIps=; b=eElLavAqty18WPNi
	akQ78LNkjS1KxXRN/LcVTT5t5wPm/l36I16VVcthNtebm+bPUaEK9t15p8plA2bD
	R+HvKJNLEAE1pNlOCGEjdMT98sV8Q1COUBZHwz6rz65MwV1NInGBJIlfs8aF5gbr
	zfd/b/hWYOjSSTNJDoGJHZ/pHHnfwCZ/KeHT6l81oMWbC4jhmW7E/+gzRRLer3UE
	592gLtW6W2UgRqgBcnie2KBts4aiVgZX7NE+BtbLh/f3AvfsEkYyu5OHwnl6HQXH
	m13TusyKegmMK+/Hj1xXXPguNjjSIUvLEp2jgScNmkSJp74M3Zb8NWGmG3TskK8M
	kJPhTg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9566g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:27:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c857ebbb0easo2218181a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781508432; x=1782113232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV3PsszzF0e8PSHEQWQ0iIE6jGmvm4gXnL8CM8FMIps=;
        b=c9/ptSjLtrxW5vWNwPIY1Tyxtz6xepfCnrib2SLzZsh79qxh7wga3I/LVKlH6tb162
         GVem8OgCDQBhqLJbNWWZPPPaxuvrb8tgOuTqiI3PwHIhLfWAvOo73G9AzqglcbjUx/fQ
         2O/6zXkd2zyD7kdN8aBnV/MDtJklJTxjbV0fF+j0MUkVrN2mJ9LhmFbiXgSU3LntMpyF
         EEKhSZ9QcBi/wLmaOvOv4vgMXhj2Xjqi3apwbygNRA4MhNrqc07sisAKMg63YHojIPeX
         oZAZzM8zJ8qjl/KYOyL8DX+CzUWfTDIy5gcb5dBB9qO8LK3hONA/vCYvusMZRCsvoYST
         VBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781508432; x=1782113232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lV3PsszzF0e8PSHEQWQ0iIE6jGmvm4gXnL8CM8FMIps=;
        b=dGbbvRTvqnwMfW4xVEnpfgCouUcYn9ycCikXoExIYgjBUbAb9VD7G4FETX8AfDfTsX
         VjpSpA2BDvWL8oW0E/4G/zcuXU3jRdxDhqGZ3WYTy01z1l8/zRHfDmYKfFyDagFkKSsw
         aK6WtNJP+Js+BAPJIyKCrbCOqK1CkTIGGjRe2gwaYCQDmTRDZjofTh6yiqOXF35PMsDH
         exJLWrBALCF/W/5+qQ7NLsMuKw9dD6PKW93m5bd1Ll8n/BLbsy0eEhZyHdu/YOlXTnNP
         ugB+uZ3+gLLUtgxhIyQUwank2iYZ5fKKm8BATw8tif3yGQFdjYXi7EJb2YPb7ALMv0LG
         6VCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+binuBEsUIWqBsZvE1zQmBnff99jHHtQGQcEkF+bPKiaROkgEr3PGoLcTR3A4Z+faRiCxbl7BDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuW390wGNVtN5h4gURpvUFEQnabPhm0eaR4L1R9RZvzAZxGGoy
	Z7+gVSzLBf1NWjKjwGWIgNHyCNR0oL03SGl+B4M9h7B8vZ2L8NySZt3D0smMlM1o2/p2mynZdvd
	488S4P8wI1BekdXi/GFwWMZnoSMyUadlrIN5OIaNEr8EBpwPvlnuLYO/uy+GrjDM=
X-Gm-Gg: Acq92OH8e7v6SRNkFAZqExZqND4FWPL7I8nmuGL6SVvm79D08hx0qufWy7CnT4QBOLv
	DYyuLzZvIfLkIBxwUS400HzPOuXghQ48JG5r5zcQLvndQ8QUcU2RXUAEpzx1OnALRnI+auY5Saf
	Ht4B1kjrAKj6Fzqu5bejtmqn/oS9yOD1hiL65eKBJSJcQmmrzqj7Exm1jftBBqGNdTbUyuXHPMv
	vpw3e9Zn3vSwAEJ4tZpZx038nLUHNrvMaUNPOGoQFNJMp3phgjHFUxM5s/SzFD5zHekGPKo+d5r
	6LkgQLBBdzh1aya0DKrlYurRBXmYGlYA1UObWQlYDQWUQtubwmPZygxBw8lCdnUfHNYPPU5aPzT
	IrzG+ErNzT7SpyM1pfOIQ4Ky16Et8RER0g2PwrOOMzKmVLAHk7w==
X-Received: by 2002:a05:6a20:e290:b0:3b3:bf9c:7c3b with SMTP id adf61e73a8af0-3b780ec2f0dmr12418313637.8.1781508432272;
        Mon, 15 Jun 2026 00:27:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:e290:b0:3b3:bf9c:7c3b with SMTP id adf61e73a8af0-3b780ec2f0dmr12418274637.8.1781508431779;
        Mon, 15 Jun 2026 00:27:11 -0700 (PDT)
Received: from [192.168.1.11] ([103.211.19.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651af0edsm7787406a12.32.2026.06.15.00.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:27:11 -0700 (PDT)
Message-ID: <b11a9de2-6bc6-4345-8d81-5befb2182a7d@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:57:02 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add CAMSS and IMX577 sensor support for Shikra EVK
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wxf6nHL7LZQQU7SZJ7Vcy3KGCEDTKh1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX1Cud4FHt3IqC
 LGXVuUY1kDPpAXq9+hY3EvVPGMOLOJAzcWoysqxhUw8SOF7t3IUOEpbm75oP0vIfgI0BS1ldzEe
 tiL0vt7Sk0EtQfJ0inhmR6tPGt6it30=
X-Proofpoint-GUID: wxf6nHL7LZQQU7SZJ7Vcy3KGCEDTKh1c
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2fa951 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6rJd4luAlhGbPPINhpk/8Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EF_2yGccovn9CQtFCckA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX5fwBwda0DEJX
 /5lrZvkS/NUddGXCqOSC4bZA4KAZO0BQJ8N0Ck5Az2ng5vU66gqnq1B1/fzi0bicDYTnQVBIBO0
 8ZpQkIFe9bRKS+Bo7vU/ok9JaSwaRfWpmnzWyQ+8pMWtpdoWwSEgSoqMzNM+U7dCxBh3iWR8tsf
 moX8q1/5gUMBqRPh3y+lkrA2Oq9GlNvlRiGglvViq5swbd766apOnP4LzK2HFThqYplf+42zkva
 vCM/9kC9D0XI4JjYdYM8/Lhq2B9vtQDGt4sCgIXH7a0Dk5JRBphVkCEZBLc6Y2Pb0jBV+DGHgR3
 xwvnGh+kle12EMXrekZgPJMP2t0vRFGOfSA/Qp9Sf0wfZOZOiHCjK/ixPdgQErX68mY3y1C7BJa
 w1jERK4jf3FfZX1MxN4M24KJQCgahPSrXDxHFHBkzEGngyMLQqrS1CzCVdMRr66qPSzikwTZWVE
 Bs8or5PpJqj8ya0zO4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150075



On 15-06-2026 12:42, Nihal Kumar Gupta wrote:
> - Add blank line between iommus and power-domains in CAMSS node (Vladimir)
> - Fix data-lanes numbering to start from 1 in all endpoints (Vladimir)
> - Move cam1_reset_default pinctrl state from board .dts files into the
>   mezzanine .dtso overlay files (Vladimir)
> - Collect Reviewed-by tags
> - Link to v2: https://lore.kernel.org/r/20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com

Hi Vladimir,

Apologies, I had tested the changes with data-lanes = <1 2 3 4> 
but mistakenly removed them before sending. Will fix and send v4.

I've incorporated other comments.
--
Regards,
Nihal Kumar Gupta
