Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7B41DDF1
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765947; cv=none; b=JFYDH87VHH3v01xrywRzYSG6zqYzKlYiybYuyxQTfQ3moe6bjdHLmGGdyfBoGnLesWpb2b7fTf+SEiWY8es/aJVrGCCPjh4NfSNCEEvMxK5Y7aDNfVRQSQG1gGZTzezhDdcM1y3HQSBNeWY2AydpGmPnfv1pw8Meh9yboMgb6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765947; c=relaxed/simple;
	bh=45G384sHb/muNeqlCokryNPXhln5CIbFxbacPGlagfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plpKraD+VClozJhx0MrrI7G7qXg6CbgjbJbxi1h1CyPIIfGfZ21WG1vGdH78LielyQDpfm4n8CfRSN9bJmrIkpIibAmS6YYdM6fMw+tlIe4VTkBu3vGJq5dYPpE4ASAXS/gD8k3Pxc0QA213tx94zD7D+xj4Au1FCgM1Hzm3sUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XH2Pv31A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLVwx1lo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XH2Pv31A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLVwx1lo"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877NNiR333055
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 07:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tse8UCFve8e+o+mmsY6iw6x2prwa5xpokEYT8L9AOhc=; b=XH2Pv31A0BcrwUNg
	iD2QZKkvWvkhY1Einw4iD2a6LSLoUku1j14bcUVQ9eVfkThzinmMCqR69LUw8gzR
	U1HFou/47WFx2Rv0pfJFV5eY6/UuZ7MQwUziRrDARaLrkGgC2ivvkw641BLMRIJN
	G9/wQPNrkEReJrml5/nWH2dY5116CdN1R23hF/LBeCYAJVApoiYsJqQBcu5jaBT/
	w0yaxUBTT1MykL7hngs+9VHgeRBY00zoNbWMcq4/bswB6vcrkWP/ml+r/gXnXYwU
	YUHmMUWF9q0Ftc81I1JT6Rk2PEwJodbvSROmbR7jq7RV707CuwPWFvOC+Ed6SiTN
	mW19LA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua82p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 07:25:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db050d469fso13470325ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788765859; x=1789370659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tse8UCFve8e+o+mmsY6iw6x2prwa5xpokEYT8L9AOhc=;
        b=cLVwx1lofadyfcO7l0wC27yr/UZThQLYZmslV5TmMGCFYeyh3BsNc39EET9TvSdx/W
         jdZZXBdbjunpZBBm8by6qED8zLJt2i2PpZnc5kPJRs8G+nvv20qxu0lXpnI6lWvUK3bM
         WMSbvWFm6xvH7oZ1rGYMwc/A22FbWl3StVNsXZKT3mKhO+aUkuOt7vH++5koYYEIqZm3
         bSxoBztwW+kVrX+u5gIVk329VTRu60BGzEwpc7IsQn2W4LeBgrxZVWi/Aq+DOZn7u1Y+
         u0dRBJ4AbGEvXBOgsBSuZqTEL4WpkrF4f+dq+kYhrJin/CiqsAJXWOf5cvDQoiQS5YpL
         5EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765859; x=1789370659;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tse8UCFve8e+o+mmsY6iw6x2prwa5xpokEYT8L9AOhc=;
        b=irtBX4AYzG5iHOd0Uz5RQcJ9jsVbnMkfUaLIMTvOxA1ZfeLYbrM6u6hPA027i6WN4U
         nq0LPDNzboPCv3s9nWmdu4uiRLMTK0NUeBadegrLqPc/r8tKVlA9VW9nQ5QuMSxIG5Rt
         nfj76ehIM7SZaTNHLe9bvbXXB72zQmFjtouFevuC/wP/ON2ZWXfpI8BcIr8JcVA0LwAx
         LYuOS5qcG5QI7HEZ6qPTEwgvJ6/VVzmA1/mk4gke2+tOdNC5PiSP0c8N1UX8ErObsTAl
         fzupHTP5a62FTNoxv2BMN/m/xFLPPp+VffZdp1ocafpeGyLY+d0EcJ7FS2THFKXHOyDX
         yEfw==
X-Forwarded-Encrypted: i=1; AKwUvByV9Bks4D9Oet2K7qQO52OexCzszTdJxgYDzykhL2A8GvD5Z2NBNODXN7eCg5amPliadHEm068o9Fc=@vger.kernel.org
X-Gm-Message-State: AFuF++mzWSkkX/Hb91AA2NbWHW4ay3KFAkjgWE5cPQ2Ye0N9r2/rASkv
	WalyV8xcAOofgmnWoIGa8uQb7e3zVQ/ZFKEC9q1/bJlgGEuTj/QeOIzG16AoxEDORwUzYXE4kYU
	ADk9c5sg5rRD5Ir1E4e5iLLkyi7x5JB6eHua7wCUzXmZsbsEAR66sC64wDYywHFs=
