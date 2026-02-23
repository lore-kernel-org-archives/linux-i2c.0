Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D4346A1F
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837219; cv=none; b=OfqTpsw4YZThaq1LabfJR3x/AEonKq0w+t4UohhuBd3eYJQgY7YEoWATERO27gVgcjFdUEdaS+WxE6rpu9Q3tw/Wz8+okuDX9YTVwaRsPncE/5Lecnr9Ms3Bq+4uGWtnvNw8ze3UxmZ6yHm6BLZdaqt3lwo8dDtAfp0PwC9CQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837219; c=relaxed/simple;
	bh=Z5y+uDYDLt8QrBK74QcxPQFJYMWolbieGXxGJWOf/Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhC77yu7UnY6zIev/3lJLFgzLZtwvXPrXmwPpUzu6Uh8Oifoe5ezRrRxRGPhRIH7yqc9gYHWpnbMNL2JppsyDRtIzJAKEdeJtYKyUMEFHyc3sZa8s3BPc+XKy3XLj9daqMxRB2DsLS+ws96MvS1aPc88m2W045SlWY2eUulqiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z31W/9nu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLNWDVzD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z31W/9nu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLNWDVzD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N7WD3Z721346
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7VJPGTun9iAEUTgsAs5oldXV0hm6NbS8Rh/bgRh+cvE=; b=Z31W/9nulwQAAZ/y
	ktZPP6LohTfU9u3yekdeRN9Zhw5JTPXndKPMIWP4ZTZPl39CRSKkGmQ24K6wTtVE
	ddvpg8edrCTXMlWpfnSHiRYHxO8cJ9IFoFSsWag9NuJrYQMXuG0MlJ8RXGpLm8j+
	GUGOuqN6cjO8Ly3R2/04h02h+COPxjNLHOM9PZVtKVX1f3Tdh/+7Vr3xra20Wsqn
	eHPAD6B+4p+gFjVPJKeeOp3BxuNhrl5v1qkvfHOMmTtW8iqoyXAEbWpfgxOaNerx
	bxOlU9NumkOl4E7q6mxJvQugmdeQQ7j4YQDpSaLABHgagXr6gLBpSD0kCzxRHHL5
	EE1fiA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbc1ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c7166a4643so4420542985a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837213; x=1772442013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VJPGTun9iAEUTgsAs5oldXV0hm6NbS8Rh/bgRh+cvE=;
        b=TLNWDVzDC08AVQuZf0N5SdB2/o/f4GG9juddgpODl9ZucUAmkuOzyU7l3eoh1xN11Q
         nsT7oVy5cdr+cf8NdqIglfu8FkeTGO/WKqlzEJeYjlCHckeONJzMbCWoY8AcSXa5k0Cq
         Sltj6qvq38hSr7fv53SHacA0jkrrNIoXwZkrw2JNYr2bfFVYK5r4PhFAs5y8865PYmYj
         tBFCXBX81kEpMtoBWOIhKpnLIm/U/jmZnPujB9R+9r6a2NR1ETGLZ5x7tw4RyT8O++JH
         dDVeFABOiQej7TvHXHN4R0jj3e+mogdx7LUHlHpRzlJqkEcn451MaM8EmFtgAj7nP09l
         7AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837213; x=1772442013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VJPGTun9iAEUTgsAs5oldXV0hm6NbS8Rh/bgRh+cvE=;
        b=SjAyuwIbVeF48DmyWk03MVMa7I7CJvj9AtBUyNpgWyItFXuMKC3tF/VY+jpdAgfXtz
         rfPaCT0StB2wvZorPlE993BQtk37FkS0W20XW1P7k051gqWMaqf3uaEDEoMet08JpgW4
         rC+WYdJIE5AOk0Gh9YRvJte2OXmi5HlUk8QAXRSvIxdufjHEjyH7cFoZCu4pUx95pC62
         UuXb7kHo+RyGxyr5EjJT7REBqohqra4nv98J6yhS/htDsxZhRTWo8O3RT7IFl4+WpDQs
         HlfmzYpB4xEnz640SgKmkcsCZYRs7+RPTUc2xQAdHeAIQiOR86ED8bqt+4OmXFp/LKuy
         LMaw==
