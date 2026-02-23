Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055834FF4A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837226; cv=none; b=JncB96Zh9Bqs87aIZs6ZxoP3C/+1l0W/+JH8c1QrdAuNbJB8g/eUL7Q2j7rB6TBXbhQnM5A820cWBt5QrvZkNBFvDfV3t54WBbmFm/qaSIebBOzc3H7vN6nRVALgULeNUChuuRoaJl2fE3vKo1V0vWerzf398rwQiQ7kRabRaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837226; c=relaxed/simple;
	bh=dI851BmOduiioly8u4iYfe+Rr//GzNIkYCteXmln3Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEv5mq6J6hX6oMh98XJrNVr66Qps9KOgD0VF0gKq8QmySJ9wX4MUuaqSlFQMKAQodIhCXZhtjWw4A1t9DPdk0RIfVZShp4OSy5apwuARPaPuUAEOf69ziIVv7iimTz3h56HqKlimvNkKjhyqmUffJw4NpbxnPb3TVR7lobycmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwlSGsPo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y/TMu4/7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwlSGsPo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y/TMu4/7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MIP8gg2771468
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	or9DvhQwaxtsrAqBQKF2R4HMkZA0UWyOfpa2BBt7/z4=; b=NwlSGsPoajg1cdlN
	7FzImz3K7gmzTZflY85WSUFFFjqKsV0yoyy9AHVsFMHPRdjvX7zEz4bKOz1FdcrY
	aXWZagVZ5ZFd2Z8FuByy3BgQuM3L4E+3cL2iEwk1Or8o4Hl3TBZvuLcAf8Al+GIP
	gbbubkB3pBEdfiIBubRvwcIdXXX+X+sHj1qa6ABgHM8t+GK0EyS9xwNLk9cg+YYw
	cqeSfSWK/1rjya1QyF89zZvbxZdJqxYN4d08FAjDFCkN4X13IOMkNcA0FbpHWbqu
	kmDGlwB+M5mfh4a539DIBSjhclF2NtGHv9PdOFxL+jQiRY0Pogby/kcckwwNoiz2
	6v0j6A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wk407x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb52a9c0eeso1324235085a.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837223; x=1772442023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or9DvhQwaxtsrAqBQKF2R4HMkZA0UWyOfpa2BBt7/z4=;
        b=Y/TMu4/7hfWA9ZjrWTEOOqBNmDzzAQF/WB9OVKsCpjDm/S47MeqcSCvxg4PErc5f9e
         jCf3rD3gRDKeV8XdcfelGluJkFVULa1zTzmvMDGbLoubXTkl9pJebicoxoJDeAGCOzMw
         Fig/eIQQrAYpc2uk1IXOOzo+QNRqnDtRvIAqbK5T4QmiZvpgerQ5rf8tsRdZVdnuq8T1
         Bbo3hGLwYo7WR6TxBBEM5n6dls8vOaTcyAZOzRJuk0hx5cSn6uUh6r7CGm249Cb7eHta
         j45fQeWmpx45f3aKSwDzkqeGIehpvx4MTAPrpHR0A5F+Rkb5fgFwgJxSKvV4CUwC1jSn
         gXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837223; x=1772442023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=or9DvhQwaxtsrAqBQKF2R4HMkZA0UWyOfpa2BBt7/z4=;
        b=DBha2t0WUx6FUSW70jlslijS97lEqobq6o4FsEamPFeyepJWaOP4a9fSKu1idiV/1N
         3XWm/70hx4LL6Bq4zq0HeYiLZ6FBRtirZ35wjHbzXlvNYUAT09rsk6VnygqNYYTXviLW
         YAvStkPTZAdoau9m5teN/eqxSjEJaMZMLdjId07giD1YPkXeSfSOAG7QaWuajeFT/5Aq
         3pb8tQ2V2eRAPjo1C1dyFRhlfs045B0WTGh0p8dPxQkTNOcIPC+GuBxnVU0gnQzMxqgD
         2C3fbKDiW4XVpLsBKmDKqyCyodojB02JHQElRn32qsgh+Y0OKrQoD7mGqsmQYRySslTe
         KzvA==
