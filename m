Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CD345750
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183942; cv=none; b=fELZZfPmnQ/ArD+zsjLCzsukXURcTaaYTzEFtgX0vseNIO4nhTI850xItu03yEnzloctIQufKsWK1414WNczc5Ki6st7JirvBmCfvWGeLDcxQZzdfd1IaCFMGcCc/5JWXDoE1za+tx9Bi3CkZtEnQ0AtuIWzWanKh1lB7G13GIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183942; c=relaxed/simple;
	bh=diWgXhSqDb51p9J1iYCOsfMugVyiLjJyhdyOxZjZDxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vdv9zNOJHF8ws2MIx4OfWgVLshWmr/iNe3V2OMaDI6muAEHKpD/zgXVx0+3U/AQFrijbF9t53r7oPJjE8+KpnqXXSkoF6l1VER0Tf3AUpNNxg6xo3FXRpsqE/ZnW/SqVxhIbkD11443ithp359wDi/eBzdjPZL3tck4NQfKLzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/SzYUyd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQo4eRRC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/SzYUyd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQo4eRRC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3xZep1612622
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ApkbgagkjnSSK3C0jYmnsq
	PIKqL4UuDL4H+/IZuEmA8=; b=W/SzYUyd6Y0TEVP+SFpr+Dw/lEKHaGCbeq6Scd
	yQR+XkNws6JLgZsF+/D2XDJtMwZtRIKtAigWjCC5wsS/oYVtAzIUE4UYqiDLR4yY
	G4s/5d2UE1a8k0aEHc/sgxjjwMIHZ8Mq9lAM3c39mdHAJ8kJtdQIAiI2ocQgHZ4h
	OUXu5i2N5AzMxiuCz0GXClmc6BX5GyjTyvpM/Yg0oNEhYqdHGnIRc3Brb3SRY6dR
	60bbZ08zKSOSkdJCOC+FleyGf81eiLamPq1WmisXLhCmydmNqtGXA0WXhUk+Y7AK
	nFYJkKXzDKYocPqjOomY5BApKkB1h8K8dZXbe4yBYCWDb4Lg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfkk1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:38:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2901981a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 23:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784183939; x=1784788739; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ApkbgagkjnSSK3C0jYmnsqPIKqL4UuDL4H+/IZuEmA8=;
        b=PQo4eRRCvLBaESCCoQqsAqpC1VoKbi6zK7oUbHXB8p01RBBmWCmmNS/SJZ8tCOyJ6O
         KqzfdKWjxj3SN9gD2LI1oXAc0TzXtsx3OTzLotAIIaLIA5FiJcXS9Ty0u75Cj02QO0sz
         prTknEbbRjJy1itxG7WKQl6dsx74lSIv7hVThDCtZFn2Is1qoOzctUB049/CF+9BfOpJ
         ZsgmfUjty+cFEX8jKnNcIkhCtQlQo6KQ5SaAkxbvW8rbNfHrJb4d9kdRfFeXIweuA34y
         FyR29A1kreRmKKd43nKUxuorUMztGjbdySmwtcQKzzMF5PI9sR7/CuGEc96WcKOACUF9
         K89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183939; x=1784788739;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ApkbgagkjnSSK3C0jYmnsqPIKqL4UuDL4H+/IZuEmA8=;
        b=rLNjEJQqKDIlznoeAdmI0STQMCPwaFQ8898QGyFbuig8bkebVnNVQ8FELbmaSmyCZR
         BombZz3cQesul8pjP7rgldzb7C0Ms/q4sqvWioZfOuHngooBuGS7Z8rzHV2Y68r3PPiR
         PHn1hREJgGZXIunGOGICuBGdZbEp95UzvA7uE+9kRkO8s1qn0yqbDkn/dzs9srn76Gvn
         bntIHckEKothv9MvTDv0t73JZy0u6TTtBX3jX88yDtyDEIF7ZoFId+6DF4/voJrPOeeO
         ybG0OIeYxWMwHmGRpNXUwg2iniC1MDYbhxmEZpYmrbi99azN3aShP2uMOM4KmqI3OUSi
         rQnA==
X-Forwarded-Encrypted: i=1; AHgh+RrLASZvJvYtJ+QrID5diE5p+tAqHJF22oMKmk39NvGvBEMY5CspP8gAcryISNhubLuU5s8ipBaMfKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOs2YOHmPzeXUP1dWtZz/OfJb6ja5kg1SKnaSk6b+gwT9yHPij
	wbskg9bSKydEn8jrvzJs15HL1U9VDpqCz7NX3mnNopVKjNL33oYXNuB/aNIm+JNTwJ3K/N/Z5ae
	ZOjO8RVVCYz7/aR1OrarbuJ5i66+41vbcVYW0i8SaKh6dP5pRhtY5TjnaFKeQ9n8=
