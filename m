Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D484A43F2
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360328; cv=none; b=E/d/o98tx4TGocc+UWzQKAoFGrXLv6FE2WRVUTqoIQIAS+gEKfmhjxqgYe8Zx2YjxfCW3FIiqhbPgRAsI2+koxjaF2ry9Y01m1ZUQ//03hfl0uIPrGiGagB7Q7c4fY0Zc/1bvE60r7k/lC8aG3LcHZAYNcThIMIL0UMO0ZPyCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360328; c=relaxed/simple;
	bh=2XSYd+uMeH5gLakhM/d5Rj7ofyalwIJWFXM60UvRoyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J1JczfdKojizv73l3KtAyTBwGhWPK87tmOS29XdCpmvigPVG17HodsaTe6SHXOTi7mADXx+9UTHfpqQDg83EMpKK1e8uTTVanBmWSR0sMT1dHGUis51v6qGQrbUEgUiIzY03vsUjUNc3fiQY06sgUMMl4TahY2bogDVR2RKxyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RKLaWNSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7aJaJhu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RKLaWNSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7aJaJhu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CR9U91647747
	for <linux-i2c@vger.kernel.org>; Wed, 2 Sep 2026 14:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FCRacwcNCuuftR2uomAhOs
	TH/tlq0gfZo384jWYVro4=; b=RKLaWNSkFGtMRs9GGg5f+9U6pUEUbPfgikOSKN
	eOSmiA9uy/EcXwjzZ9oaSVxX3fG2RE44XFotftIw8ogU9s/65A96PAJ80wKy/9Ad
	5mCBBbzaS8rbmt3TA3XmMWiXuCTl8MotAxEPby7WTb2tNJHNiqCI1VebjLlSfAuy
	eYhxyOaA6OJ8Dxt9A3pLgtdTqFfW3T40wYuoErBas+MwWjaLAF5GGSmob/Zj+4Kv
	3cvdW4z6i6nLF/44icmDiHFbH6gukSCPfqtK1Qimc9cMEgspeMrkz0DCyzfJHiLK
	CL3gh/avw2t0q/Y4s1LB6z/7mO7qsK+kmajXQu8XUJTMNLhA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv88s8k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 14:45:23 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b59d85dcso2132529a34.3
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788360322; x=1788965122; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FCRacwcNCuuftR2uomAhOsTH/tlq0gfZo384jWYVro4=;
        b=e7aJaJhuoi7njUWSvTmgGEF3e4MR99wWfmtfw53m4FrptdZx5PRvQ1RLqAFks/QNSG
         2O93VkoIOP3iZBEu33UgkkE2tKCv2PNOgqKrEyt+tLQHsMoYz/XlKZK+fdWBz54ZeWLW
         hL/PbYFNnTG52b/5v2qhTOoQ/zgB0d8AyNBEQY40ZaAmizjvCwJs6wrqqBUoVHwQ1CRW
         aUBdyd+laxVXZ28k7zdbbTkB1JqSWnRn+C1GePGHx5HicMG5KMD0O2AkEJ9+O7ClcQxB
         4VtfEHDbmq2G9f8cK1QRheawfNeERm1zELxg5wPrUh78cDD8oCFMpNUXQLrkZl+udPDE
         RAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788360322; x=1788965122;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FCRacwcNCuuftR2uomAhOsTH/tlq0gfZo384jWYVro4=;
        b=SCcRDvyOjUAG01B7H5lxIHMETx7wGIqbWfhIPvD1v6rkEguUdDEkXmvD8jLAdE62xR
         s+IsbtFOh/tBI+G8lLg7Mez1h9MQ+OoidYd/j0u/Hl/jcGM9eSB/kdG+mMlBcy/B6FP6
         W9bLFLOrNInxFUeu9g9J/8+N34iAQWTqy8viOO1BPhDHGQbOKShlu0C8gQW/oGeSPi9O
         uLdeUSR0e4fif9rIrAthfd4/Fuhr0Qd35XGgOQDiuIaEafBcU7MHcvZGeBzpQRwBCU9Q
         K6y7ZbD/IQCwUk3e4cNXB8BC3O3CD1ELiQUoF1G98fgPb0r9bmBJ/4Ek7WeqRTa9UiLT
         nkiw==
X-Forwarded-Encrypted: i=1; AHgh+RqTuViufQuVPhzo79Y3JQTQzAjG+UX/WhVQwM7kEdcwTnj3kGHOPBHGLdZ8PNuFLhr7WjDSvEeGZMM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7ybY9tUz6dMFlua9Lrtlu0l02zkP1rTXwETCx/PY6ZOnUk/tQ
	2NmfstTfDnzEzPappHN0wIB8jwCvtfGCsKWMDOw/b+cW6g58fw1dfxKFDK+TmvCM5xfYNQxRSws
	0CnqHU6q6N3VNgIjq19OfdJVZ7IlKHBJz8zLh4N98lb1hNJS/P2TW50oFsGnjtSk=
