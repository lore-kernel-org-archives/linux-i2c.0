Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9814B95C1
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887434; cv=none; b=LsBLfooQd4AFyXxge2tFc8ZsphJbnuTYow+csyb9E/s5GI81iC6ddVgmL/619nawQlOBDuzlTimF7JHP/Jw9opzr11O15QgV5W/4NfGepmTtEVh5YJbKc4KrllGfl79emiFeHe2qlInpkGN8/73yHgSZwPJNzx9kVrKqchzZlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887434; c=relaxed/simple;
	bh=RaqQ3P+jo5TiduRAS40/77iRUsyNVJuDolsbGIV7YEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdmQlqco7xtngkB4pmJadXVWAdsTk4feq4A/lfhZP9ZCBN8kqIKafi+VA84rClWUisb8sPgh8ZkBRl6QZIG777MXl1XsYVnQB2CXaHz5I0FYYrx8IOFjXoYZl3dJIi3mDjuuSpeisxwKXveFCHL3O5vdtapSJ54cDaROWlf1kuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dde3S6qy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SxGh05Bk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dde3S6qy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SxGh05Bk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Y4NV3907372
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQojHWPHBxRwjh4lA38mke9QuiPBGVFsYPy1tVQGL5E=; b=Dde3S6qyJ+EsCRVY
	XQQLfnqTbeKDm3OHEzXO8Q6+4gR7CQkyJA0QFgMXoH/VfV27U+8sG2ebb5gTBCNK
	6WzBOz3issHdOYk+k/hwwX9VeNgCj40f5iYM1PDNFMfmuFNcqZIpy4RMAagLUTG8
	t78KXLwzB1SxmjkbPp0sbDr5fx6DYjoXlFaBhm9BSYGoojXruRYcFNp86G98IEOj
	dzapOZHr3oV3WLc4CBt/ZrgLrtoPJRyUvDi+/PAP5ONMlRl9IK4Bw8QymQO6NtHR
	NlqORCVtBDRXmABVrR+pyNuefnlRnieTtyJY71Qt1f1PUcAyVosUZl46+0GreDrn
	8dugsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqu2bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ea9ea9d13so469878885a.0
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887431; x=1792492231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQojHWPHBxRwjh4lA38mke9QuiPBGVFsYPy1tVQGL5E=;
        b=SxGh05Bkt7Du2zfphVZqmb6wARDhcUy3dz5AyvxwdvVHk331ssUBPe6v8y0I9Iojdw
         Fd1EE1pgdn8Ch+PBk3eLUF7GEQBS8u6YCeZSnw0GT8VOm1u0zAy1oxRfSm/gOrKHOauv
         dVbnIC6VADB3pCfDuvBbk7qhuMm1Q6n83JbhAjEVyfByZPL8qINrhTCe80HG8E4zbgHS
         qFyKyM7BxRLKnnY6ye2jspvkzRMYfpMYF6eB8YZQ+FzpG9F2pd2U5Xc7Yul4ErKxf28d
         wS5r0/iaiaPG+OaxiS35m+zQdhtpk1fdJdZmOw8jZh4LSg9ndu3IFTBLTw6f0DqHvK/Q
         j3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887431; x=1792492231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQojHWPHBxRwjh4lA38mke9QuiPBGVFsYPy1tVQGL5E=;
        b=P6PbRgpy2/ZJvfv8DcJdeDylsu/no9ZYcjpGecs54XcZ3u+UaHXocPbqksHy11j1wy
         iqKI+wPMO2qaKdPl9cS4D0IgzLTLiAnyPPxMpMAn5O1SjJzbkRuyEKbpI9oA1AxaKMhA
         4AX01LRMJ01r2vxuKrte2aDb5xAnTLNhSb98aUHH5UOvZVTFDYAGRN1BEu3Kre/LHedp
         lS9U+RR21JGONle5LeyemUNRpKKkhsev3HT3H7qW8F8zswxRsEzC9VxbehjpMS4oU1Cp
         nfAFvaK7M/e69V85gTQ142A0V4ez3C3t+CH7rtn9pJBCx0pawNDmtajUJb4/QmgpdG9A
         8NQQ==
X-Gm-Message-State: AFq9FYLT4kmb/EnIdSxF3N3flDBNIQrgWNbRxSkftNtwXNh6SwvE0/1h
	OXlLyEFLEm7ddkqWVqX5bTCRe5dhWS4i+/zUQt0nolkJXsXbCy4COHKp/t70dGLe6Sal4MHRmXp
	jOo4j4eb+3idyjQJ9RyQV/rmfXqnMmhcRIxQZ+uGOxwj96fNTPn4jsn4uzplP0w8=
