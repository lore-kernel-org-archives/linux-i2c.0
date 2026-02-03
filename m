Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A63446D1
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122534; cv=none; b=LbxiVmri5NdNIAB+ObQnJ1HFtsHVPG+Ir6ZwogQWLNfNhVamydS0q/zRSviJVK8CanlaV2LlKvZKgGD1A3e0RzA+80nOWWN37Tx5Oq/xQpPkog0rz2b15rLmlb+WD4Y/LsFFenYNdK8fHy3V+mRMAlBD7cl1ZcpjZN1thLIMYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122534; c=relaxed/simple;
	bh=mWf04EejGF7lxKeFxdD9niBwwAGB/bVCPVvzwJS3+1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns7/o/UXDndX72a1kWANF+26IKJJXzGU0/+uLVwkdh+piTcCcimQkCq4kweXytI/RtSJhVuvQkRC/boiwfP/A5Yjb8grzBUAPnEMuhgovwAmvSDEh9eK5uA6k6jw/KD9GPZK+0JSytQrCuErC0a5Jpyn8ejAlmPXA2raEr4Xzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTPoO+Ch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RpyqvMO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTPoO+Ch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpyqvMO+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6137PVOA1324956
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZvrkwQEXiEXdBgr35BOBP0tSrpKt1YrDMAKUpeIWUo=; b=DTPoO+ChJ8p2Nu8r
	tlfwiyV42JhzbcllKquQHBpxU7vf7q2WTjGWVoEMhQ0iccAgRw6GCPHovbLud23B
	t9dlAN0x+j+J7Y+NO9P6DwYrCOTeBd125K7A6oYKwe9p+ebkNO+MBWwycD7V7kGc
	32ncM02k48a99S3Rbjohv8zm74wYexJF7DC6XqETwxVQ4T+KQrHnfiLa0y527VlN
	FpauiFs5nFoLhGwXoWEQETtqIuq8XDeREurRpKJ9OLhzJcaeM6XiEbWifl+W64Yx
	CVKkDQMvFzMJ9IYXgHh+iopmnA3dBphXtwJ8WsozwM3/hyV3vahKdG/ZnN6qD4U5
	qk1Zcw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3cm70xd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:42:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88887682068so17467486d6.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770122531; x=1770727331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZvrkwQEXiEXdBgr35BOBP0tSrpKt1YrDMAKUpeIWUo=;
        b=RpyqvMO+c6e0YuyHLW01ipSGAZkDs7qT3ysdWHRv7F8O8RxdyNA9JrNXACH28qNnwH
         eQfWY6TDPP8FAR7ScVQExZz5l4lqJFaGRIgSJJAN7VH3U8VBk0nESxJhKGfqHAR26U+i
         fR7EGXQlR67x2fElTwv7FU1S9wtxefdUXyaETwB1iVbpV7CRzrGNPRiwk3K2Nysa71ZA
         LNjBxuabBda95ChveBMgDJ9hxKIGtMcsyy5h2qxvJkNsTpRx3jKVNTX5hgcNIzK7Zc2z
         u4oMnweWvJ72iaiuEh9/zBcoW0KOQO9h6B0IW3xB1nlGVsENFZY1zYpAsVL5mkmxxZAq
         PyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122531; x=1770727331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZvrkwQEXiEXdBgr35BOBP0tSrpKt1YrDMAKUpeIWUo=;
        b=Nh9aSKWuWZTfioW1nLeUuyMK2/gHlYyX3OPyiGi/RIFgk9rePmbxCqt6JcXXjrk+tg
         kAclgYEXkBzCwD8g+o8je9SScxKR3PyPJ7+Lk2Ry4b85NvB89j9JgG5YLQkCrHGASbws
         jOlhkqxkM3uPBAM8i0i5PzNs44itsZpINXpXVcTLcn6KNu1AYukTKsNFcqmE7pnswkhH
         i9YuXzoB+mi/UVi/gWslWIRDUStAC6pqqkUJDGU8pjEzZlDxIbje02sYjVC2RCkwI8wb
         CwcFzYKQzFoPoEgPeF0xq+ObMRodwLGDS2rTt3COAYjahuBTldylBtcWYPr4J2kioshN
         mzxA==
