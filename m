Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621111DE8BB
	for <linux-i2c@vger.kernel.org>; Sun,  7 Jun 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820464; cv=none; b=gJk5+IZjghqp2t85JNi7MQssuHtKWe6/7gsJwNuWL7UXOhahdHRfFTJw4FVmIjVsUQEk8eYRyUhgjL89Vt7v5K7j9KFHuM1ipKlX7N2gPBE9n1cm1FL/qMAw6t9aLwAtbwvc+tzR9bEMdirBOgaWPl9cNDo3uLegcbtY6/JEhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820464; c=relaxed/simple;
	bh=rATwyjdaFtrJ0McnHdAuGN/9Ljvwmb/HfIFoHuMVL+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GDncDKuQUQsT+uTK64sJlfG4IojqxQtLvO56kcPNqxdFDQunu4s/jdHGa6wtg4KXeOddgG6yRFATanJXCKlZQ+vzIlWTGQWZBf3Kf6feGfIIfWqp1atTor8e5LOs6T1nEYBxUJH20IZsPZ+JdtXnwims+j3H3Y0fYXTKEIRltV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kyghw2nl; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kyghw2nl"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137dd523634so5261776c88.1
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780820461; x=1781425261; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9J0NH/I43sYxlpFkbjUNBNG1mQYZWERsQGhvxWJVjs=;
        b=kyghw2nlPz3O/H4RXEDoukcgqkU3OwEPXOo2o42CjsubDe2Jc6qMyosEo2PJlh6Vqb
         KPoGAIgyOSV9lEJnXBjVbMq01LPEa/Zc4oKIoPrNtTvvpF6PxqNU5ehJn8p+dbgHnl/g
         i5HVerlYTusZvY44v2KOnx+kwFhnUhaQfQ0aMJsXtGyIlczQlCHkO9RG9ssHOATN8TRm
         7Zf0nAS9PvY51p9zfzmoP0YB8hvDjIeKkWumCZiYC/NCcJLhwL1SVxhkroFFGaknR6j6
         42pHmJP1qnUzYBKU90cbqBQUMMOfSOy5mxnsbUZV8vnLI4EbAnljzXcSc+n6RTpOWvvj
         ITaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780820461; x=1781425261;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9J0NH/I43sYxlpFkbjUNBNG1mQYZWERsQGhvxWJVjs=;
        b=YbPoEDLTnT82re7Z2K2jFdJQiKSR8AgZE4f5TQe/oE1ysdWSbap29Bpwrp87UnVibU
         VRT4UM0tAgXws0G7DzYLQA2uq7hZR8d868E4tACcXUhQDjNjWPZBt7GSNmqJiq4rpHY9
         W60pfkMbXfQLAYeN/BYO++m31/VNggqyJ6kiZQOoEMM+N0JvC67HqvbLsRYBt6qgKbKs
         P1P/wi2Cdps1KAcZXaa65ZRcQ+1O4wwZSKDcPFFELefmdbZWJSgvdtcseFmTQ+grorOY
         vEb5jBsllt7UwQk7w2ra6J+gusCyARfiutzHEXbiskh+maJz29rsjwm+Uk9lonBudItk
         jHBQ==
X-Gm-Message-State: AOJu0YwTYhPrtdYwztAkRMWHabpqyqm0SrGHu6IOOFO8o778ZvVjDjF7
	QJgHviiR994MiEAigKLS112VGuKVMzhm8KdF53YwqlpfzIRazP0DFPEoAysLDH5ccd8=
