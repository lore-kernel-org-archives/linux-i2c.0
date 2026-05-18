Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FB27874F
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779077382; cv=none; b=XNUsHDePYBFYWcjRWDLP/8dF4oRNTa5tsoXdiQhVGPgswMZM6af8cwDnvVEA2VJRJltfGm6Xv/VQE9wQdHeARBy+XT6MWAQdCMjGp0LzookjhHU42vVDXPNLNw10IyDFtZZgtkkmjgeiJ61izqlfOT0mpN3TxSOu//pdiO2LLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779077382; c=relaxed/simple;
	bh=OAO9K6hHVyeVUzmNoCUkmsSb+GYTPbqTDu9CNEtJKkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WClUQtBWyHMMnA1deeRcbWWeusAWE2cJD42KMNUGWD2LmsWoCsA5tKXdw+rreNgcG+cYxpO3yrppvg4GIG+R63cR/g6Dywn8CsP3+Huq15Qm30Xi/t+h2vwwyzK6GnjHu8LbLVOGJp7srnJb8+yo6e1jO1/iXj56CN3uakZXE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR43W45X; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR43W45X"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90fc979d84cso111886485a.1
        for <linux-i2c@vger.kernel.org>; Sun, 17 May 2026 21:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779077380; x=1779682180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCcL3jrxU68FXhFlnqUPO2cf7OjeLTHDVP7mNnTKhlE=;
        b=CR43W45XGywsyLXdupPV0FZx8Gl9EOZcrP0aQyagPQDMpjlRr+SCTDcVC3uWnYLbWc
         JP8jkzJB0UXPkVjei+0O9XYvzYxh1NixOvhkhKbKIxx39Q+myWzTkOC0ezqaS++QIDh0
         A8XBBFNEhgkcLkYSpfEgwCMjcFdP2pAzKAzVm4aMKQxiS/4vJnXeEEEuYgWff294N3PW
         EfxZF3yIqa5YT3W5THI5DNhQC5P4IbeoqbBmNiJqsY9hWcFaBpfOO3zLaG6I72PuKgZ1
         DHc51ghIkgOc8F/DGqjZxX7WfcDJuPxwOdPknvhw1h8ABDXhCnXm+eWgUKYcAhKS5pl/
         9gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779077380; x=1779682180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCcL3jrxU68FXhFlnqUPO2cf7OjeLTHDVP7mNnTKhlE=;
        b=k0/4VxXGzBJ0GOwD/cZ0sxc1V9pUtUScAu84a3z9HMf4NcTIUGmbVbxWHDsn/d7zWx
         l2ot09petzGI/YUA0yKQwY729lXIUjhjFHg7x83QcBJ6IJMNuyfKBUcOG2nlUMCkqNo7
         CGVodh8Y7fB1SU1e/CD128zmaynkVWw4JHVWgVtCJ1ZrPgGPRwFO7fqNOCztTRid462g
         GO2tPrOx/MvXHbWcXpqaDy2XxvSFbYOXIP5tebmt+4pOyOYSDmIxcKPFRlxxyc+gJORy
         cjZNoOIZfeaEuh4+jYc2sPg0oTeBeXlcNRzFAKLfsYcPsRJ2gvpSB8Pa0yXBM9VdACIo
         HX5Q==
X-Gm-Message-State: AOJu0YxU6MrltePGdYpw8bK9rjdTrTDPo8TN4Ku6M6JDu/jj4Feq1WuN
	fT1EoQQjSjy2TY+RWKtE7nxinKRggHaGCBbB2Z4GqtbeJGxT/FU7WkBpS6FRow==
X-Gm-Gg: Acq92OEnia0GFWiqoHPUgpWS60fPhD4glT4SAURLk2VrSKTw3oe+5YVKwrcjnttOvMn
	eUdy9ygeAux9RDrM7XPnFufHNRhbKgAHp969BWoRxkSMnPcnpfRD0q6W8aku4MQwikFdVBMTcvV
	RYBzfDyadfAoHl9wD6zh6HmZmjypcU+i0LidF3GnJxwYvXB6oYo3n2Uq6fnWweCeeEMptApYj0n
	ck2YXwWoPWGU10B+ZSk6bW3dtUBuHtuylZR0Qxvtjh2f0i7ztWqudlN9bUqEbfRraUhDab/5W/M
	LFymJTt6kbUfpTaLkC/CMLAStSYWDPxwUKlSlOhT4SG+PdzaRK3VzsLv/k4n2lJxXC2Keqfc7UG
	gzUXtgxfHsm7puE2Q9HQiD54DVR+yYPvUhgXct+cwjXYYyuaC+DW1WCfqj7qbCwcMAb/WdSTTdd
	hELEAjUkpfDTg/LHz6e8TrM4+WjHkJ5q6EWIZhS10JTp/LHRd2LoOFwDD6C8dwuGSI1MSnXLhFN
	E4hHwdcbgB8uKgmg4+fqcIXthY0XCSxA1Y=
X-Received: by 2002:a05:620a:2302:20b0:911:f0ff:3d21 with SMTP id af79cd13be357-911f10e8471mr1444206985a.37.1779077379797;
        Sun, 17 May 2026 21:09:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3776dsm1425822085a.39.2026.05.17.21.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:09:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: hydra: Enable compile testing
Date: Sun, 17 May 2026 21:09:21 -0700
Message-ID: <20260518040921.724944-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the Apple Hydra Mac I/O I2C controller driver to be built
when compile testing on PowerPC.

Keep the PCI dependency separate so the driver still only builds with
PCI support enabled.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index c2d378e9a1b4..f7d15fa9580e 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -370,7 +370,8 @@ comment "Mac SMBus host controller drivers"
 
 config I2C_HYDRA
 	tristate "CHRP Apple Hydra Mac I/O I2C interface"
-	depends on PCI && PPC_CHRP
+	depends on PCI
+	depends on PPC_CHRP || (PPC && COMPILE_TEST)
 	select I2C_ALGOBIT
 	help
 	  This supports the use of the I2C interface in the Apple Hydra Mac
-- 
2.54.0

