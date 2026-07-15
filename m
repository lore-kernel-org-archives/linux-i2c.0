Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68328481A9F;
	Wed, 15 Jul 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126330; cv=none; b=Rt6IeiQkOS0oBpsYQ/aZJSzFF1lNSedup4Dzr4ey0pZlLYJXNW4BCS3doGJ1ZcNRPgo+qzit5c1Dh4M+FXALatwWXW1hg+ZVygdoA5HJc8+LYC4omxc2PyiiZqrEXO14hOlZ/HNj953RcFZ1/H3VGLdQ2v9dBSjesTA4XHXL114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126330; c=relaxed/simple;
	bh=vDeU+4zPoXa2rfas9DIJC/ack9B6GVrM3PJsqOJIVfM=;
	h=From:Date:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sM83nd7zmfgLrlRdMibDX8WouKyABQ7SJNNUS9m0msMRXiyRdhRpwS/HGyFVC3kJSlUdJSsEfz+r8QR+qssEkhUV0ngeVINpkAWfZBkm/lI5yGx23xqDa2aPlvsOepOMf2illok15Pc8tzG0b/rEe622ihUGmETADNVgR1u4dJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=WC1Ycaot reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="WC1Ycaot"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1784126324; x=1815662324;
  h=from:date:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDeU+4zPoXa2rfas9DIJC/ack9B6GVrM3PJsqOJIVfM=;
  b=WC1YcaotmxTUUN6QFrEJZciRPQ76AqPI3QLM5tXm2soW3GVZdMwGwbuu
   rAr12i0kQ96GhSRzSCyy/BKvhudhd/IBpw7AJfeSec/emVgshAlpPPMK+
   iABrTI5Lyh0BVW5nRbTMeHBeYtXaJAOVNSnwU3bPNUV81IgEMH1H/v0kb
   KMI7me0V3ooC+YMItrFeaj0XcS7mKTMimDW3l1eGWPPtSrG8IOeNDm6fN
   QPI7Jgwnpwp8nAqbI61KeMGle0CEWNbgYIN7AXLr8BiZjWYYyoUymWHav
   1TxNhfthVSW+IKQMOK2PEQ8Xwb/LAPoDncreEEcv4Uufu4FrRoHqt/wzF
   Q==;
X-CSE-ConnectionGUID: 9+Hv93NfTjm2qOkkC0ya2g==
X-CSE-MsgGUID: 585qebj+SyC5NYuBDsN/ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 17:37:30 +0300
X-CSE-ConnectionGUID: Z+9tdsEtT2W3xzX1rtWN6Q==
X-CSE-MsgGUID: TKtZWjU+SviYd6krL0Q0FQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 15 Jul 2026 17:43:04 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Wed, 15 Jul 2026 17:37:29 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Wed, 15 Jul 2026 14:45:58 +0300
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
Message-Id: <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
In-Reply-To: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 15:48:05 +0530
Aniket Randive <aniket.randive@oss.qualcomm.com> wrote:

> This replaces the fixed 1-second timeout with a transfer-specific
> timeout while preserving sufficient margin for software overheads and
> bus-level delays.
> 

The dynamic timeout may be useful for any I2C bus controller, not only
for qcom-geni. Structure i2c_adapter already has field "timeout". Isn't
it worth to move the timeout calculation to i2c-core, so that the core
updates the timeout field in i2c_adapter structure, and the controller
driver just uses this value, instead of duplicating the calculation in
every driver that will use this feature?

Also, such parameters as I2C_TIMEOUT_SAFETY_COEFFICIENT and
I2C_TIMEOUT_MIN_USEC may be configurable by user (for example, in
device tree) for more flexibility.

Best regards,
-- 
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

