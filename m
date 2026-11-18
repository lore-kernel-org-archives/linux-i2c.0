Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032332;
	b=5EZQBsGlUwhoDnP/HWBXIA53eJl4Qr/B8Tc9o/hFnbopEtFFq2/t2yfq2iDBtmGQ54Zq
	 ws4ljccWR1DwxD5ippVR6hHjbQoIwhdk1Mmh9VpeTFkUp8p5T8swXo3Va7u4Z1b1hK9WL
	 JXk4Mqr6LXR69hbPoFH4gRvBsj1T+HoIISRcxXSFg5ILaFd2o07hEl6W84Y7Bl/S8EJBF
	 cX2OhIk198ZvYf/E/tIg6etljR49URAqVsOV7fpjvO8G0FmlD3VKcEOwI1LIAlQkuBUTD
	 AGmzE1WwIjdgqgIPZqsLsgfsva8QigI0YJxvRJ+vryYXpJoHp8FU3DLzzXLzKLx8P4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lhY1kQV+0BeRiYIEaScadjDC4jmhduQLLve0FXrFB4g=;
	b=LQmQFAO15wz0gJL3cJzVl5ImMFWXMlhklyMt+xRy5oHSWAf1RXJNbBOAxoOgJP03+eT6
	 qw9kNfSfeD1DVSKBT286FaAYYCBDgkKrakFLKvPHQkmdRx3Vs8xBfi0y2CKVIoHmrHYEk
	 0qU1jB5BCIXTuEx+nEHOeNWEjtnAD5NQbIm+ZGAD02pOAEYOJM9/zfSuxQBqsHvoZEniW
	 fNaO2VrBRvpCFFZNnPP3ceJeP78i0CdkE9XKXLjTEP72nUwtt58dw0+Ucx3709of3/42u
	 tsi62DM/w0gJgOLEOcskxP4thlvBAfepcu9WokPQy21/D3QXTdathGFAKuCGNN2XXag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FY6HgOSO;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5B60A2637
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E5B60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FY6HgOSO
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3352708eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032331; x=1795637131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhY1kQV+0BeRiYIEaScadjDC4jmhduQLLve0FXrFB4g=;
        b=FY6HgOSOJk/B1JD5ErvW/oO/+/P2xQrqnVF6SES+Upa4hNTakVRhVg0gowqNRZNFh/
         3+fVjOOYnFMnjAUchXcqaY31if+qJT9qMCyhlKMnBQLgtZsgESZlBdnu49iDYrFtZ7Bo
         hZ0rVXMU0FzNs8zLXO505C2iIV+HrAV3QrEFI2CyCCG7P51W9D7SjpeR/91BBSLUZq6q
         B6HwhU2DHNyYG4zuw4UEpIvDo2BPIZqYV1aVnGOYMAbDHdEGSXKkuqniA8hwAFIkg0Lv
         53dFkXS4oNGJgjtot0JaBj6eesAp1vD+Gt6jXtuM5EnNY3Aq3ThZYtGKWTQAPn69Pn1j
         0M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032331; x=1795637131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhY1kQV+0BeRiYIEaScadjDC4jmhduQLLve0FXrFB4g=;
        b=JeXhLhe76ZMuBJqrfvLz3yUaOTAP/DcFHRQuBqviJ+8d4+QAQd/IxbX8C8YvSc7zeR
         8Tjws8Dj4BA+QjGZtk/ZCsmPNSDmVuKkDhCDYfNtUTHtPuWQHGN98DitM7p5Hgh8vc8Y
         InImUStc2FYKN8PrZ7X3RvQAZkUiAqwh0pozsv4hTkrmDfqRYX6mMHtZMUUR/vikcZYq
         +dzFrDb3GUvky/pIqWGZdmGkLvKpEPQbAE1whd9JvWdIb4wgDTfZxv+x392pmXTrTnHA
         KlFhqSYuVsIB3Y6a0dyDQsgMaDX5nQ5HITSgpGlycEVA6hSuX77iLzuK5TdM4MGWLkaS
         7BGw==
X-Forwarded-Encrypted: i=1; AL+hErGHi0MJYCYiIlUT5XpYvZCgIEoPeiFQH9QUDAtP+hE8xJ43hsQhP4LOwMTcJhrsPEyG5E8XHarMV9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ddy25G5eKOZIucynwSggj/HcoZciQAQFbV9hYQF6fTy7xA4kI
	DoQHTBPa8nJrQhFgKiAcEtqYOr73U5nw5GQHoOS9pEqo/D4lI7g/qDPl
X-Gm-Gg: AZFdTZfrl7n7o5qvdgX8gs6aDzNb1d1APHo3XsPM2P7cKbZIB3yzq9mCpMFAjzo3t4t
	xbPvBJscjcPtl+umcqsxiZtRYbuGmwvqvxrtvCapG6A7k8qcTLrqUnfMFQLbuGq2TzAXiS87QWo
	qV9Szbh9aSY3g3fTVSSQ98Bw546Fbq4windSNCKaEpPZTvzucDGgVcPOA6fdzOQcbQEU4x7Ml+w
	C0PVsIiWs4JT7zrc12gXIgP/h4mz26aYG1se21d1wT19pmEvzX0Zq7UEcxYC70X6gYNp3cgGj1t
	DPuTjobilfxc+zISTO1z3weH57YJj7iykBBCM9PXfC669KM0h7faYS0KD2n8AKx23OzuNu3DoN9
	aldAs2TFZx52FS4N/bfRWHQPSXZOVXQEjPKJDFbncR36T7W4QvVNFhI8JZOpqTScFG7p/xX9IWd
	pViIrlXZcesozoxEQlI2AuPF2m4s0GTvinKJc35wp7NrACknFED6IlTeSmNo/0TwCAVVcdk6IGO
	O/QLoF2SXlaXb1tSpS3J/Md3+l4tRKUbJmXrpp5NnEGZbYMA55Ylrymqh+B9orm69JP52DV+8jl
	vQzeBKsm0GY46ueXMqCfq18YWZYEMmVOpCL2wFIfUcJ1WwZp9AO72TwnovL4jUS2rzv37lERbhi
	g4XWxA1uFNa4hExvcKwaqFNn5osxl
X-Received: by 2002:a05:7301:77c3:b0:376:2ca2:d80e with SMTP id 5a478bee46e88-38281214024mr2770749eec.30.1795032330636;
        Wed, 18 Nov 2026 12:05:30 -0800 (PST)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a79c96b2sm11032107eec.24.2026.11.18.12.05.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 12:05:30 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Wed, 18 Nov 2026 12:05:27 -0800
Message-ID: <20261118-timecard-common-301f823ddd-r1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179502617544.3136.16911407487347494512@kernel.org>
References: <20261116-wiwi-v3-87afa10a8-1-ahmadexp@gmail.com> <179502617544.3136.16911407487347494512@kernel.org>
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

Thanks. I have clarified the comment in the v4 draft: the subword offsets
describe the default access mode, not the forced-word mode. The latter
requires unused upper bits in CR, RFD and DTR to accept zero on writes.
It still performs one transaction, without read-modify-write, for FIFO
accesses.

Patch 3 remains the first user of this flag. Other platforms keep their
existing access mode. The revised objects and accessor tests pass; this
revision has not been tested on the physical card.
