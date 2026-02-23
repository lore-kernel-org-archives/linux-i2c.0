Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B534DCCD
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837210; cv=none; b=ruMPmcyPh+4PvFnvdSIKGjcMsJO0i/JoGIAO9ud4+q0/+zvAkXno8EqbdgE/3ZGgud1jhrTdqMp3L9d9xLia/u14sV0j1lYwovOm818wQbT/XFDpt1l5TvklIXqvkB4svGutm5rQoJD20Bg06IeAy9QfpnNEge/LVpsqw1fv3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837210; c=relaxed/simple;
	bh=v8r6k2O16OnH5w6BGAVCeXNkCvKSFSyUWNXZMHQqfkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pi1SwFIU8j91LpD59xy7dRXFlLXpWBSxMWdUUqGhTh4YV4KVBEHsONalHuFKf1T7MaMzuqFkYPl7CzNaf5VSDL0nzUVVRVkh2fn0a7ZSII3CGN7qlCx6+k+EbT5CtPXMEWZ/mgg3bX/DFQfwNEf6bV2mYwCxAQ+u9x/QblraX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2TcI7/x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dY0Ex01y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2TcI7/x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dY0Ex01y"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMneMt2783699
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aRgl7yRlCXzyxV5Kapc0nHIuCvjnGwXzj9M2FJADyBk=; b=L2TcI7/x7teBpyyJ
	gPnAHuqTiwFcvqBpha0hG6k1wOXoQPhpicQsdZSIGKwqLKU4eFTnGPsjFpELk286
	EMx0GlV3ROgtwgZG4p1gJNZq5lr8WTAlBMAroSDT7/76+guIkxKoAgl+FOfivX5J
	KoWiScUAGlncq91zMMk+YdyxSPxUW6KQwXxu1LF8VutmGL/LqlyeDvVa6bAMdiSq
	r9rJSfMN0tA450ClmXMDVR9dmRl1bKnmVf746W5BYLhtSLdVkqYC7hA8SIHVT1UJ
	aNg20iPugZxTE/mIJisvw6Wknmu4wgJeieMIG3Kqx4obZXeJ7698yNh63QWjDO3Y
	hVc8nw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv2hw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:00:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4a241582so3863284485a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837206; x=1772442006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgl7yRlCXzyxV5Kapc0nHIuCvjnGwXzj9M2FJADyBk=;
        b=dY0Ex01yFfLdKVbhdsJGn50RCoOruo2uElKs190KqfJbXgX89VBehkVlY9guHoc1Vb
         c+iuU+qXu/98ax20HVmRReGRBFpmtS2PC2Wdu2az8JFx67V6UBcBLzlGMgDGI97ksoCd
         9opaZOhWN/H72WW30c2PhP5C0L+S0akaBc+zNGxYpLyg7S6lHtH8MfVtnjU+ne1HaJl4
         AH4J+n0bcxGTyeNCxcRpdPSpCy9DX9AH4OiTIjKvdo3mXuzuSSB2bbav/Tsv2oNDZbOu
         RazxB5GnrhQLvyTuOGCkgfbBo7DEj610+aRsn3M+jSGXNx7MDBL/hjkU3rhvcj0wPEx9
         NCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837206; x=1772442006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRgl7yRlCXzyxV5Kapc0nHIuCvjnGwXzj9M2FJADyBk=;
        b=ivJ7WS/hJsZ88+a91vv2dNrjtzyYX4axZOgrhX17Uxsne4S4GB9F0pkWv4juwxrnna
         VqOkZaxMbwUAGUCS4JHxl9apx16cKbw9JTuMDQFJv20l8auCr+8haSbdnNmapQa460Je
         K8rKwr3zUG9ogVgvX+6mdNrkGmKUhYxhgUgiaIc0j2ATOIsOQi5JLbDoASSB/zKQ2tfe
         /9sScOgdJGndo3vnSEd/ePCpSwZ4vAkxsffx4R6jbX/YSNK0YBrA/e+FLS4SSmcKonO6
         f9dokLIhqKgt0utrSrOGC2sOaEvhuXmmhKcRfslg4OVNFjhthnYepURZZiWRuO34bNb6
         D6rA==
