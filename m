Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910741229C
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091308; cv=none; b=AFrU2sfpUy9W23I+ztWY8HAMYv38wLWfUNo+0StrdofZh9a7r/GrtPwIC682t0LhmEcGoBBGloUXrceBhMPwQ1Z1PVW3ajK2IXyV3m9IBNS3FhiEMaHY3X+FNvNdLH7E5xIdUCgi/6mOc04FaxqxhKb1BuG+3aOZau94PD4CW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091308; c=relaxed/simple;
	bh=5LefAlIjcE/PzYIC0Xzc1u6687PAblmcgOZr94jJsUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BwDCEXim0OGUJVOOvngLv3d45picvV6OSInUHt1t70PMLSHgHbacT21Rf9x7wP81yUee3hdQe9cL26gz8Nm7c0jWjtHOX5Vrwy7g/sL4vFrqRZxenDuwhwvtLw7QNySkwRikoWIkpsf2DVylKnPS1lh5GIzcFStd9Lqt1CF3kxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkqb+VLf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Izqi6SZ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkqb+VLf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Izqi6SZ2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663DtILR3410053
	for <linux-i2c@vger.kernel.org>; Fri, 3 Jul 2026 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LvBcjeyn9vD9s8JRnZz8Km
	rSdZM+Hn1S3FaRZGhvGEk=; b=nkqb+VLfthfcEw5lsJWR7+XCb47gdjGiS/qcti
	kxxrlFpq/3iuEpzfSUuqAfEg6gi/T8I8vt8md5q3agiibnpto+pnLdKP0Jnu+U9Y
	DZFkD67R3FfCTx2ICElEmEX0q+iDimE0kjWjMznsrKeI1g5LadUJoiB38c0YYZfo
	BGA3EUN85J87YhXIPyBru+M2ds3hmUFsd12N6EG5As31Y7vkjl3o5oI8LOiVKJa3
	qfOgk3Ziu/CX3n2j4toBx5Y297q7icRlDHi/2ddb4qq7P752RpzXu1KJvW7xOUM0
	PXhqBGqKV62NhRJAhlnzIpAeqOoUobqyKRx9Rx8Vl5tN/nEQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u31n0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 15:08:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-380b630c505so930941a91.1
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091302; x=1783696102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvBcjeyn9vD9s8JRnZz8KmrSdZM+Hn1S3FaRZGhvGEk=;
        b=Izqi6SZ2uVx1Si9VQWV2Y+7T8XvEjTlxqI5M4qQ9LvLlW5ZrYUMkkiRvHZUCtv5DQK
         EJeaFI62Il5xI4Ybrr+oQd7fJpnVbh/fpzFKcVJVnxUOeB880bDNpTJ2t/3BtbaKNQsV
         AHBVuNvxUOYA2HX+ZYfXlOdoyMZGBt4IALDzRGugv2dCBrHiePuYlIYj7/oY97S/PUJW
         NojtIfg8116lRmOuX1FqtVLBZji7lHgotAW9jHOJ3rd0jbzWdNV00QXadg9gePOyXYoe
         6oeHKeAyP93oBica+b5DeWiOU8FN2acZJoBNZ5AOko+AjxRiJSIOJgL40tMloPjOkMvc
         mVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091302; x=1783696102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvBcjeyn9vD9s8JRnZz8KmrSdZM+Hn1S3FaRZGhvGEk=;
        b=lv5qax2X6Htb4tWNRCjSt3gSlUHLhF+rSAnRf2X/tMjnxTETFUvFtiVfXdUFSCZ6O/
         0ZyDG5dyRWKcvcr98VFiU+L2Y34Ok5c9dRgtQF/8CxLxF3lvv61a7Nszq7vyVVRLveAD
         oYPekuYhvjDVs53UmHvXxfM4NtoE4QZ59rt6SD8OZMkcps5gHBRy+WvqGKPpaqhIN4n/
         gLuZvrZ8JBdrjp9zxtq9TLzeZr/hF5ae46kUbwtgym2FsSD+LfCz2L4Aj03KKeDOJezc
         rqxbGjIa3QmTvfLG1ldYBGRNGtMQd794i2jEsGGlOvGAqCfCaeQZfj8midQ/zFJ9wFY7
         2lJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJCVaaMpz4PJbN1v06mpzPVCgZWgW5apZN4TsxclNShDsKzT4l8e07/478Iybz7/jSPabBPgRYOb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPtl7XXJ5OvQ4ry9ERJK1YPImZcHWRiAL/85t2uPpMoAbiNJh
	g88HQe/eWE9zpLcJMNoUc86n+YquTdxolC0Cr2onN0PrSjRJdfTLjcfRiTwmxTpaK37jzJV+T6s
	S9lgO4vtOX35S7tD3zFByt3pY+YklOVBgohRA/JclQXHyiisVOVeEwIfIp5OvPYg=