X-Gm-Gg: Acq92OE7B1FnXf+yEBxqFvjUv8FgE5HCNWSbhjM7G9OeOHspMr8XN0W1NUO/f4Bo/FZ
	c7ByeHXOBMU+dvfLTW+/I4n/Fq47D8W1e2w/kpsT7CdHmnwQDL4B0xNmNONg8d+S+TpfU0PB8Cd
	qTx+KPm+4zjMk26g12ym40FFVMha/Fntf7UiZDGaHj4ZOtBzaMAvoDRFONVXAoLq1zl4lEKQjBQ
	6MS6zIwf8kTm9aK+6LsXEIZNXNqkJsoZ0rJkrBiswbtqoId+HTCXsIiaU9G/M0vkjJuoy6AXY4X
	sD3OUkCchTsIvAUtZbwO4I1eoBGF+qW4WdVjg/uOy4i9e5PTv4/bbIcbdeswXGrPDnA7lNjMRhO
	w3eKNYkKiN9R/2JaTpA+FBa1C7HmjSYCFzoTEMwlfxO2wJc7o3Cui/0sXt6fGEnLw9DKZdN8uCf
	ZOb3KzS0bzwBK88CeNCG76R0Ix+/3DAXPEYAsW
X-Received: by 2002:a05:7022:7a5:b0:137:6781:7dd4 with SMTP id a92af1059eb24-138066b5982mr5211833c88.8.1780820461416;
        Sun, 07 Jun 2026 01:21:01 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm9439232c88.1.2026.06.07.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:21:00 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 0/2] i2c: mux: reg: allow fixing the base bus number via
 fwnode
Date: Sun, 07 Jun 2026 01:20:54 -0700
Message-Id: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOYpJWoC/y2OQQ6DIBREr2JY9zcIRcSrNF3A96s00bYgxsR49
 1Lt8iUzb2ZjkYKnyJpiY4EWH/1rylBeCoaDnXoC32ZmgouKV1yDFwhjWiFQD85GApciTGkELWt
 SrdNkDLJcfwfq/Hqo74+TY3JPwvnn+ycCfVLenM8Ye9sZh7zYFNK2plMWnawUVeQEttJxbTiZW
 jrDb0bqslTq5zlu4Gsc/dwUi76WEPDGHvv+BRvTcsHeAAAA
X-Change-ID: 20260607-i2c-mux-reg-base-bus-num-738e5db7e99c
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780820459; l=1501;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=rATwyjdaFtrJ0McnHdAuGN/9Ljvwmb/HfIFoHuMVL+k=;
 b=jXU4iMmdYuSL8QvxM7LJ4+BMOuyIXr3vqVBFjLaZumdJBEWPTLjDtOEOLIqZxOBp679Xk0v1l
 UcdkmuiY22CB0QfIvwWhG0UqyXmr6PspKz71yXZmLh7OpEqlsSCvce+
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Add an "i2c-mux-base-bus-num" device property to i2c-mux-reg so
DT/ACPI/swnode instances can request a fixed base bus number; the
legacy platdata path already supports this via data.base_nr.

Patch 1 converts the legacy Documentation/devicetree/bindings/i2c/
i2c-mux-reg.txt binding to the YAML schema and documents the new
property. Patch 2 reads the property in the driver.

The series applies on top of the device-property accessor conversion
queued in Wolfram's wsa.git i2c/for-andi:

  c191ec71250b ("i2c: mux: reg: use device property accessors")
  https://lore.kernel.org/all/20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai/

Without that conversion there is no probe-time hook on the OF path
for the new property the driver reads.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Abdurrahman Hussain (2):
      dt-bindings: i2c: convert i2c-mux-reg to DT schema
      i2c: mux: reg: allow fixing the base bus number via fwnode

 .../devicetree/bindings/i2c/i2c-mux-reg.txt        |  74 --------------
 .../devicetree/bindings/i2c/i2c-mux-reg.yaml       | 110 +++++++++++++++++++++
 drivers/i2c/muxes/i2c-mux-reg.c                    |   4 +-
 3 files changed, 113 insertions(+), 75 deletions(-)
---
base-commit: aa61612ab641d7d62b0b6889f2c7c9251489f6e3
change-id: 20260607-i2c-mux-reg-base-bus-num-738e5db7e99c
prerequisite-patch-id: 3ad9f5acb365e6eb2cd3b0790e983b9049371155

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

