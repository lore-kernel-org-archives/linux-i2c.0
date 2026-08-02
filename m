Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BD4A21
	for <linux-i2c@vger.kernel.org>; Sun,  2 Aug 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785677011; cv=none; b=WsJg6nXsVZ+8Rgfh7k1p1f1jA0Q0unUhuupu3sSYciC8g8AojH6eVRHbKUbuG7opdLFToGOpenUei699h9KeG5VOxLRLJ9xMK1VN72y/oUGno+PHJdHM98fb1S27+X7dy/Lbu8NUmdGD98UcYoYCLkLwOLrsd0rzPj9XX2yJDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785677011; c=relaxed/simple;
	bh=teVr7IdNUaL6HoT523oemvoGzAhZSzdkg4niNiWx0UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paJt/vv0hkmAzifEi/yTiyHF60FNRJMY9Eafq00f/m3ElAHkEG0VlAeIuvt8XGBWC5wQBFBMWzbjUvrbNqEShwf2KYjtGYOtbne5meM35tSdA4Wed1BUaZG6Oc6AxEPlXwwNTmZNP56rn7gSOIBmbtHUqNlhGzOye4jIH/FZru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8UEdo7a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RpF+UH90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8UEdo7a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpF+UH90"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672B6Wmb2678765
	for <linux-i2c@vger.kernel.org>; Sun, 2 Aug 2026 13:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUXHqwM6RtCuMwiSufi3YELdEb3Cb9ksQ3xjASr+G1M=; b=o8UEdo7aAwO6oD8y
	rxQKDLjzQQZP4OlV87Xd+UTXjKlQLTDNCGpzjVr1zpibzWuA+ejyLuYwWa8Z7aKv
	8KLA0sA2l2Rs5VhrycStgLGVeBjX9kG7J2HZUWgBACmEsNt8HNny7bsqGsPTWlID
	pVQWy7eIM3ob/WqCM3DiCdqQ7DACmFYK0+noOpTXjaXGX/kZ9e2OeM7QYL9+FB2T
	uQ4LkVwtBTD/BisABJrOpBuYmiQVRyEgnG3DAn5bH0ChEgPijPGuqc6NqTZJuHwK
	FjVt2GtjJjdk3gUHpfP54Y8OF0gtY2y0HTNQ9NO8oEoLjTV1na1OmKtxDcPjvekg
	cl0uLg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8pg2ujq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 13:23:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso4295753b3a.1
        for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785677008; x=1786281808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YUXHqwM6RtCuMwiSufi3YELdEb3Cb9ksQ3xjASr+G1M=;
        b=RpF+UH90goIUy1xw3QHkaywcCQ0818x2WxO9VvVeoaqzf3EryNgCuPa76Jnndt0u4z
         J6O6qwZmZgV7VUsIardBnkNmoBaHDID7/sSxjL2hfSRX1lq3sFjRXmAy+kvxe3SoV/Rf
         js5QLHCbZ8Lti2gum0IEk9Ku1H+YT/68UssBkI1VLEcxfJHEsyrfsvf1zSaLFADZJcrX
         VUgREMmxz1z9uGy5HRrFsSdxs4OOe2RS5QIw5FnhFiGnA4+snbFUKHN79ZDoz0kqiwxO
         BTEoh/viEBTFcEUyEp1T8T3PaLQgARLIC7ZkJYPd94KrdTvbtv0ayeCw6+E/kxJ28FIl
         SSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785677008; x=1786281808;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUXHqwM6RtCuMwiSufi3YELdEb3Cb9ksQ3xjASr+G1M=;
        b=aQZIj4rdiurRYy6BnyI1cYPwBAyvegTwA8pBD9XGDFk4lwmhVlvgfXiSALiE2yU60i
         O2DPTgSooL4O7TsTjoNa/op/ZklgeJSBZlM1cDiFcGoKBKJAO+wYm4rANlvlAd4N8Ez3
         JTlB25N0KU9R7oTxkJqsVg7d19jj2Oc5YPLXdB6ln0TTTeah6vamkeod3JAVVnQnoml8
         y1QE8ZiPOXUO0c3SmRYm8G8g4T3qYbfT9Fu67Vc3ZKr9mOQ2JqjE9Rvua1Vta1oEBE06
         jnGcnka/Twc/ZXYdf/uNUR65qfPqFaQEMYxoeOQ8RHPbOsHDuCxMNfFNHDQrbMhAbywk
         hNcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp14WtwmeHfA2stqXhGSojL+LuApasT1whJ57ayr46BLlm7D51oCOzX7zae1XYtLG3niXW0j2H+Ae4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInzYahC3QPXlDdp5qSL1pz4xFgi51usIAWHkEmB+q9fpbxloQ
	LqfqNT/AWnHIkpwu2K8ax6Src6rleHP6TdTsbbrUiq+5sBEziVQEL5BTn8ISLjgpdQcLutOhfzB
	0wztL7K5hM8n0GjYCwS7MuUv3m3+0rFIlkNB1tutUh2Li1O9aRMGNVJPrdJVjD5o=
