Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944B3D16E2
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786735; cv=none; b=SeNaeBj2LJFv70vnidr+KkjA1S+tEkXT+fihgMrcabUcZudJNoA+cL10pfNkPXAND2Rl1g28DzDXV3R0DJSLAu2jFMtVSl8n6pdh/spFl8MfSmglJ0OUO99ouAgLzBWko6o1oX4JYC7K55ypK+jaYAaBhaCiLeVDGNY3XXkyswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786735; c=relaxed/simple;
	bh=p6iVCpL3J8aW/Nu69aB1Mb72NYp8ofaV6E+JPgD5s+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c6f4DUqzdi3V0LF2/k88kjqKNHk3I+N2VNYt5zBGHqO20d6YKwph0s7XLJKQJ0fPx1/sfikhagoe8XfRaibqP4OqeDK++zlFCM7ktRBYIp2HT5fS4hUDJMttgc78QGF7CPUZPoh81y86Xzjqlx9BVW0rX5eXgduXtWP7aOhPiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi9Sqhrt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi9Sqhrt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e5624c053so6177663f8f.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779786733; x=1780391533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVdGlC73dpgrqg3jmTOepym9CG4JSTdsRd09/R/VHZ8=;
        b=bi9SqhrtHuI95qcc+qzoHKzJmB4SLlESwZbGKVwcZsk9wmiHDGpYTxa4B35xQSF5Fb
         bl/3rxSbkeFrJydBlFo0POfG21oxgwR0F7qHsctd7ALHcg7vEsVmSkRqwan5j8ZsGm/h
         QeICymllM0Ul1WaY8CYoq8PYEYNm1RL8zPnTqM6fS45sIxm/klk+RUkm07YBx6LWItxV
         BamAdjaqEiFwaE4Nu7E9T45ZE/+YU8ReVpIBt3mnpKW7yhV0mdZ3U2xNrn7Bo1Elecbu
         2wHCEI7y50ldiGykGF2dkd29cV9EFi3t7/I1ZM2+omoklCQuuQdz44z/gyOTg9doMEHf
         22YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779786733; x=1780391533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVdGlC73dpgrqg3jmTOepym9CG4JSTdsRd09/R/VHZ8=;
        b=j7XWsTRNlieWMkxCUE/jPgKvjgATy5Q6wHYJ0C+MKVm1KW5ReKfeVv/IjSEfmL5CFn
         VCvmWNKaERY/XINhi1YNPqVD36wV/fLs94BEgVhzB29I8I4CeUWpF2/PzMWey00Pi8Xx
         SGr4NZWMMM7wAuEABvSfzNbIVMECvk/jvoTJm6dUauZg7l1joLcMPRiOhqetgiLj6L1F
         jCKxJ4j9V83jKRRDfpcdQPxnZa5AE53zx7JtE6Z59rL2FTcGUe5o9HcslEywHhgZttHQ
         UhWjJO0zwnoBz0PzDi6GwfHU1BWLmjphEvKzzF7Z9LphDy0NYrsi5SjXBTkaxtV90uWu
         lesw==
X-Forwarded-Encrypted: i=1; AFNElJ9PEWd9/MHIkBaKXuqciVHhjXk69ju1e5DFclcsxv42ZOADWmAkawKnJFrMpvWd0CF38UeEaoQHab0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoW6uW6nI6gx0nF986sCJUzaJqnSXCMP1RvH8s/pZ0nQPNA+3/
	of/vZoiOlkLAkWWK9fEKFb6UDQVhTYFwYMZNCU5xd/MvEwrdOE7f28sz
X-Gm-Gg: Acq92OHse6ScNFsimQeOxAXxVvlB3TiGXTFLO23dGzzQjIJzdqdbPsj//smQcacuprG
	4o9x+Ro5DPWZX82247yrmGUiP+tI28miPUhRPr5Ic1L2FecBx+BECsCdA31LrKmZWMgWgCoIIG0
	+t9Xd93XCMHDEnAK0ZKRnpaK0Q8k4pn9nAk7uKgHMaQ0vJVfIYZqwei8E8muGB1zSzZwwHkZsML
	dJoLyADJXA2Ql2ldGzL+2QHChVrLnda1tE88RVm+XcI2SeK7QNZuFfqe10x3z3nNh1ca84NQw2I
	fyawtm20otJrR/0xB3LnjWSVjLKnsxvaEt7AxGmCVy+Pg33v451e7KR0TER78uR09k4k9icHQVZ
	MicYxgpQmBOpPWqFo/nLnNsQDAg7GtriDQo9IwkQkwsA4mD5PHsPnUijQB60VT8IFEhimx/VFcY
	FG/2HokCl8w/lOmffY00TxfnMORUa3xjPzXs5NdURfkNv+E2nRGIBLxcPCCAqw1rNiP3QnWi4Qh
	gJaM5OwlU12dQ==
X-Received: by 2002:a05:6000:1a87:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-45eb3673319mr31634787f8f.4.1779786732366;
        Tue, 26 May 2026 02:12:12 -0700 (PDT)
Received: from localhost.localdomain ([90.173.102.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e363sm34749267f8f.28.2026.05.26.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:12:11 -0700 (PDT)
From: =?UTF-8?q?Guillermo=20Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: =?UTF-8?q?Guillermo=20Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: stm32f7: fix timing computation ignoring i2c-analog-filter
Date: Tue, 26 May 2026 11:12:09 +0200
Message-Id: <20260526091210.20383-1-guille.rodriguez@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

stm32f7_i2c_compute_timing() uses i2c_dev->analog_filter to pick
the analog filter delay, but i2c_dev->analog_filter is parsed from
the "i2c-analog-filter" DT property only after the compute_timing
loop in stm32f7_i2c_setup_timing(), so in practice the timing
calculations always ignore the analog filter. On an STM32MP1 board
with clock-frequency = <400000> and i2c-analog-filter set, measured
SCL frequency was ~382 kHz.

This also affects (widens) the computed SDADEL range. At high bus
clock speeds, this can select an SDADEL value that violates tVD;DAT
(data valid time).

Fix by parsing "i2c-analog-filter" before the compute_timing loop.

Fixes: 83c3408f7b9c ("i2c: stm32f7: support DT binding i2c-analog-filter")
Cc: stable@vger.kernel.org
Signed-off-by: Guillermo Rodríguez <guille.rodriguez@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 53d9df70ebe4..067af255bd22 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -694,6 +694,9 @@ static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 	if (!of_property_read_bool(i2c_dev->dev->of_node, "i2c-digital-filter"))
 		i2c_dev->dnf_dt = STM32F7_I2C_DNF_DEFAULT;
 
+	i2c_dev->analog_filter = of_property_read_bool(i2c_dev->dev->of_node,
+						       "i2c-analog-filter");
+
 	do {
 		ret = stm32f7_i2c_compute_timing(i2c_dev, setup,
 						 &i2c_dev->timing);
@@ -715,9 +718,6 @@ static int stm32f7_i2c_setup_timing(struct stm32f7_i2c_dev *i2c_dev,
 		return ret;
 	}
 
-	i2c_dev->analog_filter = of_property_read_bool(i2c_dev->dev->of_node,
-						       "i2c-analog-filter");
-
 	dev_dbg(i2c_dev->dev, "I2C Speed(%i), Clk Source(%i)\n",
 		setup->speed_freq, setup->clock_src);
 	dev_dbg(i2c_dev->dev, "I2C Rise(%i) and Fall(%i) Time\n",
-- 
2.25.1

