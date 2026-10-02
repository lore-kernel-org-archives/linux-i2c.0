Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76248035A
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932747; cv=none; b=tvg9Uto/zlE55H9h++uVe0hQBvLI2lqcHqEF1x08t0cFlDT7RI2VMYGy1ogiNPblyNuP0teqU8G1NCDost9h05CbDg9i7HVtST+/dNGjOR6pe9CyGkiqmneTbHJWSDbss7KUBffkqDwSkPJsKS52N6qPg7EThmik3QCvX7ICBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932747; c=relaxed/simple;
	bh=CqCffG6nLjJm0TXOw/mVHtJVHYpp8tPhVcIO2taG2u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsB4AvkLrvNUwGEQtL8NRpbSyNYDHfsp1ELtifWlq6kN5nH3fNhDXC9qu9VCpi3LYOjmlH7aerUV3D79L1Prq+ih9asHutO+ArpcZ3pegULLR1xNhoil9gKjAg7+ozZIxgd7JTcFTC0fGcFHc7l1SYtuX7uu/CxXKZogv3jSIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0j+f1FX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cJl7QMnt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0j+f1FX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cJl7QMnt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925j66q658122
	for <linux-i2c@vger.kernel.org>; Fri, 2 Oct 2026 09:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NbN34DVOat7zldqP3Nj8SrEN
	D+/tgrzS2dBCq5LGZ2k=; b=D0j+f1FXy56bp0hlVMmayiDkwfVuniL/rqgn/1SR
	qPSBjbKmcnKqUELqpgAJ44HhuR/PMVRk6xsklaCpTHNip/y+KFLvHWAca8idiJXv
	3Av4zn00z4or8RD4uqVBwPo6HpGPjg3QaqqoOx1q8eqCzTmo1Z4BctBfd7ZkVrjT
	wd+FKpvu1NHBvWqGAclWccvSJrGIRxuYd0TjdXNoW35q+TfzyUW+90EbxjNVUVZE
	+SPwcwSVCRLSnl+qwX4Nhe4sjBN4mNXcuE1wcd6q0kutRMQxZPJWhPTJT9lB6bsT
	SaTu4CU4Qk6GfoWcOHfHM20TE1wRhqLcjXDR6Zq8hpTzBg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfspk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 09:19:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so401184585a.1
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790932743; x=1791537543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NbN34DVOat7zldqP3Nj8SrEND+/tgrzS2dBCq5LGZ2k=;
        b=cJl7QMntaKDkb1qh29hiT/h3B3Ukk7HjcBpe0OrCcA7ApWvvDxt/0xVm2rcfvKfNH1
         qno3NbMBdsaYRM0Vtg2SJQZb/05j/MqDD0v4ynptLL21ke1el7Wgx8g8LyWeeZ4ztxmn
         G1PR2SRgTJNHiPaybdJIp+OZq5m/fK9krNX+SBFWTdK4QeIsdPOQ8GGBnLYg0hbPyuq9
         kvNDAu0YBVZGWUGqlOfyH6p9K8VbpBZFmucOSZSVDH9Ynom0c2aaYjI1PzhIYtAi+WUI
         tZInwJTY15eoRVL13SrQ/KvzbpGyHOPrjj1gBg71zWgug8fK2XtW5StENEI6na76B1q2
         2Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932743; x=1791537543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbN34DVOat7zldqP3Nj8SrEND+/tgrzS2dBCq5LGZ2k=;
        b=YJ1wKG0VqLrQQU9PLv77u+OnSVszo0L2L+bi+uPOPpnOOTvzKQ7/jLNyxjLM2EpWEF
         7gZrThRTj1FkoGdZUpJNQP6SqGIfQUcYLVItkI8W1ulVkkqo8N1AIsEz5zGBldec5O8I
         3Q1iCaElbRhAZhLg0G700UmUxzhXCs55unfANOsmSsb8FxfwnBRBkWoWBjT4H7Qiz+m2
         vdsiWv5wIbhal1ISeRwAovLZRkCJxqTrfyYOREQYByluNIGgLtoWtekOKEtzJF178hRW
         DlbN9sL9GghLeIDS82i9kDKwxL9wnORAXYPDyKfbDZPP9totp/iWCg5osaXFs2S4Kmac
         18xA==
