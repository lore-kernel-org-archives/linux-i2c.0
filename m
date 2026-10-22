Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653275;
	b=vZWtqrYf/9t81cmr9AspkXYvDx+Z0MJJimaTlpUR6dxz8u3vtBby67uBkQWLwob1obm9
	 pZfi70J9KusNKJVskSiuSq3aqGbLOm/p45Lnjuu9BJlczV/CdhzHTDAguKPPs5XgaCuku
	 CpeU2WKitJgUftcwLC0kM/tHFGvjLvzJqYcjZD+/lKnLwBfPVxp4QA9eu6YrpYaMBfBYc
	 mbe3dTOawCuEuaB34a1ffgJihABORk180C0NvKa01wrj6SvlgsJH9Su10dsw0P0bzOPex
	 oWgH9feJrfWWcVcNcqYRNiFjBxMbNDF1K0/oLwTDKtl9f2LjSoCljzZdPTjvIlFrTDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LeBgHuQ2F+lcGL0HOAeswGNlhahrF/21UKsiSHNd76o=;
	b=I2R/fUbwDya6hRnw2pH4oK7oKxzz/cdZoSdWzuFuj873TrnyHy0s/9/1UArmHSu/54gK
	 MxlZQKhsz9i+MoPuA4PvqHz8kQdn7j/Lj3+bLhGHzaJUpkTSeIMncwjs3UUdidHWMfups
	 BtM0th7TSTZvfz1vAPhHgYhk8iJPuIf38GaxJ3uGvHXITvBQ2iQCGXu26es+ZHq8B/XpW
	 KC5GXjg6QphG5kChZ6PCapOccRruRJ2njfmFtqd5kPEcavwXaOZyiuek8HBm23smqzqE7
	 xSchwOf56Xs5OCS3dIsKqi4x2yjw/Yvxs+9Va7kRxYiV4DOZHSwjYcfTJ7/0RrpsHag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lDNVZ+xI;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA25606A31B
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 07:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA25606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lDNVZ+xI
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-18818daa3e7so20059c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653274; x=1793258074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LeBgHuQ2F+lcGL0HOAeswGNlhahrF/21UKsiSHNd76o=;
        b=lDNVZ+xI4TWk8YtbkTL11n92mW4AB3EEJcGsNKwMrnPi6zNYDDFQGLFaZGqqo+h4Tc
         Durk78e1tFd31HvcAc9zIzRX9DHyAx/IADWbmbXIU8w+lDgNRVHEyKyR+jqxIk3U+uot
         SKw2yQy22Ju4zXIBb0WPRCG9bTtsGCNtkOqU1A0hlE1geL4i+uM58BMz82zrPbZNMeFk
         3xrsCOqmdOL5COho/iEgTPgolIROIIVEPDTwAgnDXjvHficbn/Z4YBODnJ1At2d0bxQ9
         ARaKtFIKivQPgvJ3RL0W894tmTxyooiqbjwg7tcrUiLOlKbLnNqijx+Y1tvG+cFWf0uV
         zapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653274; x=1793258074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LeBgHuQ2F+lcGL0HOAeswGNlhahrF/21UKsiSHNd76o=;
        b=Qi/rxTZ2l3/TgbtDXWyim/akkNTs46btzPFAXU251BAEhagRItqK4dNlvMdAS0LZAV
         LYOuRJ23g9E3vXmGhjvmxDUnQYnw8qMVyELNkCwruxQDDqSOV3UhuJVdj4wb1Ju77jAi
         bFj3vpaSvcYqlqtuQHOI6U1bKVvhiTcG+rVyNsQuWXayqBVjugxm6io4GZHmQBBgAtUj
         iKTrpVCg6sLYd3DjnImAI2fKmKjHlbjon461KytcMjCRr/dEpGYszNqTphATLBS6yZER
         csXePc4E1FYdh8Dam49jExZkT9GfYmh8nbvDp6MbZ5G/Rx2A8YmeA1g4JG659j6rSaTj
         /sAA==
