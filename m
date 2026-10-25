Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896536;
	b=Bpm2Qb1PTf5EYzl+lBvLY/coIZ4ldafDFZhp3xdKoUV7e6cMeW2aayNAkiYXPw7MyqF9
	 eSk9Mc+WmXaGoNWISFnha8EaFiEAuFXcH1p4AlB9MqMU9BjLzrQ+8e1La64OFQKY63MVh
	 NkfMajSatRVX88TQG3CCDFhi8MMRfk+4FPFor+5ofS+pQLbnLeM8qg6To7xTplf1TcmK3
	 IGj1RDpzadXqB0PSbpWkPm/No96RGY6s1znGR2NN0c5qHTsXe6dGDeWxhBJXF1Ge1pFRQ
	 FZy8ZcR/EJBhCZDa2MLDyvhLf1uOFubwVIaV3qrx3FjRWQyudS8RSO6PrZ34wCLXQYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
	b=BPSgn1/WRJ25PrOc+uLnflfn/z7klsg4yh2kOYu2xQJdfY7G1OQuMBECs6W0dBBosKU+
	 kajlVUxEKtTvRuyMYKUTH1pkCHuPkkfR2x78GYdllTA909PX26MOIXEWIIzrU+s65EPfB
	 TK2NKY1AH8WO/zuySkNXzk3URxyy269iA0TgcpFcqHr9YqV/DXTx8tQEc421Jy8RlGsym
	 iR5qGg2XXAj+xZL67SLqvi1qa5ZfVKVOouSrdc4Zf3uvpaOV76u2MThOZEoWM2SG8UQ0a
	 VyMoqP+JcDHWxqMdNJmHdRgoYeL5oKWBtj0GlrR3FeJWb8HRr600YaemqWKM9Er/dGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85860A2602
	for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2026 02:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB85860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5337061eec.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896535; x=1793501335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=jY+GWyYS06WKW7sEDFJqidwo1kj5aZiu+FCc59Yl6t+aaUEEs04DN9aHOSFvf4pJ8Z
         qDTsGyTd2hnl7k5Ym46s4MK+M0SwUS6QT0od/3PXQUY9mRrVY4wqzdWTtw/7QLtKhHPa
         Wl1hqNxbGN8k3SsCbjwlCsOrJRQMs4gMf/tZHs8fW9xwTRoGmWNJzJ/3nkRIzMHK2jEx
         7Yvg/dWXiInPgUoSXDzs3Y09VvZo+NgZaXTjGaJ6myy/TWg725XOGN2XlqtCb0y6wNjt
         /5awgzg0f9X0YKC3fb5ZWJ1bxfPVtsB3fUtQFpxRIUQdbgAmX+A1x2JOoOg4XWscVZWx
         qdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896535; x=1793501335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=m9wHgv9YUzMmN3p4NAChJ/KwKXMjMtzMhIz+Y3XROqHAZbrE34ZrpBODfNHoDtq47F
         HVCQD60ZxhHBP0rJHnnTzWszKBBv221FG2hdc7ymPfvk4OfcwO8/wbQXv1uIQAKf1JzG
         9pww3DrTJOyqXd1WSJXkvMzb0gdladf24dq8ScI79PStWjF6w9ZnELy+axhrjizXwkEE
         1tyz+nOK37RJorEGNCECg4sAEkivMyskoIxt4vsvIyn2yghhkeWp9bAoDxg/fdZpCnpj
         4Y5yc3AzLtT9T8FvChM1GqDIcvrwBJCzg8gjHd4JjntniGzBlfOgctlpqo+JE3uUz4ZL
         eVzA==
X-Gm-Message-State: AFq9FYL7CnwVWs8wZ7E/uB6FLDhxVLdFPDPWrZ5+a3HA7LnrfgJypmov
	zaRXYXdI4VBR7WRG1lgHVlpr3eHx+CZjtK3tPS6qUntDjeRXCPKQjMiX
X-Gm-Gg: AYBFou1HyFXpqbwpVMP4D4ytJzR6KfiWMZP53iDlVt6qTtiS5tlFOg9WSqXaTWgcyZu
	HXYRtMBWfLMAL4bsfEPogMNeLKIPlKBhQInMa17gMYwTV8fl/gMxvcnfzp8JGBFbIUwXm2T7hHD
	LMMZHng1QRN7woUPi9qzDZCR67QocaRYFFDvq5FprVjpT3VvUX2wrdeTnxbe5h3qrckqhc1fIou
	JxwatgS2afWPe9vLkIX2gZ8dRH5NtiuVgudWSISK+wmUl7ondfidKj5t4F7W5cICq+fqp9hngu0
	CYfxObLwyxZ8a5b/ONhtDBrDiQKej4XeQyryqCg4G9iXTCKVP7PkOkSZ+9YZ5WB/lrMtgyXCWDX
	FoXyij4rbGzBUWZA9DSplzfi3KBmYJaSOiyxSXb0rRHN+T9zIjUuiF/0XHyOSXNzSGc+u0C+rzX
	absqtv5kbDzoHUXj7uuWn53NUsO9273Jamqg7RtnuGp62t8t+Gftg0Iu3XC5xqeCLg6Tc4HHFWQ
	6NtSgT676LQKwom/INsk/H0lwMm+FiY+p6ovfd5Q/bxKLhbZN4EOYV25xvbBzYNya3c1d2qIuFm
	yphrSknvUHgxK57CxWlf0CaU8uS/Afwc/P87zh/yHd0=
X-Received: by 2002:a05:701a:ca07:b0:184:d593:2897 with SMTP id a92af1059eb24-1993f3ecfb6mr5382379c88.29.1792896534741;
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:45 -0700
Subject: [PATCH 5/8] Input: synaptics-rmi4 - use 4-argument
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-5-19bb97467982@gmail.com>
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
smb_block_read().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..a180becb7670 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -172,13 +172,13 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 
 /* SMB block read - wrapper over ic2_smb_read_block */
 static int smb_block_read(struct rmi_transport_dev *xport,
-			     u8 commandcode, void *buf, size_t len)
+			  u8 commandcode, void *buf, size_t len)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	return i2c_smbus_read_block_data(client, commandcode, len, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,

-- 
2.56.0.257.gf7497c7d27-goog

