Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BE32B993
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328777; cv=none; b=uA/O4sjnUiAVHl6EZdMvC6ne/UrID+vx3wdCTxKbI1GTnoSBpKSwiulSC97UjHJgy3eTvidH7moUH+vWduzgQM1Y89rmo5rfc9uKYiWYgvL6Sv2XXktTdaUWpunV/4NBIjuTjp0teW61HknXHdnpT+jZe+YAWYiWzOjw+VjDrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328777; c=relaxed/simple;
	bh=sGTzj61xYJ1EFVupvf0NZw/NajElGdUjp1JLXk9f4yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PO6UlunRWWd52aVo5Yp0Ixpjg6hUyPoAbOZkZ2BPakeZeQ+pALdahmHMzTbSQtD4+kbAsoGwFhyN8ISPvAxe7TtH8kTdX3H4UfaPovH1++/iRcRawKoLpFNecxaFYZ/jlvY0kC0HsPg6AMApo5EdaVXFDj/hQcFpgms1TFdCYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pb/s5frp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V6+bJaU5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pb/s5frp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6+bJaU5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H7UPh33392915
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCk9OpWnJfO2diGe6paKGh1+BeBt+jweQ3ZEQMMxtpg=; b=Pb/s5frp4NM4keU9
	ilYpufn0l4Bz1pYY6VYR/LurTD0FIHXtS+ZpKXuCWs8ze0v/b0NDj9eOUzwmZ0Bg
	8w9vdufyguK9g0HIW4dCv9WDHB4Wl3vlV7Rpmi1Z8/VONBIxrEk3Yzn/1yD+VoNy
	Dh2EXyYSGzsJJsUOVWSzv6/FNiO6GIzHqlktB2XxiENJ48fq8vrTqPxoDWpr9odb
	nV037rxU/V5Rc0QXwO7OqjKM3fXcsROF3PvoYSpH2MJibP4ar5yehblogfvxzgaA
	iFnwI3mhe1o7rAxVF1eFPu+Judte59GOvz2jAo4fiN6eUijJKtMZ2zpViVNvLfq7
	RvQP2g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5khabr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:46:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb39de5c54so319822285a.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771328775; x=1771933575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCk9OpWnJfO2diGe6paKGh1+BeBt+jweQ3ZEQMMxtpg=;
        b=V6+bJaU5Map+jgYKfBhf8b352YER/QYTUyyWD2aHhwiBKpaucDZqWkjVxfF6l6qDSz
         dkSOly9zmiD+rPCnf7NOUkEBStWosWw3bZk1BNw5j3pXyDbj3dX1GUwlghCRfMy7b5sN
         2FK7WsjNTGaMQUvYmGo8xkCOTiQlXXsRA2uuXSk1Q9DjYngeSXz1+pYV3cIlGa5m2KP3
         Ak1Jt21Uh9O6YGpptewlZ37E86/5iMHArBGS3KFXWquNM+rzt4lkc1Vzml1LQb5I3pve
         MafNq2NFks/xb/M5cVtXmgU77EWuhiA4JU903nuddtGlGW5ixuUE5vjZQSnSrQ1NbZkP
         Q9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328775; x=1771933575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCk9OpWnJfO2diGe6paKGh1+BeBt+jweQ3ZEQMMxtpg=;
        b=OAT2I05plvMhUtDcxm5UfEoMLVw5eMmjpcYRPkSwSij09qEQrRdp9KWfcGeFZDuW4n
         P5N+310jgXk58GU8O4tmeWfoWISvMN8S2J/a5YlwKauRHrfeg5GxxchA+XP1u3NZ+4Mk
         LevKGcQI8YfkQPSsXQVVAVS+p0S4z1Pn+Ztoa8t6aKDK4W6fTS3JRxPZZ3SfK0Zv1mT0
         WrdRQWTIETQHOhu/A/yuk578jsEkg+VY5tkMTwOFKLnBzQu3tdMq3j9Q3Lg0N+NH4FyS
         T+yax/csclM+mpI7Xbmq0BlO9lZ9jWOl17g3c0ozxnAgQaJ4sidsTYQnvGYKPSr/3+QQ
         5oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNXM/tc5/4AvUhyC72hzZN8+L7P32V4q9loF5huJc7NkELLofRIKnldxULKpaZG6hheFQPJGol1Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hnP2qTY86nZE4cXSHgQYwSCdpF9sOOHYvnt4yxt0AQ0hcc7E
	ZjZHj8jJNflNo0j8fT1dwHktLZIVsxvJbxQGwXq7j9tVZ/d2xXpr53pmzG36iHsfE6b9E5LYAy+
	SVQD8GuPgZEz1RLcu+3pVMkVI7I8vB8bFFhK6CxifTNMbJQMAanYprIsTDq2mLto=
