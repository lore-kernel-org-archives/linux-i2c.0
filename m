Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAE34E745
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837383; cv=none; b=LRFB3IJdwjcTBYqUNEc9ZoEnFoLz6RD7sRDG/i8q1LlpIVsL3XnxBtmNo/bsP9kZuJxSMFPFjF+8Aq7E0FBcmfugqnLMQ7WzcvSG/FtJCUYZx7YHW648/h/VCl0khCMTzGmkuycvMcqJnohsEI0X2ynZ/kUvyRc9yFi+07hkys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837383; c=relaxed/simple;
	bh=88tiaV9HDvlr3GN1PksEheeTAyjNgOl38ys1aboqBxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYVjabskZl4Ux6Un6Ph8Mv3bkFHRmnubvHKz+9jJB/4BqaVY7J9IHRWrE+BcgPGa0ALAhvtkV6f+sJgllafY7awPXr8w/C7P9+SibQF+pbue4en0Rg2HW7MjW6DLIoGvcjKrDy/FK6BcR7Gcbfre/byrd5rwAEkdMjyP4r72Z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=flhklers; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=COvIgPhu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="flhklers";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COvIgPhu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMx4Uo1953696
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C1LYEIUrAQOrp9ghi20i/HX5sg1rutbkLtla6X4TRo4=; b=flhklersr5PUYuFH
	ChjDuevXiiCE/KQqyKgGkI0RJ1p/V5EjiQ95fRzQFWgrRZKcXXL9gORL9JNUiHim
	yoBT/H0njxeZjgGElrHOmjaKw+Ps4HLbryiBbabg9j7ERIyNOd/BHEWF1M6sCkox
	ABR/DtkzglYgSSPxGsyHBpGDHBznWuvY0d0e28/umeC0xe92/HsG4/I67NS1/Ypj
	69IcHilcp1i4AHm3J43wM207auYQiWWKFud6KQmTxH8eUTDN1KgsAfgpPjw1443e
	D1aYOsp7LQyYAZKN6Xpipsg5EvaU4JuFB7V/z3J3CplPqa5tb94BmunpHvXYdd20
	++ZDHA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbc29h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71655aa11so6377996085a.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837381; x=1772442181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1LYEIUrAQOrp9ghi20i/HX5sg1rutbkLtla6X4TRo4=;
        b=COvIgPhuwuLcroTD0EXEEQcRLEWvT1V6XN/L/6ZkKdisB56WsMOl9R0jhMYE2bbkki
         sYybDj52Cg5vuTh00pgO68syJuH2h7IaEgn7L+oKQiEVS2e8dp4TDsyQPj5YyqEG25VT
         dPL9a9khKFkngQIuYALUoEX74fst2R52qg2XMnXqrAYdjrUiRLx+qxOR2rpBHkd7Qfg5
         pBYer8AnagXIkECcNTHYi3Uy5ptsQmZqccu3n8qqBlFhRb3lb/Xl8pJkhBfpPOUbmImW
         RqwQTDu2+ortHE4D8SJpFnvsbZeK5DwmT/IzkNTkiIhWFr/idXsFnNx+NcjWaRhMzbMf
         icSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837381; x=1772442181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1LYEIUrAQOrp9ghi20i/HX5sg1rutbkLtla6X4TRo4=;
        b=eVxmTxqitaIFG17XIxyusnjgarOMovXUp4om/uAup9bANBENAQjYQCV8delbx9rvK7
         n6XmDV/6+GTqYFeUviHCvJsN4t+qNW9GEDlk6Gk4mycJ1uyOSSbSjZ41Ag8DWQgLQbLD
         XKynHJgGrWk1I1U038V//EqGo4QXXc3xzROE+id0wu+ndo8Ac9qpuSTDfd10WHxc6DjN
         AjygNyjhoz+LJzsVIxZvhbGqvK5nttKGlBPi/RbJ4cOB3uwNHN7GFCi3tuCxotD0s4/0
         6y9RPCjhSc3tFUkP9FRLyHy3vhlgPvH8z/aTrYD2CK7Oat+gRvQJeM5gqpeaDD3+kAYy
         cUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM8pfqrj+dHLQSLX4V3ztxtlncPepzjqZ7ATYrnyAAKst4YPwhYinAxCmPNY+84RzwhkyX2RaS5R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/wXTX11MO76aS/4+4g5AIO5K6XQLJMtl9LDQnp09QppTIgv9
	EwqZf4QsfB6nEUX1f9hmjAD7XRhlIETITwszmkqUevTJzupVofCFLh1m9H58q6C5dUMIP96rZKT
	kWVLivVNX3bmPbjvtlW5nAy8p9YUuFFSCnniqflCERwDPL20zjp9GrVWiO2mJnyA=
