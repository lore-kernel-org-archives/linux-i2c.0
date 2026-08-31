Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA946E017
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196932; cv=none; b=IVg/5vk5POU5STwQB4bZGorESZGgtupk3KUKOGXrAz3i5SLAG8lu4GGjGopEFwRQxx223FVo/hImL8Lnwok0XG4yYsreYZInp0Mz/PdI3yKYlCXNpLjg2+9jEnOSlEgy1pEK0wIHfGff5DHOJfoQPbHPdrAqKQl5+yU4m7TstTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196932; c=relaxed/simple;
	bh=3wB4bhyF3dA1bh9xcN6iss5ZuHBIuPUsoPXwm+CSnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpQ/05eqstHWH3guMxYP+4boAhweZ1ju76r50AL0yUKHYAqIAExH3lYKqxIKlIFim1iq8eGn0HnHL4WSKrsDgNMDeABRRlwZ87WCLdPcp8oitcTWudd9XHpJUN2F3NIWt0qDMeWd37RwBeEN93kwMKidkgBFp9ouGxqALTOpXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqzB68yq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqzB68yq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so5571777a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788196930; x=1788801730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9FyKBZk/71rvgbCJsBivicwYPHK0A7JeoLDX92n63Y=;
        b=SqzB68yqJGLAXwKuSIPqfvOX2TWqMQuTP3fd/HcC1Ci2s6F7mmX+kvhwDZonyLfJb+
         HMRGfV2SDh4y7EGFaeZosfb6Ugq8+8B5embtibnOb+SBdDHUIh5IIRUiAAzAFUhFjnWz
         lZ/ui2lRC1ppNkaRFoj4zpfB96g85H/jng6rkn+bnZaRUos6voV8PeAAVxPU+2vfOKCq
         NBcGR56lozV1DAQHafWqrTaSXgQKuXUx7VHiQURLzR/oBoWqMp2H9C35c1W76emVNeux
         SKQ3/lMRtvXIS09tehyQ5lQFY0WrQ7GmR5E1M+ZjPHON3ORPe8wh9E/E3ecom3sXoSkA
         Polg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788196930; x=1788801730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9FyKBZk/71rvgbCJsBivicwYPHK0A7JeoLDX92n63Y=;
        b=b3Iax2cAGnEYVDTFQCxHfjf4udUXwVMJAP0d2PY+njrzIz0J1tiGNDbH4O+JFNku+x
         5buA+8y0J0j4SFpMdRziAJolLcZWUmRlg8HrdFmuKdzwGs6E1mSIkH6ua6SwFMfgpgbG
         AH9YKGcdTVbB33bbzohDFCGcG6Qdag6ciR5I60NPpQjsxfVMIzxcPN2eS8FePp1B3Ine
         GDcqNHRlVBQA+TOwJgzVJjiMrAKTvYMaI+VTcE8p044MW/9BusVIxAAB+gLlkzn3D1be
         87OmSzQLfmc36nkeX/mcW2gpAAsbWaoE4zxAjklqM+IU3yzSXXgkklRB22xrFGFLzccn
         r5VA==
X-Forwarded-Encrypted: i=1; AKwUvBzNLs78bBdLKjGZmgCLJk3uSXiImllEbFA8HtfkqMtGPMW4b5Ndn+9STwvNrmV4IWzYcnoKBwrU5r0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGHSwUPtEfnLVtW3YxXa6GHxU3WMKPXYk6yuzkvvGHnhXo6ImR
	L4AQK2gfPTk6Yi/t+MScqLgtq+ELusx8QJPFnBFLuzMmVTD4DuTjyLCXnAFg291n
X-Gm-Gg: AYBFou1MPZcEh3DvxgE1nINbwuSMJ6Iv64yXLJUWmpe/GtitfAhwJrJHg1E6/446r/x
	AMMlXH4dl1AByTZj99nNVUfi2xW5MVPRzXKLs2bSFV3ikEUBUKmAp9bWfTI677A3TmxqOQDAyo+
	nHAVf7ph1pUE5MAPqCVru9vS0QqYhGS4BTKEj/xislP5ZpppClypyTddmNQnerA0gz1cq5qfp2c
	EHkb41JgVcmM5/Gj7Hy9JNn3n+tajWY8LF9nDynCoJZPjMLevpPCUf1fj/pTe7q9LzEbt/2WGm7
	mfwduxSTQpp8zMT4udtrHIeiAU9pXBar2zEunnnP10vJSoj6FH9Osfb4j84upf+OcyLLqKmZfT7
	OtMfN2sUDoABxxVYiJOP1QrzUCjRVKikvtMkwVTdeve+mbmdQkyjVqeN1AuSrlqRMs+BGbVpEEg
	sgCT8IExSUUkLj2phtosgm9J5xy3zuEe6Rde/jHn59odZyIixUuW7iuxpe28ya5s0wMBRhYs4nK
	YolckHEoLsf4hcjZhQgJje6V6SwIgh90qt9T2UVDrEYjKaIb62Fvs2l3yFQnV0=
X-Received: by 2002:a17:90b:3903:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39907bbe018mr2704859a91.8.1788196930354;
        Mon, 31 Aug 2026 10:22:10 -0700 (PDT)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm36241012eec.7.2026.08.31.10.22.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 10:22:09 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v8 0/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Mon, 31 Aug 2026 10:22:05 -0700
Message-ID: <cover.1788181174.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent firmware-node descriptions are not. Convert the
existing lookup to generic firmware-node operations so software-node and
ACPI descriptions can use the same property traversal.

This is the remaining I2C prerequisite split out of the Time Card series.
The channel-node leak fix from v7 was applied to i2c-next as commit
385c7af4e3b9 ("i2c: mux: Fix channel node leak on adapter add failure"), so
it is no longer included here. The first patch factors the Device Tree
lookup into a helper without changing behavior. The second converts the
helper and node lifetime handling to generic firmware-node operations.

The existing acpi_preset_companion() call remains in place after the generic
lookup. A separate reference to the node returned by that lookup is retained
because ACPI companion setup may replace the adapter's primary firmware
node. The dependent ptp_ocp board profiles will be resent to net-next after
the LED and I2C prerequisites land.

Changes since v7:
  - Drop the channel-node leak fix now present in i2c-next.
  - Rebase onto the current i2c-next branch.
  - Remove the firmware-node type restriction so ACPI firmware nodes also
    use the generic lookup, as discussed with Peter Rosin and Andy
    Shevchenko.
  - Retain the existing acpi_preset_companion() path.
  - Keep a separate reference to the generic lookup result in case ACPI
    companion setup replaces the adapter's primary firmware node.
  - Return arbitrator and gate nodes directly from the lookup helper, as
    suggested by Peter.
  - Describe the conversion as firmware-node propagation.

Validation:
  - git diff --check
  - strict checkpatch with an 80-column limit
  - x86-64 GCC W=1 object build of drivers/i2c/i2c-mux.o
  - mailbox replay onto the declared base with an identical resulting tree

v7: https://lore.kernel.org/r/cover.1787502619.git.ahmadexp@gmail.com/

Ahmad Byagowi (2):
  i2c: mux: Factor out channel node lookup
  i2c: mux: Propagate firmware nodes to channel adapters

 drivers/i2c/i2c-mux.c | 96 ++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 46 deletions(-)


base-commit: 1f3e66348d2527c31b9bedb0b4d9e28bdad9bc83
-- 
2.50.1 (Apple Git-155)
