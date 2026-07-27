Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7553ED5B9
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144102; cv=none; b=G4XILKH3D5Db/oIS4s8tGxQu7k6D/4nZb+omOpnIxNgZ+Pcdi2ypyrCZm2rrUPLgIdawLaszacj0xWWzzc6PkA/znKfT7+nRB+eruF8NflS1I9OJwCBXzVUNK6lZCwY8Ty51j/ne3Wlxo1nwmezxwFsnMB+3Tk8IY+YDhqWEUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144102; c=relaxed/simple;
	bh=kMV/fIdncevKVfjmGtD42TtZdUil7gxexiPseZZWR6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKL1k9WP+UhKUuTgTw/OwSt2gJrJd+ayWAw/j+1IOSvjtd0snfs6QY5ur/+K5mIIsX/qXjnl9RMwfbRY64pjpIvfG6tLdbBjxJrxoSR9+k3fKJJChsn+xtDzCgtJU0Dwkao/A5R3fDmRkV/6CBZapeD4Faig6kkEWxtwKJIwbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AM5BV5dr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYh62izo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AM5BV5dr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYh62izo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9LaMe3455063
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eqQE6EJ/sZeK9Gs+yGgiu4HoQE4qPd/3LI0KMakU988=; b=AM5BV5dr/OH0FQS4
	EXwNz14zGf8kwzFVsKXZ0HMax/A5IZ24ZWW5bHEbVPJYsenjZeEzLq9mlsWZ9Ydf
	nPMIR+AgU83sOGylilS+3JH6S50aZyhpDTqQJuXg/4fY6BXu27UraG82w95DgChr
	ctnoNLDXmX/mobTgs5KjgBmraDTZdfd7Pnf2CuhXEwzQLeusiKtQSVHEerQqMhNS
	xWrbS5WdjFHwAhyJ8caGxxRo58KL80mN8RYwWIFyfO+n3j80TrBGHqgaLSKOjzBg
	e55ILfB8M8dYuxodMivdZqUqG2fEon5eyxY2XfxI7qu9p4DngItz8mGeSY6Gl63v
	uBI6Lw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mq000w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1eb52e1fso45987501cf.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785144099; x=1785748899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqQE6EJ/sZeK9Gs+yGgiu4HoQE4qPd/3LI0KMakU988=;
        b=MYh62izojB/mGF+Hodb3Va0LjQkEOS01rTG8AoWhah7kdb+Ew6bFX1LAJvWFqJ3GVs
         3zRkNr6wwpxji499wElC/hRik3+CdRNTLWN33DUa4qUgr26BL6WhXB6RbL8FA2DYqDaU
         AGZf7XAeiXwe7YZlfp+3nTSO0iVJrrIkRog4YqCuLb7kDhQMEs4lyITSJPOmVC2/J1nF
         UNDY456ObE3dDc2VVX2AR3EYdUS/7PTSD7sxq5lgkd2O/4iLvdjwltoQAbev62G/IRoa
         7BHBsVlhwWm7dZd2qlBzRC8OXn0to0PdNup9XlWhErlSBGE4tKcnLmsFZrpzg9NTWzwL
         pwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144099; x=1785748899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqQE6EJ/sZeK9Gs+yGgiu4HoQE4qPd/3LI0KMakU988=;
        b=rlML65J30YVjS2OrSPu3B7E0yAL+woapWV1IpgdOSz7MJqsBm0q5JJPecSbDJ2lqZN
         h7AWtMt+k4Q6tGzy8aU5Y1X7/z91TFHIuf2fDGXJoGHgpum60ZnG1XoOWTPdy9kQzY7t
         0imTXZcGBSHM2Sn+d4m7rMIJbKDSrCnjN5GQKBS0KGUfxwllTjNJzxVh8ZDTZtmURhKH
         VHNUdM2C5A/jEES4HN1jB90j0f4dVt13nZy7hay5vgCh2aHKUo3g6OsaXcxz9DoYayc2
         TYpRBnSAKKmSBn4/y1qUXRs0EbKavJE5lU05OAadgbssF/NVMVGn2X3wgCgJWepRSxXZ
         suNg==
X-Gm-Message-State: AOJu0YxT8tx85S40d/Y/+91QqBZU7swvsXHOir4b2MZSBR+ZbdLwogWR
	NyWsuxtaMNqa/J/dBeb4TshDMOL0LvcBSyRoZT+x2WwwTZO/nwEhQS3ax66imz7g4fT0Z+rdIgF
	LwaEE34imtxGM8Q/6xd2N3azrP8bvQF9H+QJVhYF++Qr4F4zX1Oa7Z5mL0QBbvQs=
