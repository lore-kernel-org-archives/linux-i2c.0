Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548C37F756
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323812; cv=none; b=SwDpZVvk5Cubwl12r1YFICaDYbwMT9aUFFe2rC3KGNKRzXVyRbAemxlPwN43/RfOgaC+VURowHWxVhzM7vxL+VuhSXpWlN20IB0zm9sXiFyiv3e0T+/9ryx4Ki5aR0oXuEV/gKVOt9a4FDnbqyD7aINqk1V9GuMWJEwLQpnkdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323812; c=relaxed/simple;
	bh=d+CuOuf3ybPVo31Duy+EpOGsQqxm8eNmSXH5RxEr1bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/nR5iWa/AuO6+MWYwDRY6ezm2Dl23niZH6nUVK5Ny81y9CdtRlVXnutATiihXFp3akvD1M8dkLKi9LCSv1Jim/u2vhSrVgI7h70M4cjrY5t4R/6pWrR+6BbaH7OVfGZrrWoPOoMQUXiKBLwWPTptrwNa5fBM2feH06dc0Ar4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EjX4XkRZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QXBEytuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EjX4XkRZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QXBEytuf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65D3QQEv1372121
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LOdBZhTf8TwFyLRvPPm9OlEuuyxWqmYYuZEeSSpKiKE=; b=EjX4XkRZpygOmsXy
	GVaiA5BwdOv/Yb3hrVzwo6/qftVVOstDIcAxtEZgO+E6ImFeQ+bzCsFcfTccR6AV
	kHimL7q90XgU6hSIS5504E9F96Z8mGjWkvrsDI+3BgZdXNC38eNugMbNzH+BSRSw
	e/Xt5yLFD16MFYPFBWIBifvMhxWx6VuMBVe1jvY8SIV3WI33lCE8RwF2ER0/lFhX
	2s4krj6Sno4qlFdEvF+nUNz0wpzBdaY0KrhVSCAT7m5J3YoyYU5sgQkU30lACJWS
	tjLeDzFbaV3WB9e/tV8PvwndhzNmm1ARSDRGQfsBFBPa1kONhe2RwHWAK+UZoqi+
	e90dQA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erya4r2kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:10:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8425a9979e1so1097133b3a.2
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781323810; x=1781928610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOdBZhTf8TwFyLRvPPm9OlEuuyxWqmYYuZEeSSpKiKE=;
        b=QXBEytufWuzTfB4cD/RXyRcDF+MBHUjsNNMLzEBnLHKsB80nwDFufN/J4V0YXrEOpB
         KSTQ1hYnz1vAtAfzCQWnni8e9Uj5bbfeLZDcBONCVos2Q1+Td++AvoOC8UUW/mjAmf2L
         CWSFbTBQ0pUTDAWNSow+NLbw7s2dvi56WzGZgZpQ9WG7hfMdtV99DSOR2HP569kk4MoE
         1DVOPFUZD3LLOXJPZGCrS7DZxJF8ra3QF196B/Fi3F8okY3gp6fW/dG1TW//U9Q27ngz
         shkTR1RHYs2Dw2il6o5W3OSc3Gv6MnvjeE8F29N62I+i0V6T+jy+l47rW77Q+X8akJpI
         9d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323810; x=1781928610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOdBZhTf8TwFyLRvPPm9OlEuuyxWqmYYuZEeSSpKiKE=;
        b=c49eIq2QZ6E2509xCR1CcF/x0D86VtkgKoIZvc8sR51HL47BLdH2dQ2rvIFOyQ7Ql6
         c9+7hcFlJHTXun39oy4rVxzdp57TB35eFlONqIDch7W0I1tp5hXGCY4XKyAmyoDo9LBT
         TzKhaectHgpyiylhsup24+Zix2OO+SsI0rVFbH9rm6GKvfF12hBcHGBTiBJ19aIVTyHU
         SL1uAolpZXQI7vDcbY/I6wBpbkHHTV8N02trOjvPRTBu4EXcL0bHBDMATlPXj8l1yCuq
         mxNWsjy6rTKFugcUtuqkBPIJD+r3cWcpfe2Y5IBRQk5V+WpTnul0RjmG0oVUbgzJyhIu
         HW3A==
