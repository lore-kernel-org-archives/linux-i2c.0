Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E65411689
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599918; cv=none; b=TPzo9OmyQdehWPjNrBVFHo904B7cq2dxBiFRHlXFboBb0Fn1wPGKPVgEGU0WusHoN4Z7UK1Y1DEi2toIg0Mf3wEhjsNCl0ghpA5q3PWNKEg1wCWgM817ar9qko9RYYxe5kFQ0USIajNKfzSMsWUmLBTEhYFCggm5WqLLFhb7O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599918; c=relaxed/simple;
	bh=4Ih1IY9sJGO2xZu7SZLwTbHcPlFuLXeuvKTBxpJN7zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9XnZycd+T6nKan98Y6wtwLqGnBHQofQecwbBxE9ihbvUf1W0VqlnvFs//PvP222+pjpFFjNJ/noZHGezc8efsNwWk9oC28csf29mUvdMaUWn3IVh29fZRVL2A/1PVqeo+tW9entuZXRtAsO1ILT3+Y8C1TAh2tH+gfJ7iZWzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i1BabF9n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Paq2fpsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1BabF9n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Paq2fpsm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D5fmBP2974509
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NWub6h7L1pIlGN7Rro0PKlrW45DCmQOmhfogtD6KZ9A=; b=i1BabF9nWETJRGgo
	JXUlRE8MBe81Rx9nZI7syen64Nma9H29FEzDf9Ce/Cqp3bz7JatO+0bKT7aa21sS
	y7octZlBBKuU7cx2U24mBd+c3FJxi5HkFWp4us3ibHqz98kTSOXQbF7MuYD4OF1G
	Z1us0ZHdvuKjfm1WZFr5qLdYIc9zDHTkdDgx9O8OZue0ynh7sp35s6XFG5a8xH3d
	Ar6kZoFelF1U6ne/fhM4dha/wCN8Ytl8FeEE3QrU+OqIpJ1B7Pe3tquv1DcZg6Hk
	PSEMq5jEpBcQm6EYeL2r7Q2IdISCWDXQQdk0XN/KtZ99fcPslFNPEhL3dOhddbM/
	I2k+PA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g152m8nf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so2550714b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 22:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786599914; x=1787204714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWub6h7L1pIlGN7Rro0PKlrW45DCmQOmhfogtD6KZ9A=;
        b=Paq2fpsmojRrAn6XM3igT3RRh+RjfGaXolNZVqyKg9cd0FD4h3VbSlzjTPHjmmfdgU
         7Pa+eloRTHaZgzg2cLeq8oN/jbjMSWWx2wzgAXrdwVgEXfdWV1VYQw05bAD14D0RdVJO
         4ewnHx2miRW/WZZBvsXwzUmqb2kIl2prqbDNcsynEgU0OFf58RY3uUTNPt9QsELilpll
         NU1LQ9mhT3JS6wcALsGcEoUyQ4T0cDSAOcZsetDDNq9yuZ0Q0ZsbggIE5WI+HCFONkpX
         alcsBOWpiktV4vkoLoW9nnBD0MwL9A8/T72Wd0EvdQlyWV8pgSKILs0HfhKvDjVfJg2E
         xh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599914; x=1787204714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWub6h7L1pIlGN7Rro0PKlrW45DCmQOmhfogtD6KZ9A=;
        b=K+H7Tv4Ot04GugCRatJlXLJT0lX9xFzMoB7W8+TkPdz0SGT3NmXZJh5G2shnYkq73X
         2yTUCyWokYHUbJOjZ2QENmZHGmhHhpz8UeR5jS39z4F2xv9J9/w8sEXlG3Wh0aSQjOT+
         PrEVenkLZPQoIJpMShGCNE4CmKMyZ5a1riVQtbndKcj30cGf3CDWQQFnfTtNoSkt0ETs
         tl6rJoRlPm8PVDyEDTdi8BHQ3rPM+7D7kKpNOweZIwDysM1ia0Uc0sV1naEDshbOdOLT
         xfKmb90Atyma3lFdY1ln0c3GgEh3d4QP9OxuzrP/Ozo1V8ts8rXdwNDJ8RPO1RvL9K9F
         vwNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4zZcwkfmDe8xiJOj5uprlCPj2TOIR/IClK85a6zEboJ3Kg2mr4nzHZK4aoeGZ74KHB/7Dg5WnaO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAxTOrqpX6027FEb+lcXp4+xZEy5hjsjHSGYZGxQE5cXSUYHL
	m44VwiqnqvCToPL98yWrhWr0pTjnJwgCn5LSLJfvayopzPedvwPbHm5FMS5EW71jS21GloCCjDT
	xFgWat9wD6lUS+kT4KWBvBNlQC6ul61QdygaKbw0XlwC1BBkUoSdrt871jWQjAmk=