X-Gm-Message-State: AOJu0YweNWrBQAdgJL+Jpb7ArkCvm2oh6fw5SRGTFSw/9mc9KXdlXjcj
	+LsMagKgTYc59CN4RpvofRN4LqFKdx6cq1BS3riC6Q9aC6AxsEEltymvL+FMLAdMVlNyrqOMCL6
	OoneiLuma90w0BSohg6Dhew0TthDZPagebeOyLmCO3L1u085UON3GJBv7drOaPQk=
X-Gm-Gg: AZuq6aLiips0tx5dZB/5/Yb8gdjCAqIz6aTNhCWhUJeHiw30JPPluWp7YJSWR0Ke18u
	G3bLXJp2blCYTxAoyxLAhmEDlpeQDLAanjZzuDTAXeZ+AuMYgApsXs2bpqwlT1Pzl6SEOq6adeY
	kFA02nqkX4pjAFUGm96PY/xUrkkLg7X4AdujuBf09MafnRCxOLEozXWcE3EEh/JkPe2yLdAXWz9
	kui0VdodNDOnpGvoZEK2VvUW/WnhE5q6e2UkeuH2B0jNrBkQPmEW6tymQ4LbEtdjM3i5VGoayVv
	Ac1v069HfV4e//OeAToC6n8sYiYTmHBnN03JjRItm4EtYY3GkzJpS48Mmwt+dhIR0BG6mLbKzfz
	4smD+tMVvRKG+khkBfSxomkZv3e1NYiOTz6KHwjyQVGMMh65sjYmD
X-Received: by 2002:a05:620a:25cf:b0:89e:67a9:fcf1 with SMTP id af79cd13be357-8cb8ca6e5dfmr893386085a.52.1771837213242;
        Mon, 23 Feb 2026 01:00:13 -0800 (PST)
X-Received: by 2002:a05:620a:25cf:b0:89e:67a9:fcf1 with SMTP id af79cd13be357-8cb8ca6e5dfmr893381785a.52.1771837212768;
        Mon, 23 Feb 2026 01:00:12 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:37 +0100
Subject: [PATCH v2 08/13] i2c: ali15x3: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-8-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z5y+uDYDLt8QrBK74QcxPQFJYMWolbieGXxGJWOf/Z0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcEYiK5UQfbNNqKPli3aLyGyc9dDCAApPSVu
 LSNBlM5nICJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXBAAKCRAFnS7L/zaE
 w4NbEACQ/tkbIztt7habxCJvYKOkNiHzidkMAis/yUMZwvnw2HpGFGHCIFcmkdnHg0snG26uQ4h
 0M+1oJUA1rCaBIo/sDh+VRpAaMSxZQgwYg3dWej8mpAiT3t+jz1z00zVZ1/DnW0PUH+lh2agaxw
 nvsIfrzaFtUww5SdpThdARVpsR7vCDw4bpz2u1Y9OzPLqqrEewp3+YXh27EsI6WKyDxL0CQsK2Y
 Sb6pdI0qGN0YYYEpZU1xOcnOpfd4Oskb8+Kw7SVj9PlWpfZjKg34Yf7W0RKuf9OLGzjf9UIBDhw
 P8ZhrX1x2eWmWiZnQaUkF6EyhmhxGqbfnp013QQKEMecw/zmvEJds6WY6sYfoFvkgceP3xLxim9
 /jhbVGlEo7jr/FjQs1X0ek88255UcO7PUwflz2vB6zGXoMHjUAg/7QK+H9GE5rZva1whpge1CL6
 DisWCwE0DR4v4MD2gP+Rm4XTJ1ID3W6LjgygBrxIWby8hoO1PYxp4/8hpAjWHuAeDgklOK1VElK
 g2qVJfjeHMCfM1pUgX1wN6je2wLg+vjHdy/noDtTeUBkr1ikXhXpgM21fa/JMFhclnYLx+5JKDm
 BVlk2V0L04Wdt/URrfJ/aSrcxdhtsenJkpzGHNvZuOSKWS7LuTKEVdhDfbFQ3O7JS3EMR8OWiT2
 T5qRX/0rHDZqaVg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: CFrtMZm1cttwNsuXothPFmMHYcEfuIpJ
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c171e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=FH57a1SQlJoUzRel804A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: CFrtMZm1cttwNsuXothPFmMHYcEfuIpJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX2ybqqNtJ1dWc
 MjmY9fJ6C7frffoUJeSru0yX+uZu4qQhZZ+i+5RINCbNDbCMaBEsCWsIA8X0MSuOI7C+usOr9Fc
 VWv27WrIV3xYGU+UxJWgu4FCzmUuBw0r6ZjuAuG9suysTmcokq1M1YtcX6lbJJOV+7ko/UhoDpq
 8gZBRsTlWcjHMRfFI3DDWL2MnWccQIUoNL8Fu94ykbsKFvtwd31y9r+pycE+05d6OwPZKt+Yeaz
 eQtHqwD8oIxqU3EHpfAg/MsWLLHnXtlMabqf/Tp2NaxDbzsV7j9VRzSYjJSESwIRfa4WpAcJar0
 9Ry1/Hm4FH21kb/jHHi/BYcuvBth5rntjr6c5E/FCJF/2f4EQtqz6Ko+/r8LQOTcZMicAQfllgp
 LF6a7MSU3SbxYdnO800667QlwyYBqAnkn+8fapFVK41o6EMDpf6k1QNk5ZxEMGn/weOm7SUOQaU
 k4oFdSueFUf/wA7AICw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-ali15x3.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 418d11266671e314aa2fb882ece025dc0ae998da..bd62aa8d645004bef121fa46efc1d7afc473332a 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -223,7 +223,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&adap->dev, "Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, "
