Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10B3921E7
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846613; cv=none; b=CPqSc3Hd2Xgx+I2w7+yCa4D3Da/PpVbTR1/FAtSP4fE7aDqZtHviNqmXIjbpMeI044Fc98pVZ/jUg0TTga9gM0JFLR0pELzv1QW/PxhQ+ji4+pZC49FZ0uGYjiBArRBg29a+FzXuVNqLsCQkHWtMZFjF8VAPydEGp/DQ8aHdiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846613; c=relaxed/simple;
	bh=evuVvMsPb4aPlMc2LL2oBDOV9a/NkvpIQachjy0QdQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuWH+Jv6t0t7LY9Q5JmTi20Bers+lvJbohnXFWQa8zPdHeEcI3aOVOKv7LNLTdTV5Tq7NKyQeGIkoYDAuHcxGVeckeQW+73S1AbD9X9zuoSwm3Xg0L7uy0oAc+m60mmx3MwuVXRkqPpgbTAkOzaFQ0FEL/2ugezOTgd/+h41Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JS0bfayk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CN4NWcP5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JS0bfayk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CN4NWcP5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JIsji2876491
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8khxm2834in
	Oi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=; b=JS0bfaykEkC29m7S64lalu5C6wq
	6twFo8EeZFERKqupOwl8Sgcb/K1pSPLq7/hL0sZjAIU5Tod7ph9IRf9fQf7PiBMc
	T7l2lrg/qtxgJd+gptTjqst2po1gBP/PF/nBxhsQvbGYZ2r8AUYrUAd2P9CNAeBO
	QVOxBO8r9Woo4wgBPHjeVP8Do7AMebJPQCOxG0P/8B6AyAAGjrrkw7We6ihOM4OL
	FBC/tuX9bV2KcwCjdOqJrg4Y9FGSUJlqgHCGbTApiK93/H0qTnfzT7wgXaBkSTdt
	i48IWRPyyyD6vLkpQajypf7DxDOyk/1nJ8MbRmDOSLShKXxtXa0FEt/qvkw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxskdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 19:36:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939d6c515deso386577385a.3
        for <linux-i2c@vger.kernel.org>; Sat, 19 Sep 2026 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789846609; x=1790451409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8khxm2834inOi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=;
        b=CN4NWcP5IFiJ778VENJtwPO42GIVPpXjnEpJi4oDWVMoJLtvUp0UJN+CdMO2Iv/7D9
         Xdnzy81Uhll5f876LDMV5Rn57cpoMTx7eOpNtGSlVNOYVMyOIOvjLVeyMUXB8h4/Zzll
         rAP5uSdddpmY8qj8UwpaKWcCX75aZGzJlrY9cnUKMQXTYFe1RPM0aNeVsTjkxIURno6i
         WRaLMb8+KUbQ2M7gTzNoPumF+l9U6lLZBz5SMdCKGTDrt+Z2ZYy6zri/9uqNR8y/HD6K
         CTIRpmgfHzSYTaIcSEZtbXm9ItA0Ke+lmkbv48uEG9Ig01gtqa+QTXDwXK/2fl7wajKG
         94XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789846609; x=1790451409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8khxm2834inOi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=;
        b=uLnCEOAUhZ4NIkf3Jo4yyL1a99/ucW2bjjEnKpTVzWAl4uwL2fz8Vp/kaBDVjhJeeG
         l7tFdC0GJFX36Yt/Pm2dNdnE4FALD4t2q3u0pqUQbpIsnNwZJqXwMjdZucjzqNqBOGyw
         p4/KLsAh8OaIgW5+1EdkC/DbDHWbZceYFKHaqb56RaBEY2yoAHnc5xcpg5nrXfICuhzJ
         VTxxAeyK+0Y8un4b02sMk7MkoE3gi8JrZrhI3f5LgieVUcquaPbFJinPxEsj6ARScXNK
         iBz9nzbuaYoRpOIi/8LWJzFZkyf+zjbYWO8pfU/RSf83H8oXWXB63F2R8aKwkZi+LZ2n
         mGFg==
X-Forwarded-Encrypted: i=1; AKwUvBwk0xlrNLOb0pM5ElMfY8BSvcfFlt2NjBRIX9i4mG6VRZJPc65GvSwknqqbdDY5gbaqwQII3C35fN0=@vger.kernel.org
X-Gm-Message-State: AFuF++mXExr6ATjIS0Hvgb3cSOpaqu2BukvInjx/l4bR0eCVtqLyjYl3
	84KmXRtQ+6UpcxJbQPtqwgbJWbl+hWcuEj7nKvGQenwBKLslrFItha1rMY2M9JUeX0Wn2vwoG28
	PY9kvT8oE1XFpq503ccmm6QovwFs1V0Nr03PjH1pzMY7Ye/lVw/bpKie0Y31B8+I=