X-Gm-Gg: AfdE7cnjCAcl9MXoQMEHoR9uOh2ZO3uMcEpv7GUMcWYqPStdMlhOE0UTOXXJy1SLRye
	Nuqct5Cv8sKYszhCLWuNkNOiJhr7UL5MCBZ/qmI63+722OCBnoN93FOXvvh6B36y29XIlvpNnZz
	I6Z02Etb6GzsQJhYLQlDCXKPvFL2VMLqMxUTeLWu3o6DUNW0gyIuTKJPNBt+NDl6q2iMVthLbqw
	+3fdCIui1PHELx3mAtJ3oNI1/cZAQG8sbgdPH2bV61xeN4f/Cfj13kmxLTJ3qhKIATOIGYU/MUQ
	MTZ+i9JpPh9M7SkFPxWL59sqf2Xx2yGco4pl2FoZXfelw1pa3+gJnRWOj+OeVsBUxO4vrBGa5IP
	YhymqxQwsoK8+aee4vDycPR/rl41M1em0mrYrJgWwYHMC
X-Received: by 2002:a17:90b:5404:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-380aa0c086amr11735955a91.8.1783091302588;
        Fri, 03 Jul 2026 08:08:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5404:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-380aa0c086amr11735910a91.8.1783091302020;
        Fri, 03 Jul 2026 08:08:22 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add trace events for Qualcomm GENI I2C drivers
Date: Fri, 03 Jul 2026 20:38:08 +0530
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjQR2oC/42OQQ6CMBBFr0K6dgiUCujKexgW0A4wRlpoC9EQ7
 m5BD+Bmkpe8/Dcrc2gJHbtGK7O4kCOjA/BTxGRf6w6BVGDGE54nOb9ArRR4W0scDWnvoDUWJmk
 G6FATEJeQZSoV51JwXjYs7IwWW3odjXv1ZTc3D5R+H96Nnpw39n08saS79+tlyR+9JYUERCGky
 qVqkBc341w8zfUzaEMcDqu2bfsA0nVezesAAAA=
X-Change-ID: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=1679;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=5LefAlIjcE/PzYIC0Xzc1u6687PAblmcgOZr94jJsUM=;
 b=HN2zlAN7FWoASXQeWDB7aoyI7VEkpA4oLeiY09i0kGoTcQ3IkBNPAaiS/2JZk50QDZTp4bEJO
 iH7Xc24a6VFBjVY/Jq73CxvrHRAPwuFrHTFF+wjLAEeOhDU9lk9/T7H
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: kYBBEWazm52U9y-ccDyJqrqJTpSbVaZm
X-Proofpoint-ORIG-GUID: kYBBEWazm52U9y-ccDyJqrqJTpSbVaZm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX6wgvuTl5F8cK
 zigcZBdjo1GFeMwqLX3NWZrvobcLf6ls/G6PcJIREhm7HPbYD2kSwtcplfDRAwweQ4cYYDdHErQ
 yxpOP3hB0I7roukzNS+pSArrZXY7RtQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX7En5abSQuXsp
 787llfI67OQdMzGCPyH4uAfiKYfJCG5zQXd515MOsf6t9AYJG5G7DWLj5DGCHXsX/uPvvMusT2d
 I82hE7LWRCvUUNpqQ6Zf84knNkfFLw4tJvL3hBIAk9eXTY8zqkHxP8q7i5t7PSBQsK6yVSMQpK1
 GDsD4pP1X6DHVMP6Ehw2n9gGHrIbElmrBqdXFc8ScuwqMCTGY80ezgOHkqLUZo4mJNSGwJ6DMh1
 IfEOolX5hkX7Qp8t6+90VwAmoftCMUC0jiiegck3igNxBAlT/XgiDi6xpdYxB9MJ1De54XC6yGv
 0DsbuIpg6eYoR8GHdO+XJGR5uJlpk2gd+Hpnly/iaRC8EjWucBh+Eu1K549UKZQk9Ocotzr/9yv
 1dDGyel9jK272hRxlHraETZMSnHWscCpeIr8wl6rwH87Av05M5CvTVl7lewRtDGaWLhLDUAAstf
 NBarLHxZbbu05kQ05UA==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47d067 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pfqdL_FptRF-L44MAtYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030150

Add a new trace event header providing tracepoints for the Qualcomm
GENI I2C controller.

The trace events cover controller bus setup, interrupt status and 
error reporting. These events enable structured debugging and performance
analysis using ftrace.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/i2c/enable
echo 1 > /sys/kernel/tracing/events/qcom_geni_i2c/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
79.737075: i2c_write: i2c-11 #0 a=057 f=0200 l=3 [00-00-3f]
79.737075: geni_i2c_bus_setup: a90000.i2c: clk_freq=400000 clk_div=2
   t_high=5 t_low=11 t_cycle=22
79.737084: geni_i2c_irq: a90000.i2c: m_stat=0x40000000 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737201: geni_i2c_irq: a90000.i2c: m_stat=0x00000001 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737211: i2c_result: i2c-11 n=1 ret=1

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Updated Reviewed-by tags
- Link to v1: https://patch.msgid.link/20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com

---
Praveen Talari (2):
      i2c: qcom-geni: trace: Add trace events for Qualcomm GENI I2C
      i2c: qcom-geni: Add trace events for Qualcomm GENI I2C driver

 drivers/i2c/busses/i2c-qcom-geni.c   | 15 +++++++
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

