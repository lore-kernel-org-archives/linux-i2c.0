Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830833;
	b=wW7l9Fm30YdKnKv1Nzvdzm6P4gdbBmul31uD75L7qgAi3FSVRijmCOG6l5wPp4WOEfPk
	 gvqrTwDzddRPR6r+R9Z8ALXwMkpFVw4uTw9b27gHl3/aAH0FoB1VaNN+IqDul6r/xACqd
	 wcEsRwqRMGu0nLz6Uh88eywMHomkErA1avakhBoUTV9EL5DOmfzSgpJl62tyEHz19oM61
	 j7rjez7w5LI12/Tx3y9I4UqobUyvYMAyq76OdARzMA/uRxVaHH1dHEvEe0PtWvTpsqFGa
	 VSCc1ZbgY8bnu4hmFpxHyQe2Repc4Fjn1HtPMPmfWlXV3AIgIXXT8RKxD2KOEuO8bYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830833;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
	b=o5rRBxiln4O7mn1ySTKnpPFEvCNym9li6K7Obrpdf4P1CO2HHAjgIPgpaQ3oksd9Kdoq
	 Oci8/RRhAN7KXLver3ZeiS4KjWutL5LSvTEKO3vaYvTNX+NqGsWo2S8Vd4Q15QNm/Kse0
	 0A6h6RVSKcGR60c00i4EVsO1z/oHtjtMKGN4RB1aVuyeAGKtOEgAM7iy75VaDfbx/zag2
	 vvMi8yrcrGhsZr5ZT65VpL7esuycNgx/gFkpSfTiP7dNagH8NGf9qbirZMFgg5Ey+vUuN
	 jKP8ZuZVlG/G7LyEqfjMA3zGXsvXOLfUD3lNqpADkTSOTiW0YeimjWN7igfe72LJ7Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q8xHSQjH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5skqRyU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC14606A32F
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC14606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q8xHSQjH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5skqRyU
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC0neZ1101748
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhw
	FP9XSCrI=; b=Q8xHSQjHp/hmnNpSyiRKlVSHDpNZt1fwdsz9JxUAl1ggg6Qj883
	mG4bdqBuUfUwcsLM8B/buJydG88NiWLotQ0SU1MzOTwMd5pZrGFb6jYcrRU2NNfT
	qwiGotd+j2+p+MtwwXI8Oi1XZ8wF6Q5ZINk5mrXgVZnOJYHBun3g0K1eNcv58KaF
	JQrvcDVoUkrb9aBYwJucQJpmZeY5ues1n3lK/Hw3WkiaA6EcuQvhQU4auL//GI+R
	lBSJYFvQqY4ieBp3Z8woEVteRcMhEZpb8gmv4yIwtkfIqwvK8Jpj2D8/cB9NA0j+
	b9TRc2V3zuzsPhyfsYiQaKXy+jrORj1zl2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003gbwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 12:07:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94975041698so255888185a.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794830831; x=1795435631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
        b=D5skqRyUJ+j8REqkC0IBBblP91hmLz1aycitq3J7h6IBRm2BEClCDXnQEppzqJPpY4
         THzO7m37q2XRxyVkuM8QoxFewS3GdofCYKgkUeGyHK/PlmzTFvftW9wcv9hvs+AYXplj
         X+9P6ohJ8C/pFzkd3Vbs+SxVnx1L1lBRcwZJ2eTNJ4UU74YZkFfQiGHdWkY7q5rI25V4
         x140P1zMa3tPov1mzm9GcM4ncoOhRvwbWN6PRRfF4ZTKccsF2bQKGZTVNBpQIu3oBoQq
         1EGjrqN5BGbt5Pz47oiKSVF8R6AH4dta6Nw0qSCzHc37PHn6/uHEaaHmTm2hRWa2WjPB
         PfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830831; x=1795435631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7W9UVaJAR8l8ahCPGGYHBojy004he9mjdhwFP9XSCrI=;
        b=E7IRrY2YQxv5zhIbUwmMQ5TPLlS62XdsYwixKI8VsEDOTGUb/hA3PUtEIXV07DTRaE
         fOesYthmKq54+0Fs/zB5ZdqxjlsdPEJFcAlRZuzFzRejsiFzyhRmnrf16/Ss3o6oLNNe
         c3RQXTb0Ig7kdmmuVDRMqlwnAISs+Pe1ZBdF7PL9kXO3L/iigiDD6oZq4qiQ+OSAdVeB
         l4IS9M80B8G3tEhvaY6f+bW3BeFYxxe5YAKBj2HmG2EvOrOP85CCl2dJX9YPXQbNr1bq
         L/REqSztaEqEh7/iFv3xj8ollI4q3d388FGjocSlo32EREb07iWZpYL8YB6fDPNBoP4p
         iAMQ==