X-Gm-Gg: AYBFou0j8tQYIf07EUUOQlbdsjVHWFFvgwx0pV0bPQL6ou0R9zbJVuPt51/0ZW1kS+p
	UVyYat3Pm9uRx6Z2dDU+xuA+plzU0F82M9+N04iNcbfl0Emxdjkkni2JLKCYkiyM/bTaRg+EFh2
	qiiBHo429h6MUKEtrnH2s7nvXNBssnnIrIQAvUjVpiWaIbVxgSDkzKQogHdEfzl3k79UN9uY2N/
	QhY8hh0Q4LtgL+UZYGRaGMmikqxCY0uQMxuskFBTfukG7TYbgVnB068p0STB2g7475o5UZv6UlI
	X5ay1Z9bjRCpPBXKSVHz13JwJPQdkzLXaNWy+3cJJnHaraGbC7QXPNVYpy9X5GeNwtHBF3+r3QU
	nRmuPje9OO0bNFWGRc6SiFrdM2sraGBhDyw==
X-Received: by 2002:a17:903:37cc:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2dafaee6576mr219280265ad.1.1788765859212;
        Mon, 07 Sep 2026 00:24:19 -0700 (PDT)
X-Received: by 2002:a17:903:37cc:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2dafaee6576mr219279925ad.1.1788765858714;
        Mon, 07 Sep 2026 00:24:18 -0700 (PDT)
Received: from [10.217.219.15] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm23938529eec.18.2026.09.07.00.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 00:24:18 -0700 (PDT)
Message-ID: <e677e122-8653-4de6-844f-b7ca7154e3c0@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 12:54:14 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
 <20260827-master-v8-2-596bc81c5cf9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-master-v8-2-596bc81c5cf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Vm0cP2i7nYxAuwBHF6VmlYXtZOqkKM1_
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e66f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QSOts3N8JwC41gCs4uEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Vm0cP2i7nYxAuwBHF6VmlYXtZOqkKM1_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3OCBTYWx0ZWRfX5I7Z+mWYcvQ6
 KGfHW3rBo1BGgnYa7PgRJWYCG0vfIsjEQ1ba7cAtCbdpAOTDJL2U3eQtaMR765XzUcRpSR6pY0o
 842BIIBn7VoYD1ZumAY9iwcDDN8cx8A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3OCBTYWx0ZWRfX4KxeqF/DAVtL
 pneoa5u3Ey2Uf2CaNSviZBZ8pmvF47V0yVj0HKsjSNC+WDWbqwT9UeYLDc7PsdBbByGmxCKOo7X
 j7M7EpVL4i9OhkFjWb3evKHADm8Sd8NpSD1DRCIHPdlAmzPwpFNSTouLm3Vq5mpPO4YGeq01f0s
 PsAXqWebLI3Ls3QweWLiT+zKqpXmni7rOU3R6e6q0HtMLTpXUM8Zb0tkmYGlED87SRjqvV1oQzo
 lD7qEAiWpJI+zqN4fjl/1QqgmrmREhvCtL5NSrF5mjq9mgao2iWC9zsflCTFeOywwvkNpu/7Xfr
 BZU+BdylMsqPDdzQ67LPcgwT1HDVFL0aalS9UKAtQHC2WTbA8SQC3TGRJNHBlRf+K04AIuanzOE
 cQcLh0iALwGWt4LVS8I6zcCO6m/56+Ys0WWUk21A4BPKqT7m7nEV5Ov8SOq71wrbeS4fnwnxF70
 zvRy1KzTcywEooI8bQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070078



On 8/27/2026 5:57 PM, Aniket Randive wrote:
> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
> regardless of message length or bus frequency, causing unnecessary
> delays on error paths.
> 
> Use i2c_update_timeout() API to calculate transfer timeouts dynamically
> based on message length and bus frequency. update the timeout per message
> for FIFO, SE-DMA and GPI single descriptor transfers. For GPI multi
> descriptor transfers, calculate the timeout from the combined length of
> all messages, as completion is reported only after the entire batch has
> finished.
> 
> A 10x safety margin over the theoretical wire time is applied, with a
> 300ms floor to account for I2C clock stretching and other situations where
> a slave may keep SCL asserted for an extended period, including faulty
> devices holding the bus.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