X-Gm-Gg: AZuq6aKNjZCfg8Io/pghdWW/wZBz/myDwlPdyspomdcFEdnVgqov0RdWWOCgvLnPQlb
	1ydzmiboTOftx7vv1AL0kjztM3VRqjDBOmoKpBbdgrF5feCV2nHKBK9nRAa4RKCsh0xRHDmkoCJ
	pIesJ0em/pOhft4ssitVrd2nzjQ5yYc9OEaXcXJWfvp9mgu6EAD9B6ArWSBdb0pFEYDf5p3XlcQ
	CulMxQ8FLSfpUx7ZamfHxQegsEuM0hp2TA8Tx/6ThxW8j+VRwg3uQ8r8yJtJ+8ny6rgzqAxJxbJ
	LyI2pCgr3x5q28LEDEwsd1i+d6ellQT1quc2+V3smp0uPQ5tVAL7DfsIj+rVzOgfUtOwzwzZHno
	ByiZuoP5rRgWXX6IrfVD7yQri/SNRNV0CGzbRDOhbW24OxnOzwEg=
X-Received: by 2002:a05:620a:2906:b0:8cb:313f:5ce9 with SMTP id af79cd13be357-8cb8caae494mr875085285a.81.1771837381246;
        Mon, 23 Feb 2026 01:03:01 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:8cb:313f:5ce9 with SMTP id af79cd13be357-8cb8caae494mr875082085a.81.1771837380786;
        Mon, 23 Feb 2026 01:03:00 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm19657169f8f.7.2026.02.23.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:03:00 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:02:49 +0100
Subject: [PATCH v2 1/4] i2c: provide i2c_adapter_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adapter-dev-wrapper-v2-1-d02946569773@oss.qualcomm.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=88tiaV9HDvlr3GN1PksEheeTAyjNgOl38ys1aboqBxc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBe8U0iQIHTPbIVmK95QDXpm8dMmXkJGru2Fp
 Akm0oLPu9iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXvAAKCRAFnS7L/zaE
 w7xPD/41JEPvPgs8Yt/NsIDxbLkpoauHUMq5GGjhtp9dj/TMnq85qoDAQ2wCFWwfGC/5KSBT9Yc
 DrRqpQZaUzZ99bx7QLTuZlxVRo7oRvs+B0iH/239gEy3/WGwxM9cRfNHr/78QbXitKC103xWu47
 ly655yDrbjCeuQd+bA4WlSasFVIZ1qIywAXBKh+pTgd3iIUdZHtubNoo1l2uxUjHgOJZQgPXoiq
 Lm0VB8JywUKYWfOk0ROtcfNmzgR7o1EAbP+U1IXaLhwxhgM2hYEiLUExok97aO9L+JKldeAtVnK
 VIFLA29JootdUwHL7tdtGx4KW8FWwOA/kJgjrd3reS204/CRsTiv1Sl8KMPyNSDPimsxEaK6A+m
 NTTbtmBscrHSMYZruGAYp0MC2xq5g2ERXaIqGjT8PGL7IPIkwzesqzUJkArQi4IJR9x/Xg0PvoQ
 uAbUQrvjlfhAvWlMunWaeWEmAQr2QMGp9bq+HrcCrqEu5dQINHg63sk4NAniVXEvdnfafKx3bAL
 SU/OySoOOEMr6ILECRMPH+9ewnHu0X+GX1eZ3FlV4atRHbsstIMyRQ9zrXOmMSE3EyLQvx45+xy
 GSSCvBTojD5vt5+gvfYNwsRcvxAF4KTKEWYIgxMmrtJE0XVOxd+V1opX3Qo44A2zv6mJ+eeFfbj
 0DVsvxesRb6D1GQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: j0p5qYhoCnvMRXTWqBsvcOKYEA2PcJBS
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c17c6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=GLuwdYkDV1VJkgsO8fEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: j0p5qYhoCnvMRXTWqBsvcOKYEA2PcJBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfXxtQ4SxKFJbNW
 pskE1FCWNTSBwgBxRfsA05O43Zb5fsQ5BZPyvxPeRBZPvWszZt8pNYe3P9mQGkBzfkoDt665QTI
 oa+XegWKm46v1i1M5/y5phpH9ZYYEcqL87VltDCWWvof8bHlyDHF05NtUB4IsV5CI0V2pkH7ldd
 ew9o1KB09qoLZfrwIq0Co/+5yxvfOi4yX2SVYb9YRfqxp5pU57xNw2tx3q53LtYJpK+J2OYtPF6
 eA2grM6K4495t+8mYDA1tHMH9wiTY/cRupjzYZHL7rAy8sR9iCe8Xket+Qw0szZwiY0psyaTR8w
 JgdvXq/S5DKneaVEnt1VT7JFMsxl99ntSimc6ngee83NJxh0L7M8NL+LC8QoTiuXNMVzyPgd2Fg
 qiTpH8w6opCXq9pJC1yPusez3+g48xdCbHPwZ+NU2Q72yGciya+9SJWDRKxvEfPGT+iaOgnCWLQ
 W+2OvJRY/QEB5Mf+5BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Provide a wrapper around the dereferencing of i2c_adapter::dev. Once we
convert i2c drivers to using it, it will be possible to finally move the
embedded struct device into a separate, revocable structure protected by
SRCU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..b5f4db9417aca2e058c8be19d57d693339b6f9b9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -768,6 +768,11 @@ struct i2c_adapter {
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
+static inline struct device *i2c_adapter_dev(struct i2c_adapter *adap)
+{
+	return &adap->dev;
+}
+
 static inline void *i2c_get_adapdata(const struct i2c_adapter *adap)
 {
 	return dev_get_drvdata(&adap->dev);

-- 
2.47.3

