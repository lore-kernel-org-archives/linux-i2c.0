Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C544684B
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833685; cv=none; b=bToUfOyCLAdV0hawqFk9vODNT68LLxR6IQ30jjAUtuxstvSsj+fmlAEDtaXIwQjFceJ0VEsp69fbEC29HOue7IgbiiK1p8R/qwn9NwT519VJPyDL03d57EyDTBy16rboTWoFc1eUokjk1kCC2JtaALCBydTFMO0B2UXHGGXNRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833685; c=relaxed/simple;
	bh=9m66N446ktBYi/cdvd0Z4neSxdSkEViT/4d7JnekEwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pht+kCzQicam2FwNtYSAAtn+Jf1TjfU1RGvkYM4pFCKvg6iXv0VvzW44W+rfB4aJ7+x5zqMre/1eJU2xku/KS51Y21ww1rXK0SeDl8hlgmCVjZvNS7aOftKbazLpmO92S5oMWK0rp3VlV9k4Ivu9cvX+rSUA44WrRtzPxFdnWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjz7+UmK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SGK2OV2W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjz7+UmK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SGK2OV2W"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCBpHY4038865
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qLimRGLDan9aHguGi6zUxwrS7BGYZe1VlRKyaqbqyow=; b=pjz7+UmKq8qz83qw
	/xbIEoPp1SpnHkejDZdM939++6Ux+BzbbyEi8C97Gq4jscNAGC1kKxvOPZn1q58M
	gDXm138KGKEOeZcyCtLbzvcUZLsDZxijYDuP8PKnSCf+YIXVTV7yRs+ef/mBhMkY
	FVa9xRD2amgvNDVNvjtAWCwsVJ1lFoha8ILrNRHTNo0Hqb84phusoxsRwfGm2UiU
	iatvIIefFcpQRiYUjMdZxtP1hCRhrW4clfVY7CI1DOWhu/axfZLdwozgWtMVUy5X
	UFLa7xR9sped2sqYvAfZ7KHM1SVqbI1z8AEtsGVxGfZ9cle87qaBMG5COenZqWet
	2J/JEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fg81v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:28:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4245422a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787833682; x=1788438482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLimRGLDan9aHguGi6zUxwrS7BGYZe1VlRKyaqbqyow=;
        b=SGK2OV2WLZyCev22H+4EUQFys1cXmlvpNzFg7SSZizk8aj15LvlT5V5X3Nc3m98o2e
         CIIfaiwDIqOxLJamGvY279D+AMDWojUZ1yJbaAL0YLUYaHJ2QgJ5PnLCn3WPFF87yfU0
         Fa1t3gdi5kx9t573Uy2nOqhpAZxx/BGEkme8Mpy3aoigmehaSWt/3g3ox7wss1FA31vY
         /El+eb1K4JyKJtnu7pl+JYD8p+Ln26YcZJBXJL+Av5F5q5z8itn/zxGzbm/Eiwsen6ju
         oyAGdmSsA2m1X4SqqhIOrajCW8LmjgwnAgaS72X+q7Wkb8czWLGjNdC+B9h9MMFgn2RI
         WbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833682; x=1788438482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLimRGLDan9aHguGi6zUxwrS7BGYZe1VlRKyaqbqyow=;
        b=fk4xyk96WYoCPqDtMEOd6f9vQkXmZAaZ6ucYDZkiMZoc8fU4WhVART0Vgs/cGHTAao
         8CeWW0oWqKMT3EQv/uCEKS7uvpsf1/2H9g1GNv7kHZVjKH+SrZM9Ps3Z0MDAZoODk6BT
         cpdPIIBa0wl8zLWPwgvTJczQAy1+2TLAQETXTR9EqzLrGNwyjDfxOOwWFVsLEP/b0i3Q
         4cYYpSfsnkU9rNKEM9kSR9GaTUI6wBcaTWGEMbbZljJ7qXW419dC5jJp7FH39Q8lGX8y
         nFB9foqoPsLmVJ0vXQWfLZw5VgUJygFv+D3QGJfisI2Pm982wj0MVJ3OpUP0KJEpvU4c
         b/SA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3EjTzJxVtR8bmcLUvTre1yMN55SW36iJvt9UlZ+hTcaKITRfb6Dz4B5LPOaT8RNAgqrXjCYYwOp0=@vger.kernel.org
X-Gm-Message-State: AFuF++lSdb0wJp1ELoxqyWnwONn0mieoSXniL9JJ1gPcPZhFSzFNi0A+
	xazeSmc5kbI9T9urBfJ6Ae6GQVVHn4pvQNSlb2DA5T3WUGBr5jkstGwzA73vcizopm5C6xcGR4w
	JOoMU1s/nJRG3KPHulq/M74WJPtqq720ib5P1pY5dAT96vy+dZ4rfsI1u1Yhie0c0ACX8v1w=
X-Gm-Gg: AR+sD11fj42UwaTkbJvFw6wlQfIIy+MFxu3TH0t+hA0nvFCM6oukLRBL8Jl2atW38ki
	P+vQy8Zz5Cbg8sjtiK2x2whgUYiwX8nTDhfmgHfWF2SEqaWV76N0CQRECjc5fMdUrGvNch7rycN
	rAmjqLBPNTzxkE/dK9330Y9htL5jRYyL7hnal14CxGkcAzOQ+tHzwvxxBIUheni63/nRne33Vun
	l5/E6E7Ebz8MmYxgB4zjY3fEK7pf1I6jcPnv2caala5YbwiL/rEOESIX6ElIzkUAL2jQyQMwaJZ
	lnIdtbrGUCXSG0xtM67EoYUvz0GPjeUHu3rjQkrimN/2paHBb5y6PGmX5e6xRwPOHSSKFf6tIz3
	TdURNQAo3DdChRLWHxG9ZLaZ9YmXUpknHScw=
