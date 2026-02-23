Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE634DCE3
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837201; cv=none; b=k7A7V1fXIzfdPJqy8DdP/tETuPrM0Rq/WZ2j1lpLrqcrvdf4eQC/AWGjTn85XUVC8lm9U/RkfDHFLMbxqojO0thIajIZp8XoQBr+OiXdlaqMXQLv2L3+vKv3xH0MvZkb02CxUJuzzdFUbrGhkeFtsr+vkI7PYYOuXKYVNOVJIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837201; c=relaxed/simple;
	bh=YqeGgXpqldMF8HxKB3uKGoGgFOzgL8+ZDrJlc8jiAJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6ON07b2iXcIJ/rXNBdcmLC6AVi7tcRS1DR7O4Iz7KA8nvZcXN9AJmCQj3cEXAeROEuzij+mRi600KEj7c/3J0EgOPcOayhwTXFhqGlDvPDsxgIwfhTbb20LAsdRNmkWoWR7kT8UcTbqMxO6qzZ4+s9cs+L5DhxP8R96nnp1glg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hINeg6LE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d12Bs0g4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hINeg6LE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d12Bs0g4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLETI01750344
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bxUZab8aMhubY0N1zDEDqUt6vuYQLsqiJEVvXqBNr/Y=; b=hINeg6LE6NcTI4Ft
	rDmNwKGoUYDv0OLRpTbAcXmLs7YG3fwHy5C6TLgOWGmbUDcQOIdDNMZ8LMbFrx+K
	a/mGVE29+issiAEDumJZ+18H+qFyr8JpvRoHzfiBsmoHGkcqGpeTv9+2KfXvY8ev
	WKLf3G4rXue8CHf/xi6EMzdVcm24ed5OE1gIyUlz5c4h1NO6/B2er7AK5q41G/yB
	C1GV/tJu5f//GI1GOFCp7Fvrbw2Q1u2WBxs7NzZgxqeZ3/VPU+vZV/Ub/dKGmw9p
	YEK6QlzF/gSQaCndppVGGBQKWYVjLhxKJf2KBBT6di86iEhMRMbv9OWH3NZVQFkA
	2vtzGA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbc1ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb413d0002so4815334485a.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 00:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837197; x=1772441997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxUZab8aMhubY0N1zDEDqUt6vuYQLsqiJEVvXqBNr/Y=;
        b=d12Bs0g4tiP9MU+tcs4gd7f2zHx6Rov8+FgmjZ9yqTmTvJRQkXYqXypnrkGX+AFSBc
         UKlcSkAlhqtf75QigLF11Hg/mQs8M0AKZQ+TyMlKtn8n+fv8cXpjWjEDpj/XtqoB8p/z
         0swgqTfUfRHxBuD1cGPZoq4BvjL9Cmv4ylZtCmPZR8O3+fXtuCIRv79NHeaecpIleYjU
         8nemhlnaxEvkCd1+oV+8YDUgy/KTJf3ciYR7TAiawIc9Zu0MNSpeRPL/MRvv+5/hxbMM
         iClvYZQ9aauN2fZxXddXPyFf0ovuwQDN29tCCNkyYzKMXyf0HbU7MXqSH2UnS0mcER10
         59wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837197; x=1772441997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxUZab8aMhubY0N1zDEDqUt6vuYQLsqiJEVvXqBNr/Y=;
        b=EJlAsXE51FJQNWoy+ByZP9dJsRbHPpMUz+/bks9v8srGPDei8QIVKyCdPBIJO4e408
         9N784KVCyPrdRgcdlHtOrhvqYkxmMXO+n83SI9U4j3hrgzJ5zQLIB1tQE2dz55SBD85g
         vAAtCmEOkfaX/nvXosbQF5yIY5gWYY6JHXpTyFh8+I5P+5lr/xrNE+6ZGi4WN7y3fMJ2
         1psAgBYuHBILhdnsDAPowAwYGBQo/qt/7PKH9DGONQu43icCnxr+oqhglU6LLJnsmRN1
         2S5L83oRMneGiU5zQOvKWSqmqBc7EsPf+LF6tQ7yMvfNl2NwORnLLs6RKqiCN/P3AHR2
         yfoQ==