X-Gm-Gg: AR+sD100sxkhy9lsKECgIHvVNrRqs2N6RPJ8dIVUHaTU9n3C0d7OvtA8UM8Sw4Sfk8E
	uQwd0HCBH7RnbfUISF0G4PnHUE0b+VDlJdkJs9umSTIXy8Jh82Oih/ZLl7Xdu3zINT5zAybkP7h
	z1SUJe8kNfY1lLzNtN3yRzFIYHNkqCr048U7WsxLW5aU+wi7zTs8j7hONf8RAA58CTRJWKswQ/A
	dCNi/55s785TPfxldAIHc3ViBRegdT0vMBsi36o50IUo4TuXqCdp1vMTy8DYdpHIMLJZzSpV5Zm
	UZZbCgst6qqtvtspzlXVLBz85JFj2nSf8Tw8iSV6nhQ4CROXHgmCE43ivqwbUpgXvwHQh79VGrs
	g2X53JYgtAn/4QQDVLm27cQCg7iGOcBGas7E=
X-Received: by 2002:a05:6830:2644:b0:7f4:bae7:b00d with SMTP id 46e09a7af769-7f77c3d32edmr5060976a34.0.1788360322519;
        Wed, 02 Sep 2026 07:45:22 -0700 (PDT)
X-Received: by 2002:a05:6830:2644:b0:7f4:bae7:b00d with SMTP id 46e09a7af769-7f77c3d32edmr5060940a34.0.1788360322056;
        Wed, 02 Sep 2026 07:45:22 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74caad7d0sm2427286a34.4.2026.09.02.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:45:21 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 20:15:13 +0530
Subject: [PATCH v1] i2c: qcom-geni: Clear stale TX/RX buffer pointers after
 GPI cleanup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-i2c_double_free-v1-1-0f582ef32e55@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHg2mGoC/yWMQQrCMBQFr1Le2sBPFpV4FZHSJK/1i7SS2CKU3
 t1olzMws6EwKwsuzYbMVYvOUwV7ahDv/TTSaKoMJ64VL9aoi12al/BkN2TSiO+DBH9maxNq9co
 c9PM/XrFa3A5XlvBgfP9W2Pcvh+vTu3cAAAA=
X-Change-ID: 20260901-i2c_double_free-09ab0b97e61d
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788360318; l=1839;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=2XSYd+uMeH5gLakhM/d5Rj7ofyalwIJWFXM60UvRoyg=;
 b=5h5W2YkcbVmFfnSC4JOb1Q8CMLT5cgcG6+5iN5wnZ4Kjh9MosBoBn34wkyqzQ3tWv++9eOARf
 uqY3rd7vp34B9x4DJT+vvgt3M8GZqgeYsVJDl6p63tPILpAw7dAaf2i
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: zQrGY9i64HquF7oVCxbfAgBstfagLnJG
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a983683 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jmCgmGzY3TN8gweiy70A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX5QXuV9ReCGKh
 xVOi62xnvo+BC6Qh10D/NlsHTLpGrU8xJtitymFGhsZ49Gqc3nrwHipLFOwRpWOX8NqO7oJwd+n
 qWVgzFh8iTRquyFdK1LpW7eNRaTxTRBdxGSdUz15v+E8LaD/8rGlmSajRS4KkZiIOS94buL5Kl9
 kvyLwnGNHrB7xuQ2RTFilVRJVzfXJvKwNKKeq0DwpH1WUdFQ07iGxcjbTnk03TI9Y6J2xgGNzaX
 PpBAk91V4jFPZ1mYDUxE3ODt1CKvI0bSucuj5LFAlicrVD//I7P8kKx5ES0Se43cIKA5HlkMxkg
 9cYR0hogEJhYiOCbATDF7+/I5N4dcl2JQrX+M6B6pGap5AdDBWDwDYD/YUxrI4YgFx7aH/851GP
 BZqajVLM3wLzoDhcNrZ6XGhjuvOEmJ/CX6u8h/+ktd0+3TFnBExgaPg/8lJsjyW5Xo5XWIWyoRf
 rmwnFH97AbJvdULnE6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXwnQ7ryZHJf5a
 0/GAe9r3ZU2+SLxRU+Bj5IGZH1SqrtvWGPwYT/srLK5DJWlIwliK+tIt1u/SnwYq7rhlOw6HNN/
 fAgg78TqeBbvYO77yAKvViqccLP6xc4=
X-Proofpoint-ORIG-GUID: zQrGY9i64HquF7oVCxbfAgBstfagLnJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020130

The TX and RX buffer pointers are reused across messages in a GPI
transfer. After a buffer is unmapped and freed, the pointer is left
unchanged. A later message can reuse the stale pointer in the cleanup
path, causing a double unmap and double free.

This can happen when a READ message is followed by a WRITE message,
leaving a stale RX buffer pointer behind. A similar issue can occur for
the TX buffer when a mapping or allocation failure prevents the pointer
from being updated before the error path runs.

Clear tx_buf and rx_buf after unmapping and freeing them. This ensures
later iterations and error paths only see a valid buffer pointer or
NULL, preventing double unmap and double free issues.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 942cfeee99ba..4965872b47d5 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -911,10 +911,13 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 			goto err;
 		}
 
-		if (!gi2c->is_tx_multi_desc_xfer)
+		if (!gi2c->is_tx_multi_desc_xfer) {
 			geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
-		else if (tx_multi_xfer->unmap_msg_cnt != tx_multi_xfer->irq_cnt)
+			tx_buf = NULL;
+			rx_buf = NULL;
+		} else if (tx_multi_xfer->unmap_msg_cnt != tx_multi_xfer->irq_cnt) {
 			geni_i2c_gpi_multi_desc_unmap(gi2c, msgs, &peripheral);
+		}
 	}
 
 	return num;

---
base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
change-id: 20260901-i2c_double_free-09ab0b97e61d

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