X-Gm-Gg: AR+sD10I8fmdBZMAgQ8f/u0tuEDhUNAjEoBrRAvFmZsQNO7g2FDCGCYRd4eRaAb00NG
	MSs+F0AAVY1U5da00gBrCIeWa1Wz2suYR7tM2+KwpFVgCzlMkzVc0WALue+6MDR0hMKCnoo0C+h
	IAZkhxwYgVJS7uYajH/xDrWykeUb5QKOjXylRrT8nAobuxYFDWRC8jI0pw0x0MEBIMXghXZ8NJG
	1w6EuSXyjCEqx8dbNto5lz20akiNGwnCVUMKSVFL1HOF9bJtazORovvY0FQPtXxQ+oNq0/KLCBP
	1GrBo17RXyyOjHPIaROdojxrZuNihWw+HRdtOSLlSH5BGBTjhzG6ceQsTr0b6Lp2eBVevEfK//V
	Be1oLfv+8FaTLh2yabgN3jyki2vbLWB77tYY=
X-Received: by 2002:a05:6a00:4fc9:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-84fc745dac0mr3096359b3a.19.1786599914234;
        Wed, 12 Aug 2026 22:45:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc9:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-84fc745dac0mr3096298b3a.19.1786599913630;
        Wed, 12 Aug 2026 22:45:13 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e53esm381500b3a.14.2026.08.12.22.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:45:13 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 11:15:02 +0530
