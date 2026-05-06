Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B83431F8
	for <linux-i2c@vger.kernel.org>; Wed,  6 May 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050352; cv=none; b=qj8oQN1llSnbTsWbO1fFccwN31ZUpLQyxJaEYvbED5YpvUREdbdf/APXzFGilTwJ+pZGCBtma6QQ3DKOv/yg9URMx1MVqO9zI1hQ61O9YFicvxsKT7R/wLkhgFUah5Kjcg/J/v8UjX3gU2iziuHWkMA3DotNRTpPo6KdHG8STgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050352; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=LyrlU3u5lSXyC3nlM8V9/Ym/v8GoP2ZrQ7SPnXQa76ztR0Z8+ZQNJz8P3OY77Y5TBjS3HdbrxFN432ShJIAE2tlzO898Gmz1Ixl2o2bd+lcv3HoHNLRrPrrUmSKDaCYc8AuEJJGtxZrFmLpmubUIB8Z51QplNmP0DXyVNawExIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QoOuY3Ub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RL8/IDtH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QoOuY3Ub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RL8/IDtH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64603pa3248306
	for <linux-i2c@vger.kernel.org>; Wed, 6 May 2026 06:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=qcppdkim1; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++L
	fAOrCAj6OvBfk=; b=QoOuY3UbPQch0niD9Gp8j+ZVwpzCWSey7pVLxjKWScxeTD
	mA040Rq8Z0EWCNj0mcvBWMu6DduJC4/wi2jVX1SyrXeHqyF/uMNvVIfhmVn9kzeb
	pspadM06z39OjI6mi4B+HYaHDKnfXQIeJkC2vvR7fOPAja9buoonGRQHCDuRdnOc
	eEn9RDtiqs2aSFiXbCHco+UhHyUnHI0bAnIQf+haSBENBCo6q1SY7j9/cbEA/za2
	PwBe1QEO58D7gePDSX7YTqQZQr6QdOofKTL+VFuq3LN01aED5TXMAt4B4KxiAib+
	hvbH3jryZhQbIAEaHeCd0dHykMv+xtYvlj+3MymQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq43556-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 06 May 2026 06:52:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f9429f49cso7442893b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 05 May 2026 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778050349; x=1778655149; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=RL8/IDtHzkSP447o8wfk9CiWWfb9sc/QWirlmpVCv7iZbjPb4Gh2cFpH8FdtrR88a+
         xolef7kIWlbv/ZP267cBbfovIK+oIrwO4MfXm4g4qpTcPXrcAKhr+4cyH9TocGLQLa3q
         X1di8yUycQJbZoqHg7UGmWzSZVaIn87QdMvt0sQuxxL1PZXvbXZruF6GzkWQjw1wXvCM
         nTjU8UIV9RkB2Y0hJ5+7hGuuZBrShCyMP7UGk8QTztUVDQfuFJkG3/Nlru5CPW7hLqGi
         b0Dph9WMcxjnmqKysQgUY4T2DOb5ufoXLVAIlLafyEvP3RcEBkw6QP4iJr0GTCOi1My1
         MovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050349; x=1778655149;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=Y4jD7C19Oyi83IoDHuMIM7v0BaAw7dMeYiov8Gb5QnU+HlKd+erhvmb4MNNGghOc9f
         Dg8SSUT1Ea9Pi16fQdCqgoXg9VGVZn09nEjOzas8gZGPNpJFAfYV9DSWhAJwDS+Md1uF
         W1gBQyPhKztgQ/lPUNU+aa3O6M57FZv+JEhukX67YZ2BTz+3GwMgDhst43T5/ppOUs19
         hvFvy3ujlxPZf9ZWeapqnnn0rjbnJI0xJgw/ljmVcvuS3BpmVwtr4rO9cH3NDTJjfeAx
         XNdwjGw/ZT2WSOTBoEN6LtcHflAqaHTHRqREbPThpheb6ic9if09uTSx2AM+s8PedYjF
         B2nA==
