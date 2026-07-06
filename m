Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A36379C50
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343937; cv=none; b=jrCjReAYdfBceT1yQVCbQDROWOhGUd/C6fh99Pd7EKVfU78e8IKwlbe2dOO4TxygZ6b+FVBwElKSCYoSh7ldGtz8F5tku6YDWezgAzV3NeSDCkEOdBpwAsQ8kg6/O51KBYtdIM+jgpLOPhhoamZ75DR1KjHgXEhLN/1W5JZtvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343937; c=relaxed/simple;
	bh=0LJFk3mBEmQbOmWsbowXvg8jrUSqeQFiVNH+5xB5ZCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oolub9Ofj3JcQRYRA8C7PBcAMKNva6fGcrKuaF6ghIwhrjEIBcn/WFejSSR1+DIBHxnUVy9Y175amqYLwHWmCCuWjirDPkq2Z1pEYBEqYG5N66Ll8fREvgr3Bo+s/gvWOIDNKcr1Okd6qG5wP3hb/8hd1JXSeFarxcKFdJcTZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WfGe+SJC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WfGe+SJC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 56109C8EC7B
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 13:19:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4220F601A2;
	Mon,  6 Jul 2026 13:18:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E49F311BB817F;
	Mon,  6 Jul 2026 15:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783343933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e6Eiq4t3FOgqd9lK+C9hmUPBoroKTnkcB9MOWaVRYMA=;
	b=WfGe+SJC+4j6u9O5tFeNK6ff7IdwGbTFE2mZFf1XSArhgRmNlpv0FRWmgyUWru+GGX8Glg
	yNSMAbROOzQnsZBbscdvUXrfYX0O/gbGg+uDoA2r8O9RvHFr7NiFXhzP/ik7cRKTlsoapT
	xzwYr7hGCA2lr2LIJRxz3Ko/vCr+M64XvyiSw3lHsJEZGdmD1VcJIQSkNUh2vOQ3XfzXQE
	HzjheRwtNRdrZ429sJ6CuRcGdSswLLTkik/VuRqsw4Bhq9sJJKULTQf7nQYHq96PA625+R
	Euq0uDtn+HOabvcN5othtAqLq6km5E/BXMiCgAMdipiGRdI9VzqrSsAzj3vHgQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 06 Jul 2026 15:18:46 +0200
Subject: [PATCH] i2ctransfer: Print modifier flags in PRINT_HEADER
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-print-header-flags-v1-1-6d63b357d77b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADarS2oC/yXMQQ6CMBBG4auQWTtJQYLoVYyL0v6FMaaSGTQkh
 Ltbdfkt3tvIoAKjS7WR4i0mz1xQHyoKk88jWGIxNa7p3Ml1PKvkhSf4COX08KMx+rZOoT2ee0Q
 q4axIsv6m19vf9hruCMv3RPv+AeYkONt2AAAA
X-Change-ID: 20260706-print-header-flags-e841fc4398ed
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Print the optional message modifier flags when printing the message
header. For example:

    i2ctransfer -v -y 3 pr1@0x33 itr1@0x33
    msg 0: addr 0x33, read, len 1, emit STOP, buf 0x10
    msg 1: addr 0x33, read, len 1, ignore NACK, toggle read/write bit, buf 0x10

If no optional flag is set, the output is unchanged.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 tools/i2ctransfer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index a49b734..0a310a7 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -123,6 +123,26 @@ static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned int flags)
 				fprintf(output, "%u", len);
 			else
 				fprintf(output, "TBD");
+#ifdef I2C_M_IGNORE_NAK
+			if (msgs[i].flags & I2C_M_IGNORE_NAK)
+				fprintf(output, ", ignore NACK");
+#endif
+#ifdef I2C_M_NO_RD_ACK
+			if (msgs[i].flags & I2C_M_NO_RD_ACK)
+				fprintf(output, ", no master ACK/NACK bit");
+#endif
+#ifdef I2C_M_STOP
+			if (msgs[i].flags & I2C_M_STOP)
+				fprintf(output, ", emit STOP");
+#endif
+#ifdef I2C_M_NOSTART
+			if (msgs[i].flags & I2C_M_NOSTART)
+				fprintf(output, ", skip repeated start");
+#endif
+#ifdef I2C_M_REV_DIR_ADDR
+			if (msgs[i].flags & I2C_M_REV_DIR_ADDR)
+				fprintf(output, ", toggle read/write bit");
+#endif
 		}
 
 		if (len && print_buf) {

---
base-commit: 5852f5375eea6ca9dabf31f4772cb8b8ecc905d8
change-id: 20260706-print-header-flags-e841fc4398ed

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

