Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7732378D84
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547700; cv=none; b=m0UoE55i/H9G5tzGa21/Ks+dx7kjV+n/in0knPNvtdEu6ebEaWqOjfcS6i4ZfMJVn2oEGKAZnqYBbJOoW3hX2OSkWQTqxvAjMLTQAKOnUqYW20EBNuRaOUk8PaQObJIEfFY0XJtIQJ7lvDk8MdCrymCNYk+Uo5rNoogLaJiQr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547700; c=relaxed/simple;
	bh=P8NqVl1EFJ912fQvXrv3k+VINSrlyfLmQLx2G8wTsaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmc4bpVzi20KyIpR7NRP2cGgVGTTUMMI1gdXjYp+yxBDSyuIVtzIg3G8uUWpowawEXRcVjRYiP2U+r5+5RjA1yejGafA1SckN3rhZ/EXNES2QXML2WwMiYQR6Ju5VH0j4pQr54KA6Lng8Po4NSVaXN1G+g0KCcsphU1fsl+fQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KW6gRFfj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCamUz1S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KW6gRFfj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCamUz1S"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAvdAP3434801
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCUJtX0ajp2ge39lN0PpS5VKnFLfmogwHyKJc02t9RQ=; b=KW6gRFfjuiwA7Ixb
	J3fWhiGWtYgOb6KyZuBBYpp8Rr6RAa+iNxfEuJ6TFrV41dYT92AbMZqWf3DwbBKT
	2S8lWcxeES+on2FVBe37AXdhxBShpSGLx5aUgJ3qtC1vY/eXooRCLkMKXS5oX7zJ
	QIqeNKRIASFATcjAMdLmrjq/evCnrOeh/6kkFtRC8Sj9Io1BnAqn6C8fQtylW0OJ
	HEDXae5o77lg9et0QkSVll1pAzlnq39sVrtJgglBaJU0/o0kqJwHiNwv7jXSfe7w
	yU6TXncWazWWdFl8SZ8i0y2GsPIo3XlDp5nqu85yoSvptf+U7q9UyDRAxOiWB5kX
	pWSIeQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg11wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so17854125b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784547692; x=1785152492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCUJtX0ajp2ge39lN0PpS5VKnFLfmogwHyKJc02t9RQ=;
        b=NCamUz1S812SxxlVnY8RCUWi4FPP59BTgyrNn+OYmRsy41jp/7M/5aF5hTGXnnTjzT
         5cpq3cqlDxxQqtaKJe1SB7t7SEYJkuKNJGqgvVYHzCnpDSMs94NbsCXIeitsTOhwHhTC
         Ia+m1tEcSaL2irCGhM8xv6y3hIyfxaYeT8TMq3akTylqXWzlKhJb7eoEnrEwujrHx1LN
         GhB6+Jyzd/NMz4feWkFoSfEG38lUJ1KGadKePvui31qd0O1UJHy13G0oalU35BtYQ/BZ
         pqmNLLGD1aHib7+cmhCNKZ6qaH8Dp6AaWlsmqz3Z6w4qGutB1BhuAXTwySpnXesgX8nv
         ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547692; x=1785152492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCUJtX0ajp2ge39lN0PpS5VKnFLfmogwHyKJc02t9RQ=;
        b=EkFz+srImawh57n51Kt8EDdQFsZakNcP8k4nampBLydvngB5hy0MSaPzB/I9MXprFR
         6t+SsZXGVqHFg+9x61qsPnMMJdsZt1zlt7YwLQJT3X7vA/Xm0susfa6jrVUsKeMI7op4
         yjksj9L5RCnAlB5w2fotF4N8Muk9FmOIVYki76xwHDQq+RkXp+hrz/0U3Wr+R83gYtgO
         r4+S8jxnS2Ayc6gxj33F/Rxz+rZVS7HiaB/a14ByYPVhPXNagYX75krZz6Fak2oYvxJO
         D0Dc+IpYVXAhwBkKdaP3NUv/vtSo6BBlqOJ0I/OTXz/OxQzxHyLTp91DONiP88wNlw+R
         1jJA==
X-Gm-Message-State: AOJu0Yzhw2pAwEy4QvXOdEoHFaXyiYM0LHlXTDi2FuhY4Ag5+2IQChs8
	Cgb5gGGlFT+NUB6HOLWnscXvkVHH2vsxvd5reGY2A5d7QqIRFiYjBUmGDcvb8xFO3nZRkus6EBZ
	WfPavU9K1pYVN+lvBdrwEW+wF3yOkJjiuFu4GxsBRDoZeTowNPOIZ99GfQ2xqvOw=
