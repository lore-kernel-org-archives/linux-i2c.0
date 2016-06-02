From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: designware: Enable ioctl I2C_TIMEOUT
Date: Thu, 2 Jun 2016 10:33:30 +0200
Message-ID: <20160602083330.GY26768@pengutronix.de>
References: <1464854250-6810-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43390 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932152AbcFBIdf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Jun 2016 04:33:35 -0400
Content-Disposition: inline
In-Reply-To: <1464854250-6810-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com

On Thu, Jun 02, 2016 at 03:57:30PM +0800, Weifeng Voon wrote:
> This allows applications to set the transfer timeout in 10ms incremen=
ts via
> ioctl I2C_TIMEOUT.

10ms is only correct with HZ=3D100. With higher values of HZ you get a
finer resolution. I'd write:

	Respect the transfer timeout set via the I2C_TIMEOUT ioctl.

and not mention the resolution at all. After all your patch doesn't
"enable" that ioctl, just makes use of the value set by it.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
