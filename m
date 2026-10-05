Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB62874E6
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791170859; cv=none; b=oLnedwcs/fgPLQk/5XaAEomVztkjtvPUilj0EjBcl9x3JWLRQ3nKZ6XHtB33PnlgB3GCk7Kxy8xorvj1svmsNqTDQFsusvJzZ1a+vtJ9Qbbep7f8Ln5/WAVGrYNl0laeldpJJ7gbNtRF4Mupm3+pzJnCDRnKUKAGuC1cXF5Kw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791170859; c=relaxed/simple;
	bh=E5O0wlXlJyvkkz/5Vo5XiLD7vEKkwgsN4f53JEeHJvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF/C/m/VBYsnrv0Wi9mkGX9CPAylAo/rCNiridEAsU4Lxo4o+zeZ6fpa7rqN2Vx29Q7n/HsVZSEl8wrpUxvnoPuTcXp5LruGPF06P9hR95WFvPxwOU0fFQynEwESnUvSEvu2CEXk5a+y+lJL7FFm3andyRlbp49VqZlwQXTjsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPYcFeIO; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPYcFeIO"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so334358b3a.0
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 20:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791170857; x=1791775657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7rtVf2jZjIswFkHLMjLn3J1S9WPnjKaw0RzizJrzhw=;
        b=bPYcFeIO1SmYox9vZpDt3UsSZir491cPfkqonSfQitiBaVVX4uS1B3YIy0Fgf4kMgE
         K+t9ArkkH3nj3tbCB2Ahatqi4vkh8MzU5PPkDJSzWF5HkpJJhltDRBlXp0JnAQDQ+mih
         JyPEvH2RRdlg0+EkkhMIe3WO8/THIVVdnoeyJL/fmZ+to6K/jOjJoayncKpLZbJMo+xm
         DsgpierdVc7Z3et8+6hnFwzowjXTVRTSja2xM1brQAjU6dOysEBBwKru3M55o77S37Hh
         bLBmgk2gQV3Kq0Z6nY3mvx0i1xez2gpfuA+AU8NWAOFcCJ/CMIGKgv7C5VjJmSIa42De
         OVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791170857; x=1791775657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7rtVf2jZjIswFkHLMjLn3J1S9WPnjKaw0RzizJrzhw=;
        b=MvakunsumvpgRINKbmuQxAP2jxetjvMEIL9sn0DJo0fyj84gf0XneuE5vh/KwlhvMm
         dD3nGWUk7cuXVYym9WNsSbHbrpuWMCzXZGaGk+H2qPhRmtLTiDFce2GUQvioD4Fe3UQw
         JZH+GqxqK0NglwU5bNiD6OPqCg98r1KO+f5PI08Hm/SlZ+Azg+4sZWGZ5HoxBo7kZMx8
         NfmqxGU7uTsEmKCXJvZu6dM/51zjQD8j9+sxH0xayHWHddW1bSEQIa3tyAG1tQlelGuh
         AwnZH68t9Sus2FBZQTL3NY2Pc+XVZiI/Vkh0eSGKqog4Rx5s2UZ2aPuFCkgMiCK+E6WL
         NHQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdxsrI6N7ZzqMQ7AW/PEpN/A2ip10Kk3ej6Luiq6VInpTyQtZ/065qNr3UU3bKtPunBrHMsc8udlg=@vger.kernel.org
X-Gm-Message-State: AFuF++mLHG30Z/ULtFZudeKJGCcvf916UDKRh6j8jutbeHdLfKFB8wCB
	9HVl9ykh1GVtnU95R1n9fkg6Op4hfdI1WdGlxPM/s6BdK0GxoSTODTsB
