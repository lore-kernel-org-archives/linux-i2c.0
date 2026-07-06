Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6273E5A0D
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324872; cv=none; b=o/lNhyjMllgWW8kZgqL3YcVprQUEWCUoJ9liqkNUqzAfRJxXKK8G+r5pO58eeiysPVBHUCcHHO2+3Qu1G0B4mgi/DV5IafSN2BGzvotha0uX5Bjpk5ntcWPNG4I2PCmMtzE0sMLyVglmSi+NuvpMIFvLEJkEBPjeaM8nxhJYipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324872; c=relaxed/simple;
	bh=xTnA/eD0J/2aSolda/yyqbIQlehiJ4TTbwgxfN63kR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d/JSG3Zt0+YkcOQFNUeUVRKasfdrcFN+aL1iBeS5EufWAfNKj688hgs+rbs9qZe9SIbwe3+w+oYvIrNeogOSO8ADkMd2EME5jrZ9h70b2ChJeTIk6xTKoEQa/wA1K8BvajFDEdRy88JzxTNR+J9i9jbILy032T5goJpl2jDCe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=aU8c53qb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="aU8c53qb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc6dd436c6so11049845ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783324864; x=1783929664; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4wND/FQTU7bPAz2jUMQ+v5Bx7iU6hLgdSwAO863EKo=;
        b=aU8c53qbHBDMj3bBlkQ4F1Br8f+1ouP9gdJ4e+5qoPawPeBvLQG3EPU/l6fZof0udk
         IeOUojMoExSPS7fhBuI4xQrdVk1rp9xxtqI5JIeFG+Sdat3oTIlwWqZvAPmHTqInlv9h
         8zebYVyQpzddt30wIFwkQOM8c7dfivgX6suohT2TdqHxCvVMstVSpwJQbg0qXXpjwnj+
         EsqrT49DZv9Dy7xRkM94dRbZ/Ht2mpt5IFRMfQq9+UjJWLNi88x5EGvpSn/KlNbz+bU+
         s54xxEsMhqQSWWM7PnCAm1TrFoUF9/Kj7plFai8bIK+ikRf0PBCHZFRd+PhOmUzVQ2Ad
         KQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324864; x=1783929664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4wND/FQTU7bPAz2jUMQ+v5Bx7iU6hLgdSwAO863EKo=;
        b=IKZVJypn5fa4pKmiT4fz00WIRqQGkuJuHoyWEfcxKb69sWG9FX427sz2qfUdaOBEPM
         TTMafZSzhN9bu7miFEsXzEJb8phiRedBxzf0+ytaRILQigO09zBjWsZbVtRvxFo3voFs
         k1QAI0KB9bZGSHrY7jKHWP8YcdZZSDqlvyKpNrglCcNAOrAwU2WHn64eJ06TgMTbXpVV
         ybQ6yoM4rqYXVsTQN7NZkFWVf9Urs2khUSPNmuwMDyQf0X6sFQcENb3JXRRi4Q1kLmp4
         UeDkeKLNQniqbCziw2H8mV/ZwDzZvcOWb4lymCfd0v+HT7e9/1TqjtXAYN2e/ID4ybJi
         XBiQ==
X-Gm-Message-State: AOJu0Yxk69cNUBlGMtvzypNjnGNIfcjO4sXRmx6osifS4pMtY8YBs0UA
	falc8zSLcsuqkMgUX+BGmpnz7aZnUmdSA+l5d7yQC3+SKf40E32aXavOXmtsTDeA8gE=