+	i2c_dbg(adap, "Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
 		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
 		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
@@ -255,7 +255,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 	   then the BUSY bit may come back on when you try and use the chip again.
 	   If that's the case you are stuck.
 	*/
-		dev_info(&adap->dev, "Resetting entire SMB Bus to "
+		i2c_info(adap, "Resetting entire SMB Bus to "
 			"clear busy condition (%02x)\n", temp);
 		outb_p(ALI15X3_T_OUT, SMBHSTCNT);
 		temp = inb_p(SMBHSTSTS);
@@ -270,7 +270,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 			/* this is probably going to be correctable only by a power reset
 			   as one of the bits now appears to be stuck */
 			/* This may be a bus or device with electrical problems. */
-			dev_err(&adap->dev, "SMBus reset failed! (0x%02x) - "
+			i2c_err(adap, "SMBus reset failed! (0x%02x) - "
 				"controller or device on bus is probably hung\n",
 				temp);
 			return -EBUSY;
@@ -299,7 +299,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 
 	if (temp & ALI15X3_STS_TERM) {
 		result = -EIO;
-		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
+		i2c_dbg(adap, "Error: Failed bus transaction\n");
 	}
 
 	/*
@@ -310,7 +310,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 	*/
 	if (temp & ALI15X3_STS_COLL) {
 		result = -ENXIO;
-		dev_dbg(&adap->dev,
+		i2c_dbg(adap,
 			"Error: no response or bus collision ADD=%02x\n",
 			inb_p(SMBHSTADD));
 	}
@@ -318,9 +318,9 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 	/* haven't ever seen this */
 	if (temp & ALI15X3_STS_DEV) {
 		result = -EIO;
-		dev_err(&adap->dev, "Error: device error\n");
+		i2c_err(adap, "Error: device error\n");
 	}
-	dev_dbg(&adap->dev, "Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, "
+	i2c_dbg(adap, "Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
 		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
 		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
@@ -347,7 +347,7 @@ static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT) {
-		dev_err(&adap->dev, "Idle wait Timeout! STS=0x%02x\n", temp);
+		i2c_err(adap, "Idle wait Timeout! STS=0x%02x\n", temp);
 	}
 
 	switch (size) {
@@ -404,7 +404,7 @@ static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		size = ALI15X3_BLOCK_DATA;
 		break;
 	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_warn(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
 
@@ -437,7 +437,7 @@ static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);
 		for (i = 1; i <= data->block[0]; i++) {
 			data->block[i] = inb_p(SMBBLKDAT);
-			dev_dbg(&adap->dev, "Blk: len=%d, i=%d, data=%02x\n",
+			i2c_dbg(adap, "Blk: len=%d, i=%d, data=%02x\n",
 				len, i, data->block[i]);
 		}
 		break;

-- 
2.47.3

