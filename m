Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056035F8C9
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159203; cv=none; b=dk1gNF8Oq3pihoP3WnTuwOBIySczAoxhEGMS/4LjQ68x8J7Mmy4EJIWmSLkhCoPiGjeDoYQd5tJlD9S3KzXkq3TqxX3UuQU1PQbZb843jqYNt0BUo0AuW1jPbWJWwCel+wF67j/MfNFjUqya//Paf3IJOza8SJRPga0MFeMMouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159203; c=relaxed/simple;
	bh=c0gfVdcZBAPqDm2J1nmV+XKKzpQFZJuvmQtQzLGbkwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HefudlqJtgiUeH9QIlMSFbbQf5JGPXi4jbo1cbqZt7tueEOptmo3+2NIfvghn0ZVne1hhAJUyczvl7sI2YWs8mzoImEe/hWwskJY/5VyHd7Wh290LMrqt+a7PotS3GgGpojocXGI3WSbtmXyB6UR4JIMvTBn9KOBe6xMOpuGs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQlzsFro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lgn79cCj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQlzsFro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lgn79cCj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GUmg3846408
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 06:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aw+cER8RUt0S3hhQ6zDmBZRatlG33rHLOaT31tiADIM=; b=VQlzsFrotTXgp53k
	631FHHcQmxxbNfGdK2AUVkZYXhC8KMi1lQ16hXicAlDZpeVAoII6AbzSIVmu2l66
	bF1bWKcJdgyfyW8LS+OC247mvY3MYcvPhkxEVQCuiS02lHv18EsVahPBRVhn/f8N
	x0VcW9WAnOxhlIw65mCYGdIKhPYywHgnXkjWXrKobwvCTOIr1u2iPmRI5s3MauXH
	6RsCbNSDRjiA+zjz7wzwh8C7iz+atF5jy3s5/+eGDlcS8cYQlj5MuBYApG72vFs4
	sc1wC+3/yXb08cefiehufn2Em/b5zRtqstiibzPbCXU3t12lI+ctT9Tc5YCf/8kC
	KfXbeA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1y5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 06:26:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304df51ff3eso8663327eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781159199; x=1781763999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aw+cER8RUt0S3hhQ6zDmBZRatlG33rHLOaT31tiADIM=;
        b=Lgn79cCjzZpWXM1lh4MfGZ0ZWnmGMLNtQeRPTsO4vtiV0MvU5QP77FkLa4+J2Bnm3T
         f5RbwoDG/KnXepusDD7yspC8OlIWz1Ci+kKkgKsiBRrz4LwGpCp+qPX2S3ZMvPlgzgbv
         Yi5vlZeWdpXRhgkiWGUvFnHoXloLWaCa2rMbuOfw+jr/7gSWFHp2VCzOfETOZbR7RGh2
         yJeWjTnxn6Nd94q7vLnIY8YocFXoiWIaGJoUfR2LFEblAlGp8C40ED/Mr0nr0L3DgF+8
         vTD7zKoyoVdV/BF5K5iucL/s/K+GAzg9J7+jg5SfIXgvV9Uuk3wXR16pAMnqN/8FvqrW
         W/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159199; x=1781763999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw+cER8RUt0S3hhQ6zDmBZRatlG33rHLOaT31tiADIM=;
        b=ZpmbZeR86E5J4IFyB8oYETjXAxsGckbCgjZUS0SpcZzXZYpAaIlOcS5iUysBix3KC5
         OqrR9vM1y9Hit8Kb0YWzWPRdnBixqzD2iJPyUz893U8uyFzcoHFcfoGzaSoFQdQpKOf2
         hO6RPjTWbe6PYoNFwzk/7JTqS5PWqaYCL4R6ZTreLmBbCFKzuDrpDcu3Xfs4yBIdo8O8
         sJcFgwGY8uPanV2kHMhoCwlMfgVoOX58etE4TFkIm1wtrcdrvydQobVFUHgRJlooUzxw
         p9zA4hi9TpVm3RofT/dbdCn7HoJ20GeUMHOe55E7P8HfVxqBFgxiI5SUOR1SFB75Nwkq
         HMXA==
X-Forwarded-Encrypted: i=1; AFNElJ9eqZHK5ejO6HKR/OpmdTx1tSOM9QjEm92jfBwqWPbDwX85xnqAZU6buiBEzDUWnZta21WA4V0VqZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/fMwKKK2FdUZGNMJcb1ws7fjvI/+4cKWUj17LZmQ//2EImTV
	N/+DSbHA6isDXHBZZEz+hgrqvHk8iPzunqKQNU/p9nvwg3QBQvUDFosRJLU6i1cNpTOzSHhiD8y
	YgGZ/BMgzXpRqxwvokONXrmLAsynK1LpfaxZCdU9kVSwLmkYNXS3Po7PPgfRrjww=
X-Gm-Gg: Acq92OHHp/XrsKIUgVJhfwFOjqCNzNwjyzI9gMttR4eDviFzECYjFmWvf+mfSXSikjC
	ajDyMajjT0DGBMndT8Zl1RdnwL6IYzFvaAUZKOyl+hkxU3ejdwiDgoidK9nKruOgiQPYfeLYhUZ
	iOiDmXhR9m5EzZGd5GEyg1aURix+EaOqT2IG9nRdcuv/jPskJ/kMcjuAumbLJijOCJ3h3JEVuKl
	PP292eus0S2hxhxx4fELRd/0ARE+9UFUvS+yH6bVztZbpfgKeAbyYyFrI86jqa+nU28IK2waT1c
	jhO5+dkoRbeBIUQvxVnRLkl7sny8JCeOaJ04iUtusGu32NW94ygii/cE9t/GQzGrrjL7KORtwXM
	ZJfWlQQ0urcbG6XyweSRU+wbxRR72KU+V87FtRRD4zE2jsqQt6xhHgeY8PzpMXo0=
