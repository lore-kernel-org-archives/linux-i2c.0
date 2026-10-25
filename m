Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896531;
	b=vQmPdztUXYz4cVnekxDJDwCeQEDic4TH4XJlJZQN3U+B1Upz2Tc8aD+d/YbDz2//pZEm
	 sGGRofa2gcZTlv8L18TgXPWHE4WPkP1FVL7Geg/OGhY/j4L2NGtwreMHc0tvLrZNev1jv
	 xsFOJHLjAKmZAqA5kKOt21wWTCEwXfRLxli/pUWlBNgKw4rQRedC7K7Iv2XowTGDO5Ij7
	 PX0mHVV9GVAnZqbcufwCerd+UP1l4jRTPyUSoopwxRKnQmPKY/1iVjK50Y334LQPkwhZ8
	 NucLJwD+HP2QgzjwHOUmO71fdzscGxw7jcDmhhy0UvttjkSVrh9USedixF/ZMqqTyAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
	b=wFLKd/ZuyfMzfRuAS2Tgl+5v8mthuGHqOlgHaDm4EBIWOIXG4ZjhC+GkxqLOXGtC6JLx
	 1yLwn7UWTA+k1F6quoF4SU8JWx43+Kk5/mAkkeBDKWBT01IAvYDoxFPUAeQA1BY5viGPN
	 QFFNKrSP9OpGgAO3sCrbweK8slfQRaEi5u58mKBW0PEsDybYJsp+O6KT8XT0XAk2pNwbF
	 VcY9sDSKIlAl0ibtKsz5MJBxxoGKbW/mA6rZZn4Wvg+FCXwSS8qwHRvpe+zDZQJQj6fce
	 Kl5kXtuvni6dK7sQoa0FODqtVB8ArYd3TIkL3baYSIcXwnnQ4OC/sc4ukKQxLw2ybsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CB606A334
	for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2026 02:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 310CB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3281704eec.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896530; x=1793501330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=D13wWGtzDrlBw9Im7u0R1IdFHg4wNG1163II6ub/nPI2fH0oV74hQzstoAqgvSxI+0
         myknq9Ug9x38jjUUZwY/vyXKIDGMNo3ZKXP0bAWsSPufchByNmfUqbjLR9h5DiQc64wx
         b41VuTc+OHb/42Uk60MIIq5H5njnW+qeWoLqYxKwISqmgf8YvNXxGq+BL+Qjc6HvXh7N
         0UFuKY7bms75KP1rs6qbQXAEM6K6vURDSsJu7wqzwbTz0/lIFC+uDNdCBWcUI60PHNnA
         Gm3DGTK35BKOy4/WnhcBiampzvbAyAb4nyB/WhiSNzemLHUAH++XTonf9uwlP/Mvv71a
         ZGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896530; x=1793501330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=OaA3JrbLMscWx8yDIWje4ZHG/V1MVudPuu0MjxVkKwPRIMRYxvwHtS8fjOJCdrXy7Z
         Tnkf86mRViNAxWWJ4HpTqezsM7vBciu94YObp5Mg2t5wVYfqKy+gNfC1DRUxOPo3XkTe
         8oq6s7CzNjgSS3iXWtCe0k6klSSTYL9aWEVXQXr/CGutFmxxcgZ4Q35TOBqYKyTGc2ot
         KKSKH7uDX0JopuVDVY5NpmwESxnd0MRvoE0pydNCPCCs9pAmhlJjubIOwraE3/pPT301
         4yZz5euqsFJnP4HCIaqZC3CGt9tJFrSY5NSa+MKfqEt/D0IzQSsg0wJu+Kmm+AwbnfRX
         C08w==
X-Gm-Message-State: AFq9FYLbeVQuccCOWi46TJknQ7WbwhW6VBVOdX2+Bk5bFyUPxnW94sAl
	hmBT8u4TcZ4/BFVVdbR3Pa9ysuwuefWp3Cq8RI8Vl7MHbGRGQxGxzPD2
X-Gm-Gg: AYBFou20ISbpCrRyUSvk7aZ0uaPpq6vGCQBka5nJEo2ho48iD2MyzMoxiKUfaJJU1k3
	w2u3NZjjA7S0DrTclumOOpfLbWYcQdKeZ+wd3E56pOVhIMoF3zf2NU6gUqUIwGVIEIuqkr5FyqM
	ppP4XpaEWz0Af1cLY2sXbjO4HbeQ1nLJH1RFEfNP0FMAZCI/ZdLxhfpTi6/GfipGdSAZ5FKHD6I
	6FWjL0diCaXp4ktore7Q3Z7XgLzS+dLfb0TeUViRyXyCJl6B/vzn+bah2/vJRylpXlHECG7NnBz
	3niXp8NiVeGDkCvawMhJw/5yqAz9PDEH2lF/5mkp7T3mjO1fPzSlhcwwGIwTepBQxCd8Q1kyh8R
	YpByR71AEoLc2m8zXe3AWz4sZG8DO4bQx9KaeJjebsXtyfZ5fUm3X15inx+F4Vz2+42Pnyg/qFv
	zP4VauKbyKqxSIOzmZWUSvhbA9bN8ALGr4LhvavIUnhxOUOua069GgmVUbWNLPFDLj6GB3+bp8M
	+qcxD/Hj8E6koa6cWyQ68X9I2kr2hpeXLGqJQXk1vllnA9NFJqmJS34aFgwULGyIY9VW/kPPm7k
	lr61ZH0b/GWKxmkBQijy94NTMCndDhymP8fhP9t/cSo=
X-Received: by 2002:a05:7022:7f0f:b0:187:c940:21b7 with SMTP id a92af1059eb24-19934e71e37mr4620736c88.9.1792896530109;
        Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:42 -0700
Subject: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
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

Update the prototype of i2c_smbus_read_block_data() in the SMBus
protocol function table to include the length parameter.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/i2c/writing-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index 8bab8b16ca8a..896bf79ea564 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -366,7 +366,7 @@ in terms of it. Never use this function directly!
 	s32 i2c_smbus_write_word_data(struct i2c_client *client,
 				      u8 command, u16 value);
 	s32 i2c_smbus_read_block_data(struct i2c_client *client,
-				      u8 command, u8 *values);
+				      u8 command, u8 length, u8 *values);
 	s32 i2c_smbus_write_block_data(struct i2c_client *client,
 				       u8 command, u8 length, const u8 *values);
 	s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,

-- 
2.56.0.257.gf7497c7d27-goog

