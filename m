Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0035B631
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570856; cv=none; b=JihxqYStRzLErpUCdAZHD3eEisgDAaHPgZV8AWB3pp5CEtNbTVRDPcLkWF37sR0lpfMsbx3CJEz3MLyWgeZwB7oC3POmSi/OtUekg/RbiK7a2mXRdDvtdtpS+Ufhdrh8Ny3sXxZk/sVB6jWeuTfu6ize+S7vZd/jy0z167WSLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570856; c=relaxed/simple;
	bh=NkUtuuIs12BSSsmdG6xyEVbaMPiM9YCwp7AEArjcEHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=usvzrFOfO3W1ik5G7ihO3UQ+AlJk6qkHg8aoCL3JvNhFFjJo5QWhLp7oLWSFe0cTi0B+OYXkqRZAHQ6eLjwxx4mJ/5T8F5FkVqMPnU/S0nhBrxXgukO8Cusexm1tF0phs8xb41nn3j39Aby2UyNDhuEXrIbmHjIVc4IRo9y9u3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+OcwAf7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iM3PawP8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+OcwAf7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iM3PawP8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8VbL4142462
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 04:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=otrAduylictWjLlY2CQabu
	6AyUtCL+D8OY6qMEEb//A=; b=m+OcwAf7PtR01kDMHOiOcIdGJVz1v8onopj7Wp
	3JaPkgrghBmrBJwPqcvRVCuNfWZaOcugXPawOByWk0TwaSdkZuYQ17ViGaY/SbI8
	V2shgNhDU/2VMBfrxeeZjP1xnO8iAUle7Y34jFBxcy9afRq2w88gYrfLk5Zhnl74
	Hd+nW6clEu+pV8kVQNCv2Zuuq0D1AUsSke/tSqg8xZg8ctKoFAy5wpgN6JW5nYsN
	HTtGvi3mzRg+wK4Wz87IC6hrFCqfwd2bfE2DAWxTg/fcVtnZdXlgcdBiymuSOIWq
	GEj8eQTtHPC9R6KlunrABgdvtRd4FQ9JHJl/nkIyrUPXx3zw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwa9jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 04:20:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484b9fb055so2952504b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783570853; x=1784175653; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=otrAduylictWjLlY2CQabu6AyUtCL+D8OY6qMEEb//A=;
        b=iM3PawP881yNMecCo/bjGzkulX/2XpNzLhGPULrhgMuCc0z2lMKfoHko5u0aRzfI2H
         tjAUxU+8BZIU8sgt51tUyRUcNXWsih86Ak7ZGCHfwvU10QKzyN2VV1gA4vjHN2B7gkRG
         uAwfAdJx1SkpHbIjabuD/74qNp8TPXByn9x8KQDSN/KOhXvVMYMOlJgiGR9l90o/inyd
         XazCsi4CFGqkhDhgkfiK244wp0vveMS/tHuA1PBahUQZ54LN2uGVPmWsrq5O1WwI/nPb
         MDgtYql+CWIZb/NfXYivam1OA9Kb5g+K9VvqFD7r652Z0WE1Q11tNAzCjT2ig9kaTdvJ
         lJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570853; x=1784175653;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=otrAduylictWjLlY2CQabu6AyUtCL+D8OY6qMEEb//A=;
        b=aHXqI3R/f3ZI0G/jh2T028AdL87Hj8VYaszLjKm+OPT5qJIabKcVHNlHyYU/f1bGDj
         qOGVe2y4lUrJuhTcIJ6Jtet1TGzHaE0ANw0/YkGNgPi2yGhUHETu7IR4bNHj5+d1/yga
         679t3Tfl200FVoaWdc+w6UfAGIRgaZqYiwOJrnHiRt62e8VJJthjDlfXbt/IfQv7qbEL
         iFYEWhZ5WI2c2BEPaF8GDIUa9+LotNeQJTP1065RVh/A8/qNzCNoXd8QadX19B0hFOUs
         XD3RMBe8Oc7lXmxrCNV/S2lSm0yDx3t24BIoLu4NavxOLHa+qISP8EcoNANtNjHchK/W
         A1DA==
X-Forwarded-Encrypted: i=1; AHgh+RpK6/sdYc6wuc8XQMj0zebxVOgtlhaa8FzHsDvRnFRBykhkV3RtImmKb+c7QXQkT2ZxP7u1GAUl7zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Pp/1BQi4XvYlInFT05JIaMwrtwfFcy80RuHnHJYzmWe59n5O
	njDueWxH0lifM8rtmTFmc7qJbuFcbdVtGVE8ctc4lZeXL4PCNEVsso6h6PRr5lJSQvJN/rzR1U+
	6wlXAXy6Zhi3wonElCY8+DgUsQ2xFRONhNNZYI4NHpJBDA7cWxpepOOqQPtdu/jk=
X-Gm-Gg: AfdE7clsedu4rXupUwbgQYzIN98fyWHvS47BlwnooJlYUKv9Ka/U4gEKo7YJOMrpZQf
	z4g5IYyKhSk+O7RdTX3URsLNucXS60R8xtER40iBsAyljkKSo3Iem0e4l8cG77SY0b/1TbSbmJO
	Y0+GHQY+Wjb1Gl5UYAQPGbqhnT2ZMv4efor9JKbizNdJc4IfvkSEOjFCB3qcQBJ+rW49yAT8y7j
	q8iATwhlTNd5OBsI8QJL+LY3l90zg7s1O+iuYgTP5pY7ywOdIC2ILdZi/Z0DIGVbtM9nXKAq/ZI
	GMkD12DsfP+44Br+FEdsmVmrsUkHfG+6oJaGNyP5ma/ZENFeOHDETcUXxcOWnocNA68ayfuxpM8
	7w0Nc8Crb1siFQR1CRbKXQwuH/v3trhfIFyBgYEuXCPW1
