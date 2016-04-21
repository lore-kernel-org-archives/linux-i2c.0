From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
Date: Thu, 21 Apr 2016 14:03:34 +0300
Message-ID: <1461236614.6620.312.camel@linux.intel.com>
References: <1461230811-7495-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26979 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbcDULCe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 07:02:34 -0400
In-Reply-To: <1461230811-7495-1-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2016-04-21 at 17:26 +0800, Jisheng Zhang wrote:
> If i2c_dw_probe() fail, we should disable and unprepare the clk,

clk -> clock, or use function name explicitly.

> otherwise the clk enable and prepare is left unbalanced.
>=20

Ditto.

> In dw_i2c_plat_remove(), we'd better to not rely on rpm to disable
> and unprepare the clk since CONFIG_PM may be disabled when configurin=
g

Ditto.

> the kernel. So we explicitly disable and unprepare the clk in

Ditto.

> dw_i2c_plat_remove().


> +	pm_runtime_put_noidle(&pdev->dev);
> =C2=A0
> -	pm_runtime_put_sync(&pdev->dev);
>=20

This change also needs to be described in the commit message.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
