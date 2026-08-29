Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507052E6CB8;
	Sat, 29 Aug 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013354; cv=none; b=nvTKGkCU34wO5/4RkR+0O/5SuWSerTOeWQya/fM0YtpLX7WILBa4KI02ladaQ75/BMdQ4B3aMg8eb8SVsh+6uucFiyveyG0p3OSP8evAnWI+rdKLjRdpB2+V1LKRPK4/Xq2TmVIgqmP/QsXFJUfJb3a1/5RgHe0dT93QDY39FsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013354; c=relaxed/simple;
	bh=kfLo9xopLkotzBk/sMZzgWP/0uT9bPa/ds3NhpIxaQc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YGH53XJFK16BTY+Nxvl9CGaEaqbvocX55XD5B7/eMXJ6VKlXrTK43FxGOhvZcsvhf4jKrstCVGCypCBgnJWimo6qppaRsyZrzy8hpFxJKrUta8suBbO+nXRNhRyJpHTnmG6+v3C9LHMncuPUV8OoBVh9/mjZuyrT7OF1GVwGqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=orcOEPHH; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="orcOEPHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788013339;
	bh=RkJq1e9fQg4XVMb0XBeDfL6lo/lXf7u1ACzmwdvOUzw=;
	h=From:To:Cc:Subject:Date;
	b=orcOEPHH2MgXWOGot4xRwl0fsBeVXZ2xDsdymwhV6e8lbaT7+de9ER8ZCRfEgKbCT
	 fIPP9Y7iS7NWrk56WNeWSc1bEA1z+gl8BWBRbAsKRnrgOaTRMfStJj3/s7JhXmNHXy
	 AoE4Sn9eLiIljco9zpDcyjdgAb3tNxjRG8gzG9aY=
Received: from LAPTOP-TKBJAGN4.localdomain ([2408:8256:2d02:da31:a433:ae59:7369:ddb4])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 57B20AC8; Sat, 29 Aug 2026 22:21:59 +0800
X-QQ-mid: xmsmtpt1788013319tvsbvv2c8
Message-ID: <tencent_7C427B4AC09AA718A8B2E56BAEEC908CE305@qq.com>
X-QQ-XMAILINFO: NR2AmdDOCZJo4DgL4qiwP14GpP+gjVpx53cWpSTRYyrBieGB1bveR9J31SDWmB
	 vK8PDGBwsO87ycxcZDeDyxihf4S5I6UKZnVYbJQiX+CMwHlFRWACqTEypvZ8dNqNRX+iE4xuMYqI
	 4XwUG6J0mhWgqTqz6xGKhAM3zl77+gnsFftlCiZ4aE67PrDhuvIk0boDNAb0Qtf2/NUVq+j3L1QH
	 uyHrEH3ySKpxVzVheOMAFqJFK4hBmQeeB6qcv4Aw/Il0M/vroeghSsiOd0y4ZyHSzH/OqYRnsAvR
	 Z3F9yFK44sjbUNfR3ftsDBIVaEewGSJMWl9qjuE5/XVUUnukXO5n/lfpZlUGnQTI+viBpu3M53Fv
	 wZ+SHk1dc2rzFbt+SKWYIREpkKQQ8kNti5NPQ4KJoodum9Yq/FrbPGDnRKFZXmc8rlNzYUcSZZ6H
	 1hqZuf2vp7rl2vsxERUSmpY/3AtTWuq1Nwu+qGxtJZ/20d9PNRcH5PvCHDfWNe3AkKoo1aib12bN
	 4etzAYB3WBaNZbxvEwDbwdCk1QK+N9VRhWDTRswFbZXkswy3KBd4e65kPQFEiirw/EqGRGXUmvp7
	 pBk/Z2O2LTGM+JeehzjIRNvIOnZaQ5Z/OCEXIU28y7CO5Ef/IbYokMYxs2G+8MNsxv0P2jqnFs9l
	 tbapXhzHvFuLcR4EWoa185MJwIaWXMcqIbxOek+v8wyoN8jmSIjW9qZz5zaW12YTiOrfh481BTL/
	 2jr+74XSRoRQ8LQcUBd+a0I9HuoVn1tCL+TF3xznOzU53pRjJXmvC/D/2RiPYJZ3QmUljQfzEQ0I
	 6I+9CXVW3qx6cQyVhMTI9aKEgZ68wyiMKR82+HKP0uxatqiuGhnj+HU84y6HrA4GeZlmyd9p5FfW
	 tepzCxv33tNm7/kwK6GIyuNz1AagF9DIfA5QNy2mlN2eFeP0Pad6FosuuCTk0Q8Zb7uD57BHonLA
	 0KtR9zKGHezvTT0fOeXvIhiXC1xaOsE1s3Fqq145iAzv5QzfKHu8f3VTPssCC9coq9K9ktF0HapJ
	 vx+kTbreGLP9R6FZgDXz1NGxful1e0Zt1X4gn09TumzUfBzJuCtQxzvNRTaSLZXBIy0rmZLA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Haobin Jiang <lemonoutput@foxmail.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haobin Jiang <lemonoutput@foxmail.com>
Subject: [PATCH 0/1] i2c: imx: honour I2C_M_IGNORE_NAK for write messages
Date: Sat, 29 Aug 2026 22:21:47 +0800
X-OQ-MSGID: <20260829142148.10536-1-lemonoutput@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi,

This patch teaches the i.MX host driver to honour the standard
I2C_M_IGNORE_NAK flag on writes, and advertises I2C_FUNC_PROTOCOL_MANGLING
so the core will actually accept it.

Today the driver has no hardware "ignore NAK" bit and treats every NAK as
a fatal -ENXIO across all of its write paths. There are legitimate cases
where a target NAKs a write on purpose and the transfer must still
complete; the standard way to say so is I2C_M_IGNORE_NAK. One concrete
in-tree example is the ATECC508A/608A wake sequence in
drivers/crypto/atmel-i2c.c, where the still-asleep device NAKs every byte
of the wake token. I mention it only as motivation: the change itself is
driver-agnostic and simply exposes the standard flag the core already
defines.

I did look into the earlier work in this area before writing it. A 2011
mangling patch bundled NOSTART/REV_DIR_ADDR/IGNORE_NAK together and did
not honour the flag on the address byte, and a 2013 retry-on-NAK patch
retried at the controller layer, which is the wrong layer. This patch
deliberately avoids both: it implements only the standard flag, leaves
the NAK-vs-retry decision to the device driver, and changes nothing for
transfers that do not set the flag.

I would appreciate any feedback, and I am happy to adjust the commit
message or split the change if you would prefer it structured
differently.

Kind regards,
Haobin Jiang

Haobin Jiang (1):
  i2c: imx: honour I2C_M_IGNORE_NAK for write messages

 drivers/i2c/busses/i2c-imx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)


base-commit: 04e9bf1648f846976b543e91c1838a712433772a
-- 
2.34.1