X-Received: by 2002:a05:6a20:1587:b0:3b4:65d3:17b1 with SMTP id adf61e73a8af0-3c0bd1a82b8mr6263839637.43.1783570852859;
        Wed, 08 Jul 2026 21:20:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:1587:b0:3b4:65d3:17b1 with SMTP id adf61e73a8af0-3c0bd1a82b8mr6263804637.43.1783570852280;
        Wed, 08 Jul 2026 21:20:52 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm25490098eec.2.2026.07.08.21.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:20:51 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/3] i2c: qcom-geni: improve transfer error recovery and
 synchronization
Date: Thu, 09 Jul 2026 09:50:39 +0530
Message-Id: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJchT2oC/42OQQ7CIBBFr9KwlgaoFuLKe5iGIB0spgULpdE0v
 bu0xr2bybzkz3+zoAjBQkTnYkEBZhutdxnYoUC6U+4O2LaZESOsJpxU2NiX1Mpp6GWEMUHepHf
 SKNunANL4IC3TWIlanDg1nANBuewZIF/uomvz5ZhuD9DT1r4lOhsnH977JzPdcj+p+Fc6U0xw2
 wojjtRUtWIXH2M5JtVrPwxlHqhZ1/UDAxjXpvUAAAA=
X-Change-ID: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783570849; l=2149;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NkUtuuIs12BSSsmdG6xyEVbaMPiM9YCwp7AEArjcEHk=;
 b=3tbAoQWBAMFwXL9OhPVPfWdm6y8YXx6Gea7z7ElcpsIRrke7zG99hMoaVnYV0qoqLCvcJhmRH
 sldoAzYiD1eBntMyF97uSKUrgtFZ3rPcdKfijfuRuboPydYodqR9FEB
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX1XZOKPenNdoB
 QTGP3sfkz3QMMte94Bzge6dNxZ0KzxPOgF90SgDRykRBdMZ4uZ5OVF1D+8LJPGo7fOtvXy8oQkF
 Uc/yppS7U7C3tvztGttd/87tdmAhU/fZeMCFH3OMXeG4ttMWNKQzYEsKSVJmVBVILfsHZakaNu4
 xs+WAT9L+mrNxGVcC5GtdSBL6Ve/lI4Y9awFk2doBfYz9JwqKHKZvyxKR6i4NsJksDU9z3ZaIcm
 kcPdKkXyifMH+fWLv2CRaI8u/eAFcQ+KPbtYYJwDeRuLxheujxAqhELnJvZ8JkJrWZcfQfG2fpa
 nNyu76kSa37t8zESx2BYpqbiwY+5GPM09vpu2lsijCAPB1SCsarELfh6PkJbYoANqv++rBseLp0
 zpyvcqzN3A8rYKjkRibeya2z1LU+nlxNDfR1RX+A22cD4Z5+ctVMzripXRBtfg/iORAD7Z1wqCC
 mYYoPM7gvYIN1SXh+rw==
X-Proofpoint-GUID: iY2o_BGhkf6qinSj_hTHe0rAYlzgPhwD
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f21a5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=myXUcApQ-ot6Es7YN2sA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: iY2o_BGhkf6qinSj_hTHe0rAYlzgPhwD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX0Az8kodHS315
 BSnm+Md5Ev+NaTYhAQISzsdRkOgERoulTkXELSTJF8cBdSPKIOjNQ3oTNXaQole19rYB1zdCrnn
 ziYyzf6hnSFUNW7CmQmImP0RxVC5m+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090037

The GENI I2C driver has few issues in its transfer recovery
and completion handling paths.

The timeout recovery flow directly aborts outstanding commands, while
GENI hardware requires command cancellation to be attempted before
issuing an abort. In addition, multiple operations share a common
completion object, which can allow unrelated events to wake waiters
prematurely and lead to incorrect synchronization.

The M_GP_IRQ_1 interrupt fires for both address-phase and data-phase
NACKs, but the driver treated them identically, triggering unnecessary
cancellation and reset operations even though the address-phase NACK
has already terminated the transfer without arming the DMA engine.
For an address NACK, the hardware requires no recovery since the DMA
engine was never armed. For a data NACK on a write transfer, the DMA
engine was active and the normal cancel and FSM reset path must run.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Fix typo: "signalled" -> "signaled" in patch 1 commit message
- Replace "shared" with "common completion event for transfer, abort
  and DMA reset" in patch 2 commit message
- Fix "has a few issues" -> "has few issues" in cover letter
- Fix "cancel and reset operations" -> "cancellation and reset
  operations" in cover letter
- Add geni_i2c_check_addr_data_nack() to correctly gate DMA FSM
  reset and cancel per NACK type
- Link to v1: https://patch.msgid.link/20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com

---
Praveen Talari (3):
      i2c: qcom-geni: use cancel command before abort on transfer timeout
      i2c: qcom-geni: use dedicated completions for abort and reset events
      i2c: qcom-geni: distinguish address-phase and data-phase NACK

 drivers/i2c/busses/i2c-qcom-geni.c | 113 ++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 38 deletions(-)
---
base-commit: 173f2099661309fd2a52fe94e6bcbbaf0d323dea
change-id: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

