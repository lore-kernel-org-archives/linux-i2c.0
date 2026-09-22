Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4995304BA
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072127; cv=none; b=kK2JobezJdpn4Gzs8UDnW7GKIvLA+HEZFVA1JzqAtzDlKWrPbTV4tLW39+Vv1v1sOmRazfPy2uyJ+QuDToqjmuHTiExCgog5UiQktagbxZkdtZlCPnZOcYRUtoq6+W5pQ3r6PD2eVwu8ah49Fb+Pl/npsPs4GgYXlAnnolI6ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072127; c=relaxed/simple;
	bh=te1MmRG7Xxhf2ipJsVG0r0wfnHerGJXp1YCvt0VRkBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skb4Idxzaet1AVYLAld7MHT3hkkw1tG1rCBpoOa5i/oSotZy0JD2+Vql1JZc3zkTHgoY05VxSgvUMpXf5ubFDMT44JI808ppgxW1fnL8t5rphV8uqsjrfO15NihCKZGiEPAwcGKQNGrJx7fJ2QJd5dDEcZY3kpEFp0PpS6LE40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYFdvK+0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5/+UBUJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYFdvK+0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5/+UBUJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7pIi22173113
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 10:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y00J4GfX8E3zrLOCKjxjJS2m+kNaYhhwZAFzWHyLQnw=; b=AYFdvK+0jI4lcJYh
	OfI6w3dsgUDXNfnNwv8cFn1y0rfmHWJpwIXNWnqqodqJ4uxCXljFIxm/vFZ0p4F4
	tMYej+kSeGnipHQr/6AsRA2oqV5b8jfSO52Z1ohuHBDaiLRcp+DVR+i75K8hYD5G
	F/pO3mGErTxnuwCCaz0thxgY8uTP28Xx1zXyDim52c44A52wWhIOawOYfXhNLlTV
	ouoMFQNNFYv3YimUaoEa6o43F9Il+sFdbWVnWN03coDpWLAF4JcstFiUIjAjgb98
	TFKfconRdia9bfbBAStpzPQWqqrO7wdF9DS/SCxO/FDKEf9YKrGPR94cvDHczCSB
	2rL07A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsq9vwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 10:14:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so756227a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790072079; x=1790676879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y00J4GfX8E3zrLOCKjxjJS2m+kNaYhhwZAFzWHyLQnw=;
        b=V5/+UBUJ1iE/5dpwtOeCjvyrfhXFGuXz9RTj/AYeh6r8DGmquHbMYMUueIovlAUOqz
         u0b3Agfn28LM+8EXDJQ/3iCsgWRJDdA3Ra1sbWLEWoVM5ig7GE6P58dt6zq+CgCIBj8f
         +0Sy1zKg6nIGH/6ov0SNxYEWBoSqF7+OCOC6H4cS+S9EnJzDOXc9c1Ke4QBsonDFXrip
         k+VVDu7OBdct6VM21CVPE8Yo7GSiMZftZtoddooSOYYvvnchWA5bFDf68md0Rw+JuMoG
         BUiAzfqlkatCqqSddYR98KQAw7I5Mb88xByEbdH+vL8Fas6ntYR6phbDl1LFmB5rnVYq
         0HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790072079; x=1790676879;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y00J4GfX8E3zrLOCKjxjJS2m+kNaYhhwZAFzWHyLQnw=;
        b=eCsidn47P0oTkO5Qf3hzZg/VvhQymUiq0hGkInU0vzb+LpuOU27odwiBWiGKxZ822z
         WCiicxmFXJyodVFIQFzrgfIbcSgdVBYy42OuJIzjTkI0dbDYpd72jmTq/0cFEJwqmHAC
         /3t3vNuXw+29fQSP35gysln2q2teke853tI40qg8R3whPHEwCruCwOtrtN2rEHQYfY/g
         w6aH8NtQe1a9tdN2/UssPMqBGqwurw+O5uTqLQDsGZQsUWbOJjpikY7+N3fIBMhXBLvP
         1mdjUQFhZkFT+cVLzVTImx0x5s693jMyz0rgJmvAjUGPrPi3WEaEOaYiwE+s9A4b9+Rw
         v4tQ==
