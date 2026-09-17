Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF64B7A26
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658967; cv=none; b=bmf8l+BtaBzk5Avnq87Id0+Ir4awfmOJ6Y2bv8xNH9vPlKN/5gc9GTbCLrppwlPzomrVVgfdQdAcM5UaWvAnzDfJsWKCrEf6+9oc04xwfczas+KStXiuae+5JxeTuNCUOhRM6fC9kNCu/ngzRoYKSKpCrgtwUqCxfRi60KiTrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658967; c=relaxed/simple;
	bh=TlMRqQ6L0+W+LjZ003OtT0C1xwK4kdjOBRFHg4mzq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfwOArKQ3YdRFh7+RfoFoQfWFw0JzaIgiQpySi8JA2xh8+GvRTLiNxKhzc7IQ02x/ntKxRS9uaQVUUFYks6Dv/pRqoejls/+Gd0VCCT5i/44RmSYLBvm4EPf7ejO+HcWk7bvNGsa+s2WIHUpYJkYVqAyp8i25lYUnKtuU3zkaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okrG+hUE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPY2Gki1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okrG+hUE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPY2Gki1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDkQu71956155
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hk36GFpcKUAtTar/b083caQq
	YINIKpMqKrsbZbYUlBk=; b=okrG+hUEVUELGSxU2Q7Gy0F0NIDgLQdkasDpPTPv
	/5PrsfZv/no8tWk5cA81d56Ckf4IbRnjg+JBwaoOh3O+F6y/mqo5KfTIy/kNx/WN
	nUPfkg/cYuaZCQdbwrEdX/6Rc9/stSWbyrGgRC1ISGIvVgYmNlMLdWLUrkSYDZ3j
	eucRk4qbpco0a4yP9IYtDVMfcV9RpS35k8kDsTsnjdcdUGQHp9LU0Zn0KQifjvbj
	gS1zx9+IKGpbZY4H07Q3qdKaO/nsYdQz7pOIw04TZSv/Y4MM1jBgrXet/aBs14wC
	rgKjZL7TLostWY87EuGbPRj8/AV/9oIlshc3blyAkcE9Vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5gqm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:29:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so178198885a.0
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789658959; x=1790263759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hk36GFpcKUAtTar/b083caQqYINIKpMqKrsbZbYUlBk=;
        b=gPY2Gki1IqwIN7lJcbyQFuHOHZDMJDzjXH0gao01KFLnoxzcdn+uItHbkEB1AzpjLE
         HH64NQKX5fi5kWRA7Ao/QqDKl53OhrWKodN/Z2azWtuXiJWhF2jyihXjSw/XJoVGdTFG
         nq3RVptG9CLlYIN1iVXxWIuo0SJBG+nDzIv1bm00pBFvIkw51UfX5lHAC2UYrWLGR0YO
         uxemFZntJqk1a2lAlxOC4cvnoLgbyBqCjbPjH+bKixf27spj0pgJzubEww7wfPjGIoW4
         ZteSBxbYwo5q1kmKGrNxXxteyuRimbL+utu80Upi0n9/I51PgB86NY29TNFKWv6oWGBN
         QTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658959; x=1790263759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hk36GFpcKUAtTar/b083caQqYINIKpMqKrsbZbYUlBk=;
        b=KRzOflUyRxUsmlqKbSeA77GTUI2F8QGh415Cu5Gj5RTe65jWGy+MqX78Mo3xFesCnp
         YJlmHfqECgr0CFhIXwNopyjSgL0xMPxx+QLQFHpv4WWCwmlrNtBVcQRcgIwf8NSiwBMW
         q5+e4hsOG3V5NN+6E4FRHkgSIF85dtxPr6767m/O39cgesFi/fuGwNmeN65ZXBDBCeD/
         it7a+cC7BMft/UWGyI2PF3CpdCFvmIPhI8hXyEbCfgUsDpa0CY0J78a0u3gA026ug8vR
         M8+q7NJDx6/FRCejX2eIHL+PZXoiF1Q64z6LPZcp/yhGxvGA1dRLk3hOUVGkFAY/KJlo
         vdGA==
