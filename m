Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E21A00F0
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854006; cv=none; b=Rxx5DcgM3ZRbffXxhFu/+J9bfG8HvsiIxeUeTR5jiRdI8WyGmLZojRye7rXqwwVUtu+j6bGZbYBnUitSGkr46Z6fzdcIMO7FJKpLYzfBOTRdIlz4BbWeJnBRjEF+OIDpcq8q4DAcxvURcqDtjXeKr06ZhBTDol9jBEMu3w4pcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854006; c=relaxed/simple;
	bh=XVY/teWmIRKG0bhadE1kKsMkinPkfohwJbkc0JjNgCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXSYhBs3DRVsMNtfCviU58QeusNmp3zCQnbisqPmECPVF6s1QbmK2TFDgvwyv3ypAymDu0ThzB4FOHeuMFbcy+WsQvgrj1WfCoorh0jtIkSC1g/5IYauCdJAjUjzSMjzHiqfU7oaWnboF8psA0fxnEjRh9TynOdvleB50dQ1xcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gBdNugef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cR4R7AW5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gBdNugef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cR4R7AW5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NC2hDc3151782
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 13:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G4/QIr5UHiT1flGxYWTgnSP6v9y0V/IaNeyzeH6czwU=; b=gBdNugef63A+9kLN
	Oxq9N29XlyfrqdScFUaLWevZ/kSIj6joEHbgXo1oI2+SK+A2NMlU5Jwe5CB5EV2R
	uvdiWyfGPUB86LZQRznWfibKdjsYNkP5I4NhjTf4ERpNtkVdHdx/+yZRV7E8O0p+
	dc7tqILIJRD1PuB23QfamUTpnwgdCyhbK/ChnLw5iTSWPz50rDP/Lv59L3TIb1eD
	8zp55gBRD5uYae5t+PmMN1A4AgQgjjjSnhrqRjdyi0QGjIUWmhi1O36ttQF//7+b
	X/i22IdDzn3HagI71DVVXD/RiTJnS+ZON6biqw7t1XEAHSxqNNPlUsBMPo/U4+Oy
	fomefg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj887kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 13:40:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c7febaefso21361623a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771854002; x=1772458802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4/QIr5UHiT1flGxYWTgnSP6v9y0V/IaNeyzeH6czwU=;
        b=cR4R7AW56DRUxoctXuz4walS6+e7pgUfVUTuoj/SE1e3iGj5HAqId+c0srwEbyXdm8
         oze/aHM3WpTiYPoE8Iz5gVyvk3FbAYj+1IkVB5VL28mD50QkOz4blWXC06Wyln+htHDp
         Qg/7iHPHxliiy0mqbAP4cFBTXaIeimMWMlRc4crnkqhTrsZw7IclCdDMH4colxNFkSLr
         lFFx7cn7/h0xZSQAZ3Kbl0a88tTSZ9Ngy6NLP3/muHHHL8pvmLKnfvHOil+/SpSyDn21
         zBj5JTKLa0ku2AboTuiKAaj+EVA1zKubpQTRu5eykLG2FpZRGvKGRbX69DZWcyjXwjEi
         /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854002; x=1772458802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4/QIr5UHiT1flGxYWTgnSP6v9y0V/IaNeyzeH6czwU=;
        b=l8usrZT7Tt0ynj46htucwXEWOrwU8d+ODaRBzg/Mcy3nHnLNAjkNt4D3NeauYeE1YL
         psm41Js6E5j2PQsWR3SvgNhtTav7Tnilhmt7bJa8PHEfg0S3WW8eramK3qzqczslBdji
         QQDjgUTi3gsQbmzLz9TZyjB2l11xZPxnZyQMThXCT7lg9jlAbij4Emsv9sGK7Q5wYzWy
         WkLklrcZzuVJc5pRdF1NVuaAoJk9XZiQlVwYAoQL9UKVe/h7H+l+QO6yBaplpoyqwG3v
         vSVqNYJyg4aYJ/5oUQCMs+YajNV4RtmSzOGp9lPRAUNk/OKj8wkk2dbERxmk8DjnUZjZ
         r5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUl+RWgIAw9vtHkINPGYMmHXIv1XkPFSi7EMy6ocZql0fJn0AKkKW/0AuCtk5/pHyPxAakzuO7uPLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YziHqKe55KtwFrMdcrrT4iYz9BknJ64Ha0XRbMmlzTH6d6Da
	86uOYGIRDgdZoc2hdtMYQVNvE56Fffwl5UoQ3/PNywxydFdpMWoWvm8IRv+yDiEz5s2mmJxbcfY
	XOE4BEsf3hhBH2YHwZSZcb4/jpYzelFuue1SZ/k9wUO6tTgBQnJdB+vTBjBCKVmo=
X-Gm-Gg: ATEYQzxV2C4zffEb/jkbIr6KscOqVuySBBBxQsr1GSO7QaIqZPO+0iR7sfRNHPZYD6/
	is1dlFJfCZWx4GtqP1WqdQ/BFfLYpC5n0AXB3oqynyVZfJyXp0A6kk7wSnyD3v5cQ4IbNlK9jy+
	42oK1+wITYkRrQhRB+zIrgli5ecjnxrfWQvIIdEWNavQutWqHfO98g++EMfHBNy3SF2lLca5ul1
	yMtFLRYk8TSWV+t2aVYtgJfO4apcbbtyKU47lXGkQvwY6Yk+ZTpLVhYdqpN4EjzEYQV+J3qVv0L
	kQUZC6N/8JeyKXegtqTvJS73fJovUdPm059pslRfswg/+9+AUfaqdy2lzjz8uYBjNnEaT1vdGeL
	1OLVzhxvtlmUZ8OeloEJso5kexo9widMADo9hzdMdn34DqF29PrNYlA==
