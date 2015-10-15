From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [Patch V8] i2c: imx: add runtime pm support to improve the performance
Date: Thu, 15 Oct 2015 22:33:31 +0530
Message-ID: <CAKfKVtFYN0f1SWPjw8T7PVzjdSbgO2tqFBHgw9Uue4Hsg_em=g@mail.gmail.com>
References: <1442569869-10584-1-git-send-email-b54642@freescale.com>
	<20151013070711.GA3982@pengutronix.de>
	<CY1PR0301MB0858AB5F33E75B6C12E1CAB5CF300@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33502 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbJORDc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Oct 2015 13:03:32 -0400
Received: by qgeo38 with SMTP id o38so32629857qge.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2015 10:03:32 -0700 (PDT)
In-Reply-To: <CY1PR0301MB0858AB5F33E75B6C12E1CAB5CF300@CY1PR0301MB0858.namprd03.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pandy <gaopan@freescale.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Li Frank <Frank.Li@freescale.com>, Duan Andy <fugang.duan@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>

clk_enable is called here.
enables the clock here.
>
> The calling sequence is:
> pm_runtime_use_autosuspend(&pdev->dev);
> pm_runtime_set_active(&pdev->dev);
> pm_runtime_enable(&pdev->dev);
> pm_runtime_get_sync(&pdev->dev);
are we not enabling it again?

there by effectively disabling pm.

Or did I missing something.

>
> The cleanup order is:
> pm_runtime_put_noidle(&pdev->dev);
> pm_runtime_disable(&pdev->dev);
> pm_runtime_set_suspended(&pdev->dev);
>
> Is it that I miss pm_runtime_dont_use_autosuspend(&pdev->dev);
>
> Thank you!
>
> Best Reguards
> Gao Pan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
