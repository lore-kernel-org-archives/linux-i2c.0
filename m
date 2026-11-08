Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144894;
	b=LXXkkpbxIa2lridH2I47mnBBRcMrvxBlM/gicS+KvMQCRAG1Hs4GutsSPSNIHKl9W4ww
	 KTHzif2MPub93zOtILNs/Bv+FnP+ucaVwAO0EbQ/ti5oxsVF9WkYfnEbAVYPEz3a9aIlP
	 yu0vahfHDFc9ygKV7uexrS1jPlbyBme7fgnVbFn0yafGRGloalBGuQwI34igHMqvQWi41
	 z0l+X4/lTnECaWXyLV6dObV0AqyYZPrSzvOn7R4AcH2IuP2+Tc+El7hTVGxNJpXrJroCe
	 CbPWz3rtUMmyHtQBGK8ebY2w3GZcIt99tFWfWj45cXRxwenLJgTk3tA0wJdX+AErQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144894;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CJdjs9FWEhmZa2bkCXkn1D4xq6493UaFSNFcODg3JGQ=;
	b=xv6nbXpRQOJrck2sjbjyONDOo/JX8/qya3KqSuXf8qnZfU13aOP8a6JCxthoIr3FnAX/
	 6QnPWyRGILPzk9ZUCHLCZIp9XUdCbS1gla7NzKDM9pB74us84Yw7NsEWuEDILf+0iHhN5
	 30WUOxrj59SyNlaaxtSrcMrIBx1kR2l4R5v9Qpgg5WQNoQ7SLSi4SyF1G8M96D8sTQQie
	 RsexqQ9nuNEVu3R5fqiAfu0DVDQWj1sFi+XGiAUBp+ilHJYSyjFL5H5Xe3uxrVkYPGaqq
	 WX/UY3zFFA+w0wSmMiGi6B7AJTmjPEjgZlc8oKXNrvWI9YkRJEKlzQBxMyKua5eBmug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=XHTqguvW;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFC606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 13:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68CFC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=XHTqguvW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=CJdjs9FWEhmZa2
	bkCXkn1D4xq6493UaFSNFcODg3JGQ=; b=XHTqguvWZ9ONm6KfNVpeThbk3YtSuy
	TI0giGeA4pTP76nFs831P8683rppoUN7b4KFw3f38bY4R7zB9/mCfUY5mu6GTgE2
	6RZFlbBHNsxF8BuvTA7fJPnoEYNBEtAoHtDdy4KRXGa/Dc5GISxXfEdR95KjiEf9
	ixmKe7V95quEiFL4cYa1C1sfth04hfO5JkTU8I61oyEDHHTwQYm0FMUFieO9CWe5
	KUXqlcCgh4mw5ySgjmFkXsxvCa/78aoS+VjlZdpfiQ8iO39+zfFIw2Q3bH+a1dCN
	0cnemJUajn94rcruoS3dQYhOc8AZ86q27CA+Toko1aFbBDTPaZyC7exQ==
Received: (qmail 2857347 invoked from network); 8 Nov 2026 14:34:49 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 14:34:49 +0100
X-UD-Smtp-Session: l3s3148p1@hNDK6MNf/rIvQDC3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.de>
Subject: [PATCH i2c-tools] describe how to do releases
Date: Sun,  8 Nov 2026 14:32:53 +0100
Message-ID: <20261108133441.2384-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I asked Jean how he did releases, he provided me with this text
file. I just replaceed the hardcoded version number to X.Y. We agreed to
put it into the repository.

Maybe the whole release process can utilize more scripts and variables
but let us start with what we have now.

Kind-of-Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Jean, a formal SoB is missing, so if you could provide one, pretty
please?

 RELEASE-howto | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 RELEASE-howto

diff --git a/RELEASE-howto b/RELEASE-howto
new file mode 100644
index 0000000..693d701
--- /dev/null
+++ b/RELEASE-howto
@@ -0,0 +1,38 @@
+CHECKLIST FOR NEW RELEASES
+==========================
+
+Release steps:
+- Update if necessary, the version number of libi2c
+  (edit lib/Module.mk and change LIB_MAINVER and/or LIB_MINORVER)
+  Remember: update main number when interface changes, minor if new
+  functionality is added, and patch if only bugs are fixed.
+- Update the CHANGES file (set version and release date), make sure list is
+  up-to-date
+- Update I2C_API_VERSION in include/i2c/smbus.h
+- Update version.h
+- Set I2C_TOOLS_VER in eeprom/decode-dimms to the same version
+- Commit
+  git add ...
+  git commit -m "Set version to X.Y"
+- Tag the release:
+  git tag "vX.Y"
+- Push to the repository:
+  git push
+  git push --tags
+
+- Create an archive of the release:
+  make clean
+  git archive --format=tar --prefix=i2c-tools-X.Y/ vX.Y > ../../release/i2c-tools/i2c-tools-X.Y.tar
+- Sign it:
+  cd ../../release/i2c-tools
+  gpg --detach-sign --armor i2c-tools-X.Y.tar
+- Compress it:
+  xz i2c-tools-X.Y.tar
+- Upload to kernel.org:
+  kup put i2c-tools-X.Y.tar.xz i2c-tools-X.Y.tar.asc /pub/software/utils/i2c-tools/i2c-tools-X.Y.tar.xz
+
+After release, remember to:
+- Announce on the linux-i2c mailing list
+- Add "+git" to version.h, commit and push
+  git add version.h
+  git commit -m "Post-release version marker"
-- 
2.53.0

