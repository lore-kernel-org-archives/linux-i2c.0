Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896529;
	b=0gwkhw9mC5IiU5LtOjGBXihDs2ml8uLfgNtJu4Orp8sJ9/EQ9ELf2pT0uvYqONTZb4dN
	 XyNTya23uLjK0mD8HuRizRENB/cNhbZuaHoA6FbAGTGBKl/bmmtSbFuKmJXXDrbr/zCT5
	 S0IxxI3EHF/mdyDKsVP2YvdlFnnXR870kmIqcvPlo4t9CUQgcdiHKFmQ62vud1KVzrme9
	 8zFOa/U0MWlsiJ6bXENLk6S6LNxXWDfvSlGk/Dw8WaoMqEqZefn0kDpKC+ndbn/bqUpF1
	 oZIcfkP5XHcYWSoGqNRHIB0PQ2JqBuIjnVVExnYCz5A3953xR0FXV5+xfRfisG8nAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
	b=ezpmMdQGFrO9NUjzGgtTpkttW+Y4W0OVbJS5xoj8Q1v5tQ1NJEvLN6JoeRFcHGn97iZy
	 wOr1cJCi3Lz4Zbl+42kVxTAoR9nYzpl9XI6LYQHvN8KYFZ4+fzhco7Y6Zlf9glhp01chc
	 ahE5mDPNris1kysHB2E4brEaOeofheDAMVfCv05iBBKErUPvNRSDiQc/DbwRAeUiQEHSS
	 +RHidlCUE2kU0+hGqWHz1aSYxj2ZpzGs3wZumXfBR3VBUOw1V4sZLqzCzpHQK3xJJcuS5
	 usoN0nn615f3L45X3yBh5cPf5NlMQD7ParIkujzLXB/9jUTvnC53/6VQ1ZRK9dNeJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C622606A332
	for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2026 02:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C622606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-157fe9d771bso2424415c88.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896528; x=1793501328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=TpxwA813+P5znsifZUJ8deji2Cfy3YNYm07xUH+eLP83aZg54OT8spSktYMe6uqGRE
         iQECHez5gjvBbx6xLGeVbfT8DSZ1k8Qt62vdK8EaDhI3b1+wztqIkJbaJlCtnuCA5esL
         QRH/IaQA0IS4/4rwKKtRZShp/VJZY5B2CGAQ4+oQP9868SHQzHcsRMqbIUIJIrKAZ80n
         lruFtXxmDd9FsV8X+PllJ668rF3ZZJTTNnl5/6dcw99NfAg8N0Yo5T4C0J1RuHQYX1ve
         +cFbn2eSkjaZFV55MBT+LCMMz8FPEg4aiNN52QkcwWnlvHZrZ4/6zCg7MfQQ7POzh5gG
         lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896528; x=1793501328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=BDBByRn7nvWc+jpZyV8GNYvN4nTSivccei7khufPHC5x5dHDuq2uxRhevcBMt9jcAl
         hMoHPdSYyhvG64QJXmtNkH5YIjQ6igT/SJh8LltuF+ypGsyzbH9hClTE+5V6onLW4s4G
         5QnklGUKdv07+eMhE+vBl78bn6lTTuhiIhHYGoTY8vgech5Oo8rOffAzoCxoCgRlSPs+
         h3m0azTTF8qQkG8py+zK4eF4Q4QlKvVRs/DiLVgSUONPPYYH/a8hFFj8735wk4j77TuF
         pKBwYbhF/xbYZ3WdWvok7JbQyDYFfuID6NW9GuA+4J7gFcnT2zGaacCnyljZLUgAJvqc
         s85Q==
X-Gm-Message-State: AFq9FYJVPbo/rEy09kf18x3YI4Q7KmQhfR14/LZsz+LiIf1gIBAP+57Y
	VeuNHU22gPxZHhj4Z7EnVhzHNRfUv0AewH/mKjYCMzMIND+5UxyI/BH7
X-Gm-Gg: AYBFou21TwoEAs4IBdmzw17DXEf9p7hoVoWPYxCSujcR/Gewg3GxqHbPimhJLQks26E
	swipC/lYK/7DOZCZUKWsWlUuoafFr/I+87KldSx0x4T/fK3dwA2ETk7xjb/OmC+8sffq4+vWxIQ
	bkMDyMYUk2fzqDA/nb0N+s2yjGgOcBKP2su7Q5d8Hsk7eyz7O4BHyY/IwA9lIKBoFS5IKo1di5I
	VwJ0vc6bj2g1hN03Ya87OYsIeSJZY+qI3g6reVB13Mvk71Uw1Cr0dXJLQFD/n+YCi/8PrIW+Eok
	F1uugU7o/lqxn/FjhF2y3Mt0u+bW9UND6jMhWH+lGanIEFEAcCqQhpDv7nRMP+4/lI2whJmKNy/
	0WzGpZ931O/PNMp4RFyA4+nbAlCRaTdXjvG1G1sUpCsoN1zBNnWU4h0iXq8vG6UeTw3ksBDk4T8
	h5vmI/gJnVdboTUxKr9lzKoRNxx+dJvfB2WmTELpCBG1HoUf8/iBCTS2o3MbYCvfdSE1ZDgofQC
	pyYPuY0nRWJmKvNbPByfUPYSlKb+lwbPQH3vRmL8vJ8IC+aJkliRW7GYlqHMXXGm3jjnlLYDOqj
	47WgYFF2Ei4lsbx8dOtoxMDdAqV5riv9QyVaPQh8cQ8=
X-Received: by 2002:a05:7022:1087:b0:17d:7b45:f905 with SMTP id a92af1059eb24-19937025befmr4633321c88.31.1792896528487;
        Sat, 24 Oct 2026 19:48:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:41 -0700
Subject: [PATCH 1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass I2C_SMBUS_BLOCK_MAX to i2c_smbus_read_block_data() in
i2c_acpi_space_handler().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..4acce685457f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -751,7 +751,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
 		if (action == ACPI_READ) {
 			status = i2c_smbus_read_block_data(client, command,
-					gsb->data);
+					I2C_SMBUS_BLOCK_MAX, gsb->data);
 			if (status >= 0) {
 				gsb->len = status;
 				status = 0;

-- 
2.56.0.257.gf7497c7d27-goog

