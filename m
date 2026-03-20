Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22425B663
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987152; cv=none; b=pjGCpFKaw6stvZ3xLXbjt4PNBpuzyUVUMjTeKk5NM+WaRf/qQRlv4VuBNt+ReWwzJ5r6OkM/Q3y9iz9sKEQcWUdPwu3ARQg9MFwxVbXPZGz6jasEAglRmP/tDu9K7BEraMmPhqIFnFDm/poLQEALilj+7AhCeQsFQbPlEfle+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987152; c=relaxed/simple;
	bh=4hoa9J6xOBHrM0aN7Jc9XMxjRE3Ci9RIclJ6AJ0pnyk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S+V3mVnEoQmOO57mw1vngiotMZzempZSWpPL4qn3V4pOqUMUcyiSN8fX6vrFAVGz5l5ASPZPJj921DwzPJNYWmaE6pE21/mfH4jspvT+80K1CZp5QLtYAJjuwNuYR9PUT75D9H3fJJ4z4wutLIyMS/rfkZhCJEAhcDYzb03gLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=FgbEaZbS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="FgbEaZbS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so606264a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Mar 2026 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1773987150; x=1774591950; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1iz6MeksNNtIcxd9ic1iSI1CofBBNW6rOw3XqGitRw=;
        b=FgbEaZbSCtAtCCltN/d54QqT/e+GkqN0SgWTavF0Uyn7wsSQPCK/M9p/ODhlGsRQuP
         v0Iy8islxmP8u9vd5w1+5zPwXpPdIli+tkzUzllCDVgkXF0Inb9gO5qnYAUhdLhILP63
         xgo4Qa7XijSB6PBXpnFlJXCqySbP+gp8390jq+9H3xYRh8son8Pcg0j3nDUSDOGlNqoR
         uiuyIFcGpbgN9y8/rVclrFm77t/HFVDkvAYlBoQgSg6iF9wGT855ruoCmrsJWNwkx3ai
         yRtVlqRHYTJQTAPawYA4KHliM1F1A3O9U9n+WmTcuQDjg6ueuSPF1CDbTPQLm6VmVX6M
         Rc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773987150; x=1774591950;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1iz6MeksNNtIcxd9ic1iSI1CofBBNW6rOw3XqGitRw=;
        b=dGZxsF3zkLzHr4zdX4mWc89kjKEoWj7BK6rQ3Dl2ZytIm8DEAlkywtPLYSZ8DJ+NiY
         ej7xHPY4o8NW/rpJyZOgdQpRRQL5MVQhO4cmVAjj578p02PYJ+kis3//VgUqRbBSnTw4
         ji0BTBBcwYU/Cm7udWx1ZCqemuIWfAlBsW0MlGW9Tu/oP4ABymFlLWPyvcLrfveklu2y
         zKHVhzSg2bO9Oc3JGQki9qVws60v5UbTkS06BOn0YauNxbo80g4GY/t8jsI+qv9x7MhG
         jylqDNzlayS0r5gLDYaS14Gr0sIV1slr8A3CCDkB0ZthWRcStdRq+gUWICuT65pLYZS4
         0CEw==
X-Forwarded-Encrypted: i=1; AJvYcCW9d1CiV0wdmiNSOyBZ7vz9F1JiwdLjvdcDCZED9LJ9RjBqSitkCUZZxLvsZ4nB7YDOyP2mmP6NH18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFTPXeqctVVWFgJrc0WncV/DZ8nhOQZ+61+f6KCFQUM3b4r+j
	gTj2JimOVXh/n6QNsG9rYyTDIbvFBhfoS3k1v9QnI0Fn+AUUg0FBqrBV2yZo5gj64Ig=
X-Gm-Gg: ATEYQzyh/8cjDPbbYC8CZei4fUePAgRjVG+boGpz67D6LaYo4sMEU2kD60aBj/wXqgV
	7FQW1mtkMWN1H8vieADO6Mvm1EmSeKctwJfhXL8wwlb+Hg3vFPWcro6Ant5dVHBrrq8yNXtKxlg
	UZKYVcye1oARWM9vGwrYv7HQe39azf3pgzJdHGXDWb5OKdFqyDNTMqkqYCcABbQfxw0VqmPea2I
	PwgPffw5m76H3fLHPzhJwGDzUUKQ9t5Kyvj/uvGaWbx6/+sOdfzG4f9+1gkRR8STOyE9Wdg9B2L
	hw0ZbTC+vxlCdw8441xpoMXx0n/nqAdeIqS8JTHF30W9I8lghIm2MBnnkV5q19RZuMhY0bKtqfF
	gHVk2E+KEPS52fm3AU61vdmhLt1PF9MANE88RDlsID1ZEJ2+t4UMqoumJjcSpZFNNILRWKGCeAh
	pUOwFLgLSQUTXcF4X75rHB83m1lTPA/jsoPpiqG4x7xF7Cun8=