X-Forwarded-Encrypted: i=1; AJvYcCUwdXjWWJu2NRvBJmZlepjt9D9sMIMm6u5RrwnqRWpN3W2IXJcyR+vR2tSdOHYaOlrzLdmRi8eGD/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/KTgd40UilgzaRB5eQjGpYF9puogLWhKipgh9pO/jzegtGG3
	ZbviWYJkKX8cPrIiMHRx32YjWi7t3+3bWnlMSpz6H9qyOI3FqEEUs0kGVTCdl0h3cneDJ1O+aFU
	PLRQpXhQKnN6KTfKuNyPszIHIm2/N1G6wiM5ial3wJTOv9A63VPyx5Q9NkpKmJa8=
X-Gm-Gg: AZuq6aKTS6/0MNfJdOu83gvNKiYGLyAG+ayvTN8/Pcl0f7KHZIR7et6kOdFNCM+GeHf
	JW6KQ9j3H7nGo8r2iLYYyqTKEh5g561zz5Gh5p4p2ebFLoDY6/fF9pzD1RKuXWYU/E8984dYxir
	54OLPU2Eosj/H1LgmBW1V1YVTslPHvBhGeh9q8xPD4nPTLS6liMEW7uYjWM29uw7kzmErme7Oi8
	4kFJhbmIBZysfuK8S5NDIIrGQJaGdlWelvyujN+ybNTeOeky5AQOhr2lQIJH+NY2IP5wdd3URff
	vWA+AcLcQhsbKSdmb/9QhwpcJuFNxW4O37oYXYdkQRqICn9/wk7fbReggz94z77h+NeldSUj/04
	sUopq3tsl7zix/10UgCJWgxDkjsJbZistkvDpcuM2UeWKWdAoFmgUDCSyjX8or792cxY=
X-Received: by 2002:a05:620a:28d0:b0:8c7:1af8:4ea0 with SMTP id af79cd13be357-8c9eb2ecf59mr1438350485a.6.1770122531256;
        Tue, 03 Feb 2026 04:42:11 -0800 (PST)
X-Received: by 2002:a05:620a:28d0:b0:8c7:1af8:4ea0 with SMTP id af79cd13be357-8c9eb2ecf59mr1438345585a.6.1770122530750;
        Tue, 03 Feb 2026 04:42:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1baa42sm1039773666b.46.2026.02.03.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:42:10 -0800 (PST)
Message-ID: <a0b505e2-cc0f-43e4-879c-88451114bccb@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] i2c: qcom-geni: Isolate serial engine setup
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-10-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-10-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEwMSBTYWx0ZWRfXxyuaDNeRuyN0
 E8Hz4g6iQxx84U9gMvuDBXtfRyBGn9rWhQuyd5m0Hq/ffS+VqqGOQ8zw4Wz3cZzxxTjsyLXiSFp
 uvgiTMU7cCOEuvRHqxvvQ1+qQNXSjy/yZQbx8QDX3wea3prnRvXjRP8RV39S40baT+x29c+i3nd
 q94DFNG5IN7IGeYZ7GdGsNRDyoe/bgA/5f3HJegAtIO7dfnaZQzC+wYQHjlzMH+8qVESXXOmIVd
 6B0qI34nI4lxttxD9MTc0O3zTg7hEX8ay3AG33Gh71k6VyB0ByHsTIHz88AyVXkHPsZtVVAUEXr
 jTriUi2cT37cPcW87Ee1UFLfZ+DnqOC7j5CfNOXJE4z3IY/vc+VJ8zwxxsb1+DwtL8MtLqWEunz
 CnE5CMbYu1NH0F4gdUoknCxKBKFX/kmLvg9hk8O/aI3tQBoA1IXECJiwJzkldJPuUdlBe6VENbz
 UArw3k+6kYPrWdfE/iQ==
X-Proofpoint-ORIG-GUID: 4NVssYpFXyhSuBnsnjrUxOw9azdC9yfs
X-Authority-Analysis: v=2.4 cv=L4sQguT8 c=1 sm=1 tr=0 ts=6981ed23 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3uQcbjdxft5aBLpoArUA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 4NVssYpFXyhSuBnsnjrUxOw9azdC9yfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030101

On 2/2/26 7:09 PM, Praveen Talari wrote:
> Moving the serial engine setup to geni_i2c_init() API for a cleaner
> probe function and utilizes the PM runtime API to control resources
> instead of direct clock-related APIs for better resource management.
> 
> Enables reusability of the serial engine initialization like
> hibernation and deep sleep features where hardware context is lost.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
