Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DD200C2
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505963; cv=none; b=AyB9hZyGZi5nyQMpovT7uMeWUO9o6QHrhPTdDA/f5jKPhLYotuLzmOinw8fjGoiF2+CivTLaxhvkgr/2v7Caot8UfoAIwic2F3Iov+BAOBuRu5k3WBuEw6WPGFML2q2WVvmKf916fNFri14m92+DNwsUtX3+zIApU7PxOYJzjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505963; c=relaxed/simple;
	bh=uVaBeK0rGmD4Y1AJqJcV5b/prJ3MijW1nqkT6bg09Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlhADrS5TDfCxJs8LgI2MfBlRtdOX0V/3mK+4WTVYBh7raePwE4jMbmjLTmyBsPRO3dNFvD0iXYFyfqcsXQANdyB+Exzxmw1YKPL4bix27ePSZezye0mT+WU0MU6mVE62U5/6Kav6PTg/pjkrDO0Vslk4RjjpI3jNMjRWMBRFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vNirLK59; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vNirLK59"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D3D2E4E422CD
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:26:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A53DD606F5;
	Tue, 27 Jan 2026 09:26:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2B85119A867A;
	Tue, 27 Jan 2026 10:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769505960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i3d0qwfYawAzdcDAssviLuWSr7dJX/2XZdHtFP/HYUA=;
	b=vNirLK59ZLzuvMRvVimfuj/oYxVEPhCoHSXRxdQD/L3HX5d6GyuAwZulklxKqaOL5PVznu
	vRxiref6G09xwry3Qh/T2kqvpdSOdTGRaB+UcUUGzlV0qlC1HsRWgyPWMX7JWmFezaS1If
	tatQFDFSAYAIpv8miFbjfhBTHGJgBqqd3NlGn2CoRyex3uPXubKwTGHWrk36CEfB3JCOq8
	u4ppD4aks5qTLYBfUubtQVs4Oxc/HH3VzU7Co7XrOI/qMmZp880A7SqOc/A1jUaakuOzJA
	HCeu6KQUHZPkgmGJRdaADE/MapyIze73psTIRTM3gmLUMRthz5TiViQE4hSzbQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Tue, 27 Jan 2026 10:25:57 +0100
Subject: [PATCH i2c-tools v3 1/2] i2cdetect: Display mangling and nostart
 support
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-msg-flags-v3-1-e7539945db2b@bootlin.com>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
In-Reply-To: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Show the support of protocol mangling and repeated start elision in
the list of fonctionnalities displayed with '-F'. We only use these
functionnalities if they are known at compile-time so i2cdetect can be
built against older kernels.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 tools/i2cdetect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
index bb2f146..3c22f17 100644
--- a/tools/i2cdetect.c
+++ b/tools/i2cdetect.c
@@ -164,6 +164,14 @@ static const struct func all_func[] = {
 #if defined(I2C_FUNC_SLAVE)
 	{ .value = I2C_FUNC_SLAVE,
 	  .name = "Target mode" },
+#endif
+#if defined(I2C_FUNC_PROTOCOL_MANGLING)
+	{ .value = I2C_FUNC_PROTOCOL_MANGLING,
+	  .name = "Protocol mangling" },
+#endif
+#if defined(I2C_FUNC_NOSTART)
+	{ .value = I2C_FUNC_NOSTART,
+	  .name = "Repeated start skipping" },
 #endif
 	{ .value = 0, .name = "" }
 };

-- 
2.52.0

