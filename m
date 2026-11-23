Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407590;
	b=LcYWU/PW9fRsfoOn2ZY2PwtRXj0Yqdm0DByC+QO/dtTwGKlfSu/km6ZtQ7BG3gKcf1Qd
	 lBkSkswB9v0jHLyniQTqAP8UUASMzT7jNG34QyNRfbn6K14FnABpO2L+XYmoswpGa/rnA
	 VkgvV1aFFYmAdhGI95d78uPvRFO7N4MmJbqUgRFcTGuznBWtz1ykPJSSDetj/zNxUZlhI
	 lPMFtMLyer/l6xc6bUPlq5XMtXPsBSYkf+ChXwTPimkJyojEK1CiZcl0nkAIjkZ1OGg5p
	 Ws4PN8HIi0kY5JxDZeE5zU7Bt8DiAAD79QWlAgTxmyMdqKQHodA7fQXuNWAtcpYs+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZAoL3/SVLn+0j3kam52e/lUYhtvCuZGUp79gTE2O194=;
	b=5qYR6LlvytyWN7LDi6f+A09oboStCtdYZVB62b3SuLq5r7iyFj8qKOIz57cTW+zfbYHz
	 p2v3hoWVMyMSom28HBvZBlQoRjAcbsX+B+Q4MtFo5azevXnmHLx32WEelZIFvPe0xroTh
	 Vt60ORcUv28OEt8txwOqHyWoRguqKlr1l8ebZTA1vQs0pTOiYuCKK8EFMmyGcTH//yufF
	 RJH2PxOKs8Vr1JbeAQ6szqWwqNLtrSrnFIqrKVJJ6oOpyCX+UzBp0hVbil0BWkMNbZNpg
	 rvNfA0C8FPkBpkjuxP1TKlpC6UH4L99l3uyfYhRY644673jkyntGfZ82nnsvhFyqRgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YuSBZL12;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2058606A31A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 04:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2058606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YuSBZL12
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1340508b3a.2
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407589; x=1796012389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAoL3/SVLn+0j3kam52e/lUYhtvCuZGUp79gTE2O194=;
        b=YuSBZL12UsolrJNMWp7uacuFRl/poXZ/RQeHg8klFwlLgOsBwKZAvRoQYoLiPXKWew
         9c9EA3XIYxbMHaRW/1rII3hxSAXkgLvwelcWKwKD+WWHvj5kowNRKJNlH3Y5niObf6TX
         rgwo5wCFJkHwmBxVyFRgMngUlboopqKr08AdguXjBuUWxZUFKsiHTVAlu33oWIefuN+H
         Px33D0ieDMb7x/18NmgoT0oL1mDV/JXQ1WlmtUkdDFKMr8cPpSciTFuhtMlK+G6Tk4Gx
         reyde38Wwb0J85eVsymRuYmy9CtUwGNlGQwKiMg03YplMYNorU+IxUGajyX3KxViytQY
         a7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407589; x=1796012389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAoL3/SVLn+0j3kam52e/lUYhtvCuZGUp79gTE2O194=;
        b=BnC6SvQQpg78bcCS2ul1jOleqQfgSSigKALVVKzDCbtt38kP4Ei6Mt1cKDI49mjwjK
         4zd3Q7QfeRluKlsYQBzIJtux5gHG5QJPE39KyqRPfDVR8H3KfoWG8qVPzOHJpaz4Wv0Y
         /W0V9vuC+zM5Nnt4eO1iOuCNv/PNhBlyVl7FWzRo9jGK+gyLItO31mO1l8zBnnlP79Ad
         VO0bVHtZvnv5aXFyTw3nblyCQC7Mu9WFKOLuiN7/dNK4/JwdkawvRfe56AK8RBOtimTI
         ZzGTWD9OU8yTVwli5jEI80fYHMmzrxbbdJSlEyEymXQZoS2wOAXfiE1BYPxiASg8w+B5
         mQwA==