X-Received: by 2002:a17:90b:35c6:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3966d3bd49bmr30985552a91.4.1787833681872;
        Thu, 27 Aug 2026 05:28:01 -0700 (PDT)
X-Received: by 2002:a17:90b:35c6:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3966d3bd49bmr30985422a91.4.1787833681284;
        Thu, 27 Aug 2026 05:28:01 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm2707690a91.6.2026.08.27.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:28:00 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 17:57:50 +0530
Subject: [PATCH v8 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-master-v8-1-596bc81c5cf9@oss.qualcomm.com>
References: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
In-Reply-To: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787833673; l=6840;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=9m66N446ktBYi/cdvd0Z4neSxdSkEViT/4d7JnekEwU=;
 b=ANWpnw23fmiDnC6zx/pVAfYL06LIhEcpU5IykMT5Gccr1DUeaH4KEEFy2BpYqGHxP2uxZTq+4
 zBPsQQSab8sAecQi9MM6tcSbu/3aNtnc2tp3t2pYIK1BoNagECHpFPe
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfX8zhUsB3RdvpJ
 v9RPIMgcOJD+h+W6VUX4HfgS0iJuTRuYWZxwYGmpvFeIYbN5dsiMAJDGHVcEnQwHcxQphQP3bh7
 Wnic/2nn+5Hh+53c3Bo8zQCpUfo3JPM=
X-Proofpoint-GUID: JhsUyKpk-OeIA5g9YsNLKkI5n1jzONDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfX+Fsvv1qQh6Cv
 iqqAjLAXWQJ0mbocbED5RJI3RphFsJiMp2CYmvVQlQCchDVv/Mr+2+F9gD76L3Ni4FvOwiDeNd2
 MsG7MW/zaQgtUayd99/zch0brZ68pm5Kr/Nn5Xj6EjGhifYwmehT4eVDtjPTDDBXtpQvXfk1q1z
 TUjjFgE1IeSbGRgq7Mz/nltv0Qd9ZGQyNRZGAFdGtmpDJpogpm8CDB2jUt2WnlOnRUhRoL2m2pe
 cAjMzAX7BTkp6vRycqsW16lyK6JShZ5vgYh6x1d9qqN1gHbaAZ5Oicox9iR8NJizeVjZJPdVFtr
 W2V+UNXpL4lU3zdntjKJECXq8Q1tTiTE7A1IAwK8vCkOaxmjTxzEnTPcNXOe3ndFK7co17UVrLP
 vk+n/UjULHEd8K+pfgFeU0kgQPGk9VHx0BvLBssgb/vQ5tXfjkziVlyn4zxR9dcEe2quC6IlqFe
 5RlXcMAHI6hxMzOGkrQ==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a902d53 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Xw8hV2vT4XMzfsrjPA4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: JhsUyKpk-OeIA5g9YsNLKkI5n1jzONDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270104

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
the computed value is used.  The ioctl keeps writing adap->timeout as well,
so adapters that never call i2c_update_timeout() continue to honour it
exactly as before.

As i2c_update_timeout() is an exported helper, guard against a zero bus
frequency from a misbehaving caller with WARN_ON_ONCE() and return early,
leaving the existing timeout untouched as a safe fallback rather than
dividing by zero.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/Kconfig         | 13 +++++++++++++
 drivers/i2c/i2c-core-base.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c       |  3 +++
 include/linux/i2c.h         | 13 +++++++++++++
 4 files changed, 72 insertions(+)

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
index fb25704219c7..5f6a7370dc89 100644
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
@@ -2001,6 +2002,48 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
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
+	u64 bit_usec, total_usec;
+	unsigned long jiffies_val;
+
+	if (adap->user_timeout > 0) {
+		adap->timeout = adap->user_timeout;
+		return;
+	}
+
+	if (WARN_ON_ONCE(!bus_freq_hz))
+		return;
+
+	bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
+	total_usec = bit_usec * safety_coeff + min_usec;
+
+	jiffies_val = usecs_to_jiffies((unsigned int)min_t(u64, total_usec, UINT_MAX));
+	adap->timeout = (int)min_t(unsigned long, jiffies_val, INT_MAX);
+}
+EXPORT_SYMBOL_GPL(i2c_update_timeout);
+#endif /* CONFIG_I2C_DYNAMIC_TIMEOUT */
+
 /* ------------------------------------------------------------------------- */
 
 int i2c_for_each_dev(void *data, int (*fn)(struct device *dev, void *data))
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccaac5e29f90..d219eb89f978 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -495,6 +495,9 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 
 		client->adapter->timeout = msecs_to_jiffies(arg * 10);
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+		client->adapter->user_timeout = client->adapter->timeout;
+#endif
 		break;
 	default:
 		/* NOTE:  returning a fault code here could cause trouble
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 14ab4d3055af..e4302a1bd8ea 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,9 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+#ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
+	int user_timeout;		/* I2C_TIMEOUT ioctl value in jiffies */
+#endif
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -913,6 +916,16 @@ unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
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
+
 /* Return the functionality mask */
 static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
 {

-- 
2.34.1