X-Gm-Message-State: AOJu0Yy+aBFzKb06rICZojcWNxYJijcgpw1vvC5r3jsafJz6C8i9Dqjp
	elKySMCfRgMEIJzMQEZwr1PsWLU/ccEebeunJXO1NhONxa/cRqlaZSQOftEEhY0ZtQpLRTf1DMu
	0ILQq61E/gWgOzigMWubfaLZa+TSG7Xy/r6GnE8c/lSMnGBmD1FTx6q39jhYskBU=
X-Gm-Gg: AZuq6aJjcUkdcTya71asbC3o0G+bidRgda5RuB6ptGfgM3kfDJOeO/d4uDAatEpi4z9
	f6WR7dcW5TAHDDm+oMwjPDioLK4oG9/fcECgbneD8J37Q9xKzSgnJPp5WkgWh3At8WPahXNvBUh
	h9nsloltKnErSxafcVmRmOQrigF/myc/zej5iGiIXqc5iCPDqZvpelV32M5CtWBW0tTTBSp9M1l
	JXDkpgurmPR+LE2O92OTf0WCFuYZy0yiHsqLSL6w+kwIIf/6I3V5Mo9sDrkYs2JpBPOqBfXWLrW
	BNBGBb7JIzEs9yQj0S/wJhZUcoYo9mgGBkTDoEA5AydW2lHd5PGYk3FbtIxhA5SAbodddaH7y6X
	AfQiBnMFKnTbS5bjgkQ4BVPUPi/5ZUT/QFPI7Nji/4Z7jDJkclU8i
X-Received: by 2002:a05:620a:4555:b0:8c9:fb26:dc6e with SMTP id af79cd13be357-8cb8ca65ae1mr991090885a.38.1771837222310;
        Mon, 23 Feb 2026 01:00:22 -0800 (PST)
X-Received: by 2002:a05:620a:4555:b0:8c9:fb26:dc6e with SMTP id af79cd13be357-8cb8ca65ae1mr991085485a.38.1771837221857;
        Mon, 23 Feb 2026 01:00:21 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:20 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:41 +0100
Subject: [PATCH v2 12/13] i2c: amd756: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-12-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dI851BmOduiioly8u4iYfe+Rr//GzNIkYCteXmln3Ng=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcHDR72fg/RLmfqEfX9o8DKYkAT9RN+UOU/R
 RWoY8UXtcqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXBwAKCRAFnS7L/zaE
 w6GID/96qWc6HzdW5LSb/XKz9++1uSGtny1zn/Y2Dov7vn78E1+wi1vBGY97PMuY3wBXAFWHPkg
 je0bVLHjsDEv+4uqAr3C4T0MelEgMHgYx+EcA/vRYlrZsDTah14vhyIVVBAgU+LH/qnqHJ9vnb/
 R07bjiuhq0RygoZggbvZxDp2/psEw1yfOq2Tv+rSH51jenKvSShvBbfDzpmXNvo1WIKFKuxObtb
 y+L/xfFlfq9tSHkwKnLFytYKBRgerLwkqFANPeuHYpPL9EXoqHjKuvAt1CJqc55EJVNzGZFkFIT
 eYid0jiEyP0q2IDoJDYUbTPpGLIDJcrrC3Tc7J9uLALV7BTKVrJjdR1lZD0FA50vtH/UdMmTlKt
 vHba0Q2n68Kl5mkhjCDGHPg02it0MuFVgFFppU2bT+u1rTNlfSu1dZpebdQ4uCu55REXTij9N8i
 v3EWewd2H6lkniqel+JvZlorsNA+W42Lpxj7xHgKVQnd5Q2nvPKVGmneLlRQfVn9fpQ/WBaxBuo
 aCNzM7qDoUqFEYSbjFfwq4Tz2MUfkkPH6kT6ZQyMiw1U8U719a0prDzVkG1x9m3lkx7W4zcsGF8
 /9P/DxDJVq94qbo2A6aa9ouqHJR7NFgwxXkhLUoE7sqoBb2GDX0+VLb4wUCGtORmHX3GC0ps1yv
 kOomrQu/puIrA4g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=699c1727 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=IUzV_G_aAFXi5cZUTYgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX/4bm3K61Y/k1
 XegpsjNsuMGINHdpibeTa6QLIFMp1OutwwvjGw64lMM4VcMn033P2oMITzDXkCRiQwfNUL5d2L6
 EiacVHbJwoDN9dJQreK+E5zJsR1fkxPYnBIEEMHmtQ+y7AdbPdJgNP6ROUqnFUzHYJk3XQaFDOo
 D12cDuj0D8zAkTZcLGoNKnJXna6jlpQ31+h9mA+TZHVZaXtfxvLPbak7oxzXstxWu46GXihx8D/
 tyi2t+X090dyOSpvVmG0N2+lWWynW1ScmtIvhKNEiqnjx+m222pTcfH3pb8Pggx6d3+6rRQLcK4
 CPSLrwih9PBNH1loDQzgwfSsY6/l6fz9mIio3mnu/MkAvZFgsD4cBxLsqOTh++u7BWD3o3O7K6S
 ayPbDvMKcntI8bmTV1/HfoviLzsdWxenThq9fgpLc93c5xBywPmxlZFB7w2eOrX0Ro9b8Fe/E/2
 v92MHbqelSvRLvmZdtg==