X-Gm-Message-State: AOJu0Yw5hlcrXGkNRyNH/tW8TzdTpVA/wSccvzv5sxUe8hZh6JPwTd83
	db2CS5HqNu8zPPCT5gGVf9dY8/h6X3pOc5n6zbwfBD3NEaNOQRsk9RZSlXIQWRlAEQ3Q3cKJmOA
	yziU86wEkU1zQD23PLUU5xSV6LnbeT8VJySgFUHd7nk5o2EEzrgZbph/UJxrzuAw=
X-Gm-Gg: AZuq6aJpC+eR+mMaGpU7sMOZ1HQxo5IpysZMGTQj/cmUIJywD8vfVsDi2EN2kLDrd8m
	oXGH30VBXvZUklxSfeOZ/XJxob3kWVrGVtWxdH0F9BHbzUQVgHqunNc+D/F/j4sPPpvV3sttNGS
	KsFBNzSIBs51CJWiMfeoxQ7OkwQ7qr1vQXUU0UiGUpbAKL33x3B3Oz8/JNi0LBCXjX0xrsh+raF
	h0pe4+3RDLcUYfycY8c0AtLL2oytN5v0rb8erFycK01y32dcYYd+Mh9FVJXKo0+9ijS76ZX47DW
	k684BDe+k2UYtrcuWneQr5+ofQDTy+1PPp1ozkKBoUnof67ORTZZFNBDbar4cLs70wBwNyU0Xd3
	G+muC7JhpnT4h8JXl3hS5YPU1k+wbABjXMOgW1dKEbx6P0DpSSfsa
X-Received: by 2002:a05:620a:480e:b0:8cb:df8:e86c with SMTP id af79cd13be357-8cb7bfc91a4mr1729666785a.26.1771837197558;
        Mon, 23 Feb 2026 00:59:57 -0800 (PST)
X-Received: by 2002:a05:620a:480e:b0:8cb:df8:e86c with SMTP id af79cd13be357-8cb7bfc91a4mr1729664085a.26.1771837197127;
        Mon, 23 Feb 2026 00:59:57 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.00.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:59:56 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:30 +0100