X-Gm-Message-State: AFuF++kv9zz3poEUBiYMEqTjuVACM65wePaJFgucx6GQ+jwrOOnSGbut
	UaDsZOSFDnOIg5G5j+MI9I/xM0QTL0grjSKjm43o+msothoXOIWPUClRhSzsO+VfKwmvQc9JqrM
	2kjhf19PbaPTVUG5komW46qFtnEXcsB+HXcmZFTkdjmIIqDd2GlGiVFpr6iVq2RU=
X-Gm-Gg: AYBFou073/Lz4AjQd09jtHmhNg3JCG+qpcIM4xuaw9oI+fAryJPW0PanlWYIgaPvaxH
	Uk2/vN2h4JYbki1dtkj1t4LzUJZgWTyoDcEo0J8eH57rCPbxRh3xrbUSQXvrfaU5/4QYyddupmp
	R+rffz4yEUqzZHfqvusBTpY4ifkSpNd34kuVB3HB7nJkAK5IsbNVfD0xz8wcC/S93PdkhS7MtCd
	JqE5mKomSAc7i2IVkkbJC3b3Y3d9KCYC1AXbW302bCvnbJTNC744kFp4hjFSA4jpGBANnK25Lma
	hfkYV27VsrMtA8Kylyjw0Vfds2rPcORUvH5BLsb+8dWK7tEJEQ7TFtgVepUHezKIRs8XmsoourX
	bArc/METnK12S5UKnhBdVpeRkbryCb5Zm
X-Received: by 2002:a17:90b:5787:b0:39e:5cc:717b with SMTP id 98e67ed59e1d1-3a07311b790mr584180a91.25.1790072079078;
        Tue, 22 Sep 2026 03:14:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5787:b0:39e:5cc:717b with SMTP id 98e67ed59e1d1-3a07311b790mr584157a91.25.1790072078555;
        Tue, 22 Sep 2026 03:14:38 -0700 (PDT)
Received: from [10.217.219.38] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6131506dsm4464341eec.25.2026.09.22.03.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 03:14:38 -0700 (PDT)
Message-ID: <30756100-d633-412d-be81-1078b7db49a6@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 15:44:34 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] i2c: qcom-geni: Use device_set_node() helper
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 16H8D-4MlM6Apcq4Dtc_ES-BKotsXM9j
X-Proofpoint-GUID: 16H8D-4MlM6Apcq4Dtc_ES-BKotsXM9j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0NyBTYWx0ZWRfXyqoG1c4URGXb
 byZlIRsg9c8c/7SI26t0DQ4O6eNQ+0wO4Sc3u2L4iXipNEipjVOXPKXQ/CNzhyusCYsQoZczI+G
 p5dZrGduGycFxchpSBesx8eq1NjSgb4=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2552b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=k_HDGeKfpP-0RDluWcAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0NyBTYWx0ZWRfX/WgXQq59iTYW
 glrHEZMNMlzShGPEdaFGxaWkBKK4GaFUV3Ruz4dBvDa8bQztZE6TBeqmu2+RZp8OLsMKm0HWRTR
 Y0Ex62FGvwx3c54MXZOS1cpTtYqasc1666J6Q0WyAbIEUM00+E+Iz4DQlm8+j2gUcgvyVB2t0Hc
 B2/Xf040FwSCEfkYBIVyO7P4m1kvy0FZdvvtIONeoCzWHubCiq6Y+syKXLlbVhYVIMzf/yKjlfo
 gJqnvAvPcbs/oL0E7JiaGCOLAfF/Krdyh9K1CgjAUb/H31MJgx5bYKbUmOHH0m3YUjnwRHR6WcR
 Y+Ty3ACexz8NihYhzNH4RFXrt/lNj2Qumr3yBT83ImvYMoM5gdmaB7qhL5zCltp+Z0Q/YQWkikm
 CB20pM3i6GUBtNjeY7xCKbBFonOyOikCUEDxWVSQVjmlxsoaUI5DheBIc40EUVX0LZ2r1f/rkjd
 KntHc8yaCZovSWJZ4PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220147



On 9/19/2026 7:44 PM, Hans de Goede wrote:
> Use the device_set_node() helper instead of manually setting
> adap.dev.of_node, this:
> 
> 1. Ensures that in if he parent has an of_node adap.dev.fwnode also
he => the, seems typo> gets set to point to the parent of_node, rather 
then leaving it NULL.
> 
> 2. Removes the need the specially handle the parent having an ACPI
The need to specially handle ?> fwnode, since the generic helpers take 
care of this too.
> 

May you can write crisp reason and benefit like a story instead of point 
1,2.


> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