X-Gm-Gg: AYBFou3SnsABBAd+ULfbI5QGwVHJi6f7cm3v6UU4Qr0Zww/QCcEOLlMsvp1L3mHm+xW
	QItZS0iTQ4jMN6yK9jiWACTZk9wLQr7so6XAFaxRNQ3FJkKaWzwjqxXtT0He7SDvi8mC2Ig15EO
	iz7bu44tZZ5HV2SLCwZjGVuPh8/Eks+3Us62//uRkd47NVditoKDllmjCR14o/HLCEcPcK+ykD2
	IwS4IofS+l/M22V22ljXizbF35fBnum7uoxyZVpcFiVHlkkfyTVfmp8+V1UWpBTCO6drab7u4oy
	ZyR9TCOdyx7m7hCxGwztRN9MLkw9P3LLPZXCA8vfky9ozREFZE8eBQV5RjIA0ABIfRL1qVoDvoi
	dUYRjIuPV3Gna0a80dLaIuiKFAcfqebsleB8L7xPQM+exppiZcnYfk/yxAkTem/BwrV7w9zp48/
	qHqdk1sdUHH/+kpz/nVZXcx6Lz/vqPnAussa5Pw9KrykA7YGIWWn8=
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id af79cd13be357-93ec12c9f5fmr1331961285a.82.1791887430393;
        Tue, 13 Oct 2026 03:30:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:20b0:93e:c12c:9b77 with SMTP id af79cd13be357-93ec12c9f5fmr1331957585a.82.1791887429729;
        Tue, 13 Oct 2026 03:30:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:25 +0200
Subject: [PATCH v2 1/6] i2c: qcom-cci: Factor out write command queue
 programming
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-cci-imp-v2-1-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXyq9YtL9nAS/8
 cJfrdy0/KAk52wAFSYSr2yACAdIeMq2wKxAq2GA/MZf7BXBQggG1H9OOalSPe3vW2fnYNQdvhuQ
 kWQRUfRLhx9QO9AFeG889WDKv3MF0Ob1wphCPJfZdwHi7xCyDhU+okgJbtqCTdwR0KXtm7k3jOe
 recq2ftNcPrXbW+yKhoQbNegQpqg4sNwrK4IrK1JjZOJ3bFXIIQdeQvYUT5EpKoahpVD7qu5OfR
 +Fflmgjg0NTO8pjHkQjfaTKSK41qJrFZMUCD0kDjXrXghu5MYfo0xff6pf2jEExR9fSSHSFuaJ5
 3FoSq2sGQYtOak2iAgsJ9i+DW3UP8OhZB0Ta5iS1qv3r+pkEN9a6Q2BPUzFpQ/FGb8gpc1hEBM8
 L/4MVMIFiQvybA6bkdrPHp0EXIJoT8k1GpbQFUfNJJCkbG4wZ2DvQ6mhImd25c4sqMqUzVy4ENF
 EOLD0kyA6MsSXavk/Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXxyLfAFZTjRdR
 kCekaWETNbY/vIj2Xz09ot0htmcIm9Ezj7ZD1frBQTERD7tqI3qlbEGloyjwaKxrF2YVE0Nz1bA
 wsdbnZdLpKCrKKrMFHPy4qXJb8d+Dz4=
X-Proofpoint-ORIG-GUID: MB-zZsivHFDvSBom1GqfP5gsZCBv4RCe
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6ace0847 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=S5OCs8wk23pqgH2W7UgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: MB-zZsivHFDvSBom1GqfP5gsZCBv4RCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

Factor out write-command queueing into a dedicated helper and replace
the manual byte-to-word packing code with iowrite32_rep().
 
The resulting code is easier to follow and will be reused by
upcoming burst-write support.

Also add a sanity check on the write buffer length, which should
already be validated by the caller/I2C-core.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 41 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index d509dc1c14700d9c199d67df19082bae4f1ae470..3304760411082b72e10e529a2bd66361e100fa06 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -77,6 +77,9 @@
 #define CCI_I2C_WRITE		9
 #define CCI_I2C_READ		10
 
+#define CCI_I2C_WRITE_WC	3
+#define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
+
 #define CCI_I2C_REPORT_IRQ_EN	BIT(8)
 
 enum {
@@ -485,42 +488,42 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
+static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+{
+	u32 cmd[CCI_I2C_WRITE_WC] = { };
+
+	if (WARN_ON(len >= CCI_I2C_WRITE_WC * sizeof(u32)))
+		return;
+
+	cmd[0] = CCI_I2C_WRITE | len << 4;
+	memcpy((u8 *)cmd + 1, buf, len);
+	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
+}
+
 static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
-	u8 queue = QUEUE_0;
-	u8 load[12] = { 0 };
-	int i = 0, j, ret;
+	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	int ret;
 	u32 val;
 
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
 	 * This is to avoid overflow / underflow of queue.
 	 */
-	ret = cci_validate_queue(cci, master, queue);
+	ret = cci_validate_queue(cci, master, QUEUE_0);
 	if (ret < 0)
 		return ret;
 
 	val = CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
-	writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
+	writel(val, loadq);
 
-	load[i++] = CCI_I2C_WRITE | len << 4;
-
-	for (j = 0; j < len; j++)
-		load[i++] = buf[j];
-
-	for (j = 0; j < i; j += 4) {
-		val = load[j];
-		val |= load[j + 1] << 8;
-		val |= load[j + 2] << 16;
-		val |= load[j + 3] << 24;
-		writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
-	}
+	cci_i2c_load_write(buf, len, loadq);
 
 	val = CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
-	writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
+	writel(val, loadq);
 
-	return cci_run_queue(cci, master, queue);
+	return cci_run_queue(cci, master, QUEUE_0);
 }
 
 static int cci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)

-- 
2.34.1