Subject: [PATCH v2 01/13] media: saa7134: rename i2c_dbg() to
 saa7134_i2c_dbg()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Khalil Blaiech <kblaiech@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
        Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4322;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YqeGgXpqldMF8HxKB3uKGoGgFOzgL8+ZDrJlc8jiAJc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBb8OHlHHDWBSO8ZFzntsN3xbV7ZeexU+rxfg
 feCDFo3zIuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwW/AAKCRAFnS7L/zaE
 w3SRD/9kRjMgv00rIPHPHM9uZeGcfzBrrOW3e2CjD/Ba6V/M4ZeVfvzifGy9uG7Vo/bj4qrB5Eh
 vRIG6Ao9+a27vcLckM9zoaEffZgVxG8fjAntZaP7dxUhuj1kZpbOzuTQUFdstBpoJEQi3qx4s8t
 DVAvP9ZAZuPi5nyhg8sMTkXtV7OU1arFsbqNo5TJysZEiYHPwJRhTDK0pNzaApbkb7c4FUOLPhZ
 pYac4xlu0gK26Mf838V0KKmAZfkEFFb/MVFPWp51PKH+wP3pALiK1F+A/hN1PbkdVRDlsP2865t
 qfJzYUOuUzhyA3R1so7E6axACC311B1Ll1LGcU9uyUgtREDMDIhbKDN1cM9kcE6Df8Ki/FRgKf2
 5Bjboe7TjXXo/Kkjlx5I/HGCQrZjt4NkXOv1HNF3MhUfbZdymKm6xY4OYBTH7/a6SGguwuwL6bq
 bsUVAFIId7KTsCgpdVqxHHkHgzwHz+PQ3cyeNUDuhp1HCp82oAPOfRPLn3pAFFBpzog1PolQn4U
 fZ+UcPxnqCDy5uscllfkBC9sgnHoVrtcDtV1MjdlWQg2SZgc9ws3/oRzapN+w6NcQYHbRZ7rcrP
 taQSy/k5L9uCdRHDWd1dUOtlH8kkAanoWkUICVRJcSEonJfZRA/pCuZu6B9qVyReTmNnMMymi5D
 84Ah+S6uwmFMyAQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: qlzo5zNNpzYXBHdg1gLqAbM8P6VKltpB
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c170e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=LDBv8-xUAAAA:8
 a=EUspDBNiAAAA:8 a=dK0ov3_ljch-J7--2m4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-GUID: qlzo5zNNpzYXBHdg1gLqAbM8P6VKltpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX6CzMDlP85Qc9
 qV5YbJjaecbeS7Z+4q/9iP6ydS9nxZctf2R51Q+y/u/TvclGF2byylpSJ5ikfEgSpXeA29B9ORG
 jckYN+r5bqVKSVLlFpUr0wi3vtU+/Qf5/3UzQVRjth8Alh5N6AOF/nHmacnFtXEP/BuqlG8WmLb
 Y3cJnaJVRhzrPJrh4kyAh/bI++W0p7jKBFBcVk3vt8d3h3PaLVwhwivTH3vb7bnhgR9Go26zbkY
 WrZZhGkfuzTIN+2ccFY+wFqpbJotoXMMm4ZwhEMKZKgZAU0ix1lSzewhZ5WFd8U+XODh9sG+WCs
 dE4sHXTGfkJI0HZuTdIXWgaAZdNVj5dySx5pp+OFDZXED02wSghgtGagkTfM3IGdmU5WfFG4/xF
 UWJh1bHTup3LQCrVng3A3h3ZSzPDCo68qXaTNZOD464rKgbMqbPt4Ua3FVwaTXZFZwE6nOPJPJX
 /bph00n7j03S+h3vBXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Ahead of introducing I2C-adapter-specific printk() helpers, preemptively
avoid a conflict with the upcoming i2c_dbg() and rename the local macro
in the saa7134 driver to saa7134_i2c_dbg().

Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/media/pci/saa7134/saa7134-i2c.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-i2c.c b/drivers/media/pci/saa7134/saa7134-i2c.c
index 04e85765373ecc0f0759eba539c20bcdc9716ca8..1164e91cbb7b7f5250dc02bc086f5cc06ea8f5a5 100644
--- a/drivers/media/pci/saa7134/saa7134-i2c.c
+++ b/drivers/media/pci/saa7134/saa7134-i2c.c
@@ -28,7 +28,7 @@ static unsigned int i2c_scan;
 module_param(i2c_scan, int, 0444);
 MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
 
-#define i2c_dbg(level, fmt, arg...) do { \
+#define saa7134_i2c_dbg(level, fmt, arg...) do { \
 	if (i2c_debug == level) \
 		printk(KERN_DEBUG pr_fmt("i2c: " fmt), ## arg); \
 	} while (0)
@@ -84,20 +84,20 @@ static inline enum i2c_status i2c_get_status(struct saa7134_dev *dev)
 	enum i2c_status status;
 
 	status = saa_readb(SAA7134_I2C_ATTR_STATUS) & 0x0f;
