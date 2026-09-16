Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51A3B7B70
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547800; cv=none; b=T53x5/tU8DjPyiOFDpVk5XmvtWbxj43eG4+McTj5nmVtgg7tfZ8TC0hND20APSnEcsCHCf6Liz12mHRh3Sg1Ey9pSIu3EEmHqnTC//lUsV+3jHvYNEyh4hyYkylMn3Oosb8rzpdbp7tNP07UTZykkuxP9koWurceyQ5wuI3oqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547800; c=relaxed/simple;
	bh=lIEZs0GXeegRirjBJiyGpN1Dtj48BN3h/g0mb2XBdw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwUGEEhYOGD+mS/2rCysulWfucBwNttuXwGms+41o2HbDe4tEiv2B0exE2kjHW4T01fdGgHcYuvFzOJrbCEq0TWYjZ1P4dATJ/iqjY94GUSlq61pGZsQ/mEmuRot8SSk/7qPmA79qTFGzRf9I86nQFhl3nEU6CIp0MO5Mqt+fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+dKOipo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/gxnlOi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+dKOipo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/gxnlOi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G693vr1333414
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 08:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=; b=Y+dKOipo864fhB8M
	jm8ERbC7LkWwAXIklZ5bccaAx0rX7KJTIN/zZFgvneDnjhAJw4PGDqKGw5y5XzYD
	+89Ozsa3nhsdhaPLTMyvx5W3m8PUq0QtI7AU3q0et+vEqw/5MeJ93um2mRNvK4p0
	sL8TrYfxXZ3Oj4GjNonBQmSK6hkcUXGZ0Ewxqiu5LZ9QWCpQkS84isarrgvcRk5U
	mmWsWZ9Us/TNUdt27aQfz1mJ46p8JGvz3MeuYCqTdIiAfBFdS9m4xeV2ILx675Uo
	yJvZ43Iwi36uWcOCkXicLQUDQzwTOuy34fjOXmibqzXG8dwnGbB4lvX3U6K7qRyC
	/xYVnQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqbmnjw11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 08:36:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9392788b3f8so98723185a.2
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789547797; x=1790152597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=;
        b=a/gxnlOimezpNm7VGXcSBXgKkFZVxj2zv18yONN3t0D5dCj0mOgZEwlqdNHHAk1Ndu
         0yKQawqCc3FV8p3ky1AY99RqLByKmotpkw4FUik35adeE5feX2FdwzkMMNAJGof0VuUA
         lMtLiLAWRXKU/9SJFZdgXVhlxb9t9380UC3lI2WmCrFDNjEMGjAPQuIL4tfwnAthbgxf
         nVP6JQ9tTALJIgrOTyptLdnGFnuTGrLVh3C5YQBz2bhLHqJYuVeKC7MuiIascHUmFf0t
         yi+GnN5XRegWGNoyRNsxn7MLRU26fr2S8GaTf/OoyEJzQV4YPpaNHiVDsPAQYE2XRuTE
         KAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789547797; x=1790152597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z55uKb5eMnBqg/aAKyYCFAjbxpK+j/u+vm1xXas9DMM=;
        b=mefNx582ZXODDZm+WXVefP2myA446LPai0RftzWn/ftsBG4E4cyN7x6PjREmZYNesc
         0w9ZPBabUVaNaEu5IAWneiswfv8DQn2UfoSzzC+z6Ge3wdmJ60zrAIBPFSphQOS33qQY
         zwr1stiQNfftLDUofcHnM0mlgLIfeUalOfj94S7Ol2vJWBxtMxaUJfZFBtQx80tif/Es
         gexfbAdwPSabnsGVG7v+VML+kNVjmjZj8fGn+mlDMuw8Kfr1WAIgfSxCUX0c6VMqljYV
         K5usmkKCMsT85vICOK5+9yOr5V7Qj1tYJJ32U23dlfEClZws9W9ca9naGo9zJBFZO1Sq
         SH4A==
X-Gm-Message-State: AFuF++nu87hJmntUQ2d1Jd6KLwFQyxwwSlOGH7E+sK5EeiflDmw0ARg1
	A9h9M/B/LPvuZ+X/05R7Yl35hSAYHhM4pg7PnXMirrRjgzBARr96V+yVXxGhNDJwlNFDDCUwli+
	U7lDRS7afWb2xAuTTinb0ZaoGYKKaG3CKEPe4gHp0eAXl5rMo77G9X8K1ios/RFA=