X-Forwarded-Encrypted: i=1; AFNElJ+zlvCZlUupfV5fXx68/wV8IhxSQbtw6lfbuf02roLWAT4Dp05pADO6WKHfD2raVqEtaj8o9LywaV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUtKfVPRVYGXZfWYD8rYDqqbF+d3U558MC8T1FY66fjw8H9tlQ
	IKP7IaKGqN7N89fCb8ud+1SpvdTHQlxuK7Fvhzsfx9NA2XH3Y5MsVe114dS535B8nFs6Ld1jsJd
	egiB+qfaWBN1/LJTz++qlnkax+RPjrjeDE9ee1AkDwbfC8xbIamsfUls3Qi5tb5Y=
X-Gm-Gg: Acq92OHaYrU2tyGePAYRoCDFD81BUl3QDtm1O7Str81ZqsQqU+qkoDLlkdiqINXqmzB
	yG6D5XJ9BgUpcHG22llSVpZ8dZUmiggsXg/i2OzWCw7+erf2zpZun8tk3RHA9pb5Da+oFW091bn
	c3psuXcTmwl3DROcJOhjFKkLxWbFj+fi0ulGnoL2tyZ9W8wwszm+IhzuOcpi6ptEHj7CHdmjyJ7
	t3JlHHUgYt9aDVYeBKP3nAYPf+i8nnrVwSrpPlmgbr1V++ysiX3ryENYuj4ulJJ9uZEDy9ucUwy
	dsd9VXEfeZgQIxaCzWiDZCNLJZZz1+sjl6mmfKilHVWjJX8utDapIwxguwkAPQb64uZnilG2IrP
	USUwXBxt2xJPqYNaJYHHN3XpJMmXopZdLyyz43LSuJfRt8WG88U4=
X-Received: by 2002:a05:6a00:1483:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-8434ce95f96mr5902252b3a.10.1781323809818;
        Fri, 12 Jun 2026 21:10:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1483:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-8434ce95f96mr5902220b3a.10.1781323809366;
        Fri, 12 Jun 2026 21:10:09 -0700 (PDT)
Received: from [192.168.1.11] ([103.211.19.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm4480992b3a.34.2026.06.12.21.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 21:10:09 -0700 (PDT)
Message-ID: <fbb00150-e3bd-45b8-a87a-100ecd235a46@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 09:40:00 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: shikra: Add CAMSS node
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
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
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-3-ca1936bf1219@oss.qualcomm.com>
 <3ec2bd75-4d88-492e-a8c2-b21000ef2afc@linaro.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <3ec2bd75-4d88-492e-a8c2-b21000ef2afc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDAzNyBTYWx0ZWRfXww99zyV+LYx4
 +1KOy8/qEKekEci3rfhYv5o/aOboD63nx/CaBFluhwHkK8DONy/mazvqiIb5awqli0YSTmW6OaQ
 V+kmZBLWBDnWoFjcDuNEXco+qHZZWhFiPUdRnUhxks2oqd0RodbhJLYxW4V4W3100t3qrSdfjFh
 ePUgHZYL91uf5k/DKBdWChLGb5E7aWjAEAPaSqFNLAiuAeAsYrRLPBPLSkJPw9H2xFhF5fC9mZv
 kdGWOuubr/xBZbSTo68Ce8nIK1sRLuMFPCE6vfwoQfL8aG6hsXweVARybW0DF9rni1WhAv1I5qn
 KYxth2gD3rdu7IvIZeXrLubqwUWIIczxLtF0Tw51FEVCNwhXIPeikBGJg/xQUxArYMHF1yGrg+P
 R1MUIMQD6/+yMX/iocF9fCt3VvvkbmT3gubvkPrUEOSypZEyJwpNzM0SOG/e9eVvyFxu9pE8s6k
 UlXuXBL1iKmb6CXAShA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDAzNyBTYWx0ZWRfX/b0Y8t6gDgdr
 WCvAH7WtHlmxbVOFoZFvAUdGKPp+EQ+wBfmfp8aILpwkRDjybuxsED+QKDeoUXse3a7zNcaB3Ny
 EAUVWAAYbDI4pCxjrT605xHhylniUyc=
X-Authority-Analysis: v=2.4 cv=KZLidwYD c=1 sm=1 tr=0 ts=6a2cd822 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=RuEr1PiGI7RNW/QBahnYvg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=HRvYZQSnNB20PN4mEw4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: qS6HPzxuFeQkCpeK1esVJrQHTHBmor46
X-Proofpoint-GUID: qS6HPzxuFeQkCpeK1esVJrQHTHBmor46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130037



On 12-06-2026 13:26, Vladimir Zapolskiy wrote:
>> +            iommus = <&apps_smmu 0x400 0x0>;
>> +            power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
> 
> Please add an empty line between the properties above.
> 
>> + 
ACK

--
Regards,
Nihal Kumar Gupta