X-Received: by 2002:a05:6a20:7f9f:b0:398:b178:a53f with SMTP id adf61e73a8af0-39bceb427b1mr1734963637.40.1773987150278;
        Thu, 19 Mar 2026 23:12:30 -0700 (PDT)
Received: from smtpclient.apple ([50.47.115.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm968942b3a.31.2026.03.19.23.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 23:12:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v12 0/7] i2c: xiic: use generic device property accessors
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
Date: Thu, 19 Mar 2026 23:12:19 -0700
Cc: Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC244FF4-29CA-4A3A-8E58-C6CDB05A248D@nexthop.ai>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
To: abdurrahman@nexthop.ai
X-Mailer: Apple Mail (2.3864.400.21)

Hi Andi,

I'm just following up on this patch series (v12) aimed at updating the =
xiic
driver to use generic device property accessors.

I addressed the feedback from Krzysztof and Andy in this version. Do you
have any updates or further comments on this series? I am happy to make
any necessary changes.

Thank you,
Abdurrahman

Link to patchwork: =
https://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D493003

> On Feb 23, 2026, at 7:59=E2=80=AFAM, Abdurrahman Hussain via B4 Relay =
<devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>=20
> - Switch to generic device property accessors.
> - Switch to managed devm_ functions to simplify error handling.
> - General cleanups.
> - Skip clock setup on non-OF systems where clock is not specified via
> firmware.
>=20
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Changes in v12:
> - Reworded the patch 3 description as suggested by Krzysztof.
> - Added fwnode to patch 3 as suggested by Andy.
> - Used fwnode added in patch 3 in patch 7 as suggested by Andy.
> - Link to v11: =
https://lore.kernel.org/r/20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai
>=20
> Changes in v11:
> - Cosmetic change to return 0 in patch 1.
> - Remove pm_runtime_dont_use_autosuspend() in patch 1.
> - Link to v10: =
https://lore.kernel.org/r/20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai
>=20
> Changes in v10:
> - Moved dev_dbg() change from patch 4 to patch 5.
> - Reworded description in patch 6.
> - Addressed Andy's comment in patch 7 (&pdev->dev -> dev).
> - Link to v9: =
https://lore.kernel.org/r/20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai
>=20
> Changes in v9:
> - Fix an issue found by the test robot in the cleanup patch.
> - Reworded the clock change description.
> - Add a patch to switch to i2c_add_numbered_adapter().
> - Link to v8: =
https://lore.kernel.org/r/20260201-i2c-xiic-v8-0-deb2dd158d1a@nexthop.ai
>=20
> Changes in v8:
> - Made the clock change the last patch in the series.
> - Reworded the clock change description.
> - Changed dev->fwnode to dev_fwnode(dev).
> - Link to v7: =
https://lore.kernel.org/r/20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai
>=20
> Changes in v7:
> - Drop the dt-bindings patch.
> - Skip clock setup on non-OF systems.
> - Minor commit body rewording.
> - Applied code-review trailers with `b4 trailers -u`
> - Link to v6: =
https://lore.kernel.org/r/20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai
>=20
> Changes in v6:
> - Cosmetic changes to address the comments.
> - Added a patch to use resource format specifier in debug log.
> - Link to v5: =
https://lore.kernel.org/r/20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai
>=20
> Changes in v5:
> - Reorder the cosmetic patch to be the last in the series.
> - Added a documentation patch to describe the optional clock.
> - Minor commit body rewording.
> - Link to v4: =
https://lore.kernel.org/r/20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai
>=20
> Changes in v4:
> - Reorder the cosmetic patch to be the first in the series.
> - Amend the mutex_init patch to also switch to the managed pm_runtime_
>  variant.
> - Link to v3: =
https://lore.kernel.org/r/20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai
>=20
> Changes in v3:
> - Reorder the "optional clock" patch to be the first in the series.=20
> - Add a patch to switch to devm_mutex_init().
> - Remove dup message in error path.
> - Cosmetic: use temporary dev variable.
> - Link to v2: =
https://lore.kernel.org/r/20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai
>=20
> Changes in v2:
> - Split the patch into two independent changes.
> - Added struct device *dev at the top of probe() and remove() to =
re-use.
> - Switched to device_set_node(...)
>=20
> ---
> Abdurrahman Hussain (7):
>      i2c: xiic: switch to devres managed APIs
>      i2c: xiic: remove duplicate error message
>      i2c: xiic: switch to generic device property accessors
>      i2c: xiic: cosmetic cleanup
>      i2c: xiic: cosmetic: use resource format specifier in debug log
>      i2c: xiic: use numbered adapter registration
>      i2c: xiic: skip input clock setup on non-OF systems
>=20
> drivers/i2c/busses/i2c-xiic.c | 97 =
+++++++++++++++++++------------------------
> 1 file changed, 42 insertions(+), 55 deletions(-)
> ---
> base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
> change-id: 20260122-i2c-xiic-3ba89ff5ea93
>=20
> Best regards,
> --=20
> Abdurrahman Hussain <abdurrahman@nexthop.ai>
>=20
>=20