X-Forwarded-Encrypted: i=1; AL+hErE5Lp/vjY0LWMNsGDVNj26mVgaOg80if7y6XD5MPbDdKnnGhBkmRp9MjGWqVbouuYdszjF5YRMWYvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DgDUzVRKt8EfRYQfjaOZdDuJXAaGgb+Fg2CruFH3Y59m1hirx
	3i/TBTLdgTZL/QtjtUvcozgaYaocemHZtDHl41skkY4mnTgD31o2haXRgt+0ecnjBaq8D8JPC+m
	cMhzJybsrqWe/18i7hKQAWHpP83skATg7WlG3f94Lf8SJ0Q7//0Se7Jpv838bWgg=
X-Gm-Gg: AYBFou2ozajG3rU4NixJkUbOEo5iP2UfRuAUpi9Rb7QQX5TxbAYjzTTrcYvDnxLmleI
	4F3oO0o3n+WTvzp6WlhVCciRogvIH5J72+hsID0eN5jNKWPCoLEWxlYsONHzVWAsMkMqrrXOjIc
	uOj/ffmHFp/bgVtI5jZQuBwGmhjpuSkKWrONRSFH8nQNkEUXcPK8AL/sOD+O1roszQPIIHlWt08
	g5G0Nmh0zqDYUig5Exnq8S5W7GLXbDM4WbH8frIYGvYAnHUAIXwbbk4NeCCN3N8YkaTHJ4hiKyw
	BvihCcuGu6TYnRHLr6p2yRkYK2AtNfySN15DUaZs384Uoh9hBji8w+a2NndzAlQgrRJEopogucw
	GU25pCuyAwfAhqePWggZWQycuPpwmnduucUyndn9CXrBwgJvGUe9Xc6iaji4pxFPt2+V/nGEjOE
	/2c2hE71iKWfc08kc4n+gzBA==
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr2028555785a.0.1794830831020;
        Mon, 16 Nov 2026 04:07:11 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr2028551585a.0.1794830830473;
        Mon, 16 Nov 2026 04:07:10 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm21564581f8f.12.2026.11.16.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:07:09 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2] i2c: acpi: Add AttribRawBytes accessor-type support to OpRegion handler
Date: Mon, 16 Nov 2026 13:07:02 +0100
Message-ID: <20261116120702.6146-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O6G2jRs_DeNhFgsntftPzcsqRBFRmvdi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX1S70+w1tE7wm
 U5+DzcjRwpO9k/nxSfl7CdMSXkVXWAm4eYXRoxd8bV98MU8YltsmuR2spbRhryzOMYCU5mBYMkb
 XS5nOjnmASG5jqStxfit8BMaZaeXHO8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX/Hr9Ls45lNPL
 sUO9hyGqbLNckTy69O3tfSvvnXN5fly5bKAPzoNkJHVuhjOdhK2hkZSRq1P6QTYga+Jzu0K5Qvm
 Q5FRsTw1Hg1AwFVTb09yC90miuMCWiRkRg5fdYXrV/m8LlhOsojEd8g/nStPMUG8iawKPxop7/b
 TiQCOcamsvMjMNEEYTdrz8X3reyAdYNvG9cw7ib0TOGdR++TxrCjpJkptcp65RuhxIkxhTaidll
 /HkQLm1P+1vciVseVrLVwghUovlwG7z4GDJihYj/MJZh0CsAPoYHQwf3OioxDpyQ1wib9VqWMH1
 uiMqdX2iQgpDme9j9jDcGWzEObgJIOtZdI/4dBCBMkc+BYZZJcXptUGW/F6c/R3MCrTDfciV7ne
 /YZGjXH60ul+XzqDX6BfZID6PVd/2sWNW56KRR7icLVBvgR2a/Y/vL1uZrC9w6hSjhtwtTiegxJ
 /F5V3i3MXQxfs84AbAA==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afaf1ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JQQ7xCQNSWZi7JF5RkgA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: O6G2jRs_DeNhFgsntftPzcsqRBFRmvdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160048

Add AttribRawBytes accessor-type support to OpRegion handler, this is used
by the ACPI tables on a ThinkPad T14s gen6 Snapdragon laptop.

Looking at the AML it seems the expected behavior is to simply read or
write accessor-length bytes and this implementation allows successful
communication with the EC on a T14s gen6 Snapdragon laptop.

Acked-by: Mika Westerberg <westeri@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Check the requested amount of bytes has been read/written
- On an error return from i2c_master_[send|recv] set gsb->len = 0
---
 drivers/i2c/i2c-core-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..f4f7759c2bec 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -772,6 +772,20 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		}
 		break;
 
+	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
+		if (action == ACPI_READ)
+			status = i2c_master_recv(client, gsb->data, info->access_length);
+		else
+			status = i2c_master_send(client, gsb->data, info->access_length);
+
+		if (status >= 0) {
+			gsb->len = status;
+			status = (status == info->access_length) ? 0 : -EIO;
+		} else {
+			gsb->len = 0;
+		}
+		break;
+
 	default:
 		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
 			 accessor_type, client->addr);

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.0

