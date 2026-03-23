Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B693B9D9B
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281692; cv=none; b=Z6NCFXJURkN0yuWxq7x6N/3NMX5UudqiqnpRYF1jXV8G7zRxehLa84z9R0djGS4UMeUy7KmeICBUyscLwK87BMgMNyABNuUlPMqGMraMSkNO+2C4uydzX8/vBM44eTo/+2gJVIl0kmvlIbhbr3fO+ZdLiEN75SosgNAY+k95c9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281692; c=relaxed/simple;
	bh=c6f01OsvTiyXVnZWo8PZotkO7JnabjBxlucvDk2sbbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA4VZt+SiF12H/cHfRwVdzgXC06UCBgqWZGMJSf/3sGCfky4DHtbsj2oZCkTQuTQldVK8UEdjLV1pDYjqZXgo/UFahN9vRZZOS/RIFmniNakIQaO0U+lU2MhNpoAirueYTzeDLIVwGT24bLFJlPrkWJV1RBMYSe5r4eRX4anrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=H07E0vD+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="H07E0vD+"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-67c281e3fa1so167465eaf.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281689; x=1774886489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIpGiwlR+P+YjF46voPKMTMFtfqJy7FG3o7efUKpfWo=;
        b=H07E0vD+EJFb7Rj7CpD+riSDXztheoLAJz7gJHTfBQOt5mkC6KnZxa0P5Qtx+U8B7W
         xWdeblvbFUoWhP3UZApKDfnzYDq35+M8dkNJDFwpGx+HDQIy/ktFTsNbTla6P0tDT2Nm
         FONT01pV66JZlZIybBnvc7fqdIHaOx1Rm6d8BIZ2Ss9w1XcQGKYZFhulUfQrZ2xQQmKY
         rA2+HbrQRh0jg+Uz2ngR6wW7/HyAGDKG1AuZerZcWW1QD8CEUiD030sffKAYEMyGebKp
         o5eYdrsiL8EwhHUtmCLLhFNNndr/HcfG4cwzuUgu9Fm1my8sAW/8Sub7GAJJi+fU05pT
         1UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281689; x=1774886489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIpGiwlR+P+YjF46voPKMTMFtfqJy7FG3o7efUKpfWo=;
        b=B/exV0+wwhpKvGK6DSQlb7D4+JH8Tr22Sv8Nu5EiFXFUGTKHWbez1RsF/oKaoz5kYm
         aDEXVIu1et92WIx9n3tY3r1J2g0ffo6pqMfhXr3voFZGvbHRY6Jucl1FcBXpOCmlPxYu
         ZFliEJ43j+0T80mR8w3k7c/Zj9OH6q7Z8mev6IQytSH8APg3+MypNlfndq8VXnymmGn/
         LwPG8b8ZGC428vUuv1toq4P0Mjm2UALrgIFaE+lsDWqyJTW3lDfpXCa8SKIgD29W5nTV
         dwhkBmv7L+4fegyfKsg1Ztus7ddnMIzKtljG8zSvHh8OjdcJESs/HnIR1JeMQJPvNsq5
         OA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWAQGWcdx8kUYLgnUPu7IORfWadJETOQ+r5PykPZdgxdCjV+n+t9xzbCj4Szr26H/uX8UGnZoL8cZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9A/+L+V/Ih+IE9elFDGwlZbCdXP1chDHvQ6H1Q5Z7yLJrA/l
	0mqv+kWG4Q3byagzEeK7qR70wIe8ykl3sPacLLIqRc5mKEnjZCk+n1btNGysaVSN3xI=
X-Gm-Gg: ATEYQzzW0S/Mfm2e4whxfCBADopmFzihXbeVP9T/1yy4z4C+9OM8Ut94zVZ9l8MG9H/
	jFPEozRKJ/7+d5Z+XmwVvHwOgWn3cG4uCuHAGxPyy+iIMPq49QdehVy4LOUf7MEATDYKxsfy4C9
	7VEHXhXTTwxa+0mHCImXCeALJGaii1Az3CUssfDn4rFv79XisbP0gcjRKJCoPGgM2WiJ0SGGFUR
	QjP0/ld/hjxFsuFqyhlOAHli0BGrGktts6VeIeMSlo2ZNk9yVuwRm5rF4pzKNBsEphOR7HAuPln
	Wdw1FSzs0JtgJqWpGhQUR6gmC8MvMxyWCcgaJDOKTeefOU4ZGdRWbtCbXgdRxQxTBjtABtRCv+g
	v6iTz+RKZznGT/aW5AUOfwj0q2KRAkPLbageXXlEhcM8Ej70aBPiFvC4yhzyjAcfdZXpc/LMK0B
	Xrx3zH3o523IsAyeJDbe3VWwkG2T3I7z5vfZbT6vvtOSaBNsbGzw5TvpgiewjZuy3Wpg==
X-Received: by 2002:a05:6820:199a:b0:67d:e8a3:4c30 with SMTP id 006d021491bc7-67de8a34d8bmr3475554eaf.32.1774281688978;
        Mon, 23 Mar 2026 09:01:28 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:28 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 12/19] i2c: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:31 -0400
Message-ID: <20260323160052.17528-13-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/i2c/i2c-core-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 02ca55c2246bc..bebb7ba67e30d 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -89,7 +89,7 @@ int i2c_slave_event(struct i2c_client *client,
 	int ret = client->slave_cb(client, event, val);
 
 	if (trace_i2c_slave_enabled())
-		trace_i2c_slave(client, event, val, ret);
+		trace_call__i2c_slave(client, event, val, ret);
 
 	return ret;
 }
-- 
2.53.0

