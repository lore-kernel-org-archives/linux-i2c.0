Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA51FC7C5
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172507; cv=none; b=lYh6Ri07KRP/4m6bXVqUCcnwTrVvn0cWBwSY1LrGNfyYciU/06F8DMC/d9hWCS/fnA7k1p+hJbv3FheXUB6UR5ra/bVVU6nN7yZhFRW8j4OYClEX0a6KlYxYtmhXopZw5puzSDNIzbJVM4pGS/75xFXotogeuIH/6kM3RMRlqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172507; c=relaxed/simple;
	bh=sLKncsIpAR+9g5qW/XVOkuKxSZQ9qSFECYXQkmCd+Yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCwSaA9OF4XX09BCT3Gb2HpEn5meWW2l+inu/uxn+l8+U4dDYssu3QmOzhWp4DA3qU4zYXoqWqveIKHNUUsuAQA1myeFk4z0alAwfP14t2rataKEUcsjxD2dgxSbTDRv/m3SBe97PNVYAtK7Nzad6cE3zslaL+ula4CE7L8huZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vjGaF-0008QP-Ry; Fri, 23 Jan 2026 13:48:15 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vjGaF-0025sQ-2E;
	Fri, 23 Jan 2026 13:48:15 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vjGaE-000000006YO-3zSh;
	Fri, 23 Jan 2026 13:48:14 +0100
Message-ID: <d802354283652410ebfbe7717716bb347d7dba25.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/2] i2c: designware-platdrv: refactor error handling
 and simplify cleanup
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>, Mika Westerberg	
 <mika.westerberg@linux.intel.com>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, Andi
 Shyti	 <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 13:48:14 +0100
In-Reply-To: <20260123100537.1429497-3-a.shimko.dev@gmail.com>
References: <20260123100537.1429497-3-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-i2c@vger.kernel.org

On Fr, 2026-01-23 at 13:05 +0300, Artem Shimko wrote:
> Streamline the probe error handling by replacing goto statements with
> direct returns and using dev_err_probe() for consistent error reporting.
> This results in more linear and readable control flow.
>=20
> Remove the explicit reset_control_assert() call from the driver's
> remove function, as the reset controller is acquired with
> devm_reset_control_get_optional_exclusive_deasserted() which manages
> the reset state automatically through devm resource management.

This change belongs in patch 1, same with the assert in the  probe
error path.

regards
Philipp