X-Gm-Gg: AYBFou2qxHwHsPLkQyy503EiBEUIIVU8ZHsqWlwHJ7MI4jBS2wUt1OsO29TuJkurHJg
	HZbSrod7Ry+lEzuefVYcNBh4NoJVwnQrc9xItaoksmx3f+wi5j2vtclE45oShzlqfD6f965sKr6
	bHEL4W54x77Cv90Et6dIrun29MADlwyCHFcLNz61pYtL/h9uLxdPkGrgbmoayWR8hIESBzlqdE3
	MW64iU0j8CM/IxfY/BS4IDlZGIMikksk+8UmfN6ZUkatlEmBh+GDGc8IbCWMGA0jy2xSmaiOkKx
	FqCwdY+eLv2Z6DUn6vzuDlh0U8hjNkPdXCE6U4DLXJxTV7tTgkLfju5d32OpUDwHZMJ3IZnkCzM
	R9425hdz03FNaFsLZx5+KHA==
X-Received: by 2002:a05:6214:4884:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9123d90af10mr26229856d6.5.1789547796901;
        Wed, 16 Sep 2026 01:36:36 -0700 (PDT)
X-Received: by 2002:a05:6214:4884:b0:90e:9aba:f095 with SMTP id 6a1803df08f44-9123d90af10mr26229526d6.5.1789547796463;
        Wed, 16 Sep 2026 01:36:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48af2asm89705466b.26.2026.09.16.01.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 01:36:35 -0700 (PDT)
Message-ID: <7f812c3a-c933-4d43-98de-f4862bd042dd@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
To: Andi Shyti <andi.shyti@kernel.org>, Liu Zhenlong <dragonliu2018@gmail.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
 <20260818175750.4205-1-dragonliu2018@gmail.com>
 <aqpNxZvYu8pDCchC@zenone.zhora.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aqpNxZvYu8pDCchC@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POyaavqC c=1 sm=1 tr=0 ts=6aaa5515 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7-2GvdTY6LjJ1SSQjosA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfX5b2NnSWNL8Rx
 3ws5XijwdIMCzhXzV2x1WGT2Wku0XASG6j0zDymgGJoO9sGZAU5vvf70qG4evyD2G/JWhN3igsu
 T1iE37t4K+pSREHSe4bMzFpFKhzh2jubr6jPl9EH6Xa/DHMdLzngeE4iBZQ8Ge8vVlUNvASaWn1
 S5esuzE3nipGjJQXJ9WPGYcimlIewl9fNvPPF1Mw0mN7r4FFSjySeKVKJ4EeLelgwyuCRSSBhxq
 y7r5xAlRsga+jbbAhrQxJpLA4jUHXhXFohcvZcCiV2/16t7hV9Tt7a9MTjWdIxsP422yXV8uzmj
 yhmH1GWYxHlHtUUEoJlY7VWQOtOx57MOo3hQD+1+dCqmZkcHNCb7LpIeuRTVOJauHn/dHusE2b1
 jITHOHI8QN266EPM9vZaqEs3mY1UHdIJdRETR4Gf6SQVLP+8C78Njy3YNeL7Ok2gma7A66vssDj
 2+zH8IFduB6QfJa6nXA==
X-Proofpoint-GUID: wGyZzw56KYdOL5_4dBSNNFYAPlsniBJ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfXxnkEpRnVFpVl
 z7gSCtqMIJEXkISdt87pnIKIPfCsYeKgxgcDFq3kiHiu5m79DlOSMoYaFrFFcVSZC8D4xyiN90d
 g7PXJ8x6SIDl9npSbJgPZsD7w/aOK5E=
X-Proofpoint-ORIG-GUID: wGyZzw56KYdOL5_4dBSNNFYAPlsniBJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160111

On 9/16/26 10:06 AM, Andi Shyti wrote:
> Hi Liu,
> 
> On Wed, Aug 19, 2026 at 01:57:50AM +0800, Liu Zhenlong wrote:
>> The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
>> whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
>> making the put a no-op and leaking the node on every adapter removal
>> and error cleanup.
>>
>> Use a devm action: the pointer is captured at registration, out of
>> reach of that memset(), and devres runs the put once on probe failure
>> and detach, replacing the three manual of_node_put() calls.  The
>> setup loop uses the scoped iterator form so the child node is released
>> automatically if devm_add_action_or_reset() fails mid-loop.
>>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
> 
> pushed to i2c/i2c-fixes.
> 
> Please, next time don't send patches as --in-reply-to.
> 
> We should train LLM's not to take much freedom as to send the
> next versions in the same threads.

The process is well documented, but the LLMs don't really seem
to care about the current chain of:

README.md: 
  find "Who are you / * AI Coding Assistant"
  go to the "AI Coding Assistant" paragraph
  read the link to "Documentation/process/coding-assistants.rst"
coding-assistants.rst:
  read the links to process docs
  read the whole file

Might be because we have no AGENTS.md/CLAUDE.md which the tools
look at by default. But it's not guaranteed that it'd be a
panaceum either

Konrad