X-Gm-Gg: AfdE7cn8SqKghEXMQWKwwXild6AV90htH6lV9jTw75oRmVhDI28eObR6hvOWOVcvHAQ
	kn2RrQwpTrW7abtBp9YWGVvXXcLg8j/kDl7Ndrrcsiw1Qz4syjw+D8X+Iy/PYnrCm2lrs62lKf6
	kyS/m/2iylMmEBGtq91RqmK6+OdqmCKUJ/MpH3JIusyT9vaKag4BF4REjVKiEldxC3l4H0DAEQN
	fSjzrLZlhetSLSzVxv0PrRUvnX8og2Pakqu7ax2Dgb0uk4yKxMByedKs0k5hL5YNPgWCdRCnvWy
	KmSM2A7pqdETMPOv8s2DC4rbjCoKtoopKvN8vdGGHoZYXgIwQ9tIiyju/jwxBZ2WFxqCC7DgZYh
	UKCucfGSlY+T5pwDAOOykP1jGl3xtrfP+fWR2vriQt1ScpT7o4Lri4V40WXM8zWEomop0udqZxF
	n3nHDppxYewfdoBJMZW5ZiK9EUPMxb8QVKO8e+p2DkRNim0coZ6ePjpZ/blA==
X-Received: by 2002:a17:902:f54c:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2cb97e576a4mr93046445ad.2.1783324864115;
        Mon, 06 Jul 2026 01:01:04 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm67268786c88.1.2026.07.06.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:01:03 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Mon, 06 Jul 2026 02:02:39 -0600
Subject: [PATCH] i2c-tools: Enable cross compilation
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-cross-compile-v1-1-e3ebdd485ce6@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMz3eSi/OJi3eT83ILMnFRdY7M0SwMTI1MzEwtDJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAIeZ6z9xAAAA
X-Change-ID: 20260706-cross-compile-36f904256481
To: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=xTnA/eD0J/2aSolda/yyqbIQlehiJ4TTbwgxfN63kR8=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ5Z3ooWFkkSoYqGspgSXEZepSUTTgvkMJ8SO9D7YfZ1lS
 ljRtTMdpSwMYlwMsmKKLCq3ZqlfnGz96GAE/wSYOaxMIEMYuDgFYCIM/xkZDoVJn9+0/n7xpF7u
 Opnbwt8eX22WL3ja2833vH2bp8qFLkaG6Q9Cpgju4+Fh2LNxn6Psyy8vc4RmhgS/NbjqqnRVwka
 FAQA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Currently, the Makefile fails to change CC, AR, and STRIP variables from
their default values[^1] because it uses the conditional variable
assignment operator. The Makefile also doesn't allow for cross
compilation without modification.

Modify the Makefile to use unconditional assignment and allow the user
to cross compile the software via the CROSS_COMPILE variable.

[^1]: https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 Makefile | 9 ++++++---
 README   | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a0d4269..2a51485 100644
--- a/Makefile
+++ b/Makefile
@@ -24,9 +24,12 @@ INSTALL_PROGRAM	:= $(INSTALL) -m 755
 LN		:= ln -sf
 RM		:= rm -f
 
-CC	?= gcc
-AR	?= ar
-STRIP	?= strip
+# Use CROSS_COMPILE to specify the toolchain prefix. E.g.
+# make CROSS_COMPILE=aarch64-linux-gnu-
+
+CC	= $(CROSS_COMPILE)gcc
+AR	= $(CROSS_COMPILE)ar
+STRIP	= $(CROSS_COMPILE)strip
 
 CFLAGS		?= -O2
 # When debugging, use the following instead
diff --git a/README b/README
index 502132f..1c83561 100644
--- a/README
+++ b/README
@@ -80,6 +80,9 @@ If you want to compile the tools against the static version of the library
 you can do:
   $ make USE_STATIC_LIB=1
 
+To compile for another platform, use the CROSS_COMPILE toolchain prefix option:
+  $ make CROSS_COMPILE=aarch64-linux-gnu-
+
 Optionally, you can run "make strip" prior to "make install" if you want
 smaller binaries. However, be aware that this will prevent any further
 attempt to debug the library and tools.

---
base-commit: 5852f5375eea6ca9dabf31f4772cb8b8ecc905d8
change-id: 20260706-cross-compile-36f904256481

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