X-Gm-Gg: AYBFou1DsqX5jVZiGCaVQfAdSHUpa+Tw/brDcO5Pv7/mIDbOd83Leb2I3ku83xVy0sD
	AXQIZ5Enla7bNmK24/gJ6yw1a2tjzjjZLZbjQnYQMmEqZrR7SzvzYILV/LDutXvvwTgaBf3mgEC
	uNWQsP14mu+MacQO8MSjEYobUeYuR2ghXGT0BGRPp9fssHDx9Ia6znskgvMLT/iE7FuVAm318I9
	E/Hh2Y/yh3Qh4y6VapP8cBN1PP8VJmSwwbvyref0EoOlCBtksxHoJo+077qmrym4GPeUxYKgB6I
	zw39SqdwfWxGkpiotjuholpnwwEw8qSyQbeWJaS+prZUDRO0EycE6k2dBL98Nm6tbZqE4fDt9lK
	+pFRHHLM6Gz7I1m6Gw7c74QweW9eVXIkHt24iXu8FnByOeQPy/LQ54xavEkCo6ocxW6sN7tWSu3
	Rt+qKUFQzKGW8Xjg==
X-Received: by 2002:a05:620a:1a13:b0:93b:d79e:1903 with SMTP id af79cd13be357-93bf578a159mr308371885a.70.1789846608961;
        Sat, 19 Sep 2026 12:36:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1a13:b0:93b:d79e:1903 with SMTP id af79cd13be357-93bf578a159mr308369585a.70.1789846608530;
        Sat, 19 Sep 2026 12:36:48 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dafe8csm1623947a12.13.2026.09.19.12.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:36:46 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support to OpRegion handler
Date: Sat, 19 Sep 2026 21:36:42 +0200
Message-ID: <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6aaee451 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=JQQ7xCQNSWZi7JF5RkgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX0zBpv/YZNypk
 9Yoma/42SS5Zsf8u6xOckwTvc1b/gk3Dzrs35lugxStrIroyh+70mWw51NbNObDfi+OfieSH40L
 LQHGKBAq8mhtpht7TTxaleZZJsNGwpI=
X-Proofpoint-GUID: ib4pqhuXBqFKPHltMjyq2JYxvnKna8F3
X-Proofpoint-ORIG-GUID: ib4pqhuXBqFKPHltMjyq2JYxvnKna8F3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX3DwgZRHxC9Jz
 jXT3ADhMzebXVzHrwPx3s1IZs1ADa69DfxV3vKg+U8E+zYtw2qSy6QwXKBmFWC//wztiMcLe+Z2
 RsOOmIQc+EunaozMipxs1YnkHjkWNTjoC6N0BgnQKWwjeDn6sgNHZP8aDX+DjbM1mJuzHCSF6hQ
 mAzGzViRhISCeGQXPne/Gp1y0Gmf5l9Nybym5ZtzfaeKrfhIlmD3FMZkevs5p3jBfFK2qfX8jIQ
 VZPrWlVbNWgSIt1NyMmdDDn8qcLm2qn/5+1/k4JsGejqJsXGqH37/MpzqJ5YrKynAUI4wAOpvWr
 edMX/Oiqwt9ko6wQTJi9+VwsiF6tzgYiJfCVfElp80g/v75qVYlPSz4f19jXGlvHCER2ux+DnQq
 Fdk1xYv2CMYsHeJEvfTrZqVQvvf1AIZewWrvUu4zrFpxNCtz/W15yL4v1HhTsyhWxiVmWmsmBXR
 sm+W+K04bfDTbeUKEDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190287

Add AttribRawBytes accessor-type support to OpRegion handler, this is used
by the ACPI tables on a ThinkPad T14s gen6 Snapdragon laptop.

Looking at the AML it seems the expected behavior is to simply read or
write accessor-length bytes and this implementation allows successful
communication with the EC on a T14s gen6 Snapdragon laptop.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-acpi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 583d89c626e3..31fd88e63bf5 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -766,6 +766,18 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
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
+			status = 0;
+		}
+		break;
+
 	default:
 		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
 			 accessor_type, client->addr);
-- 
2.55.0

