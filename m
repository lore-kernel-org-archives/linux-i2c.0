Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597431;
	b=2enNSTzCZuTPkkAsHptUn4u1KsAAMhf6X88z4eXFjPTDZD33XTIE30VueiXgLwyOuP1F
	 7Jyzzqlp3m3J6hgofgRk5tX8g1gBv0eVvI5Q3nPP3laNY6n3UIz4sVzI4WUKEvT0JaTIx
	 hHs7naCogSXbo5CuCbYxJxJikXzISCrnuC554Eskthz/ksd3hcVb+usPkYW4+GsAe9S72
	 hY7G1s5+fuRCYuNFYpCiO/8m0sQDlB3eMkpu5hJDwEPtNYb5BwJzjWxBV84wBK6+B4FL2
	 9+83QLd1/BGYxkwdtJq7P07KCubGeoNWZpsHTgPB8zDwAuIvYEyq6lHU5hENXExY91Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
	b=DqGkBYBV84oVHvAX0fYJW29wkETxOaFgITU46y4XQFd6KXecgBUirbDxSxpFOks4RocY
	 9CxTr791TcoS0aSK8NiGMqGe6ExIUUK6E2dlD2mx9CjUehtrMxvmHae69iVNEl2K7BBf7
	 MQpaoKNd6N/qM3vRkbaAwAoSqgZlSw2s8yHERmop2ypmplvv8XwGuIhsJgxjnZhNN1GJY
	 fLZwtMb5MUVGeeNDhJi44lGJzVCEkVTLeTGg4pmVYiRs1z+/5HiSkxvT2YAvfogEbTVLe
	 WzcnQDQAZsM1nY5Pfij/x8qPPsV53YDkhkG5GQp5d5B5TVXk1cNg+RqAMlVqcGQwQIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HY9x75Mb;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F680606A321
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F680606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HY9x75Mb
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3866a784546so7356175eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597431; x=1796202231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=HY9x75MbktHUwVKLIjoW0r4G8U9AL+zGRk/oiAJaPZPbj8AB7HKEVuMM+TB8aJ+dJR
         f8bZI5psfk9sGePKAGpDU//iYdl9et6CkaKxTKr1p6jyP7AW+UXJ78GDY27AJEwceh0m
         kEX0bojnDdo7s+nPikxRobNvgGGtC3XSMKL44XnlnNDbn5S8ITEV5BaoQewaisdOyQnq
         FjzaplAhjZ8C3aqkcvN0uyoIeOQI3URFC/7xOTaID+zcmrPlSXW1rgEeS+rAQfXIUG7v
         dg1t00lGESsaIEde0lStnYO9fwo5IGucPsIBYy/xDyknxzheatIJPO5oM2i0rbsPD4EA
         MW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597431; x=1796202231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5RSPGAWd3oxeQteUUuoK6f8743toWOpgplcBAfwJJQ=;
        b=O/pL47qKmBxtpjSOskJXADc6soU/7zCzfCmyThbEw4jIko1Bbdzt9ac7FTvBy2ppAE
         KgoM82ruHxY0Grw02pxwsBeyJyb9AFRC6P4opLJa16JWs5F822shd9LSgbIZqMGndYkm
         BOu20POsUNXX247IX0t2pUCSltChRHK+CmAtvRT1Yc7M5rhgfbvSh8Zlrgs8lBdEGUzx
         BVbFsgFaXknVTn1TQNQSkutIFYcMhiD5/2TnTVl54Y94chzCaFdR2whGOGaGEirTmcEM
         1l9cfIAAZ8oN26NQrmRCHfgDbzIKe5wISw4DY1X8lgKZGNSzJ50MVFlcrC0dh+5TnocJ
         JP8Q==