X-Gm-Message-State: AOJu0Yy6LDiR3mUMHx9kEvUNiShJtaTg9Z/nKXNl1V+opVX/u+0j7Zjz
	Neqd/n8PEvVU89fI+FimyckRYsM8cWqm2+B4ossbY9R6ihic5XhJVAuo1A5jsVmsMCZbEk9PgUc
	sFSSHtSSY6ClteDgrDT8IXVFL11swDnvTrz9euWv0IfkhoybxBRcdsOfBjrxXKrU=
X-Gm-Gg: AZuq6aIcMhP3lNchdN+lTBvvdsOuFksoQgYA9g5ZflV17eHPPAD+58Qgg3bIy9wljzA
	xT1/VxS2vzeU5I5NnwYMmFj54I3zTHPlxd9OX9K1l9JmLn9e8nCTFGKuIVkLb9C//6d5uo8vFQN
	91s8NS0yveugRyIMqNNrze6vV4ZSDWYcvwYQjhJ5r3w8UNmxok4DOgBHK2q5za6X1jTa+Lsf+oJ
	/xX5i3zI70pbNPEHSEoGbb6AR9Tcl4SuKRG8dTH2AFxGM6JJNVpPwDaw1gvkC2jI0dVEY2Z7Nax
	VUCaG13FfDS1GkFVBgETvzatt8obO/oYpwQnrSI+0YLN+L1j0hQI0Fhk6BcKOKIKtiyur3+Xc3r
	am/BUCUUBE2oiYuDdX1hffSsWkSMUlCjCEnvhfzQkRv0bOnDmlRJL
X-Received: by 2002:a05:620a:1a0f:b0:8c5:3045:3e7b with SMTP id af79cd13be357-8cb8c9fc733mr1029848785a.26.1771837205847;
        Mon, 23 Feb 2026 01:00:05 -0800 (PST)
X-Received: by 2002:a05:620a:1a0f:b0:8c5:3045:3e7b with SMTP id af79cd13be357-8cb8c9fc733mr1029845185a.26.1771837205401;
        Mon, 23 Feb 2026 01:00:05 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:00:04 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:59:34 +0100
