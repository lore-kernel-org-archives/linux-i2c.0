Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111D3B9608
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679587; cv=none; b=O3OqddUyF8EGJH+KonaLyUYjqINWcweE4hla3ejh1dEhMlCi3L6rsP/hIdzsBlApP5wYFWc3aT08dpn6RlyRYVVBf9ByuiuhDTc1v1xrKJarNSgUl1zDjUTcgVXtUT83BScPtVWi7Vn+czs/nBYG+3XDTu8VRno1Qthjc1VsuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679587; c=relaxed/simple;
	bh=njX4kjH9VNfVjsyF7DQlInsFhd4q08GMPgkouSTFro8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOmEySimLYIxzj7+og/VqW2AzjXOGOoG9OGHj8g6kcltUKtdHud1cpGe86QIugoi1K0Ox/ZpF3cbycoyasXnsv0o9LIOeeg99kDLagBiZNQLvJFXeb6qWtSYns+pTN/HCP5OHdDroPWoBWgXPnbUrksLN7pIpcfDfflwCd18gMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDWipJBX; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDWipJBX"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-138501f8c04so2884852c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 23:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679586; x=1782284386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXbJQhUMuKVvQIG2xqPeUT189Ia+/U2eNTBYjldFsPs=;
        b=kDWipJBXWHt0juL1Oc72ddG3DNlGF0xYFo5NSq753gubgYql59f7LMd/eY4f9B6Npu
         0lhTLKGTqRMXl5EAY3Nu7G5imYYRjFLFy2AmI1AAAufFaHGQwXz9IF882h/VfY6azYM4
         PILGGqpZck2NmtdvcIl/9SZdGkemAZjlsoQ1J9Dy6m6bN9AI1/UhhwoDzK3JwdgPO6Xn
         C1T3jvPSg0/wmsc+lafZFrZ7luWdU8MYL13BYGab2nFJwGDKN6Lq+2FgyyJE6GBazJUc
         Q7Q1yw4AD2UQV2aCjxtpZoJp3Rrgss3pbDdg62a32Fbj77RWB2uI9rNpO3y8cKOk3SZT
         NkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679586; x=1782284386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXbJQhUMuKVvQIG2xqPeUT189Ia+/U2eNTBYjldFsPs=;
        b=lFCOIunmSCuWL8UyJyclV77SHQyasVCLQ3MK98VAP4/QDWYJIwCM17CZI3F0ipVL8O
         9BZ+f7FqBdVPbAhcGZaL1NJ5v5GrGhfZLCa8JNibTfcTBY2lEoxYFH43s/O2XvLgTOUe
         gam1PawswwvWGb5GfXd4/KSjJ8jVyt9BxscC9KXQ5TWgnNza8P8gMZaKCU5JJeEYkSH7
         PD62Y4Oeb9QmxHlg0z1KmYXZqTpHtVr2GzxwT2O0F8m4fY42BkKQgApqD7YLkKWhPGwm
         70FMpYBIQ9F6XYR4qYkPOI1Z7TvF7ABbmyRt24aCsNU5uSCb8bsyY8S25Drzlpm5Fpdm
         3bpg==
X-Gm-Message-State: AOJu0YwKDtrAY5otNlEUug2mo+nhUZniK/98jry5yEFhrIAvOJSJRYED
	0RzKo+7gFPUHZvGOlpRb4KqYZVwX3DQiKZ28oAXLjPUs1cyMYWmLGQc5XFA/e+F1