X-Gm-Message-State: AOJu0Yy6I+sJjoZAx9Voj9FY49toIZlSmCNrwovT7IuxgSVSMIyXfpLT
	wzfLzWl4Ch3cL+L3/tpDmoQU7NStPj4umfNQq6YmiQazBrkJtXhgbs1R4G5QhR7iKcFQ/IqdKFY
	BtkXKEHN7yJxup09OdeSsUjbtlp/DLqulGwQx/GD5/pgtikb5jTaSw1ncmKQhnYeQN3byvgo2+p
	uI
X-Gm-Gg: AeBDiesedPkHKlv0cpJtqtjIsL2ZyvbBKzSMlR52OceGAmAw3/0MCfrDV6X9yTxn2iJ
	DjSxSwqgO1NswASnMTxqIhxrhyGBvBJTOh62WWo4zBy0hr2ZiDbQ0cRded3l2/3IgrricHFPbM3
	51FlqslpAjIPiGUqIB6R0jJC+O1sIFwmrjRBn6sSAQZzrTTEChaJD0EYEJgL27qKQ0dsV1dLGnk
	Ez10xJ6SeIXXfK9KG1TI2uNFnqxLcvNkUYjnePY9HuTrZ9r6UmQ4k1B48w2ZYbmHz/Fibx83S4C
	juPnnh28k6CFxVcDKVVTW4XFEGRhpw3O6dNGOWHHO+hKjE3xxlTarInJ1qHVFDo9PGc275arWYI
	6a9/+8p0Pae+2fu5HfDimqq6iLKx/oS602sIznIk=
X-Received: by 2002:a05:6a00:27a1:b0:835:388c:9764 with SMTP id d2e1a72fcca58-83a5e3519fbmr2012065b3a.37.1778050349062;
        Tue, 05 May 2026 23:52:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a1:b0:835:388c:9764 with SMTP id d2e1a72fcca58-83a5e3519fbmr2012050b3a.37.1778050348613;
        Tue, 05 May 2026 23:52:28 -0700 (PDT)
Received: from [10.151.36.91] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm5548241b3a.48.2026.05.05.23.52.27
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 23:52:28 -0700 (PDT)
Message-ID: <d03f751e-834f-4184-a3fe-e32061a0fd61@oss.qualcomm.com>
Date: Wed, 6 May 2026 12:22:26 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-i2c@vger.kernel.org
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fae52e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JV2eVSZHMSyV4Tj97bsA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2NCBTYWx0ZWRfXx+89a3rce4XL
 tZz3VG/I8cV10yo/kp0PwtI9wFTnB00F6L5jUM1nA0s7LLRt8aEinMBIqI+OnnuezlZn0PHm4kp
 cmRQRwYlCmLrMg0En+VkdY8tSbj0QSF5fFil5jJ57sjoCZ+ou3stz2zLXWlTf1rDGPIklz7kHx6
 pUl47doD//U1B8o2HYh7PuUiaeF+vQyyF3hwd/O1KaM2/+eacmnmVF8+lEAZbCautg/3xy67YmM
 P4JBUN7a/96gjo6wrWom67u1XksqUd2GTY26X8BR/Op/cxrv7jwGbV7/TnifjMqoISU3k+04y77
 gMjh4Hzyh6yTRDPPOAYiXncoqzSnyNPrvHGZU0P12xjHQEkJJT20CFqp/OhAtHC6RN7tUye2fy/
 JxCOgGw9ZC0PzTRKhu2rI3rZexqUxUckbKuCjVa8rvNMXOX8bEmSceji+0rjCZ+9tDub3Ao8Jt+
 xb4jMXyu9a+stljZIDw==
X-Proofpoint-GUID: Y7fI8EHGkaNDegOg-yEupWSdSpI5oEWD
X-Proofpoint-ORIG-GUID: Y7fI8EHGkaNDegOg-yEupWSdSpI5oEWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060064

subscribe