Subject: [PATCH v2 05/13] i2c: isch: use i2c_adapter-specific printk
 helpers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-printk-helpers-v2-5-13b2a97762af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4804;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=v8r6k2O16OnH5w6BGAVCeXNkCvKSFSyUWNXZMHQqfkA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBcBJgBWfoyEfYLkAxhcJWdiklbYSi9bXzFb9
 oLJUErBEW+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXAQAKCRAFnS7L/zaE
 w1P+D/44ZcebR/fvD0BMZJTYIEGXsUdU+RvW7Aguaz+mVFiT8m8BjgGaH6bXTtOwFXWltPaYVB8
 gA988LhNnl9RLXQx/d3msmtcpEzxnqJ82g2IBUBx47/Qn5JYYgqUJ7LF0q0dHMl1XKj+e0awcp5
 VRPl4BH/moANOs+eghmvoD1ttdkl+3FMIHqsbY7Kq88iSRMbo7tml0+H/KbtJT5ypVwq1TxHAOJ
 1hCKo2zPjVoDM3VG8yzn4TInTSrlxiVog3/YIPtDR4whybvkrctIa0AX/Zyjn2mnyeI8JgqAXSR
 oaha7BeM6SAMI53TP+V/jq4Kw4RO0v4sVIlKWDEcbXwzmDjH1HFntiZn39C1ZqAYSIflxBKNV+Q
 CoFSfuA2hIq9W/iYmZ3ejMyDByyLKraBPgtOQ0sUPAsmNAIHLbyL//uxD/mT3bvqkSgUmhF3Xdi
 Shm2mBaRB84VPI5P2d5OyK0nbkN6um4VWfA8q/98mjk5X6c+AAmrildSJD0c9WP0L1WYkV7eTTt
 vVWBUJA8GEuLnQPcLTZg7kSKixPQArRRLn9sv0l7sLSzNUqTdqML+VFuqIpRKlbCilNSbTzt7U3
 kLL6biV8HF2aK+DfRl1pVWcaj7QjPt2rrNc2DV2Qt9ocvFAAM0khP2QOYQ27/rcUh4kxU8j2Zzq
 VHZR8pXt3HsZDeg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX0qeqB/181eem
 r5NAdyT6xugtrfHYSZ0iKwIk3p4G4H4CztKrbtcSCrHmmIkzbL6GH4U7II2bYEzlxYN/r/gZBvp
 oZe7vaMcsdW1pADKU9FFZOUm4X56hjseqtxYpO8Ryu2wdpOz+vfv0TWBlVTXpBoPkFQKjLi5GVw
 SG1y8T8hvKjekuJ7st6k/1eWbDMuhXQ+s4AWPL0T0zBGZ9w9RxwORyvSSbMOs0OExUnvGeUS632
 E3aFmyDGgUa6MSS5NQ74tQj5udkvYtdsCml23yUOKjQimdUS/2L9KUOQi+yRzpsl5p6HCOoaI2w
 lqobUnhK22XI8KVpfAKxZC4U04xk28BunrTqsBW/UWTeJB5BEPkMTck5emmCOZzg04sOIklvTzl
 htR/750KnkQ06Id/zO9Yk3QGFGO7bEC1WA6eByY05LPgixv8TeaJlKhF0rz88y769ioHbsCXDD0
 aOgJjuwaIwv7JZlxayA==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c1717 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=7nvlAvaXHceVFyMUCzIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: urOLFnQUmP3YuNhs1Qu9mY_Sve4qD6rb
X-Proofpoint-ORIG-GUID: urOLFnQUmP3YuNhs1Qu9mY_Sve4qD6rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

Convert all instances of using device printk helpers with struct device
embedded in struct i2c_adapter to the new i2c-specific macros that hide
that dereference.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-isch.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index a2ac992f9cb0d2accfaa979b802b98c3b7fbe3af..6ff07ab12e30db6821cadea4de3a588b9023ea20 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -86,7 +86,7 @@ static int sch_transaction(struct i2c_adapter *adap)
 	int temp;
 	int rc;
 
