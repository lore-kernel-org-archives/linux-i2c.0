Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1F3F823C
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110038; cv=none; b=Tt605VLnpWgVyrorEkGE/RdtGlZFCGlvZGDTPFglNcxk8gXzWRzM25gGI351N9DHygCRs3E4et9S1ut6JaLDixT1+M92VaoV4ho0UQ7kBNtPQLiwIgN3fBrHxtbjTSAKy3CrJ30TgCmJeAyH8K9BlkzEFmZq1Yc/QJWWJ0sw7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110038; c=relaxed/simple;
	bh=CBt8MX5rIzNb3d5REngrwYN6aQHq1xRM1sRT2r61QFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btillWsabcso7dkd0TxiMOxK42ncgEA/kY1DPqMzbUc5vWx9XfdCKEf8mGCo2Zaq7lL85N6S45U4WoAIlrDQ24c+wOTXyWCF5o5ePkgyeqKsv+hPUdGY9sci5W/Oce37YgMhumnxMBE+lkYsJdeoJk5ZDhNa81n5K/54Ssi7Ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Spk4E/zm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vf5pkJix; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Spk4E/zm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vf5pkJix"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B6kFSS286328
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B0C1RJkdi9pngWirNo4qhGJuYnCZd20yeNRymvfFXgc=; b=Spk4E/zmrLSEfIug
	MlybMJpKcec+3UpZhNwZny4gTGAsnvXINVKGPQr13DDCLB4HQJXwGhzDDoqufsU+
	Z3Vmflhdd5RLf3Crje0vw48syJHkcRssvBpAng1Npzy74RquGcXbIgYlp4/tDEym
	omsXYY4lebwtkbr9fwa0RYcjQXCTZZyR5ySBz5VSAzzug6oESNxysSUUhoevs4qi
	zYS1TSVsLkm8TYMV9P2ss5wiktB6TVgma8/oo0h8RHCZQE3vMcZqia9j2Lemhrmi
	LaAyP68/4RUMGlebTbKDDS0HNAk0E7ClXlWQNXs7awAcLStXQiU/Y83yZKny9W1e
	Gw7XHA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8gbwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso1141843a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789110012; x=1789714812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0C1RJkdi9pngWirNo4qhGJuYnCZd20yeNRymvfFXgc=;
        b=Vf5pkJixiMNe/MRw+xVADuPFZpAlIdFe32Qgb9/risl+K8PliX6kynnWTTBRcQDxer
         CcsX3D5y3+5iPY2csEIavYnS+tqun4/letyCVAtOk8M4s0bTbuzyiuoLpvr2e7FQq/eQ
         uhdhP5m2mGZUpAKK0NWe/QKpk3kQMdCzepiNOO7Rm0ZOdIS4P90PLwYM7J7c1+KJ03Uc
         SB9+KeVXHy0FUvRywZUnuRallOsz+MVFQY+6RDTfeDPFKglb8w0WHWwPnJxCz4WyCmBe
         reArH+j+8uI3E8W+W3uFx40PV5usGM9Ono8PvfZHggCVWxphzKNl+KkJ2GGOacaWleRz
         1htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110012; x=1789714812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0C1RJkdi9pngWirNo4qhGJuYnCZd20yeNRymvfFXgc=;
        b=k9xZAkAc7Dt7E/y65EDaGFZoE2FUoHcXggb1+KNoKipBr3iEdffBwFfEhzytBIDviX
         xi32DLKeAT5OTveqsRnXEF/qmeGAr8i5YSDlqSxSV4el0Qvyl+7JxoLVKXZm9Cs6L1OJ
         Y+BeRlAWHvycT2CwRq36zef8/PvOsf5sszBrK0I3W3f5MD4JjXpSIBs8MwKk3RhBMWUB
         J8MO3PYlpFwf2fwWz31Ik6iQWTMmwu6l0cu2eZmrPhUSrZ9xo/emkOCWe9KZ3iVBQVpy
         ReF02Q7PWb674QYXWkRNTLGUoDYOAqNm/ZdpXoNdAbJkSRHf56zscLpb/3PiTQlRXrUH
         Zc6g==