X-Forwarded-Encrypted: i=1; AKwUvBw5yeyLKJV1Ln6m01Ydo8p11IcIenSM+9qSKjevwJ8o/az6ILDtT5m9B1LtzFO69ErcyW2xMUBsBTU=@vger.kernel.org
X-Gm-Message-State: AFuF++n24ovZizNyuthkOhKQoW6mGKleXNQ012eUbVyALO9DDyipIaLW
	H5Pld+OVSOjiBsSrhF6g++LT7uRDWbGLYCYBzlkjXVqyA0v41tfIgZnBmnk+Ue0qDAvgSZGz8Sk
	CHitFMHQtyoXPJEYqwuFlshjiKopGzovFn9e6Mst9WJyWVwyQOTvNpU4ABN6VwGg=
X-Gm-Gg: AYBFou1xu6CFVwSvU8CBImb0Jjcj+cGArHXrepvbULy0Nx6W3wQHzG2x9pSBRfZCM2s
	bxW9LpDTQ9VcOxgnT9DplRABFzDFV1EBFfBaWbmfkOQ3aBhiivCUjmU1CsyBdSfPqP1/p0Ba0qh
	I2SmmH2bLnYLx3dhSguubqyvI5Ty34tIdu5Vam13oGjrJpkqzN4/vJ/RKmYRTEU5kue2Hk343TQ
	uQbvpZjor0Z4woPn04PAkSpclBtRrhcfZ1k/wEMGZgnQiSulalTVaiZSv9C5Wms5GQeytbGHe0+
	hxLtiBwky1K+Uqb5qfwIiJTNZ7vgwY/OIXbPZaWrl4e0sSkih1Cku+gVM0iRQE6P4lD0wfeE1X6
	3pSEgKX73SMtaDA==
X-Received: by 2002:a05:620a:4592:b0:939:31b5:4e08 with SMTP id af79cd13be357-93bb7267e92mr1277599885a.0.1789658958643;
        Thu, 17 Sep 2026 08:29:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:939:31b5:4e08 with SMTP id af79cd13be357-93bb7267e92mr1277595185a.0.1789658958112;
        Thu, 17 Sep 2026 08:29:18 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbefe1791sm68837795e9.1.2026.09.17.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:29:17 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:29:14 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v8 4/5] arm64: dts: qcom:
 shikra-cqm-cqs-evk-imx577-camera: Add DT overlay for Shikra
Message-ID: <z4usj632ovj2cadfgp2zvwue6vuvqhifzgjb2uvfikitxksdvk@4k7xnyojsa7e>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-4-9b9596221cfa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-shikra-camss-review-v8-4-9b9596221cfa@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX5O5CdeTmMBXa
 4okG2GnZ3QFRgZqL0YgeBgR/6aLWnrsa6/jJzlg3Lf7I0ucQBSiP56IwbNEKwES39xKq096/o5Y
 vd0fcuqFJPo55o69zfadvgkidrI5hSA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX+tPkUxP9XpNr
 /NT3FIO4vfDbsQ31zzSgNKoa/SvULzgpChX+nYhfUhG/2izeC2RGn0QcPNyExsGU/IvQL8r7Zo+
 MuhHde/ZbDetxQe1brYdlhGSX93dzhdpX/1jTQBoBzZtDM7BvXp69PgsgTeQwBrMGlvgMzpCs/1
 pA5fMmlKqsz8AETCB6U6OXVhH5Y5OkssRkrnSuq+bOOKCxCX223ajp2dZSyK13SspZzELEXq3ag
 Z9EyPGRdZv8c4QJsIzkqZMQ0CjwUMdRzq9mAwyXK30GyRbDOTd0IyFcqBi3ykoMl+O1p4ZHY+q+
 gbd2mVWhO45/iugwAKCNjF49pbh0X8uFA561L71eYTWfzIuk6AciqZlZyTBmwoFihoV+c3Hr+8T
 sZyVzKL44Mdih/IJQsLtQ68dmwMoDdf48y61e/cB7mx+L7A28WtKbbYIW1L6/AQVe+I8yp7GAU8
 OtlZ0lIeW43Wm1opoJw==
X-Proofpoint-GUID: vWsCf0MGmLG-2POYnAeRqZ2Wd7B_47fq
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac074f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XE-wypd_VeY0GsksmEIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vWsCf0MGmLG-2POYnAeRqZ2Wd7B_47fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170220

On 26-09-17 17:11:03, Nihal Kumar Gupta wrote:
> Shikra CQM and CQS are retail variants sharing the same PM4125 PMIC
> and identical camera supply rails. The only difference between them
> is the integrated modem on CQM, which does not affect camera hardware.
> 
> Add a shared overlay for optional IMX577 integration via CSIPHY1,
> used by both CQM and CQS EVK boards.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
