Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C803749E2
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595379; cv=none; b=eoY10eE2SmMre4UO5+6df1uhD+eRVhB1TSKieBwX1wOgB46/xa1vGPYDAbz39mDF6IkYovADL+TQw8qgEErfSgXwyJ5/aWjhRQuXtsSsd+KlQPtM5Wrb50W0UMQiIuEEgF5Emu+vK0LP/EQFYSmZ5NkR3UHEBirq8qcSE4tCvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595379; c=relaxed/simple;
	bh=Xf/vtFg9XHDHbpj8BPPhagxrEjOllb/lmVYHdVEfkS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhF+kq5BRUKsTuh/Pt08TOmuPgm3oozL/L2yKfuSdI3Ar10JC5tBu8u7ghnb90L9qOIxKuIYasQjckL0ky5F8y4WUgiLs5KAAaYGMzN5WYK263dHcb/HfDJ17u9Zkbp8lHLiFnfVNZyhpYegXnVrR9avwzkPlFV16vWFiwH900Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBUccWLD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBUccWLD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d5335cf904so29739845ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787595378; x=1788200178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYyCkSIU7eKC/04a/F6o+tJf0qYZ/8bHxi+4hQtbxFM=;
        b=HBUccWLDysKMp+NrgjAMQEdKJcY/I8848f3uNqLceuHKJ/19dyKJfgZiBmPZu9lPhO
         ZyJon+C01CR/XfQ1TVYHfEFlCKLPnRzmo35rFnitrge2KE/VVU/RHXvaZG29olQRNvmg
         DuoWiiXzJSsFuGNTVUtRutDepLedTr1RrSteuC/xhe+9bUyKIu5EsNJXm2qpixygdWIk
         tBXQYa8P+KQsMbBDc2PrCuTZWexSql5HkufDOzxiP+Oa/RoqzT3O5d1HsIDrEw39jbqe
         rPYjVt6aOLk/fw988qD2vewLf9ay/DIdqm3r9D4m4NE4sCVPbhc81q/1N/siy6KFyMQK
         iIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595378; x=1788200178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYyCkSIU7eKC/04a/F6o+tJf0qYZ/8bHxi+4hQtbxFM=;
        b=FXyE3K1px0RQsQ3JiicKF00r2wC2Hx2ZtHuYjNfYh631J6wDjxL8Xy0suGcEwBvxlz
         jYyFrNGEClgSdStBkApSxanRYUs/JvR49FgQvBFrq6dPnfVk5vxLvsKyZ/JFj/erSB4A
         c0wBmxmgLmL6oWyxbBeslsWmBUFB2lz/51oAAV9X3XtMRAqW3J+33WGlqciwFfY0XrvS
         eF74jSbwA9ly8KlJ5H52w6Pk5dlr+gM5VVSTHaP3XqWDeWYM+EfkCmzkIzlaoQOeAV+o
         /R5lL3kr4gilcNJ/SpvJ77CzqxTwdH4THJ4tAC55kQCb+kmXWFRrpTMkk/A70yGIgIlE
         mpiw==
X-Gm-Message-State: AFuF++kcTcfdDgZVz6K+wRF5fapeMTG8SMpknZoyaMMCl4CdT0/BMYf+
	s8dgI2wDAXHjhxy2gXS2YbcIUK4kz28M9jRskMPlUG+SrD7Cql6wFj7N
X-Gm-Gg: AR+sD10PUp/4gnB3dt8EPjAQq2WwcAFOMOJ3tj9ataWuL9ZJB+cRShuwE6Az14KXII4
	Yt7yo8fzl+0MNe4jqaCcNbBi9TAeqqobn3wmTCcLmm48yUvpQuV3vOzTsKH8dxEUxpMvpwJSa5Z
	+2LY6n8cJf85GzBb4X4JuWR1Nq+dU8/ssSRdzSI89xGeTltzkwnXZAsIBL+TtXqkjNOmOTORr7k
	jxqYYlU03vdOi06FQdA/9BfeViEjNTMVdQtO5doAPwCd1AEJVBPdxx6FR29xir/cRlC+2kLqRNU
	1vjWbj3i7iZGLCb/y8B2Gg+e0W5J1MoNBknUOkctIdd1UGPPcdd+snTC50aBVUlBtdhO93Cjh8G
	lsmch+40AZdS83QxTOaco6+e1rcoKg50kDqWSbruGU6/td235dShBhjf7QzSpYlU5tnT/SCtGKF
	mSq2B73Iv6Ck2JwK4kSXNGI0LSynPUU6i57pKX1mrD4hBMwx4g+ma9fw+3M+lG9RVhA6pL4iMR
X-Received: by 2002:a17:90b:3985:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-395c357d3a3mr48892418a91.15.1787595377740;
        Mon, 24 Aug 2026 11:16:17 -0700 (PDT)
Received: from InspironBook ([23.26.139.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm446080a91.10.2026.08.24.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:16:17 -0700 (PDT)
From: YuXin Xiao <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Tue, 25 Aug 2026 02:15:59 +0800
Message-ID: <20260824181559.146133-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
References: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

An independent 2021 report from another Dell Inspiron 13 5310 user
describes the same intermittent sticky behavior and identifies the same
DELL0A86 / 04F3:3185 touchpad.

Link: https://www.reddit.com/r/linuxquestions/comments/nsso5b/help_needed_with_sticky_touchpad_spoiling_brand/

Assisted-by: Codex:ChatGPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: YuXin Xiao <xiaoyueyoqwq@gmail.com>
---
Changes in v4:
- Add an independent public report for the same model, device, and symptom.
- No code changes.

 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
-- 
2.53.0