X-Received: by 2002:a05:7022:128c:b0:137:64ad:a62e with SMTP id a92af1059eb24-13842400ef8mr899974c88.30.1781159199339;
        Wed, 10 Jun 2026 23:26:39 -0700 (PDT)
X-Received: by 2002:a05:7022:128c:b0:137:64ad:a62e with SMTP id a92af1059eb24-13842400ef8mr899942c88.30.1781159198714;
        Wed, 10 Jun 2026 23:26:38 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.107.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13842fa5f9asm919602c88.8.2026.06.10.23.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 23:26:38 -0700 (PDT)
Message-ID: <5a3aeed3-a141-4691-a8f0-fea03aaf59a3@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 11:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Enable I2C on SA8255p Qualcomm platforms
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <ahEObi9ubGaTEcwK@baldur>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ahEObi9ubGaTEcwK@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a5520 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=uEP1mZ4tISDvfoPjOx4BnA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uETz73-oS2rKXqHautkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 3tq_TePFXNZ7LaU3NoHQ5kA3vSkDTued
X-Proofpoint-GUID: 3tq_TePFXNZ7LaU3NoHQ5kA3vSkDTued
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MSBTYWx0ZWRfX6Sk/QzZC+uD0
 xUns5n1W43RvBJfqHjtWclkVy/tC5lEHP1nry58uGetTnTKd6Pawru6D5cn6I6S2kZIjWZHEU10
 Ywskp8zxS979FFQCVEDAH7GyuxOaklwIFq5PqQ50biPpnBsbho/ciB4i8Le1jsWGPWjmLAOHMNU
 PY77Y9TrFpoW5n8CUjUd20M8TZyD9X2VQAelomMnED5KZDV+qcVa56Ic2SgWfmtQF5rgA2bEBwX
 y8HrqtVYb6UeS+nbTD1x+Scao5t2BonW6/7LXXqmvSvEdSsFRsS88e5TCnyiCAtD1xiNw/XLims
 inUWM71FuDcVaJpXITzv+BCSGxHI2tY2xYZVNhLZ9pW+KEPwa0zCqUychkwkFP4tznxt7+veC40
 64dqa9tehslWqmk1m4yJyUlGXni+No4x86EODiquCv3nPtiv+lte74NXlfDQ40+wkM+f7Xh2sI5
 J2poeYWCM/Xa9/lOQuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MSBTYWx0ZWRfX0yt/QJ1yLMz6
 84u67ZVJpHXFUbaDVJCbeCZCEbDMf6Qb03KNBLWvW19U9W9qR0CW7e+oH0uOLQGwf/bDQfODKch
 sIy8RCN7hUS9uWIL+LclgRrtmuZ7RW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110061

Hi Andi.

On 23-05-2026 07:49, Bjorn Andersson wrote:
> On Fri, Feb 27, 2026 at 11:45:31AM +0530, Praveen Talari wrote:
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM.
>> The driver requests resources operations over SCMI using power
>> and performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power states(on/off).
>>
>> The SCMI performance protocol manages I2C frequency, with each
>> frequency rate represented by a performance level. The driver uses
>> geni_se_set_perf_opp() API to request the desired frequency rate..
>>
>> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
>> is obtained using dev_pm_opp_find_freq_floor() and the performance
>> level is set using dev_pm_opp_set_opp().
>>
> @Andi, I've merged the soc-patches through an immutable branch into the
> qcom-tree for 7.2, please find this at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260227061544.1785978-1-praveen.talari@oss.qualcomm.com
>
> Regards,
> Bjorn
@Andi
I hope these I2C patches can be picked up now.

Feedback is welcome if anything further is needed.


Thanks,

Praveen Talari

>
>> Praveen Talari (13):
>>    soc: qcom: geni-se: Refactor geni_icc_get() and make qup-memory ICC
>>      path optional
>>    soc: qcom: geni-se: Add geni_icc_set_bw_ab() function
>>    soc: qcom: geni-se: Introduce helper API for resource initialization
>>    soc: qcom: geni-se: Handle core clk in geni_se_clks_off() and
>>      geni_se_clks_on()
>>    soc: qcom: geni-se: Add resources activation/deactivation helpers
>>    soc: qcom: geni-se: Introduce helper API for attaching power domains
>>    soc: qcom: geni-se: Introduce helper APIs for performance control
>>    dt-bindings: i2c: Describe SA8255p
>>    i2c: qcom-geni: Isolate serial engine setup
>>    i2c: qcom-geni: Move resource initialization to separate function
>>    i2c: qcom-geni: Use resources helper APIs in runtime PM functions
>>    i2c: qcom-geni: Store of_device_id data in driver private struct
>>    i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
>> ---
>> v3->v4
>> - Added a new patch(4/13) to handle core clk as part of
>>    geni_se_clks_off/on().
>>
>>   .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   |  64 ++++
>>   drivers/i2c/busses/i2c-qcom-geni.c            | 324 +++++++++---------
>>   drivers/soc/qcom/qcom-geni-se.c               | 270 ++++++++++++++-
>>   include/linux/soc/qcom/geni-se.h              |  19 +
>>   4 files changed, 491 insertions(+), 186 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
>>
>>
>> base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
>> -- 
>> 2.34.1
>>
