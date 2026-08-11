Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584C428820
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440216; cv=none; b=CWXifXJMFNR1NMPj7Xlaeq5YY/RTS5dqnKO/OIaQrRktH3bGOnAJv3Lvr6cOs/pqsa5ffdaL/YBpzJm7C64xVqhi6qQilY1PZ+DodoZsBwdr65sAxQvwTR7eZjg42XLqWiFVpxac0mzNxbkp2nZjmT1UV4699P8+D5TEtKekx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440216; c=relaxed/simple;
	bh=nNd1sHw/pDcljf6WEYttK0Wj77QmwhxMR3bvc97UrYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A7iuc8138zL7yaQ2TqegTghRsFYCUSzPk4/s1PCagO/fcsOwMGEGizwxWe9zZpQdOD6RUWLuFBF/1EtDDDBwn8wWhS2CjZEAHEto5XJMviF+Z1hEuKwymc7hkOCE/gv75Xhf4fai+LIWXBu2IcHX8ekYPHXOgqrCBKcQ0IbD25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CC2/3C9P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=if3IFpwe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CC2/3C9P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="if3IFpwe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6ol4r2996509
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cwcpxYnXdMKdVSP39ZYLzb
	xDO+iMb+EToEjccW7X4h4=; b=CC2/3C9PQePyjFas9UY+cdOygalx0J/+qso0zp
	w4ZysmKWTJe621n5uwsG8Qv1YjguX+9mHzCj50x8bqVxN4zyOhwl8emTREjGbeH6
	jcrJXmE/uf5op98zjQDZBLt27EQ1SHE7q8LqxsCSGDdJdsPq5Fj2HHb6ga7bbW2M
	aDGE8OrNXjDLvpngS1yEdscWVsE3cJ5Bk34Tz3BW7utyu/rPXRtbxrSLB7SW4Wxf
	W5F1wNgyjQbRgVRhoG9Ggt6+xsRWXZY1DfUffbEFHnzbO9fxU2bGLqg/eaj8Wojb
	8JqCUfgEsmCtXqkZ5y8cw7lrlb2FCdtZg/N5QH+UDuQz4u+w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf3a5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:23:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso5369968a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786440212; x=1787045012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cwcpxYnXdMKdVSP39ZYLzbxDO+iMb+EToEjccW7X4h4=;
        b=if3IFpweBkxetw/4MICYAkLOLcuaZIyHiInF2Q7rdvz30qgcTqOhqctb1jnXbYG7pg
         pkYp5R9Rge0yu9g0aePzgUo6oGb8JRBrh36/LjRAabjcf1oLz5cH/oujp5GptpIKgyy0
         OlPsY3N+NQ58XLhDHpWtvbHxew+OzLsn8BhA0Crs/hcAT/XD5X/joH0FhRFCDmXgxAq3
         qT7srx7w1C5b05GqLi36miBPEccpsl0GVIlc8N9iP9WKaBtk8579g/xvnoYs/dVpTQfR
         oT0c7q5mAGcJ/vwud+n+8/rjvWDKBK+nH2GKdli41YvUhbBhPsMoCX6JUnrq/+mfYHcK
         QKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440212; x=1787045012;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cwcpxYnXdMKdVSP39ZYLzbxDO+iMb+EToEjccW7X4h4=;
        b=knnKlB3mbRUxQPGzEVyr28x48WHSuU7sdYAKL3kg5YYNFseAV4P5TK47GWvEeN7oo+
         h3CXLYeX4mKCppKFuOe52Ycfn5P9VG5ms8FwJKRklwxP/3mit1RNelTFW7EnKJOuptgY
         MkGfDGjw5NeqHbVLYPRYVCkTNzGOGYzL/Oq0VqRPZbQ69nXPL5quLRPpx2NhlHTciSK4
         v7ywSaB/YrHdV0hp+vqjxdK/aYXbkAz64DhIqXwSDyPNoHj7m3bzFQElu3qRVdlx5o90
         tep2b3/Am6jailnrVF/LqDtSPnnXeOd0K2OEYooCepDcmde+OjGM8y617+T8ce70bjb6
         4Lng==
X-Forwarded-Encrypted: i=1; AHgh+RrP/xRyoiURwXkh6Gt+VsZBiw5LhmMnrncQZQK0dwewfZ/PSEyqAMfUJgKrgQuiRcGjBnToH3iLAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1HRH8stbQ94oqkirNPhI2Po7rAwrpjxhu5OGexWYRvDKZ1OW
	/Wj/cgh3jNV+yvb7VHRZnOJ3y9MdDiJ0OVpW4u4CNsCspAPsVzaReJ8WhoWa0XGX5h8h6Ane26f
	ZxqnOwq56YJPIqZULOA3CJNrNsubTUepASDMQjV7ujVdiBnMOI6cRcZ5dE1NaVTN5aqrfKv8=
