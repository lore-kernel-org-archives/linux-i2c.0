Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4647607E;
	Tue, 18 Aug 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058908; cv=none; b=LKFUa8vQiLWPc5Ji03JHPhiuiDg0e2cQhPH+ZShetSHMS1ex2NyoD63yhAB1IcOupMQtAD1WYF/F4nrmvOW9cI5GEtmMSLNQftpM2TEsUb8zDnnLPGxfyfg69JY4IeB/2RbxJC1JOPkHwIPYTTFxCNxnyRM7D0RouowmC0dsSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058908; c=relaxed/simple;
	bh=AEHMkPshZIEpyNIsuIqz0TqCKmK5s/d4bPa5NED0LHY=;
	h=Message-ID:From:Subject:To:Date; b=VFGluQDinE5b3tU687zwHsfqLi7S7zmVAlso0K4BnzHdfQ6E71b9jHsz2MJYQmlcCps6R7UgaFjOX24q66b7N4xWNeB+iZsv0d5LCQg9c7RVvbRLDABxyPlV6Pl4rOkdRvOwSsqiBsZGIJ13PwepsHUme/s9VjUdk2gP1lXboCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZlFXXQVM; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZlFXXQVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058903; bh=u6AguuAWLbSwsm7gvplSJIU4u9KycYlA20U5mWWflWg=;
	h=From:Subject:To:Date;
	b=ZlFXXQVMXx1yzK+ENYHhUnfrJB56nzrQ6Poco21QAEHWAyzVfRFxHKhOn+UT6gIvL
	 7Bib9O4xANJNm13b3MzjQdswmxqQNTpPSHynnPAtnKu9nsh37PNDEDTyB0xKnZMv6m
	 blOy7oT7jIwLkDMjV6tgUGpc3mPyODUQpmJFLnfI=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058811t67kjk469
Message-ID: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
X-QQ-XMAILINFO: NZYNQwNkdR3O2tQUjyqyuCnpmKQEGBhlLKmnENn4xstocLyw8UTsacv3j0HdvZ
	 eOSttdJ5eQOe/BgEQll9Tw4MmoYI/lQQU/WA4tdFx3Gs+j+1Nz2jon2B3R5pFCVZ/oPNPOAtkxQP
	 Ktyd+JKCmIyASULazaiSyqG79Cve+EfVNTzEnZwk8V0TuX0NATGfhm0gg2yHQNbIL0qmHYqdZqAb
	 oCN4jp8AAeZpBxMyYwKv3I/bGxxJsRC97kOQQC45QAr6p0Neottnm/TToVUrCBZSEnxRVD4sDsDf
	 ReD9cOxGySGcUWxsgd8L9gKRpxAd06KGZOjJG8FJpEYTDVMui1LtMuXqijcL2g6A9jGpiqKefrBM
	 1JfJTJX7UuORcSYTqzpzSIPCzMS1fiTPY4RLHd+K6nP5TqqtOmEEcQPyNNZELBuGt/NHmObwWBBO
	 cTDld/mViSp7mJ0x1F7ue5fIKzR86Z+EzdJ/H5J0Z3Iyeu+x05jazjx2tIBNsfi4WM0PY7sFHE79
	 Sedn93OX0nBaF2Sp3OugBMDkaPOJ56QXogpLc09HcYcisIxGxHKEpGkobsGUefZxDXw+W5Pxf0LW
	 tqQl0l57szPBv02x61jbK1CRqcaC7M/4c9/3v3S8+czoAGUpt/jHoA6O2TLifo2HYnyLg7JRkpVD
	 7O/SXHloPds8ALNUZ5+d/4iMZbDU1rsjnEsu9YYYE0aiixdx7fZNWtZxJunpTVdBLf1Ei2cRREJJ
	 4Xi4NdlMap3eijRMkl8Z/1IPnR6CnpXhJDl61fZ3OA+LE4mynGb7luKvpEqUfBPNe/O06QKfhOTC
	 umPxgpndFchXlJtqBdXzb37/F2OHU1qN4BxghrXZ6Iulm/R3KNZp7wvf6Jh/WSpepgAILJoVpta7
	 3LhfO3K4R/PX6foxDcyVnCGT9bSLHUAOYlEmoeSc2hrWOQ8d1UNNJvBOsCBN3Vpa/atUN95ztq92
	 qyjiXmDsOAiGwokEsxUe7JHHyn8iYF8jxBbh8XhfSVfnNwCjToA9C+p2GitPztSejl+UgoaNYGjI
	 3NkVce2qdAfYRaHMRHgNy7ye/Mhk7V8yBdjVGadA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] i2c: i2c-rzv2m: fix runtime PM cleanup
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:15:01 +0400
X-OQ-MSGID: <178705890139.291840.17601296554208016978@qq.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>

Update rzv2m_i2c_probe() for the confirmed driver lifecycle defect.

Keep the change limited to the concrete operation shown in the final
patch.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2m.c
--- a/drivers/i2c/busses/i2c-rzv2m.c
+++ b/drivers/i2c/busses/i2c-rzv2m.c
@@ -461,7 +461,12 @@
 
 	pm_runtime_enable(dev);
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
 	rzv2m_i2c_init(priv);
 	pm_runtime_put(dev);
 