X-Gm-Message-State: APuU4Z8cA3bdIHYIppMxbZeRaQwrvxiWTGxNMhipgsPA3KAJYIA1U3zg
	LpNa6hfokjzHRlffjK+FYzqcmZdTqkeLW/nnvN8tbXw4HSEBjOx1+pWw4DOb5g==
X-Gm-Gg: AZFdTZe6mt3BZqFVXXUbFoMKgR9j6yD4J3ZAgkz3vtXAYuzKDYziIywwi1zmwVe4mY9
	qjXIqlJflr8HL/CtlsdCtl6CvfrzxuyU04s27TFyZFUH7jM4Dpgzf2V4Gh4ZVQWvG2qiLHdTXHW
	EqJsb+S+kARh9V61Ur1/BPKE/qh1cncBKwybvI4N9imGv6IdLSZSDAhBYelg0ZlPoKgYKJmMDwc
	AWn3hc7TuiVyRBIupLRd9w4M1qU90QR8nkRrrfutdGzCjvc8c14/AVLcyEKxIEfCNa7Xsp37dpe
	l1IV95DpjlXBfHodjMXQs1HA/x/aHRZ928goMhwlC9PsN/fCuzs9T3N0q/g1o6V/2acc3uMTMt4
	VJSxb3w+AMYG60+JEYVPfPT+CWpcobfq2L5Wt1i5PWaIBNS47hLso8TbPvPl2phYGw7CL1pgOyK
	Fw4AUAfBXkk8xfA2cT4A99Ib3tAjXjmDNRFYmPogEs4uI32cs0rs9cT8BOqJzQN6JwBc+/kF60g
	Uczs4JpRORaIwqQd5xdcoA2uW4gA64rFLZ4e7rYcdqMFzgUp9gDE2ZtkjoLQXSluG5frflMICby
	Xd1K1s9i8Q+KOZDLoW9swEI8rCBA6fXJL+SORxCvQMWHYiRtkRFjDHW5RXAZpxKmWGpiT08LTcb
	Fd9eN2jWzXt2I/0F71ZpUPsqNh5yqCDy1Nys1Rqlb39Dz1ontBiUpvUwY80uE/Mf/SKD+XAdCjT
	N2T/7hITC84Q6/5+KfElKJRoc=
X-Received: by 2002:a05:6a00:170d:b0:8a0:7573:4f20 with SMTP id d2e1a72fcca58-8c8794b7ff1mr8605596b3a.4.1795407589217;
        Sun, 22 Nov 2026 20:19:49 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4af1fsm4798039b3a.28.2026.11.22.20.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:19:48 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] i2c: piix4: don't register SPDs on the AUX adapter
Date: Sun, 22 Nov 2026 20:19:47 -0800
Message-ID: <20261123041947.9411-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
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

piix4_add_adapter() intends to skip SPD registration on the AUX bus,
since on some platforms it reports all devices present. The check uses
"port == 0", but the AUX adapter is also added with port 0, so SPDs are
still probed there.

On an X470 board this binds ee1004 to a non-existent EEPROM at 0x51 on
the AUX bus:

  ee1004 10-0051: Failed to select page 0 (-6)
  ee1004 10-0051: 512 byte EE1004-compliant SPD EEPROM, read-only

Reading its eeprom then fails with -ENXIO.

Check hw_port_nr instead, which is 0 only for the main port 0 (and for
the main adapter of pre-SB800 controllers) and 1 for AUX.

Fixes: de4f2f52f932 ("i2c: piix4: Register SPDs")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 7b6a4e201be4..a21e6d377bc2 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -969,8 +969,10 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	 * The AUX bus can not be probed as on some platforms it reports all
 	 * devices present and all reads return "0".
 	 * This would allow the ee1004 to be probed incorrectly.
+	 * The AUX adapter is also registered with port 0, so check the
+	 * hardware port number, which is 1 for AUX.
 	 */
-	if (port == 0)
+	if (hw_port_nr == 0)
 		i2c_register_spd_write_enable(adap);
 
 	*padap = adap;
-- 
2.56.1