X-Gm-Gg: AR+sD126s7ZivHFv8QvjrtiO8mMAkbPUgsXehcUqmh6G0GCD/OY8GR4e/0UE+1744cL
	VYlC1CiN+zOY+eAlBaOMl+9G4SNOnC96yZi8/l13jDl57wwI4GaRe6bnh0RXsfmu40KJ+ds/tbt
	cCDpIfoR56DoMEiz0zl+Y5f3SAimfSU8ojarLhx6Tq1Kr4gjIPH/1ERzerZewBf4zIGLEe0MiVl
	UBm0g5pohHqXT4c8st3D9Ks47MYEohS8CG+eLKJswE3Wu+E8C9I2NL0wPSgmekbBKe8/z6J7YRJ
	zXwsvJCa/wTCttzZZAx65dSPUxLK9y5VYE7FJy2s1QBYFg6SnkeRLqJaQUc7zTABgmcw1OqcPPI
	BTFHO7xfWpvTYT36K628U2oYJP0Gd0aecnRPTl1trvncR+STl5i8d5U+V8mIGyJSKx+GjHJ7mIz
	8Nw3TjagGMw+quBKVD1vcyxFvcLTyREUYRFXM=
X-Received: by 2002:a17:90b:288b:b0:38d:f94d:4c6e with SMTP id 98e67ed59e1d1-392ec68df93mr1949800a91.17.1786440212502;
        Tue, 11 Aug 2026 02:23:32 -0700 (PDT)
X-Received: by 2002:a17:90b:288b:b0:38d:f94d:4c6e with SMTP id 98e67ed59e1d1-392ec68df93mr1949767a91.17.1786440212028;
        Tue, 11 Aug 2026 02:23:32 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14120447d8esm3385004c88.14.2026.08.11.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:23:31 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
Date: Tue, 11 Aug 2026 14:53:15 +0530
Message-Id: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPqemoC/yXMQQqDMBBA0avIrBsYgwbtVUoJ6ThppxSbZlQK4
 t2N7fIt/l9BOQsrnKsVMi+i8h4L6lMF9AjjnY0MxWDROuywM5I+bWMbL5a80svPaQgTq4m1613
 AtsdIUOqUOcr3d75c/9b59mSajh1s2w6ee01/ewAAAA==
X-Change-ID: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: WJfryb1vU9q1kJsURNBZZzh9sv6HgL7J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfX6qBcWE1lS91f
 Vk8CtgD+hojoK+r7d6t3sIjic0wJnQvPi4VbssYhepq5mxyj3d9QlC6sqbtPtcIjcgYlmaftTsh
 r9+vGW2+XB80lHDXckeIjMSQWpsm6SQ=
X-Proofpoint-GUID: WJfryb1vU9q1kJsURNBZZzh9sv6HgL7J
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7aea15 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZOKYLu___qOWv_Z2YtIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NyBTYWx0ZWRfX0fyGAwzGMAoM
 1gJhoysLgAYqyV3De0AUbVoYjO2e/Zo0x7RUtYrvIItCScJWYUBcz6dTBBJql25vWqKurBIsWKE
 /QXWjI7+Qs0fBcwtPnFEAzZU2mkZwXv//U7TKocOdlOoRBogNYPq0aUiGoa4DWvMJn+0uxHTU65
 SXj7UuB9bksEJPufd3NasX6/G/DrnJI9OyMfQJ3pnJOImaffSoR1hXgX3e4g9KxzOqtQndkC3vW
 reIihbWgi+PWJeLFF5n/DGo7u54IR7Q9+9s0a4SOKeePFzQ0RtpO2MHUmfZLB6PcWOC63QQ6S0J
 zRIw25SJt5G0pQNXrXyGpAFtu6diRaS+k6VjQpF6KPJu6oXGLdD+FnE1wMmq8wTeZYmYnSp6KON
 OiX0Dg+O4O03xEsKd6A1MUbL281Y3ct9/pJ+TbTt0rFN8J5s32Go/71i/L65RGF+b5RH80arddq
 hSVh0et485jTX3e91mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110077

To meet the specification requirement in the standard-mode bus frequency,
update the SCL counters as recommended by the design team.

Also, SCL counters for the FW based SEs are different. Identify if the
SE is mini-core or firmware based and chose the appropriate counter
values.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (2):
      i2c: qcom-geni: update frequency table to fix timing parameters
      i2c: qcom-geni: Add I2C frequency table for firmware-based SEs

 drivers/i2c/busses/i2c-qcom-geni.c | 27 +++++++++++++++++++--------
 include/linux/soc/qcom/geni-se.h   |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)
---
base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