X-Received: by 2002:a17:90b:1d82:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-358ae8d0700mr7338170a91.27.1771854002239;
        Mon, 23 Feb 2026 05:40:02 -0800 (PST)
X-Received: by 2002:a17:90b:1d82:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-358ae8d0700mr7338136a91.27.1771854001684;
        Mon, 23 Feb 2026 05:40:01 -0800 (PST)
Received: from [192.168.1.5] ([49.204.105.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1b63088sm7338194a91.2.2026.02.23.05.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 05:40:01 -0800 (PST)
Message-ID: <9b49a776-a65b-4210-b335-627a296049a3@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 19:09:53 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-6-praveen.talari@oss.qualcomm.com>
 <05340972-2013-45b6-801c-7e52fe48cef0@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <05340972-2013-45b6-801c-7e52fe48cef0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExNyBTYWx0ZWRfXzyRFo158w7lO
 SPaT6+dtJTUumBWUylt0E+FDpoTzH2BC/xQct8nQgqqn0WEaTsbZLYFaX8sU+O4CzluSK1xXQjy
 D7IxB7fC+yrjBSaA2b6KRM9NAtzvHz8VBw7/QDOqpvVCjH7oNwNipumQDtGDesIH/TbZG8Fqrab
 EkI5HMwQQefNQMVVClGsQ8dYmJsJW4Q+Hx/ZhlwqV9RaDhxuNAhIPCDRuucN4Dhb1t7XHcddy2A
 G6ZmMisDKHF3YQbFys9PJGL9T7lnYxneA7zMhebY1uaVDhbNexcIF78/9RyfcoEpFEFxGOkE1T1
 /uTOu49nLsZi9ildLw4Vdjh3qYvD+B/y4fYRj5D4Ca5xV7cHYg1573iom4YU7vf93T40uNERmSo
 8N2Mp2rj4FAI658aijNOjUDFmlpgdp3a8i+ayCaJn7vvbYdJOjwwp3b9HDBQsWLbtoL5eZSH+li
 eD3naO5CZ3FFU1AvoPg==
X-Proofpoint-GUID: WYbnWNXgY-n7Wf959MD0L2fbBCPGp_ww
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699c58b3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nVOepZjDv8C4mF6t9zHebw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VriMNdUBh5tPIKgiUd4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: WYbnWNXgY-n7Wf959MD0L2fbBCPGp_ww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230117

Hi Konrad,

On 2/17/2026 5:32 PM, Konrad Dybcio wrote:
> On 2/6/26 6:41 PM, Praveen Talari wrote:
>> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
>> activation/deactivation sequences independently, leading to code
>> duplication.
>>
>> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
>> power on/off resources.The activate function enables ICC, clocks, and TLMM
>> whereas the deactivate function disables resources in reverse order
>> including OPP rate reset, clocks, ICC and TLMM.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v4 -> v5
>> Konrad
>> - updated return value as 0 for geni_se_resources_activate().
> 
> I would really like you to include that kerneldoc bit I mentioned it
> 
> https://lore.kernel.org/linux-arm-msm/ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com/

I hope the below works for you.

+/**
+ * geni_se_resources_activate() - Activate GENI SE device resources
+ * @se: Pointer to the geni_se structure
+ *
+ * Activates device resources for operation: enables interconnect, 
prepares clocks,
+ * and sets pin control to default state. Includes error cleanup. Skips 
ACPI devices.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int geni_se_resources_activate(struct geni_se *se)
+{
+       int ret;
+
+       if (has_acpi_companion(se->dev))
+               return 0;
+
+       ret = geni_icc_enable(se);
+       if (ret)
+               return ret;
+
+       ret = geni_se_clks_on(se);
+       if (ret)
+               goto out_icc_disable;
+
+       ret = pinctrl_pm_select_default_state(se->dev);
+       if (ret) {
+               geni_se_clks_off(se);
+               goto out_icc_disable;
+       }
+
+       if (se->has_opp && se->cur_rate)
+               ret = dev_pm_opp_set_rate(se->dev, se->cur_rate);
+
+       return ret;
+
+out_icc_disable:
+       geni_icc_disable(se);
+       return ret;
+}
+EXPORT_SYMBOL_GPL(geni_se_resources_activate);
+
  /**
   * geni_se_resources_init() - Initialize resources for a GENI SE device.
   * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h 
b/include/linux/soc/qcom/geni-se.h
index c182dd0f0bde..2f7aba4f89b3 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -65,6 +65,7 @@ struct geni_icc_path {
   * @clk_perf_tbl:      Table of clock frequency input to serial engine 
clock
   * @icc_paths:         Array of ICC paths for SE
   * @has_opp:           Indicates if OPP is supported
+ * @cur_rate:          Current clock rate of the serial engine
   */
  struct geni_se {
         void __iomem *base;
@@ -76,6 +77,7 @@ struct geni_se {
         unsigned long *clk_perf_tbl;
         struct geni_icc_path icc_paths[3];
         bool has_opp;
+       unsigned long cur_rate;
  };

Thanks,
Praveen Talari

> 
> Konrad

