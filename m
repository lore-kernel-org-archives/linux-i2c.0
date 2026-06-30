Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A432DCF41
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803203; cv=pass; b=qWHImGNzAhpOOCn/qVFd0qsN2sEkfPYFCRbzSaaJikVq4NOFiEC4VZqEIHBSQUcOQI2D4OJMwQ2tQA3DR0nJski2lE/ZJjSPgpP1PLeIVDHm7XqdmKLnqFkgawW2O40LbpgMwhg8YGG93hRHOvQRebG78n1atUDGtjirqVj8E10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803203; c=relaxed/simple;
	bh=TTPpw2tPJabjQqsI1rZCNpItrW0CyPmWJA9VsvH6Ca4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lLpYrHA7Qu+Qgf4aWumgbR1Gvvj83Iu+MpCEZK5tJkesmRcDebLEKtm+aVrIZZRBLGUq0T1F1cvtWESvENhFO0dA2+3GzqRJpXTwpuzLvLXvAA6qsgYdQiRrPQP6DAqVtL/AnNi+S18Wq1QMAVErIEG9SWK4D5znboX0bSMdR5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeLLUih2; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeLLUih2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so2519870a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 00:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782803201; cv=none;
        d=google.com; s=arc-20260327;
        b=azQM4yKLcpVNzil9RI0wzd+yyIgC7TfoTb+QF4KEdrdXZeslXkYsKWYvsDmojzcJBV
         cLPAgjcseIvgh54Lt+ZGovR3gpZR/bFBZUeLWKDvmVDNWpPnTZphar43WamqgKOhROzz
         QCP5aCV4mRl2uwdMTGUvQmgmXPrqBbKBcokaAFtKl9moTmBWWtjpG/2MnLcbO9IDHz3m
         uIGC7+5gX6Z9jX8VAoy6IyTNtpsMDHYM0QLYj0jL2oOi8PPWO+CjDz+I0wXEBeGwZZFm
         y+tm0vof/RVkjQn4tosR78PIThfOVXO+wZenTw/JDuF9bnh0IaUqHDoPwnrSOTAEXvex
         wZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=a1zXOtS1lGcB46+233WMS8HtWNMltCjgRC5QtegikN0=;
        fh=eJbUYNM5b23LYzZvOWIGEq0DwhDDMIZeKpO5r8WJYUo=;
        b=TWaI9vDqUNbhpoWHBBj1/vaJz2eGBXWwK/2b5RrbVpp9Wr0WkIDi1lic2CZoJ53LUE
         VRYM13tyq6gau/nCvd/JKi9beu96LJl/tdsO5yGnvN/vPSgW/C8vReDTKGlJlkaFMgOD
         eLZjZ5q1k4Ya5/4qoqQVH/tHRvDt/mfDZb0ZpELF9Rj+3k3gPSrwZgrgulU7Jq4Ca4WP
         NDwiMf4JsjvieJlOBFjo/pr86rpnF9CpgCACwFQzx7uuf8rDXxwxYLW/9vU8iNm1spZe
         m9MqvLlPvg28U7qj1uxcrf0bZlm4ft6rTCBwWhpOka2HImK4Dy48GrDhlMAvHOwNcoQS
         Z1qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803201; x=1783408001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1zXOtS1lGcB46+233WMS8HtWNMltCjgRC5QtegikN0=;
        b=PeLLUih2aXaiT7DbdC8sHYNVvCxPB1VT1eeBHiHoDXaDIVRTVTxFHJvp0+fYHVoQmh
         3yS/UeEJiLaSI89+4TX1aeF7xs3Fh1YwspXR0kbC8q4RIe8SgI2HKT3jrYdf+b4bTYZg
         iuBxO269BeO26UkNwjcvCvzLJlGryJMfPuaqSZES2RzepSfUHqxDcyOy1ZEIU8HByyS9
         Iwsax4XJ/e4FDk1DZsx/3Z/zULBbk5UHsDc19S5kuQZA4HYDzH1aYso3B4l/hM8wbeoZ
         y4QjNvQvG8PSonX41Eib7dvr/2hKjg6jdKcNinLNxP+LERQJ2LgSWCAba+znrApzWddZ
         FIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803201; x=1783408001;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1zXOtS1lGcB46+233WMS8HtWNMltCjgRC5QtegikN0=;
        b=itWa+kqdQA5jT1yxuDlDWYBoQFqmSO4Zy/Q+PW8y19pRk1bYZpDijrj6+kKlLcXqEl
         RUIkUIxvnnnfbC8Mb4h4By9FQFQL25UOQ3bn+E874lCBjCWF3XpKr6x9pfVzNbBobq7E
         XnhYx6vREeFTXg+r8UjDYOOkgY+x/8iPllZOKx7y/5R9h0OT62Yxs7kOgNfY4Hky3SrL
         Wk/0SeOY8hbaytJMLX7ddhcAeDrCClcCtKrmvqeW2NC16YAYGeb5dW4B9K7S0Y/vkX+1
         Ji9TcOQ8WwXQX02m0XCsUsIKaxZgwzJHUIiPBO3azy9mAHkK054l50g1tKIqeKNGFUAA
         iUMg==