X-Gm-Gg: AR+sD12IwdEmx5+D5K5apoEmGUkDwS162+2t8Pd7CfCP7N0hbGwMz6eAu/ESR4PCYyb
	o++H8VVJcYwXIWQiVodBcdNGuU3Ow4Kp9xIsJtegFzq896gdoYVhIS5g3j7wlqUY7uubQ7c6/h3
	aamdnTMaqD1lxoWRhh7nBrqARzNd9Jpfi2UHuTTRlzZ8H2zOvQj/GmZ92faBOy6YaCmFefKAKnN
	AGKaCDFYuGkZ1rCGwpbNavPgOBxGEFwnyZ+FhAsBC2sHuM9VOMsRgY3tcadPVyyePl7kojI7jeO
	yEWgwxYdN0KkZkdTKbWCGdYqnkLCStzyuSKPXUH939oQJJ0dXfwn+4exYV4SsALJ0plRCET6M6b
	5RwqlrCApf4QKogJFjT048ghQCOWVnBy/Zz7tqFUUuGjn5Po/qc8fx+SATF10upRH/72jZsflNF
	AfDRmdGBDZouXu2vIpgA8X6cod34Rs12XvHU94Cs4xaahAaqNmmlMI
X-Received: by 2002:a05:622a:5883:b0:51c:7b12:5fd2 with SMTP id d75a77b69052e-529a8775ef1mr73343161cf.78.1785144098674;
        Mon, 27 Jul 2026 02:21:38 -0700 (PDT)
X-Received: by 2002:a05:622a:5883:b0:51c:7b12:5fd2 with SMTP id d75a77b69052e-529a8775ef1mr73343051cf.78.1785144098322;
        Mon, 27 Jul 2026 02:21:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9babsm2265326a12.12.2026.07.27.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:21:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 11:21:33 +0200
Subject: [PATCH v2 2/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-cci-clk-fix-v2-2-c3958f28b045@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
In-Reply-To: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX3CjNRVjQzxtF
 a207EuUxkW3Kl2xmvf0jZpAuEcnlImKUx5oHVQOnOBxzHEhUZhtFIQ7ivlwtEGblx2V/NvlSSoU
 AkSPEDobJdr8MEC7VQVDbrnDIB2O45M=
X-Proofpoint-ORIG-GUID: FdItb4CyIyITt8sAPDkm0k6o6e9AOs2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfXzkeId0VZIlSf
 Fduv+yPjQTmJA1zMgvq+xVUbnAkpQH90bx7bkCXpw7qy+wF75Wof7A0VgQQ2kqaDjFVaOejxwW0
 CI4dYmLvWlzqeO4UNsN2Fn8+UO4/UcRrx7DMvxl1QVziS4BmD1tGk4gskBTfT2mGVRyR9eWvCTl
 YHc9RKTEGsDNfJ/kPp4PyExKxSWLn2az+nB6V40zEwRfcKcA/bwiqMapA6VP2/4TxLO/EmvK50B
 KY1q1gFdbpIJI+8UZ4Ib5cia1awX2p1aZnrLjM9gwdaXy40pnkR5vpstokGaapzV90Xm41zp81p
 T7l1WFgsinYy3o6gZpq5C6gyhS1T34XKDIRgeBZ626IBxGkQiLSgOxmdxbQZd4e6XKE/vaTEZbe
 jpHbiGehjoXaPLHP9wjOxflxpLo2NCo0jn79B9VvdDmK2rFQW8gLSKTSiTYpADAmzM0HCJq3vpK
 kuvzNfWwgBP7Ssd1pHQ==
X-Proofpoint-GUID: FdItb4CyIyITt8sAPDkm0k6o6e9AOs2A
X-Authority-Analysis: v=2.4 cv=TemmcxQh c=1 sm=1 tr=0 ts=6a672323 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=wn_r6Zk-WEjAk6jVh9gA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270092

This reverts commit b641af684fc28a07bee9c808eb6c433f9d9bcec6.

The cci_clk_rate field is needed to enforce the correct CCI clock rate
at probe time. The hw_params timing values are in clock ticks and were
calibrated for a specific frequency per hardware variant, so running at
the wrong rate would violate I2C timing specifications.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 23cef922351ce44d71f1691cd7e4aab274fdd196..2ed58b2a2f31c62ee1c972a53b71f86787144b84 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -117,6 +117,7 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
+	unsigned long cci_clk_rate;
 	struct hw_params params[3];
 };
 
@@ -668,6 +669,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  19200000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
@@ -701,6 +703,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  19200000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
@@ -734,6 +737,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  37500000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,

-- 
2.34.1

