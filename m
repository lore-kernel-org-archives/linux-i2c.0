Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCF3AC0C2;
	Wed,  9 Sep 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942080; cv=none; b=ab5/lTHSt9vBxql+swzZAaqwiqLpX0n7X2ndE5YRC5OCM5ihPkHMzbyktjnyMieFoK6U0VVY+2cmgRNkgF/hVdHitZOoN/5GVbcAjUHp2dVtqFn1in6HW/gznh3g61hrZKiPu3zHL6+lc+zKcuFOyMvhFXi3sLBlnjCsNzpSorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942080; c=relaxed/simple;
	bh=Mv2A8WwLTVK1GfPFaI2yhm4KHmgVfG6K2UhrLOVN7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kg1Rv91Bisgeo1NCw5gWt8lIlNl17rpnDZetOsBXaY8fslYT2/yoi2Ewg1ldCnliAh6ZtWl8f/7PKZwuo/yTHSOm/b6wMMGRtOj/doEDvYtfkuswKmSpD0B7iwfzAh+05YTK8X8/+Y9eb7FaZfbA7R+VmzsFyPtZPdHPICNWD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpyprU1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpyprU1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03251F00A3A;
	Wed,  9 Sep 2026 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942078;
	bh=5It4lCnW/eZOSwnx+tvTyaMiRIkZsGLU4DugZjtaIwI=;
	h=From:To:Cc:Subject:Date;
	b=SpyprU1O2F1IMf2kbfg158LdqhU9qTK9DapnXQvHXwhcMUnqMtIT4CKf4EdJb2JhP
	 k39c4t9X/iyye3wI5sE3Ztd/49UbTRj3lQ14SQCF8Gbu9u8/bHwn+OwfBzpH4mH9AE
	 mk8E5bHCwtrHAQlwmX/dLQ8tTRWEYT1PhLx8Qyce0WTwTlMUz4iJyV82qwHxsQhrrz
	 obGM181f2j6InaoSRJM1ncQK6l6E5p1qUJe1VofYhmjGmvGi2NiRd4+l+QE8d1uWYR
	 fne+1/Z5NrBiv6Zzq/VAiVltlAcH+Ntazh6DkxCqxflRaHdX8A3BBAmubPVi0VNwCm
	 4fLVRP1D/17/w==
From: Thorsten Blum <blum@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH RESEND 1/2] media: i2c: isl7998x: Inline i2c_check_functionality() check
Date: Wed,  9 Sep 2026 10:20:55 +0200
Message-ID: <20260909082053.410739-4-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=blum@kernel.org; h=from:subject; bh=Mv2A8WwLTVK1GfPFaI2yhm4KHmgVfG6K2UhrLOVN7zY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkLxZ7q8c2cmCe/vdlB9HSvSeYe5c/Nc66EX9DnLiqQ7 FViNdfsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIn8+cLwh/N01DGO8utL3c1e rKmz3Pvp6Xw5r83MD1lCVJUcP8jLMjEy/NR7Ll6yImbB9I1evq7Gef1Mt6O2auyZv1hXdc7as7x sbAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Inline the i2c_check_functionality() check, since the function returns a
boolean status rather than an error code.

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Wolfram, could you please apply this last conversion, since this patch
has not been applied yet despite several resends since April? Thanks.
---
 drivers/media/i2c/isl7998x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/isl7998x.c b/drivers/media/i2c/isl7998x.c
index a77538d2343c..8244d4296a02 100644
--- a/drivers/media/i2c/isl7998x.c
+++ b/drivers/media/i2c/isl7998x.c
@@ -1460,8 +1460,7 @@ static int isl7998x_probe(struct i2c_client *client)
 	int nr_inputs;
 	int ret;
 
-	ret = i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA);
-	if (!ret) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
 		dev_warn(&adapter->dev,
 			 "I2C-Adapter doesn't support I2C_FUNC_SMBUS_WORD\n");
 		return -EIO;