X-Gm-Gg: AZuq6aIY9VZU5KTMg+hRUoq+J5TmYMvZ1s7OFod70JKeduDEDyYFTW0jVT0V4lCqzYs
	3ZZR0EtjySNuKuUgybxANpI1rwT9pLH/2fVH0rciRyoZy7a6JbNj5SWGn/ya5jWRwpaQHa4NjHW
	iNqmJKg9Hnozpuh+mBYuQKA+UBGhu8FJbrU/jwo/ADc/w7J7ZXbcEwjqLkM/1SwzJMqdH26ZsLG
	N/mqk9bHIVEsmgSkJFtSM+NaVYZO8GaUWfy24iu8OyXJIDtvvD8aL5rGJyuSXvbx6dx9utuEX9m
	6CwKAss5/58P4j2SLjlAB/7s0+61Jeav+VPccMf1kltebgeazBIl/VbeFzQ3Qdw7vUoUOjF69uO
	ChztmsNvllvxiCRGqplmzscZg0mn+U3YregiaFj+6tdVjGrnGtkFzXbmnxCTgK7r7xfZVdl3zcU
	1NKbk=
X-Received: by 2002:a05:620a:454f:b0:8ca:2e7:56c5 with SMTP id af79cd13be357-8cb40916695mr1244230785a.11.1771328774813;
        Tue, 17 Feb 2026 03:46:14 -0800 (PST)
X-Received: by 2002:a05:620a:454f:b0:8ca:2e7:56c5 with SMTP id af79cd13be357-8cb40916695mr1244228885a.11.1771328774294;
        Tue, 17 Feb 2026 03:46:14 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385f7asm351610766b.21.2026.02.17.03.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:46:13 -0800 (PST)
Message-ID: <3b9821b4-68df-4f2b-a384-912a2dc98bf7@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] i2c: qcom-geni: Store of_device_id data in
 driver private struct
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
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-13-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-13-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=69945508 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=pV_FUetQsCUf9QfKx1wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: PkzpFjKe0W3cGr3BBE2ifKw34i93xhQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5OCBTYWx0ZWRfX23gvaSBAoWJb
 Brb163ix8mN4f8lSKXJpIR3VAsKvJH14QoukkSKtlI3sThBorWwbp0d62acxgsWJCgQNzLuF5d6
 O1auixs0WFo/AjqUQWmEZJqJgJ+jRgC5g9C30gYZnWKkVIbFS4MhQsnZ5vKmxmgTctGI8e8lHpp
 fgntIfj/14k+9PVnTJ1SJzFIJ6GbN0sH8JPd/JntkWaqyGi55whWkqJOidIDqnzw3DljtCg93eE
 jvvj8aU8uu7O8jg+bK6gWWdvAwELjEJo+ZniS8F278keSDNL6dn5d0eO3ctMo74iKdEs2dsA346
 bNLzjMdXyNbwI2CVCcjQpdmt/ZRf8Da2mRwvSh7fVZFSFWbD8I4C6WVxJmWmAs/BXWBCuM+Vxmr
 YIkK9mF0m/rMXQXPAb4jSdDSfH9pnjy9gcGBHeWO91XNLw/aQNOolJuSZTZghOZAuDvhamZT9We
 WBlQx+NEEOlewEYXoTw==
X-Proofpoint-ORIG-GUID: PkzpFjKe0W3cGr3BBE2ifKw34i93xhQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170098

On 2/6/26 6:41 PM, Praveen Talari wrote:
> To avoid repeatedly fetching and checking platform data across various
> functions, store the struct of_device_id data directly in the i2c
> private structure. This change enhances code maintainability and reduces
> redundancy.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> -	desc = device_get_match_data(&pdev->dev);
> +	gi2c->dev_data = device_get_match_data(&pdev->dev);
> +	if (!gi2c->dev_data)
> +		return -EINVAL;

This is an improvement, but you still need this:

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ae609bdd2ec4..08e5a1917933 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -933,8 +933,8 @@ static const struct i2c_algorithm geni_i2c_algo = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id geni_i2c_acpi_match[] = {
-       { "QCOM0220"},
-       { "QCOM0411" },
+       { "QCOM0220", (kernel_ulong_t)&geni_i2c},
+       { "QCOM0411", (kernel_ulong_t)&geni_i2c },
        { }
 };
 MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);

for this check to not fail

Konrad