X-Gm-Gg: AfdE7cmciSv1MoNfL/Eo6IDOD1Pi2QYkArJG0ZKBpsHkef/4qFBdgXzzHgjSWdZoUGt
	s967LhI2Pc2RmDvAwHKqI6c+BWXE1tJqhp8N2eidrGZN/BO53/U3bch3WpjaCZkxl1GjF1iPfOm
	Fw0LogFvXlfl2gKG38S+ZzDS3+fm+v+E/GexuFvqVUrAwkR8fetVdaOTcchabUNhRC6A3x4Dln5
	xeHaRZ98X4WQP3NU35hjZxbphUgzjDDxmfYjkKWrLG3ZsL8FgXWui7D8NaVWg89KJ47FvlX9iBn
	+azPnyh7PgikvPZbhMAcRo2igGy+b/6ZklMDY2egY1D61dzk2Oq5xy0dvOnnDgmFRi2bxOpF0Zk
	UqOXnm1CVI4BMmPBXEDmltJHr34n4mI659Qs=
X-Received: by 2002:a05:6a00:9084:b0:845:4126:222b with SMTP id d2e1a72fcca58-84c2931072dmr14798488b3a.28.1784547692172;
        Mon, 20 Jul 2026 04:41:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:9084:b0:845:4126:222b with SMTP id d2e1a72fcca58-84c2931072dmr14798448b3a.28.1784547691576;
        Mon, 20 Jul 2026 04:41:31 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm5450701b3a.27.2026.07.20.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:41:31 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 17:11:19 +0530
Subject: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
In-Reply-To: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784547685; l=3397;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=P8NqVl1EFJ912fQvXrv3k+VINSrlyfLmQLx2G8wTsaU=;
 b=+3MTI4xr1BSlejyrCh1HNxgOlO94XP11FcKi9DNvkcOVKM4IXF3PNh5WqyMjMfLrkoM249QL3
 kE8L/w389V4AfmSywdeNhXuWoP9oxs4wRLOf1Nsp4fYQwAgazKU4Bvz
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzMCBTYWx0ZWRfX/DG5PKRLcfCE
 jvfgbOGnSwcEJBufmDRjpUqrwxecIvNZdvgPXcLcDJ0ZwBTWaqfuhe/v7duXCWDI8zuhJP3z7qn
 jVrJp+7/Q9oY1aytYVmMnL/5wFmXqFM=
X-Proofpoint-GUID: hS7MBb5Ua1dOTDaw6q7sSk4fw4t5cjhl
X-Proofpoint-ORIG-GUID: hS7MBb5Ua1dOTDaw6q7sSk4fw4t5cjhl
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5e096c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-hBw8TQWdD6LnWPIZ_AA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzMCBTYWx0ZWRfX0EiupcaHotjT
 W5vYoQvpcFdnYy3f7pI66m6k/fTS/hlx4OxlZCOeX4Egpw2rxdrMjJrYFv3f2mC1/LRXOM4d25L
 Gq+gRtu4zVqYhWpX6YuzKfXdsX44ojJD/KShnDsKMv/UdLvLgrcZ2xxi4MCxoEAKWTmyRMHKxVQ
 X4gwuYch/AzxAqnIcLdvvM0mgE9NOiSBQaw4i9BgAJDvxy1+tv/OLFwzE6xgHdq4eTwfx65m03A
 q63tPqGtDP842mR4fTF/Qrob8KB2nJelNr/j7DqRdlGsUD/8zqT/Jsc+WgbN4eEkcKT96iXNuP4
 AWRokmyrGM3Y4adejNSk8zWNtwuGX3qJPmur7kbiHoOqdVMNdAOffkJC9VzhvWMfVTCmbMQGCOC
 L3bpLF0/7XcQiftQJCYxEQ+leEZmEfNOLzsD7rLSlvY1M5biLEV/WB5vrW52o238CBWt6cdfIgn
 Nhwj13PZ2PENdQIBUbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200130

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

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-base.c | 24 ++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..3280652e20d8 100644
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
@@ -2000,6 +2001,29 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
 }
 EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
 
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
+ */
+void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
+			size_t len, unsigned int safety_coeff,
+			unsigned int min_usec)
+{
+	u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
+
+	adap->timeout = usecs_to_jiffies(bit_usec * safety_coeff + min_usec);
+}
+EXPORT_SYMBOL_GPL(i2c_update_timeout);
+
 /* ------------------------------------------------------------------------- */
 
 int i2c_for_each_dev(void *data, int (*fn)(struct device *dev, void *data))
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 14ab4d3055af..b52974eb7e58 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -912,6 +912,9 @@ void i2c_put_adapter(struct i2c_adapter *adap);
 unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
+void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
+			size_t len, unsigned int safety_coeff,
+			unsigned int min_usec);
 
 /* Return the functionality mask */
 static inline u32 i2c_get_functionality(struct i2c_adapter *adap)

-- 
2.34.1

