Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901A2D0C97
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801588; cv=pass; b=l7k016IhpDPDW4yYms5e28BeBnFc4ywzRTNyxN7Q+xTcnpcj7ssvpnIYCygjuNM12xZISNeOSxpu0m4yebroGfwPIDWpxGfi8VAoxa5NiIayd9QbsiJ36dn/8/Sdw5q9TxyJV3P97BmtF7fX6gljd/7sg1cbOnt7NLff650mj7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801588; c=relaxed/simple;
	bh=+KLygUoxeiM/8RtGzilTLa/e7pOwDKpIDm6NCKkk6bo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hv/7gPIZ2IQm8yw8s8CaRDfje9utgaSHQi3oJ7Ci0Wid217DLX06Ynjv61jooV6IP5urrHCKEXqVSNsO41UoNpNARyeATsSbxyPMwsicGl44Yli/ag75DsZzV3QEgjZtExXWxlpVXSNDqRw8FrsvUhUcjfCs0RBJAURSG9Rq5qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owF8MGT/; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owF8MGT/"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847a52edeb2so189315b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 23:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782801582; cv=none;
        d=google.com; s=arc-20260327;
        b=KMWEJAVDg0T+aUUZrm7erw3/l+Sk7o4v4WbxPW0ty7h2rDT//+J4FrbS5PmkQbX9Wf
         QBbZiJMFm2DcyIAoav/IuigUMaZtQVdFRrUPEsS19b6GmTHaoiIpJdrswgDhoA6vy5T6
         qWZzuqsqlSjujIilGF+3QAyM8gvvN2+TM8e9SAeDhkBl7ymYeSpUnrXpdxehkRtteGeh
         EQ3OLrxmZwnoVHFttgNmt4slhujOeqSgc27XeCFPRHoU34JkqSAUXgTmLsw0VGzpBtk8
         oV/kZPVwH2kfzOLPaUDtmZM1c1tW6GYvJNBI1Lkqnl/bfkgkYmwwAy0g7HYrlTgIKW3Q
         //tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HEEP8Q8hvoLB7y7EezlcQqVBnLjbvMEXaAaoaBQlpAo=;
        fh=peIqhu6ZoQ0n7YaP0ARtSr6AiTgdEHHxeKpnlUiI6Hc=;
        b=MS9YQfBCkYUKLDyYx6YCEiO2w8YcZKprBRQDTYLNy2NcUaTD5fQNULeraKxlnKBYMm
         F1/y+99BQov3ZHgO+YMeSClyl1G7rYhcLkypIhjSrh+Z1/lhNSgxpd02KQF5cJX43ome
         4JB8XooqNhEK7NDG1P+BcVRLFOYUaw9a2beUyNvy7m+nzlbGOyDFVLHE/WgK+HWXAS5O
         /96NIiJ1/D8NalPZT4XeaH+ANmz8NYrCtITTU096ohBQKrJy5y9p5LAReEBBg2+NcTZE
         ZFw3q3b8xCToEy2dqJw/urN6/TFYWCgxULf5blRA+fgsz7EG7jgdIDNvl/ccv8h2DWQq
         ZdSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782801582; x=1783406382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEEP8Q8hvoLB7y7EezlcQqVBnLjbvMEXaAaoaBQlpAo=;
        b=owF8MGT/cLrC46/MFC9SK5UEnTjl8iIW/F60Fof6LIwCAPgcZC+HPvYYekaA43OScT
         RPc2MPCYjOZmEE3qZkr4OhlrqGwBIaD81LouV7t7Y6mFHPZJWyIp90dMaWf6YantSjDY
         Qm5r6ZrDI6OTMWweRgzj++yoKGV1QpkKjIXNlKRU7PMN+T01FrSTBQnAaZ8l0nZkqSzD
         01ShmJjOQd2nDUZvjAjFe0viDWIHjopIOD124yjqozF9Gvs6ZZNJbpakarBXQ8H0xwa2
         Pv30U8UWASXKm2pbsmk+1YvD6pu/gXoKuXXu3z3V5woMBRGXbuaJiWtbFGhq25BDXaU7
         1BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782801582; x=1783406382;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEEP8Q8hvoLB7y7EezlcQqVBnLjbvMEXaAaoaBQlpAo=;
        b=f+NluOVFR3vuR2Dbxg1IJdJjXPJSQ2whzrgV/2vEOd5RSOQ8DbIYX8EgzKW9/lHScz
         Nd7ldAfTnhH/IjzyZ/6/W4RidzsHDTEI3I+vAWELp6dfOoY15ZTAYzbccB6tIJc61ofH
         Mu1uaA8kVVRuxyq+zjXTd3o42cgnwBOPGKe8LDVH1AIR3UtiJMRw6lNin7EebWrwG9Qn
         KsqzM9GTKiQsmNi5Qhdzhgjervic7gnrShkuBrhdDG/h3TbQrJIfYNeoMXyX9oGhH0rm
         BSLI6aMF2KoEQuuFY79XU30jVjqJoODcwOIa17RnIagasnjOUazX/itfDPCiMmsY0Ozf
         QV7g==
