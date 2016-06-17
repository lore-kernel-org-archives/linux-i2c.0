From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] i2c: designware: Use transfer timeout from ioctl
 I2C_TIMEOUT
Date: Fri, 17 Jun 2016 09:15:27 +0200
Message-ID: <20160617071527.GW26048@pengutronix.de>
References: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56348 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774AbcFQHPc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Jun 2016 03:15:32 -0400
Content-Disposition: inline
In-Reply-To: <1466127995-28318-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com

On Fri, Jun 17, 2016 at 09:46:35AM +0800, Weifeng Voon wrote:
> This allows applications to set the transfer timeout in 10ms incremen=
ts via
> ioctl I2C_TIMEOUT.
>=20
> Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