X-Gm-Gg: AYBFou2e0VxjFeemYHMLzXJy2FL3ZeQ69G9wPvuguTkymLFsGqn8F7MFv6zMXn7nUbW
	mjHJbhOy49ASU8CMEh3vfcRnD/8N2loCaSmLLakLuyWjOGbG4eroME27t1Wyu4IAJkgYZIpjzdH
	alNAW0t0tZw9ogj8HvzSjFjskwbjpAj++yd7PI2fLV0dA2/OcFEIEo2tTsPJRZ6ZxNgK2lFwV/L
	74YQ+l0bzLOKqIHPIDKOd38fxS7OLjewt2BsvIlLP2HzeYmuWIOAce4X4zx9GjUX5mihFW7ccAj
	nJcaMLuXPn1IUXmkcp2AnnNC44LbPfIMf2A3SzyPf+Em0NbUm1TXbAs1dZmj9jTbTchfMDLEQGh
	OcLSx5KAIS56wK4a6Xz7KNPoNNwjmYWtYbUgGty7t+DT5SBXOSq0YR/lhc8goTVEyKVJ8Pb37bO
	nMWCAIj6XBRs8DgG1I9AEY86fwpYx4wjixujLeemrBtSVbXsmT/mGplIuW1GY0ctRk0JhdAZfHP
	F+ALfO9bNp169GeOo4z7f2a+MvnTvCfygmvWRU=
X-Received: by 2002:a05:6a20:4324:b0:3e0:d65c:494b with SMTP id adf61e73a8af0-3e0d65cf428mr6369545637.26.1791170857208;
        Sun, 04 Oct 2026 20:27:37 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([112.2.158.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6ddd9a25sm115037a12.22.2026.10.04.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:27:36 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: westeri@kernel.org,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0662 to i2c_acpi_force_100khz_device_ids
Date: Mon,  5 Oct 2026 11:26:55 +0800
Message-ID: <20261005032655.12633-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005024654.26888-1-xuyuqiabc@gmail.com>
References: <20260918054109.23550-1-xuyuqiabc@gmail.com> <20260918055653.GD106095@black.igk.intel.com> <20261005024654.26888-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi, Mika,

Please don't apply this patch. I was wrong about the fix, and I'm
sorry for the time already spent on it.

I treated this as the same 100 kHz quirk as the other ELAN touchpads.
That was a mistake. On this machine, forcing ELAN0662 to 100 kHz does
not stop the touch jumps.

The firmware already asks for 400 kHz. \_SB.I2CA (_HID AMDI0010)
publishes the timings through _DSM. iasl marks the UUID unknown, and
I could not find a public AMD specification for it:

    Method (_DSM, 4, Serialized)
    {
        If ((Arg0 == ToUUID ("d93e4d1c-58bb-493c-a06a-605a717f9e2e")))
        {
            Switch (ToInteger (Arg2))
            {
                Case (Zero)
                {
                    Return (Buffer (One) { 0x03 })
                }
                Case (One)
                {
                    Return (Buffer (0x04) { 0xE5, 0x00, 0x6A, 0x00 })
                }
            }
        }
    }

The same UUID is present on other Lenovo AMD platforms. AMD's
amdi2c.sys 1.2.0.126 reads function 1 as two little-endian words,
LCNT 0x00E5 (229) and HCNT 0x006A (106), and programs IC_SDA_HOLD
with 0x48. I could not find that layout written down anywhere else.

i2c-designware does not evaluate this _DSM. It derives HCNT/LCNT from
the 150 MHz input clock and leaves SDA hold at the reset value of 1.
The comment above i2c_acpi_force_100khz_device_ids already suspects
those default counters, and notes that Windows works at 400 kHz.
Forcing 100 kHz only avoids the bad fast-mode counters.

Programming the values from the _DSM changed the result:

  100 kHz, SDA hold 45: touch jumps within about a minute
  400 kHz, FS HCNT/LCNT 106/229, SDA hold 0x48:

    i2c_designware AMDI0010:00: SDA Hold Time TX:RX = 72:1
    i2c_designware AMDI0010:00: Fast Mode HCNT:LCNT = 106:229
    i2c_designware AMDI0010:00: Bus speed: Fast Mode (400 kHz)

  the same use no longer logged "Touch jump detected".

So this entry does not belong in
i2c_acpi_force_100khz_device_ids. The follow-up will be a separate
i2c-designware patch: in i2c_dw_acpi_configure(), when SSCN/FMCN are
absent, take fast-mode HCNT/LCNT from that _DSM and set SDA hold to
0x48, and leave the bus at the firmware speed. Please drop this one.

Thank you for the Ack, Mika, and sorry again.

Yuqi