X-Forwarded-Encrypted: i=1; AL+hErF+M4389A1LRWeYUeu9OPdhuzZrjzjRPrQe2uq7f7FqiC+Z9ne/g5q3RM/PhiqG/Qv184b2E+yZU6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MV80j8VJ/x/QOwz59Ci+m4+z/PALKxQhMFepGcKaMYMvhZoSQ
	2fIlluG1mvTkal4Z0omx2CrcOWHv1VtBamM0FemWRiTfhIUmBK+SS5Q=
X-Gm-Gg: AZFdTZcUb8lYZvBqwispXxYGZoyaNGTHA23dkITSU/SsI0He5JsqZO7RO3tzaz+9nFR
	EUskjYTXq6HdAfJttntzceDksAR84jzSI72gdw7YEJok7Kf++3f8H/dK2FFnEYof1UNxPaZYI6T
	Ly0Vt1ypM3xTTKTylYzUBBbW+vRpptWmH6WJnmq47jKiPYHsw142lyclYyndtxbsUMKPaGWbu26
	OvtDY2twGj8adgyDmpU1T1BENKmqYHbe8ftIiM/KxoDCILVByyYBajt8J3GuX4j71JDOzElqrjJ
	4IzUtN1jZ+4iJObnON+F0d2no28P8y3AjAMP7KGwmdfHMjGiJ1rU6JMfzfcJKJ2dhNOXYsPNxEO
	TFjdHgn6DoQ+/85XFIkOjtV64+LDImoguCfdgkrtPn8R5EAT8hCBhWXwB+s/TVJBm55SijEmN/O
	CMSteH+7rgiWaTAtKaeCH3z0BPny0ozs/eb+F5krMT5LeenmFaHivIcR6O/mZK8DyI8kt1zk8+e
	32LgE9lBzA6clv9Vje9u2JjiJaum55XHIt/8pp1IXMoGOaL9ShIQ1/gsc7bKxwJas9oMfQNhSqQ
	wD1lqTxldAeMHFVtu4jsHu5rWiJzlcDwiwgOQlsaGfUwaBuOE3WMs5Ui/uyGw3/PRZkiFDhJX93
	oUsBq7YsomeGwlQ==
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr16715777eec.39.1795597430484;
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm53859174eec.12.2026.11.25.01.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:03:50 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Wolfram Sang <wsa@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: therm_windtunnel: Fix i2c adapter reference leak in probe
Date: Wed, 25 Nov 2026 17:03:43 +0800
Message-ID: <rc-b1-20261110-vc-23-41d00428efcb@gmail.com>
X-Mailer: git-send-email 2.50.1
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

therm_of_probe() walks the i2c adapters with i2c_get_adapter() and
drops each reference with i2c_put_adapter() before taking the next one.
Once do_attach() has started the control loop, however, it returns 0
while still holding the reference to the current adapter. The pointer
is not stored anywhere, so that reference is never dropped. This
happens on every successful probe, including after an unbind/rebind of
the platform device, and the extra device reference would make
i2c_del_adapter() for that bus wait forever for the adapter device to
be released.

The driver does not use the adapter after do_attach() returns; the
sensor clients it talks to afterwards are children of the adapter and
are unregistered by i2c_del_adapter(). Drop the reference right after
do_attach(), before checking x.running.

Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: powerpc (ppc32), GCC 14.2.0, W=1, pmac32_defconfig with CONFIG_THERM_WINDTUNNEL=m, CONFIG_I2C_POWERMAC=y (object only; no new warnings).
No hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.
Runs on every successful probe of the Windtunnel G4 (PowerMac3,6) fan controller, and again on each unbind/rebind.

 drivers/macintosh/therm_windtunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 0b2e08a1bee0..4f2581d9dec9 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -472,9 +472,9 @@ static int therm_of_probe(struct platform_device *dev)
 	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
 	while (adap) {
 		do_attach(adap);
+		i2c_put_adapter(adap);
 		if (x.running)
 			return 0;
-		i2c_put_adapter(adap);
 		adap = i2c_get_adapter(++i);
 	}
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