X-Gm-Gg: Acq92OFJJFawc16DV3Sq9g7Kkmcnk86aec7L1F7WSpoYQ1/boL0GcqqQ5iC0GoFigaj
	7Wsg9jM1SsTerJxfv9ve6MOnu1Bldh3UwDNpsUTdFWtkrLsqwxTiyiBEYhWG22qh96DWN3kuBM+
	wPV5Xio0Rzy/cMsnlovoaJybvF0brznWAnLeJ5TE5CA1Lk0HNgn1T2z1YTBz4CowWNTKqqYbboA
	LlZY2uUN0VMHdoiTUp0GVxTxSI/vQusIe/YFHTygsJc5Glv9eRHs93dW9BtGp26Fld/qazGk6+c
	jKp8he6jK6hB0HzTnyyNxk7qPvgNsuem6sgJy41uy2i72rqLV2PKHzvX0+s8JQpVyN5m0U5OC83
	hmNfiTXUZybAioWtSTgy3buaxO+XdWBEB8DiVDF7v7zLPxcljx/Fx8a0uKvGGEdq16NcWd5FiKW
	VFS5Xfkp5zFH3UIPPLC4KDv+GWcsYrNd54bChRshfxR4F3DeSn+4rtO/JsWLUtZfBEv8aoRhZNu
	S0l9K/yR98JoVSNvM+iiI4CWZtu6zHgVR3956tC4Hkg/cPUd0zubT3ecez8i7IWC5YZJ0dGe2CH
X-Received: by 2002:a05:7022:fa0b:b0:138:50d6:7ee8 with SMTP id a92af1059eb24-1398f6720a9mr941357c88.16.1781679585497;
        Tue, 16 Jun 2026 23:59:45 -0700 (PDT)
Received: from hardik-yoga.oryx-cobra.ts.net ([2401:4900:1c62:151d:8407:852b:5db:1408])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1386f20ad25sm14118376c88.0.2026.06.16.23.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:59:44 -0700 (PDT)
From: Hardik Prakash <hardikprakash.official@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	wsa@kernel.org,
	andriy.shevchenko@intel.com,
	mario.limonciello@amd.com,
	brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	linusw@kernel.org,
	nathan@kernel.org,
	chaitanya.kumar.borah@intel.com,
	Hardik Prakash <hardikprakash.official@gmail.com>
Subject: [PATCH v9 0/2] i2c: designware: fix WACF2200 touchscreen probe ordering
Date: Wed, 17 Jun 2026 12:29:20 +0530
Message-ID: <20260617065922.26004-1-hardikprakash.official@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 reverts the broken v8 patch 2/2 which caused boot regressions
(NULL pointer dereference and probe deferral loop leading to CPU
starvation). Patch 2 is a corrected resubmission addressing all issues.

Changes from v8:
 - Use acpi_gpio_get_irq_resource() instead of open-coding GPIO resource
   type checks, eliminating duplication with gpiolib-acpi (Andy Shevchenko)
 - Remove gpio_dep_ctx wrapper struct, pass list_head * directly (Andy)
 - Add const to gpio_controller_ref.path (Andy)
 - Add NULL check for resource_source.string_ptr to fix crash on hardware
   where GPIO resources have no named controller (Nathan Chancellor,
   Chaitanya Kumar Borah)
 - Use acpi_dev_get_resources() return value properly (Andy)
 - Fix all error paths to call free_gpio_controller_list() (Andy)
 - Change guard to #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
 - Remove erroneous put_device() calls -- acpi_get_first_physical_node()
   returns a borrowed pointer with no refcount increment
 - Use LIST_HEAD() macro, split adev declaration and assignment (Andy)
 - scoped_guard single statement without braces (Andy)
 - Remove misused Reported-by/Closes tags (Andy)

Tested on Lenovo Yoga 7 14AGP11 (83TD), Fedora 44, kernel 7.1.0-rc5+.
Touch and stylus fully functional.

Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221494

Hardik Prakash (2):
  Revert "i2c: designware: defer probe if child GpioInt controllers are
    not bound"
  i2c: designware: defer probe if child GpioInt controllers are not bound

 drivers/i2c/busses/i2c-designware-platdrv.c | 133 ++++++++++++++++++++
 1 file changed, 133 insertions(+)

base-commit: ef76a3a28c79b628890431aa344af633e892035b