X-Gm-Message-State: AOJu0YzsqgcmfNOd0XWcirYfIgO9qHE7M5dQEapJoA8d9+Uq1yTONjVN
	Pk2fzYZlxVN81lScRIdLPG5uJzOi1LC8HupDXeF6YLyVkNat5f6aIZ2UA0Xnpkkpx3k5QeiAa5T
	YtG/Yk8BpxkpFao0ld8bmjTmnpiBYATo=
X-Gm-Gg: AfdE7cnt/hXi5nVMgUV+WxtBRyteEcduCH0ZKMVTpgTwWdONFXgdFevynQ0MsubQTI4
	tngm9Pw5+pMK7A9hZL9dUocyf5LP2Oeh8Cu+khd9KABG9KuHjRowzbbIGO+IUyI6FYDTHmTtphK
	vnWmaCAH3LZqNandRgQ81M78vdLvHVJ0hBhORojxfdnilhTKXJ2yyJNW5hDP8wyfCtst7dhFVWi
	gkEx5zq3y2iINBo8nvRBqK2kTWi3VkAxOdirTT8Jd4gAP1gsXJuIRSDLLoXsjABgPtVw5XL1cX4
	lkLj9gA=
X-Received: by 2002:a17:90b:48c8:b0:37f:d1e4:2a32 with SMTP id
 98e67ed59e1d1-380526a7796mr1784997a91.14.1782803201463; Tue, 30 Jun 2026
 00:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Delaida_Muminovi=C4=87?= <delaidamuminovic2@gmail.com>
Date: Tue, 30 Jun 2026 09:06:30 +0200
X-Gm-Features: AVVi8CfE5GC10eqoaJWhNm3LwgFRrXmqlKPCzQZn3rN7X0qgYr-zOF3uk_3PGgo
Message-ID: <CALQvZG-F9_69jWX4wvvWLxrMxWqVFM_dcR10noNMEUzp8QBg4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as
 adapter quirk
To: tinsaetadesse2015@gmail.com, wsa+renesas@sang-engineering.com, 
	jdelvare@suse.com, andi.shyti@kernel.org, linux@roeck-us.net
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested the series on a machine that hits this bug:

  Lenovo ThinkPad T14 Gen 6 (21QCS1NV00)
  Fedora 44, kernel 7.0.13-200.fc44.x86_64
  BIOS N4JET27W 1.17

This controller has SPD Write Disable set:

  i801_smbus 0000:00:1f.4: SPD Write Disable is set

Without the series, spd5118 binds at 15-0050 and resume fails with:

  spd5118 15-0050: Failed to write b = 0: -6
  spd5118 15-0050: PM: dpm_run_callback(): spd5118_resume [spd5118] returns -6
  spd5118 15-0050: PM: failed to resume async: error -6

I rebuilt i2c-i801 and spd5118 with this series on the above kernel. i801 now
marks the adapter with I2C_AQ_SPD_WRITE_DISABLED, and spd5118 declines to bind:

  spd5118 15-0050: SPD Write Disable is set on adapter; refusing probe

spd5118 is loaded but not bound to the SPD device, so spd5118_resume() is never
registered and the -6 failure can no longer occur. The approach works on this
hardware and is cleaner than blacklisting the module.

Tested-by: Delaida Muminovic <delaidamuminovic2@gmail.com>