Subject: [PATCH v7 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-master-v7-1-3f9010cf9229@oss.qualcomm.com>
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
In-Reply-To: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786599906; l=6603;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=4Ih1IY9sJGO2xZu7SZLwTbHcPlFuLXeuvKTBxpJN7zI=;
 b=AHnu1ClrGKYq7Fjcdx+xaazaWz9OK+B9az/wUe6K63YRVNv/KthGFKu7ROWaXNN81GcVzOWi0
 h3+csATiZ1OCWhPnz3zrkXN6I3uqEvbPqEG67HijO9d+an5Bdp7dSiF
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX79JqpoyZ0XTw
 y5p2rKJDw6mQ+6/UOKM+itSMfAtJv84/t25Hkdqxe5kYPHhhO6ZHjZrneCIwxBaM1WikEaPEkAA
 08XS5LTEpW5hlVRE2/upDymh0GGCJoI=
X-Proofpoint-GUID: vCOdKK7fevq1q_EYpe-3wvdrN0sh_gbC
X-Authority-Analysis: v=2.4 cv=D8R37PRj c=1 sm=1 tr=0 ts=6a7d59eb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Xw8hV2vT4XMzfsrjPA4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXwh5ygWWgalpT
 +9PnwzwNKwz6Z0lo0eE3VD9JUgKTUs9nbYokireiGscELdc5rP8hgsZ/qopMhARJJVHfr8sp0tR
 g3P91CNUyzYJG7YrL5yXwQEByXx5jBpRtNsG1J3eYVa+4uTevke3NrcEeFGOoHi7zeQFtAhzTEZ
 qXhdiQT7Nohtik17cgil35ihgq6DHaKUUF1vv7uWC7ZNmSOd8op89qLVd2pgtM0mtNcZRi9LXqa
 U+mPSVcUiZsPYfeJObNAgnj5kcA4RO4rWCtriC7XKntarUet2DDT1M2r5p6VlrnYcChBakGChRo
 YVyQqUxsGvHAINX0pLEpkXPnDkUUYHufJjKSgKU8GCC/n5LE+i9KeUoX+qXupF8/cEuH2M5/7KX
 QSEgtdIukt8CnOjYhs6yrniiSucau5kL+Bh7ArkbsGqFpVKdWL72n/VhjQfWZ6bFonAuHSq6+ct
 v279t5fcKaOG8qU+V5Q==
X-Proofpoint-ORIG-GUID: vCOdKK7fevq1q_EYpe-3wvdrN0sh_gbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130037

The transfer timeout for an I2C controller should reflect the actual
message length and bus frequency rather than a static 1-second value.
A static timeout causes unnecessary delays on error paths for short
messages, and may be insufficient for very long transfers.

Add i2c_update_timeout() to i2c-core which computes a transfer-specific
timeout and stores it directly in the standard adap->timeout field.  The
formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
bus frequency.  The caller supplies a safety multiplier and a minimum
floor so that each driver retains full control over its timing policy
without those values becoming public API.

Storing the result in adap->timeout makes it visible to all consumers of
that field, including the arbitration-loss retry loop in __i2c_transfer().

The function is gated by CONFIG_I2C_DYNAMIC_TIMEOUT.  When the config is
disabled, i2c_update_timeout() compiles to a no-op inline stub so drivers
that call it build cleanly and the existing static 1-second default is
preserved unchanged.

A timeout explicitly configured by userspace via the I2C_TIMEOUT ioctl is
stored in a new adap->user_timeout field and always takes precedence over
the kernel-computed value.  When userspace has not configured a timeout,
the computed value is used.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/Kconfig         | 13 +++++++++++++
 drivers/i2c/i2c-core-base.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c       |  4 ++++
 include/linux/i2c.h         | 12 ++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index c232054fddd6..1d9691ec0e7e 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -136,6 +136,19 @@ config I2C_SLAVE_TESTUNIT
 
 endif
 
+config I2C_DYNAMIC_TIMEOUT
+	bool "Dynamic per-transfer timeout based on message length"
+	depends on I2C
+	help
+	  When enabled, the I2C core computes a per-transfer timeout from the
+	  message length and bus frequency instead of using a static 1-second
+	  default.  A timeout explicitly configured via the I2C_TIMEOUT userspace
+	  interface always takes precedence over the computed value.
+
+	  When disabled, the existing static 1-second timeout is preserved.
+
+	  If unsure, say N.
+
 config I2C_DEBUG_CORE
 	bool "I2C Core debugging messages"
 	help
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fb25704219c7..caa0748253ab 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -29,6 +29,7 @@
 #include <linux/irq.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
@@ -2001,6 +2002,45 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 }
 EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
 
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+/**
+ * i2c_update_timeout - compute and set a dynamic transfer timeout on an adapter
+ * @adap: the i2c_adapter whose timeout field will be updated
+ * @bus_freq_hz: I2C bus clock frequency in Hz
+ * @len: transfer length in bytes
+ * @safety_coeff: multiplier applied over the theoretical wire time
+ * @min_usec: minimum timeout floor in microseconds
+ *
+ * Computes a transfer-specific timeout from the message length and bus
+ * frequency, applies a safety multiplier and a minimum floor, then stores
+ * the result in adap->timeout (in jiffies).  The caller supplies the policy
+ * constants so they remain internal to the driver.
+ *
+ * A timeout explicitly configured by userspace via the I2C_TIMEOUT ioctl
+ * always takes precedence; the computed value is used only when userspace
+ * has not configured one.
+ */
+void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
+			size_t len, unsigned int safety_coeff,
+			unsigned int min_usec)
+{
+	u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
+	u64 total_usec = bit_usec * safety_coeff + min_usec;
+	unsigned long jiffies_val;
+
+	/* Userspace-configured timeout always takes precedence. */
+	if (adap->user_timeout > 0) {
+		adap->timeout = adap->user_timeout;
+		return;
+	}
+
+	jiffies_val = usecs_to_jiffies((unsigned int)min_t(u64, total_usec, UINT_MAX));
+	/* adap->timeout is int; guard against signed overflow. */
+	adap->timeout = (int)min_t(unsigned long, jiffies_val, INT_MAX);
+}
+EXPORT_SYMBOL_GPL(i2c_update_timeout);
+#endif /* CONFIG_I2C_DYNAMIC_TIMEOUT */
+
 /* ------------------------------------------------------------------------- */
 
 int i2c_for_each_dev(void *data, int (*fn)(struct device *dev, void *data))
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccaac5e29f90..2d918bcbf8f7 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -494,7 +494,11 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (arg > INT_MAX / 10)
 			return -EINVAL;
 
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+		client->adapter->user_timeout = msecs_to_jiffies(arg * 10);
+#else
 		client->adapter->timeout = msecs_to_jiffies(arg * 10);
+#endif
 		break;
 	default:
 		/* NOTE:  returning a fault code here could cause trouble
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 14ab4d3055af..068217549266 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,9 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+	int user_timeout;		/* I2C_TIMEOUT ioctl value in jiffies; 0 = not set */
+#endif
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -912,6 +915,15 @@ void i2c_put_adapter(struct i2c_adapter *adap);
 unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
+			size_t len, unsigned int safety_coeff,
+			unsigned int min_usec);
+#else
+static inline void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
+				      size_t len, unsigned int safety_coeff,
+				      unsigned int min_usec) {}
+#endif
 
 /* Return the functionality mask */
 static inline u32 i2c_get_functionality(struct i2c_adapter *adap)

-- 
2.34.1