X-Forwarded-Encrypted: i=1; AKwUvBwV9e5p4cAjo/yXhjEu7WJMcnkcT9LmUG1R1JZ4LBCAGUTDX3SE7zGQc7n7fa/uI3Zc6HbULeG/5PI=@vger.kernel.org
X-Gm-Message-State: AFuF++nXRD/QpxUw3Xazr2JTmKhzrDsN9gCOlSSX5rvHyDU2FgO/UcW9
	kcpE2jwr8VfvcBrToB1VxkMk24nusPIIRuzt6L87GcLcqq2PZskNHTUL0avUuX8AsqKV/2N8Mrm
	GLqsejLuXgj1byXa+vS5GDECOlGF15SHhO20zbztLoHDZgQUQ6d3U1pvFQapiQIlREbfrgkk=
X-Gm-Gg: AYBFou2RjP18NpGsRqXZmXIYN2rzWDtyY5JTNoDkjq3sFEUCNQ9Vm828o+yvg22BVui
	XtUKXPo3vPYyYyxb+JbFZ3VAmZqvfU4i6pIiK+jBLcrlFHds9WaV14khD9QBs2yJHWuZwslhqtl
	mSVkavhFsIJdHmvuRq+T1UZemR0KyHqDKzvjjVuwWX4MYeTCb9M4rVH5VXnn7J/SBIQaV/QLhUe
	d7fkLwZeDr2BLc9SElkQSNmgCm4jy9tsLOTv7Z9eLZ/wM3Hm6qb05UsCWIfhLmqMGkxKc4OsPph
	XxCd3Fz8SYdzp8eqqkwk4k7qELFAK+cs/D7CroaWZbtVVQvK6qcHBSyoiyLXoCcUxNHkhLuXus2
	Wm6wao6rehW4fTDLYGMif17kFoGuRUeVbBgk=
X-Received: by 2002:a05:6a21:a96:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3daed895710mr4985617637.28.1789110011540;
        Fri, 11 Sep 2026 00:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:a96:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3daed895710mr4985522637.28.1789110010978;
        Fri, 11 Sep 2026 00:00:10 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm3799532eec.13.2026.09.11.00.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:00:10 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:51 +0530
Subject: [PATCH v9 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-master-v9-1-77ac458344e2@oss.qualcomm.com>
References: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
In-Reply-To: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        naresh.maramaina@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110003; l=6911;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=CBt8MX5rIzNb3d5REngrwYN6aQHq1xRM1sRT2r61QFA=;
 b=2nsXlxL4z5MH7mBlCzFLtLc5y/2kYL7anQuSShQ7XF+7K/hg6R5jGr8VCpfxi7JEjEgusXeL9
 I7Wq/yqa2IJAV7d3r8dCFx3N6wctk9L9BP4lTZzJdzoxCBaaGiMLOsI
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: c2TFYGsOV5i90M9PJTZgaLbr8_0y8eAB
X-Proofpoint-ORIG-GUID: c2TFYGsOV5i90M9PJTZgaLbr8_0y8eAB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfXzDzHxXSfM9Xq
 HhcARXdr4Qiu6f6YW+Qj2HO8w4eefvhx2/lE5mTfWCezBMTbmI6ZVXFvGwhJ+G5nTenbke8iX7o
 yjSnA6g0uIqxiwjB1UsvXY9IPc/H3I/ya/kGxFeGfxyAwp+H2IGi0vXj36OIfctBabVBLnVk3yA
 JdAn9iOe5ckCHj0qjvbBwsrFrsBZCqgjTK5U15v2lLLSqh9uFkhcjNfYI9JqnSxesIf46nhSBNC
 Ghdvg/V+zg0hIDtbHM9VN2nijbCMevOXiqQbiLMnRtmyrMdj+pVWvVZzyGyPxS6B4IKjy3NKUTQ
 Yy82U6jUE+pvxdLWtXwvpIVGtcg2/nvfjF6jLACAKqcSnjSwohSMT9Z+zt8T1cjQ2b+yjCuo4vu
 mMhBVMuF0+6VPrktnaArKMdnf/gAdchhyAlSx4iXaOQgZ6hvXJrN+GgieviVhSdUt9Ks6dWh4iK
 hjrA1q+UPN7e/UnyKgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfX+6zNgMJJlEG1
 kytfwL+plMQR/7NZpt8j3WqByg1U3/e+4j63NyqN/kKiMi68ha95EJbAnxxWW9ZZhIiR63pEm80
 V01zw5SZECikRWoQdzYXW60VBfZfA4s=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3a6fc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Xw8hV2vT4XMzfsrjPA4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110095

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

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
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