X-Forwarded-Encrypted: i=1; AKwUvBxTZ45SoywvyOEZUJZ7njrLycbBtaLq1S2aIbsZb+CfKNBCiBqUM20Yc2rK0Hd0XfXmOUCz9dSXhTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLonx4LQgWAAmJporqj4Y9vsu5LplfZuqoaXySg7fdpQCaceooq
	XY5UNKvJj6slS9HcEHt46SgdutwdGda3cXm9KQzp1J0mPb8SmbgJSpVk
X-Gm-Gg: AYBFou0HiST08iEoWCER81JZpwZMv6tmX+ca+GqjAqkL/rIle7/8EflSexHF3NtJYjr
	OZFA/vEnwaKU1BUrbg0IM0xSG18UqKp9bWdZgqDkA+nbKMJ+gWPWa8fj/ikTfGoEmC0hFSXdsRy
	xX44+jRXMcBoBnfqf/nWID2XiXyxzvkjhSKyi9bC/FTUdWuiezxX98JD5wJ1papM0/95lVQtrpk
	EmdQg020fyrgNZrY1ZoqbSQakvXSJCPIz9Fau0Y7SRdYumMQ/gfbatqevZWMYKks/J96gjapHVD
	ygsH/GqyF+uGKp7M1hFkT9MIWZD0cruPQMlWHSVGIj+JNCuSOtJCH57mhfYTZoGxDdQZcF5Gwe9
	pA7wDL6jJXBPl1+UrxhQ6nnx4FECs0HBiJBcNHUchpT8rLpewWNS7IXT2Y5i5JMWQZc/BoGAN5k
	1u5HouAKx0/bHscfsr5Mx9tBhNhy/OStchz+ARjdDbzfZJ8cQhaap1PQpMJleK+J+a2t9uA3hDV
	/clkFtnbofN2Mn9GvFX2gxyyGeNbGgy1zavfmdSARD+JesnMMdbSg==
X-Received: by 2002:a05:7022:458b:b0:14e:d0ba:75af with SMTP id a92af1059eb24-192eebbb953mr2935796c88.6.1792653273782;
        Thu, 22 Oct 2026 00:14:33 -0700 (PDT)
Received: from fedora-x1e ([210.89.35.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm11112321c88.13.2026.10.22.00.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:14:33 -0700 (PDT)
From: Saikiran <bjsaikiran@gmail.com>
To: loic.poulain@oss.qualcomm.com
Cc: rfoss@kernel.org,
	andi.shyti@kernel.org,
	sakari.ailus@linux.intel.com,
	hansg@kernel.org,
	bod@kernel.org,
	mchehab@kernel.org,
	vladimir.zapolskiy@linaro.org,
	jishnu.prakash@oss.qualcomm.com,
	birk.skyum@pm.me,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH v1 0/2] i2c: qcom-cci, media: ov02c10: Fix camera power cycling
Date: Thu, 22 Oct 2026 12:44:16 +0530
Message-ID: <20261022071418.26895-1-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The OV02C10 camera on the Lenovo Yoga Slim 7x can fail to restart after
streaming stops. The CCI runtime PM callbacks gate the controller clocks
but leave the bus pins in their default state while suspended. The X1E80100
device tree already defines a CCI sleep state with pull-downs for the bus
pins, so select that state before suspending the controller and restore the
default state on resume.

The OV02C10 driver also enables the sensor supplies before MCLK and disables
MCLK before the supplies, with the required reset and startup timing. This
series fixes the power transitions without adding a regulator-off delay or
runtime autosuspend workaround.

Tested on Lenovo Yoga Slim 7x (Snapdragon X Elite): 20 consecutive Kamoso
camera open/close cycles. The sensor entered runtime-active on each open and
returned to runtime-suspended on each close. Both modified driver objects
build cleanly against the running kernel configuration.

Saikiran (2):
  i2c: qcom-cci: Select pinctrl states during runtime PM
  media: ov02c10: Fix sensor power sequencing

 drivers/i2c/busses/i2c-qcom-cci.c | 14 +++++++++++++-
 drivers/media/i2c/ov02c10.c       | 20 +++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.56.0

