Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040937B02B
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529991; cv=none; b=az9XnQIa9kXym1Q893Jl9NLWAx/p5CTdO57KerCkfOp/PmlNpmjyplfTNpcj3FKWXkvmxa/ehEctFoROGf7n8coQCR5+rLXxQ46RXJGXYpZ8c4nUb9DO4DSVvsXcYVbhZtky4qUJlCXb0EbZBGwttK8fFLgHVOXPJpBTWYxpp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529991; c=relaxed/simple;
	bh=i4mD15MJaYvk9BsNCp+/D7q7HYHneZDzDwI5LzchOYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7eHes2R0xYJAQe3Qa6tAZY0jxs92DzeYQepVPsxD//bJ23OLTACfWHIcZDOLN4vtdW/X3LeMOQbstV1xSCdoaEv4E/rjoDKozwqe0QJOBrsjbnU4zp9NBWWF6iR9YGCZG9P/xbT6+kFq/dHZimbf3Zh/atoC7o3QO9WyXtMwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=BSKDyit/; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="BSKDyit/"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so4743672eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529990; x=1779134790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or16F3QI3wbVcFGF3Sy78Pg5a2SE5j6ngUICpjDsMuw=;
        b=BSKDyit/o0V5oQTv248jKpBQWrtng/k7nJxe+bRyeX7gBduBN93nl4kNn3tBuWpzC7
         MI23lozeiXPtzMUEgKN6DMjNRsMvn8ac9JsaeVXy5B2t1ExbmbHQpHHkkz0fCw0F16He
         JXGDRkptl/fptlINrS8vRXztJmrCXwiGgnEHkBBRwUWbzABC+EPlAj46Z5rLP7SVWBh3
         md9ETSgTo70RyMplL9AtKTPr9cBuHoGwXzNVc3lW02SXSF/AGlBxk3CXRv7Tpbm6NYvP
         bUmz1oL2vLhujbb4ai2HfH0g6uV5TMqK4Ly9kdtRKxUklzychivjxCiyPdkOK4NVQy6g
         PBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529990; x=1779134790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=or16F3QI3wbVcFGF3Sy78Pg5a2SE5j6ngUICpjDsMuw=;
        b=fPAuupMt9m3/w6ygmKNgXIQ5ILRWPVg0dBphS7Q1aSNT3k1kuohfh6QmyEDEAd4U5J
         i+oMdMNAv0qnzuVhjOXDe4cb35xfmJW3SyAMnLTPEaN82mnwF3dOcbwS9h/MyaB+PK7U
         vq4t+HC3zHOh/B5e+jm/00/8Vrc6eGSTEjoA/HWTVzwlqamRRK/4Cz7Ie69qDGi1NgSO
         QlEIFz6FbFJ32haNoWU3mmztrlwVeQoylmwnwg++2Ehw4dlGYzNg2BGPmTvie+sjgJX3
         9demSFeAdf/PGHqxRzcoJrBzcv9DQRDZGV5+WwU3idMT5LZJZvTLRyO8jy3cECJ26bxH
         sRfA==
X-Gm-Message-State: AOJu0Yx57DVuv4E7/3CNXytMbgMYs0fCPvDcFR2rgKDNcfqcIMs6kgGH
	aknq42QY/Pppr/eoTNf1BiPuPHY/Z2Em+02LCByfm9OTtwH0SLygIXOg/x7xjRd5rGs=
X-Gm-Gg: Acq92OGaeQZEppvd7OM8tIUv7adyKNfD/V03AbhMx1G0TaVnYFJn6jFYvVXSZm63wbu
	SZcQ4J4MNNtuA0RerGup92j873+7o3HFNzomhdWCN3fi0RvIiGQqWhysvHrCyzxVBC+XQNDZ+XE
	OmEXMQtsoq6lnmIDrrMF9i/oe/iYj/1mXnJA/dQV3Z551wsMZtzNvsXRr78eb1CBOELKvakJvoz
	2lf3F4w88iMm6c7n18n8tnV1wZyaEQ7rIPLNfv5gL9xhG9RhKjM5U/GVlo+VCfTve5xat1fM9C+
	TUfHLFh+IA0XLVIxJ6mrpxeVquZ042swfivZ7Q8eFssluX98taUcPxOA0/ChScL3fOrEflcVIMt
	rF6iP/oZJzl+TULCs+pguVLrFUYRY/HukfIunq+DVbjdH1KqoFpCaRO+UV1aNEsARuWXnHWx9mu
	QtDpiNwM53Ma8gDN2u1sMQRFLYkgpx5PMu+JOdE6yJORs8VVln/pyAvPSgjQtJxn+9cwIrHsXxY
	E3YceCvIy0Va6k=
X-Received: by 2002:a05:7300:4313:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2f54b89a0cemr12984893eec.3.1778529989711;
        Mon, 11 May 2026 13:06:29 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm15066942eec.24.2026.05.11.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:06:29 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 11 May 2026 20:06:27 +0000
Subject: [PATCH v5 2/4] i2c: designware: Convert PCI driver to use shutdown
 hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dw-i2c-v5-2-6c382e1b5de6@wkennington.com>
References: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
In-Reply-To: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
the controller to gracefully NACK controller requests during system
shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f9877c040..ab21d4414681 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -356,10 +356,24 @@ static const struct pci_device_id i2c_designware_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
+static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = pci_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.probe		= i2c_dw_pci_probe,
 	.remove		= i2c_dw_pci_remove,
+	.shutdown	= i2c_dw_pci_shutdown,
 	.driver         = {
 		.pm	= pm_ptr(&i2c_dw_dev_pm_ops),
 	},

-- 
2.54.0.563.g4f69b47b94-goog