-	dev_dbg(&adap->dev,
+	i2c_dbg(adap,
 		"Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",
 		sch_io_rd8(priv, SMBHSTCNT), sch_io_rd8(priv, SMBHSTCMD),
 		sch_io_rd8(priv, SMBHSTADD),
@@ -97,13 +97,13 @@ static int sch_transaction(struct i2c_adapter *adap)
 	if (temp) {
 		/* Can not be busy since we checked it in sch_access */
 		if (temp & 0x01)
-			dev_dbg(&adap->dev, "Completion (%02x). Clear...\n", temp);
+			i2c_dbg(adap, "Completion (%02x). Clear...\n", temp);
 		if (temp & 0x06)
-			dev_dbg(&adap->dev, "SMBus error (%02x). Resetting...\n", temp);
+			i2c_dbg(adap, "SMBus error (%02x). Resetting...\n", temp);
 		sch_io_wr8(priv, SMBHSTSTS, temp);
 		temp = sch_io_rd8(priv, SMBHSTSTS) & 0x0f;
 		if (temp) {
-			dev_err(&adap->dev, "SMBus is not ready: (%02x)\n", temp);
+			i2c_err(adap, "SMBus is not ready: (%02x)\n", temp);
 			return -EAGAIN;
 		}
 	}
@@ -116,28 +116,28 @@ static int sch_transaction(struct i2c_adapter *adap)
 	rc = read_poll_timeout(sch_io_rd8, temp, !(temp & 0x08), 200, 500000, true, priv, SMBHSTSTS);
 	/* If the SMBus is still busy, we give up */
 	if (rc) {
-		dev_err(&adap->dev, "SMBus Timeout!\n");
+		i2c_err(adap, "SMBus Timeout!\n");
 	} else if (temp & 0x04) {
 		rc = -EIO;
-		dev_dbg(&adap->dev, "Bus collision! SMBus may be locked until next hard reset. (sorry!)\n");
+		i2c_dbg(adap, "Bus collision! SMBus may be locked until next hard reset. (sorry!)\n");
 		/* Clock stops and target is stuck in mid-transmission */
 	} else if (temp & 0x02) {
 		rc = -EIO;
-		dev_err(&adap->dev, "Error: no response!\n");
+		i2c_err(adap, "Error: no response!\n");
 	} else if (temp & 0x01) {
-		dev_dbg(&adap->dev, "Post complete!\n");
+		i2c_dbg(adap, "Post complete!\n");
 		sch_io_wr8(priv, SMBHSTSTS, temp & 0x0f);
 		temp = sch_io_rd8(priv, SMBHSTSTS) & 0x07;
 		if (temp & 0x06) {
 			/* Completion clear failed */
-			dev_dbg(&adap->dev,
+			i2c_dbg(adap,
 				"Failed reset at end of transaction (%02x), Bus error!\n", temp);
 		}
 	} else {
 		rc = -ENXIO;
-		dev_dbg(&adap->dev, "No such address.\n");
+		i2c_dbg(adap, "No such address.\n");
 	}
-	dev_dbg(&adap->dev, "Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",
+	i2c_dbg(adap, "Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",
 		sch_io_rd8(priv, SMBHSTCNT), sch_io_rd8(priv, SMBHSTCMD),
 		sch_io_rd8(priv, SMBHSTADD),
 		sch_io_rd8(priv, SMBHSTDAT0), sch_io_rd8(priv, SMBHSTDAT1));
@@ -166,7 +166,7 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
 	/* Make sure the SMBus host is not busy */
 	temp = sch_io_rd8(priv, SMBHSTSTS) & 0x0f;
 	if (temp & 0x08) {
-		dev_dbg(&adap->dev, "SMBus busy (%02x)\n", temp);
+		i2c_dbg(adap, "SMBus busy (%02x)\n", temp);
 		return -EAGAIN;
 	}
 	temp = sch_io_rd16(priv, SMBHSTCLK);
@@ -177,11 +177,11 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
 		 * 100 kHz. If we actually run at 25 MHz the bus will be
 		 * run ~75 kHz instead which should do no harm.
 		 */
-		dev_notice(&adap->dev, "Clock divider uninitialized. Setting defaults\n");
+		i2c_notice(adap, "Clock divider uninitialized. Setting defaults\n");
 		sch_io_wr16(priv, SMBHSTCLK, backbone_speed / (4 * 100));
 	}
 
-	dev_dbg(&adap->dev, "access size: %d %s\n", size, str_read_write(read_write));
+	i2c_dbg(adap, "access size: %d %s\n", size, str_read_write(read_write));
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		sch_io_wr8(priv, SMBHSTADD, (addr << 1) | read_write);
@@ -223,10 +223,10 @@ static s32 sch_access(struct i2c_adapter *adap, u16 addr,
 		size = SCH_BLOCK_DATA;
 		break;
 	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		i2c_warn(adap, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
-	dev_dbg(&adap->dev, "write size %d to 0x%04x\n", size, SMBHSTCNT);
+	i2c_dbg(adap, "write size %d to 0x%04x\n", size, SMBHSTCNT);
 
 	temp = sch_io_rd8(priv, SMBHSTCNT);
 	temp = (temp & 0xb0) | (size & 0x7);

-- 
2.47.3