X-Gm-Gg: AfdE7clhiVw+08c7yBJQ5m9yhEA7uBSjTUacqKyVVPHX3EAnZWx2v6FR0ch506cZ06b
	g9Tm2/kCaFZa3UV4uxWO5Qolg3yKeO2ryJz42eNY372Gs/vBCCJXWuZwAqVZ88gl27xkChykkjz
	WLGIV8N+qvZHeJOeZReXBOBZOxrB2v9i0C4x17bjFI4u7xVINjoXBNPsJSytjDz12YxD/KunRZg
	LGt/gBmMlv7KD3FSo32t9BBCBGAaRyZs9kFF2LD0VonI6dFMLjcmsJI50oRcamOYYzcqH2xz8y/
	kz7GXInIeKoXfUnmaZLSMpZWOZ3cI8olA84IXl/yidnCtI6P0djea+9KVYd60mBBksUQBmDozqG
	ecSDt2vYe2jcuQ9n1EvzzK2ZiItkrPpwPvA==
X-Received: by 2002:a05:6a21:8809:b0:3c3:6544:5eb2 with SMTP id adf61e73a8af0-3c36544661amr5918894637.55.1784183938884;
        Wed, 15 Jul 2026 23:38:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:8809:b0:3c3:6544:5eb2 with SMTP id adf61e73a8af0-3c36544661amr5918868637.55.1784183938248;
        Wed, 15 Jul 2026 23:38:58 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb82desm1320870a12.2.2026.07.15.23.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:38:57 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/3] i2c: qcom-geni: improve transfer error recovery and
 synchronization
Date: Thu, 16 Jul 2026 12:08:42 +0530
Message-Id: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHN8WGoC/42OQQ7CIBBFr2JYiwGqgK68hzEE6GAxbVGwjcb07
 oLGxIWLbibzkz/vzRMliB4S2i2eKMLokw99DtVygWyj+xNgX+eMGGGcCFJh5+/K6t5CqxJcB8i
 bCr1y2rdDBOVCVJ5ZrCWXG0GdEEBQhl0i5Mu36HD85DSYM9hboZdG49MtxMf7k5GW3lcq50pHi
 gmua+nkmrqKa7YPKa2ug25t6LpVHqi4R/ZL386ms0yntaFCWr7dGPOHPk3TC336rH5TAQAA
X-Change-ID: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784183935; l=2338;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=diWgXhSqDb51p9J1iYCOsfMugVyiLjJyhdyOxZjZDxI=;
 b=jgeAn3BSKLLXKYTCXEn97MuWdT487hIouJFl7MiUJ59r7hWVt+Uz11nr1OXlks+Wez9ncMR3z
 WP6wcuUFxjoA7sYIA4Ve2k8ilg4C01T3WSbeMPeEzUskhWz+Y9gvDjF
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 1EjDsatwpNH680t2FTMsvnSn__u2kqN-
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a587c84 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=myXUcApQ-ot6Es7YN2sA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NyBTYWx0ZWRfX0Eo+tZkIoxWQ
 ylD+qJO2khphpwCw78W4h0qaQcBGeiCJ1vqZSSzMFS1sE6QAL0qcrqcgaTi5iX0cPyY/flkO3p/
 Pt99AkeCuvjgi0Fk450UcdsQOUSvxhkN9AkPyCgYVXugFQCPIxQb5ie1q80GKjUoqrKmE/+/b+5
 NssARfuA+gvOYASpTrrl1tKzIWaWOtAuCPXsbU7BiwsJp8PPB447iHjDNRD9DHwsMH/tJHj12m5
 Whz7EiC3ZZWVwadshZPFj9D9jyga2pkfwb5iBqQ9WR/p6dpttd+9qbUIgtjACNUopAaAHjth9dP
 notdpCOxqPf+hURkskatO2uiVCktPfffIej7mBbuh34opN5U+chl2M1OrD7s+RUHweAOphJNycQ
 Mg359HcmeSFtHKgR6/7Puu4jRvEqZ6w4YcGotwZV1GAT2Pva4P2vR4/r0bl3wQfiBUlokbWBxoq
 /5nDnCzqkw5N2F5OK5w==
X-Proofpoint-ORIG-GUID: 1EjDsatwpNH680t2FTMsvnSn__u2kqN-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NyBTYWx0ZWRfX6TqE9zQw92Ie
 qiK6HfCTgQ1YP08Qov9sranpBz7pVkjHAlagupx5C0NMI8e6CbHjsvoTmOZtgf98Ze9I3QZOtvs
 EpZ298EQswGeiaCalkytDCLq9Kt9g30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160067

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
Changes in v3:
- Updated Address and Data NACK error message.
- Link to v2: https://patch.msgid.link/20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com

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