X-Gm-Gg: AR+sD10WFWtSKnJGaD1PH71Hi5yIae47NCZQdQdZKyvV3lZjgTWdgOZNbgwWqe2fBqI
	OZK0ILxOzHOiiJqwibJ1hfy5l+m7s1Wih81TJA4X9o8PBxY3jb6XcQPTpGQmC0oOBhqRUQ8edD4
	1JOUWRRgtH0XJ2KCeOW8SkqFfChps+Yz6WIgWXlNQ8YIlRG9hU9YB7OSSIzDVw5B9/J1abVdvMZ
	la3v4cKjOxR+bLqtZbEiAh4pVdi64ka9uglQQRbH7D2iOtccR5+ODkcf2NjvxZjiVE76OyPvV/e
	1pNT9OswwXoLow3gb9F5k+4N65JGmloymkx/7N6CjInZQqw5U5Z4VFq89PFXWoNSgJF6M/kVH9L
	VxRZ+z773nJn4dI0RS+YTrzmhTHjdQe9kRgM=
X-Received: by 2002:a05:6a21:9984:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c91a9099b8mr9194986637.23.1785677008354;
        Sun, 02 Aug 2026 06:23:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:9984:b0:3c3:6e84:ace8 with SMTP id adf61e73a8af0-3c91a9099b8mr9194953637.23.1785677007896;
        Sun, 02 Aug 2026 06:23:27 -0700 (PDT)
Received: from [192.168.1.15] ([106.222.229.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm27661888eec.8.2026.08.02.06.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 06:23:27 -0700 (PDT)
Message-ID: <ed076cf9-b687-40aa-a1e4-c12b7205a818@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 18:53:22 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add entry for Qualcomm I2C slave
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
 <20260628-i2c-qcom-slave-v1-3-8b0a5c01f9f6@oss.qualcomm.com>
 <7183cd4b-833f-45f9-ada4-1392152680b1@kernel.org>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <7183cd4b-833f-45f9-ada4-1392152680b1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NdhX8iMo5VphAjC8Nv06xcKJs8uFm0bV
X-Proofpoint-ORIG-GUID: NdhX8iMo5VphAjC8Nv06xcKJs8uFm0bV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDExOCBTYWx0ZWRfXyujUGRzxe19l
 6JgadfB8X+ytJ4jPyEt+22TsGazVXR3SjO9yY8EPbMX6cQbX9k9UBG9Atx50Mzi1gW44BuvrdIm
 IHNG8mQNlGC/0jNCc2RzJ0/+ZF2Ti9A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDExOCBTYWx0ZWRfX1CYORqjXh3ws
 NHl1dPHz+Ly/WHPeeuwKsCYZ9ZXBX97KDynRF4e0Xv7OdBf75szRjYFw3jCSh7hxBtpFI5se5ye
 Ogv+HBkorVGK7XJPJCYBy4MjoNG+O76zNP6mu9z4ETsO884TdxMWfHh5Ec/n27bSeoPUDSPRPVV
 Zwzi9nDoRkBTQyjzOye6RHOw4iTYz489h2/m4R7oSA5qiEE2EOdXwlZJ9dN03UPqpxjsQhyGY69
 dfgIAi9Q4tTV45x7AlDhfNdv0QtlaiHtTzoOxyfAo/f47PN74zuy8WF3BmZt01Y/Kq+ueQ5EVHL
 /lclcZ0+yIg1ncDe7SJVHNimVoZ3T0aFr+ksUqJThhKOxscToZWWLDmijaSo2F2CdrMpWr+/k1D
 KrqS7aMJ34rUrzz5dlfBXb6eak/t6lSKWxUsP/8xz3bCMDb2Z1S03oJtlcC/ttTRqPQxj7XycHd
 AqvLBgV99biC0xQddXA==
X-Authority-Analysis: v=2.4 cv=U4Oiy+ru c=1 sm=1 tr=0 ts=6a6f44d1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9c8ARojF9RoukzHm9jbkGw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WZ9ViHwJSGtzc2qvcnoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020118



On 6/29/2026 12:05 PM, Krzysztof Kozlowski wrote:
> On 28/06/2026 16:39, Viken Dadhaniya wrote:
>> Add a MAINTAINERS entry for the Qualcomm I2C slave controller driver
>> introduced in the previous patch. The entry covers the driver source
>> file and the associated Device Tree binding document.
> 
> Squash the patch if you cannot say here anything useful other than
> repeating the diff (which we can read...).
> 

Done. MAINTAINERS entry has been merged into the driver patch in v2.

> Best regards,
> Krzysztof