X-Forwarded-Encrypted: i=1; AKwUvBxJZtUdphmkswNewuXZ4SOrDKIXuuke9ZSr8p8aezUqMNrWLAS5ZCtBEVlxuCOEw3QlDFZuK8UZmHw=@vger.kernel.org
X-Gm-Message-State: AFuF++l2NBMwXV96l62zmppV0CnKwT4Kc9jT9O06t++hwb+iqjQxmOsV
	IROb1Bnr0QLTL23GuMu3JkDOe/RMI7b6XjpWjjktXPnt1AECJL3sBqREuUf7Rt82H/pLY3gTHCe
	u7tDk/Fpl6YV3FrO/UkyzjGo7928ne2xjahC7QFAawu9A6kFSCquwNN4hXlqpkLg=
X-Gm-Gg: AYBFou0yKhKzgQB8ahVgzjBsGLY+doUbgc3ddeus178PNgSKLqtLkE3jz8kaR/SsA0Z
	JmfKLUGsa8QNEQjILKsKP0zmfb0UyOmDmXtFZptOs6rUMKzyJPIi5DSDtRwRPpCtr5RF0BwL2f9
	tK80AjCetwCtpVPrA77wUGt9Kqy0Jsgsfnds6cm9ybLgorX4tDYZv8nzD/Z+8IMJBbhISorRw7K
	hDvdc41UvuphFqFAg9tqcwnFytgCjHGPAgPcVwkqm0t4u3uJktlQ9TMyGTLkWyOBlrjkKOWd8qz
	ra3clKB5nyX4tSA08deB0DgKSaCcWcK0zyHVkNCcR4HAlIse1+VPtaTF2VzdsGR4RPxoqYBQ9t8
	omKQfcH+CpYj7DOPW6LcEEYympg==
X-Received: by 2002:a05:620a:28cd:b0:93b:d79a:c45f with SMTP id af79cd13be357-93cf19d92f4mr331615085a.55.1790932743305;
        Fri, 02 Oct 2026 02:19:03 -0700 (PDT)
X-Received: by 2002:a05:620a:28cd:b0:93b:d79a:c45f with SMTP id af79cd13be357-93cf19d92f4mr331610885a.55.1790932742557;
        Fri, 02 Oct 2026 02:19:02 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f89c3sm3983582f8f.34.2026.10.02.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:19:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:19:00 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Subject: Re: [PATCH RFC 11/15] arm64: dts: qcom: maili: Add support for
 cambistmclkcc and camcc
Message-ID: <astvkiexa6ihrg3w7g5lhowvu5g2i37rxofmtlqejuozl3i4cu@34ej3ckphqwc>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-11-cbbb42e534ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-hawi-maili-camss-v1-11-cbbb42e534ef@oss.qualcomm.com>
X-Proofpoint-GUID: 7GWLOeveSPDECJhLidi8o_20rRDaOCUW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNyBTYWx0ZWRfX2h6liljf4Q0l
 eCOR435wSi4x0Ce3bg/h1Rlx9qgyIQ1gDFBarHoPwERXEzWRQ77fFGW8VKurN42T9OTMRfNuMhv
 bqyJBK/aJfllJKLdddTVIM2gb2ntkSo=
X-Proofpoint-ORIG-GUID: 7GWLOeveSPDECJhLidi8o_20rRDaOCUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNyBTYWx0ZWRfX5CXw0k8xcZTa
 V041AFr4mWySVH1Gq0GOiMMFFKeZtLaq6mZ6b9mU45qgT+zpjtvmFNcgzQNQT9q8lI7pM6sr93w
 pZ0LCFMThxCNpcXolf2g4w5YwNUApCVgSXFFCHBVxOx6RBDzz+wq803fDBM2VO5HDM0g/c0GhvP
 m8rw04M0GumnbmvYWtltbvjSW0BcBxn/PPt3boZ1TWhsgWiUL0aFHhSBDjz/+Hn2S5z0JkXbXvc
 phlajkr0T79VIasyV4So/SaD4KNylNv3mumWdrtUmahoJh+QQ4FdzGlTYxIsTZU9wlBNSIqJVwh
 yMnafh/fiAKv86iAk3rEwi6ZeKkcdMQqk7tyLyd0PsbwQUchQHrWdON9ulhZjE/sEURoQffmg3b
 YMfSBPk2xNZgkBSxlB/+GRHDTYXHqlisgVbAog+98ozNJ62AcvRVyF2yMYRx1/WqCZXCXZ3h0ua
 JsSZNlu/kx7Zih37rrA==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6abf7708 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=c8Nb2DwzlUeNwivyVygA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020037

On 26-09-23 16:32:42, Nihal Kumar Gupta wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add the device nodes for the cambistmclkcc and camcc on Qualcomm
> Maili SoC.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
