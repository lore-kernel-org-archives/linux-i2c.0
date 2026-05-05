Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7432F3C0A;
	Tue,  5 May 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023374; cv=none; b=tUsQTNI60CDevm/UydxoK2xANb1Mwut57cbNK9OxrrMf4ePbWWK/MdxytmDyQtZjX1F/PqS9i+tUEB2aQIzyO4yOotK1M53k9wVWup2Ql34elKXCEkFfhsLZsPabbyA3ULB8QiAVEXnBPsCHE+OBEgtC2WBGUHhAHVR0kkNzujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023374; c=relaxed/simple;
	bh=5X5sjo1veBsW3+QvOZX+cy82jWair4HbH+EHOjwLgpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxQv0HZ+5Y8orqBHzXAqfjLKPzyiROWptqtrHS73NXSKUzbV682EGLTV1k86M5esU0d79XSRnHauK+FpVFE8b+0zF3PoXAkQWvtu+GB9DzBH1JuOITzZd4eqODuIdACoKCVZo8kLzmRxWJQwqGSnIRiwP4Ufl7SLLbX+XgNaGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AwGEBn6a; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AwGEBn6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778023373; x=1809559373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+1MgVX1JjYABbB43s3+tzS/iUlKkc5HUBWfNIY+DQUw=;
  b=AwGEBn6aQTZcYwK/arVUKr6zlEBoVFVDhKsbueHE9hlFA8dDUnjuf2Ht
   i6/agDfV7JtFBynVZYvzJz8tNZRMuSviQ7oXyhNAKyQF5AQI7piH3iVfZ
   w4W66MKg7jymzUOHB9YS7rXh1QPU08xzs8dpM8fRJdq/VST6VPaNIFhXB
   dAjcDu+7zAiojLwRLxSKyt90JHQKaW9urISdWgtOopdvjhWc0dwusKwXJ
   k760Thu4lKmvgkLTJlaRPiaKwlSTiUkQQuxuOLCpuBMXsXcFuDsAY4EMW
   +7PfDkLUSpfETJpWYY8imQEWURzrPk0gRC7S8gZAZ+yD3H9bbEEdmZcoE
   Q==;
X-CSE-ConnectionGUID: EGp1A7mdSQGrl09l2Kq06g==
X-CSE-MsgGUID: nNgcz8fIS66Anrd892H/9Q==
X-IronPort-AV: E=Sophos;i="6.23,218,1770595200"; 
   d="scan'208";a="18744505"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:22:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:24477]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id fa2f24f3-6bbd-4925-8e4b-0394d60aab0b; Tue, 5 May 2026 23:22:52 +0000 (UTC)
X-Farcaster-Flow-ID: fa2f24f3-6bbd-4925-8e4b-0394d60aab0b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 5 May 2026 23:22:50 +0000
Received: from 842f574e803f.amazon.com (10.187.171.33) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 5 May 2026 23:22:50 +0000
From: David LaPorte <dalaport@amazon.com>
To: <benoit.monin@bootlin.com>
CC: <andi.shyti@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<bala.senthil@intel.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
	<dmitry.guzman@mobileye.com>, <gregory.clement@bootlin.com>,
	<jarkko.nikula@linux.intel.com>, <jsd@semihalf.com>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <mika.westerberg@linux.intel.com>,
	<rostedt@goodmis.org>, <tamal.saha@intel.com>, <tawfik.bayouk@mobileye.com>,
	<theo.lebrun@bootlin.com>, <thomas.petazzoni@bootlin.com>,
	<vladimir.kondratiev@mobileye.com>, <wsa@kernel.org>, <dgj@amazon.com>,
	<gunnarku@amazon.com>
Subject: Re: [PATCH v6 3/3] i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER disabled
Date: Tue, 5 May 2026 16:22:42 -0700
Message-ID: <20260505232244.71807-1-dalaport@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260130-i2c-dw-v6-3-08ca1e9ece07@bootlin.com>
References: <20260130-i2c-dw-v6-3-08ca1e9ece07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi all,

I don't have Keem Bay hardware, but reviewing this against the existing driver I think this hunk may regress the multi-master support added by commit f4e0ba52a89f ("i2c: designware: Do not complete i2c read without RX_FULL interrupt"):

/* Abort if we detect a STOP in the middle of a read or a write */
if ((stat & DW_IC_INTR_STOP_DET) &&
    (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS))) {
    dev_err(dev->dev, "spurious STOP detected\n");
    dev->rx_outstanding = 0;
    dev->msg_err = -EIO;
}

That commit handles the case where STOP_DET is observed before the final RX_FULL. The new check aborts on that intermediate state.

The sibling TX-side underrun check in i2c_dw_xfer_msg() is gated on !emptyfifo_hold_master; this one isn't. I couldn't find discussion of the interaction in the v1–v6 review history so flagging in case it was an oversight.

A minimal fix matching the TX-side gating:

- /* Abort if we detect a STOP in the middle of a read or a write */
- if ((stat & DW_IC_INTR_STOP_DET) &&
+ /*
+  * Abort if we detect a STOP in the middle of a read or a write on
+  * controllers that do not hold SCL on FIFO underrun.
+  */
+ if (!dev->emptyfifo_hold_master &&
+     (stat & DW_IC_INTR_STOP_DET) &&
      (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS))) {
    dev_err(dev->dev, "spurious STOP detected\n");
    dev->rx_outstanding = 0;

Happy to send as a proper patch if that's the right direction, or to be corrected.

Thanks,
David