X-Proofpoint-ORIG-GUID: PYI7JBBW3HsFYpDtfczDDHrUEMuqfprx
X-Proofpoint-GUID: PYI7JBBW3HsFYpDtfczDDHrUEMuqfprx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-amd756.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 3621c02f1cbabd8c5e9d8a4ae1494ada78726b15..629da0b8024b88cc4d51ea5e785147b462a1281c 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -99,14 +99,14 @@ static int amd756_transaction(struct i2c_adapter *adap)
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&adap->dev, "Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
+	i2c_dbg(adap, "Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
 		"DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
 		inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
 		inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-		dev_dbg(&adap->dev, "SMBus busy (%04x). Waiting...\n", temp);
+		i2c_dbg(adap, "SMBus busy (%04x). Waiting...\n", temp);
 		do {
 			msleep(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -114,7 +114,7 @@ static int amd756_transaction(struct i2c_adapter *adap)
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout > MAX_TIMEOUT) {
-			dev_dbg(&adap->dev, "Busy wait timeout (%04x)\n", temp);
+			i2c_dbg(adap, "Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
 		timeout = 0;
@@ -131,38 +131,38 @@ static int amd756_transaction(struct i2c_adapter *adap)
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout > MAX_TIMEOUT) {
-		dev_dbg(&adap->dev, "Completion timeout!\n");
+		i2c_dbg(adap, "Completion timeout!\n");
 		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -ENXIO;
-		dev_dbg(&adap->dev, "SMBus Protocol error (no response)!\n");
+		i2c_dbg(adap, "SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -EIO;
-		dev_warn(&adap->dev, "SMBus collision!\n");
+		i2c_warn(adap, "SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -ETIMEDOUT;
-		dev_dbg(&adap->dev, "SMBus protocol timeout!\n");
+		i2c_dbg(adap, "SMBus protocol timeout!\n");
 	}
 
 	if (temp & GS_HCYC_STS)
-		dev_dbg(&adap->dev, "SMBus protocol success!\n");
+		i2c_dbg(adap, "SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
-		dev_dbg(&adap->dev,
+		i2c_dbg(adap,
 			"Failed reset at end of transaction (%04x)\n", temp);
 	}
 #endif
 
-	dev_dbg(&adap->dev,
+	i2c_dbg(adap,
 		"Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
 		inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
 		inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
@@ -170,7 +170,7 @@ static int amd756_transaction(struct i2c_adapter *adap)
 	return result;
 
  abort:
-	dev_warn(&adap->dev, "Sending abort\n");
+	i2c_warn(adap, "Sending abort\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	msleep(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
@@ -233,7 +233,7 @@ static s32 amd756_access(struct i2c_adapter * adap, u16 addr,
 		size = AMD756_BLOCK_DATA;
 		break;
 	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_warn(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 

-- 
2.47.3