X-Forwarded-Encrypted: i=1; AHgh+Ro6TsD1+6rxSpFlCbyLyScUiBV3FMRMvUX2exnYcyvq/FdR7w4fdyLtArsgAtpLTEV5yfAeS8w62Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0BwktP07tx2K4hW1W2EBJPtp6SBbLZz9fCcIJ7xBMsXM3YWD
	D2D6YTJxGOrd/XVgctfQ5y6wmSGpRNiLMAWTN/Nbluv7PUisTQxyF1HoInXz85Qbj3FxFY50Ywx
	t1KW6Zs/JIawIiF92Qqlfd2fNPXSfmw4=
X-Gm-Gg: AfdE7cnZfcyUNabX8/D6Hqo45iSGhEGjGHbSkvPXNkXzWu8Bce7xYH+S8nf2fEgDaJ5
	AlVH2iy0u/E/SuEfkmyB5A/lH7zsBZxOFfNF9NR11X00F8+E4zrXSDxBlS4l84xTI06afaj1/Ww
	i7x72qDRTe38TLqwzNDQq/67iWsIvR+wqi77vZaRRrVDmwKJ+RtrAjj+c3zqss7MbeIuSpIx1ih
	Hx9M5jUIgFEa4WYEnlaqiVvkzsBjD7wIjzqwUMldSR9WYR5jcu6xk594sGP/5ty8xOcxVZe
X-Received: by 2002:a05:6a00:2e15:b0:847:833c:6451 with SMTP id
 d2e1a72fcca58-8479f47018dmr2157435b3a.57.1782801581706; Mon, 29 Jun 2026
 23:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Delaida_Muminovi=C4=87?= <delaidamuminovic2@gmail.com>
Date: Tue, 30 Jun 2026 08:39:30 +0200
X-Gm-Features: AVVi8Ced6jbKqt1HyRp4D_sOG4-58futT-JPzqdm0-zdlhgW6VjcDLDt-ZhsIbE
Message-ID: <CALQvZG-5g5BEscMY7jE-fzyRVYD4_OZd+_XPKpUrYfwA1=TvpA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Do not instantiate spd5118 under SPD Write Disable
To: leo.lin@canonical.com, jdelvare@suse.com, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com
Cc: linux@roeck-us.net, acelan.kao@canonical.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested on a machine that hits this exact bug:

  Lenovo ThinkPad T14 Gen 6 (21QCS1NV00)
  Fedora 44, kernel 7.0.13-200.fc44.x86_64
  BIOS N4JET27W 1.17

dmesg confirms the trigger condition:

  i801_smbus 0000:00:1f.4: SPD Write Disable is set

With the stock module the SPD device is instantiated:

  i2c i2c-15: Successfully instantiated SPD at 0x50

spd5118 then binds at 15-0050 and resume fails with:

  spd5118 15-0050: Failed to write b = 0: -6
  spd5118 15-0050: PM: dpm_run_callback(): spd5118_resume [spd5118] returns -6
  spd5118 15-0050: PM: failed to resume async: error -6

I refreshed this patch onto current torvalds master (it still applies; the
three hunks are unchanged) and rebuilt i2c-i801 against the 7.0.13 kernel.
With the patched module loaded, i801 detects SPD Write Disable and the SPD
device is no longer instantiated (no "Successfully instantiated SPD" line, no
*-0050 node), which removes the failing spd5118_resume() write path.

Note: mainline master still calls i2c_register_spd_write_enable()
unconditionally, so this fix does not appear to have landed yet. Any chance
of a respin / picking it up? Happy to test a v3.

Tested-by: Delaida Muminovic <delaidamuminovic2@gmail.com>
