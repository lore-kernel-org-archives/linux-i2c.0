Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896542;
	b=RWcWPygfYbqDJgrLHj1XrzXvfLtGwYDFx3GAwei1T7APSz+cEcInbBc23xykXOJ+3EQX
	 a/901IZ0dBSSGMNSWEHMgRoIqch4s8nH3TT7vcmjwe47+zzeMCqlkSi7jz50Ja2m5YkE3
	 wrqFQ5cBGFfP88//2JLoa/v5mYYwJ+AHcmMQBavrYY567P5Da0Slvk794Qp684/idyqhO
	 hVJyr/S+z+4RSNGcuHc+EK/beuLaiTCYAfmsoOvUSkvbt/4ig10SbMj/fjGzamhvWe6Dt
	 PpIcOsThvC/dYTumEUeiDCM1q/s0JbH3zgmC3ILXj6Lde4fRHV0G2n5sREqfkeoMhJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
	b=hJhSU8al/lhQneOuTC+MgHDgEHBjrDC3uYqN2dNeM3fknrgs1btg61rLWqbjbqqUYSwU
	 CWWbqghHO1Z5Bl58GgpF2q1EMxx7aF3Hh0J92ipIMIW3ruPeZVznN7cAMKyN3PmTsbp8A
	 oyVd5PbSVBODXbBWyy+x9OJ7qzoL5a+6dA3/G7xlzF0UcsqDe125lrmnHu2bn23lK2wW8
	 MITRsWSOY1bbBmP8XgGGd/6k0k3xhTcsT8t0c/LeQ9hcLPCLpESYWfXPjs8iOQPh78zS7
	 MLVd0JSYTH/vTvQN7SRuRx4A221KkULarqkPuUpgRF0I+h2HPD/3QZfQ9NKRLrOnjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (unknown [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4E60A263D
	for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2026 02:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF4E60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so3391633c88.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896532; x=1793501332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=AogBztQaefRHxqIf7r7yyiPJ32TbkKSI3EZbJyc0kM0DrFhuCiEAqIV7SisQG5g01m
         lP8walfX9nQXhaXidqzuNwI6Liv8Yr7pKoxYww/l1I3zNqNPsE0AbTEz1Y9/wA1xXQ+u
         pQ6Bjf0E790OrznGUopeKOQszZ9uwLfYdMH3COcZyZ4oSsC6QlaWXUQep2FG9atErDPJ
         rLSXwIHURFU/vZ1FggsB7lHTTHi5Nztr+uIT7tAjeUcGHkirI6ugimoSrRGeOsGzaU7p
         Ogm+9BojY6irQAwGPPBCC/Udjma2QscUnzmO2cmOitOQmo9ottCgL420ReMargrfLKyq
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896532; x=1793501332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=yHK0Ze2WMVq0NJbVnwuiyZoIq9jV43mDjh0VcvbLZ+amSE6RqNf3E5PhisyKtrV0nl
         bzNCJdAwnhzGdIsIKcweAMJtgO6VaJcbR7L1hBXQTkdYRk1GurMDyVkun3A9id9mFe0V
         g4ZlVLl/p1fy30BPTYFdyQMRSGU8hZdpAmCZRImua282Y70LZKL0yicBrzPhOHmEbeAR
         PbML/vMz/JF0NxIVWzMV3MJWavgChSNiaXyb5VNOeuNnIRyQaJmuw8mGEJlmen5u1cmC
         eD+e42/pr1/Kzcyqqk0bJOdzy2NGhPSqDQxPNHFtrxMLSgQoqRfsW9Hb7Yrc16AcOG8F
         7c7w==
X-Gm-Message-State: AFq9FYKvkvuky7dv4O65GJ4xEW0ZQP6DvCgBDPxKqnUESpS8ay2wNhnU
	Jx+b68+NRnOxiOKIXMCPkBQLkvDs9AVe14inFmScGBQMjKDExbUEFcU9
X-Gm-Gg: AYBFou2H8A5szBDWH3sZCQeA6OgNOQNGSXvSRj/UdxUkXJvKZqPQLpFeIWGch3mCzHr
	UEtCerz4bcup8W6V4oLcFtwpXE1eXQYgPeR+2KusTlNUdBKcU//LLotpyAgvl4CrltaIPdYfZUf
	hdAYPyRdJbHK0W8PMpLfGOmlR1udO17kol4i7qHaoiGYNOFxNiniFrXJmrGx0RDEQS5jlrUqN0v
	0c/qTOy+I4qsBYtr5MmKsFxcE1wL5ULUWL7R+8wppgPufhXi9u7/s7fFVey9MDUVMNvCE8rwpXJ
	MtbuvmqIUjO0jAA4Tga6EACGoRrDONgF87rjZ1fxVH9ch3bKGHAu1hNtIcU+U2j27qD976uqRcL
	3Z0oylv0xM8+HTEqzePLhbotBW/5tV6Wcmgo6huwsyms92wJTmyFXQAgx2y1gjlfgzkGei6skro
	7zdyykKcuL7dCzZYkNeGPYNy3vkm0KMdBmxIRB8dhpDYUIrmi9v2aabPrxpTvYf1FLOPBM/LCtX
	7o61bfw2Q9UM82I733UmXDEtpe6yJyEv6R5fzI1YE1BY7cHDvOquXdnBROfH7nrHp2ef1/p5MsR
	wPh+wYGTegAtieZD5eroRsDScboau97U/kulilVByF2lLJ4fg0F+Q2OBQIV0ZSxE
X-Received: by 2002:a05:7022:ea5b:b0:19e:1ad9:1c2 with SMTP id a92af1059eb24-19e1ad9061emr760295c88.38.1792896531619;
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:43 -0700
Subject: [PATCH 3/8] Input: cyapa - use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-3-19bb97467982@gmail.com>
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

Pass the transfer length to i2c_smbus_read_block_data() in
cyapa_smbus_read_block(), accounting for the final chunk size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..0cdebf2c34e7 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -256,7 +256,7 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, len, values);
 		goto out;
 	}
 
@@ -265,7 +265,11 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd,
+						min_t(size_t,
+						      len - I2C_SMBUS_BLOCK_MAX * index,
+						      I2C_SMBUS_BLOCK_MAX),
+						buf);
 		if (ret < 0)
 			goto out;
 	}

-- 
2.56.0.257.gf7497c7d27-goog