-	i2c_dbg(2, "i2c stat <= %s\n", str_i2c_status[status]);
+	saa7134_i2c_dbg(2, "i2c stat <= %s\n", str_i2c_status[status]);
 	return status;
 }
 
 static inline void i2c_set_status(struct saa7134_dev *dev,
 				  enum i2c_status status)
 {
-	i2c_dbg(2, "i2c stat => %s\n", str_i2c_status[status]);
+	saa7134_i2c_dbg(2, "i2c stat => %s\n", str_i2c_status[status]);
 	saa_andorb(SAA7134_I2C_ATTR_STATUS,0x0f,status);
 }
 
 static inline void i2c_set_attr(struct saa7134_dev *dev, enum i2c_attr attr)
 {
-	i2c_dbg(2, "i2c attr => %s\n", str_i2c_attr[attr]);
+	saa7134_i2c_dbg(2, "i2c attr => %s\n", str_i2c_attr[attr]);
 	saa_andorb(SAA7134_I2C_ATTR_STATUS,0xc0,attr << 6);
 }
 
@@ -160,7 +160,7 @@ static int i2c_reset(struct saa7134_dev *dev)
 	enum i2c_status status;
 	int count;
 
-	i2c_dbg(2, "i2c reset\n");
+	saa7134_i2c_dbg(2, "i2c reset\n");
 	status = i2c_get_status(dev);
 	if (!i2c_is_error(status))
 		return true;
@@ -198,7 +198,7 @@ static inline int i2c_send_byte(struct saa7134_dev *dev,
 //	dword |= 0x40 << 16;  /* 400 kHz */
 	dword |= 0xf0 << 24;
 	saa_writel(SAA7134_I2C_ATTR_STATUS >> 2, dword);
-	i2c_dbg(2, "i2c data => 0x%x\n", data);
+	saa7134_i2c_dbg(2, "i2c data => 0x%x\n", data);
 
 	if (!i2c_is_busy_wait(dev))
 		return -EIO;
@@ -220,7 +220,7 @@ static inline int i2c_recv_byte(struct saa7134_dev *dev)
 	if (i2c_is_error(status))
 		return -EIO;
 	data = saa_readb(SAA7134_I2C_DATA);
-	i2c_dbg(2, "i2c data <= 0x%x\n", data);
+	saa7134_i2c_dbg(2, "i2c data <= 0x%x\n", data);
 	return data;
 }
 
@@ -237,12 +237,12 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
 		if (!i2c_reset(dev))
 			return -EIO;
 
-	i2c_dbg(2, "start xfer\n");
-	i2c_dbg(1, "i2c xfer:");
+	saa7134_i2c_dbg(2, "start xfer\n");
+	saa7134_i2c_dbg(1, "i2c xfer:");
 	for (i = 0; i < num; i++) {
 		if (!(msgs[i].flags & I2C_M_NOSTART) || 0 == i) {
 			/* send address */
-			i2c_dbg(2, "send address\n");
+			saa7134_i2c_dbg(2, "send address\n");
 			addr  = msgs[i].addr << 1;
 			if (msgs[i].flags & I2C_M_RD)
 				addr |= 1;
@@ -265,7 +265,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
 		}
 		if (msgs[i].flags & I2C_M_RD) {
 			/* read bytes */
-			i2c_dbg(2, "read bytes\n");
+			saa7134_i2c_dbg(2, "read bytes\n");
 			for (byte = 0; byte < msgs[i].len; byte++) {
 				i2c_cont(1, " =");
 				rc = i2c_recv_byte(dev);
@@ -286,7 +286,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		} else {
 			/* write bytes */
-			i2c_dbg(2, "write bytes\n");
+			saa7134_i2c_dbg(2, "write bytes\n");
 			for (byte = 0; byte < msgs[i].len; byte++) {
 				data = msgs[i].buf[byte];
 				i2c_cont(1, " %02x", data);
@@ -296,7 +296,7 @@ static int saa7134_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		}
 	}
-	i2c_dbg(2, "xfer done\n");
+	saa7134_i2c_dbg(2, "xfer done\n");
 	i2c_cont(1, " >");
 	i2c_set_attr(dev,STOP);
 	rc = -EIO;

-- 
2.47.3

