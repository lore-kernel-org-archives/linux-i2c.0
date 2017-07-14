From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] drivers: i2c: muxes: Kconfig
Date: Fri, 14 Jul 2017 12:19:46 +0200
Message-ID: <96f20a24-e125-f8be-4716-a5000a67496f@axentia.se>
References: <1499880686-8257-1-git-send-email-chrisjohgorman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:28448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752602AbdGNKTz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 14 Jul 2017 06:19:55 -0400
In-Reply-To: <1499880686-8257-1-git-send-email-chrisjohgorman@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Gorman <chrisjohgorman@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017-07-12 19:31, Chris Gorman wrote:
> Kconfig says the resulting module is pinctrl-i2cmux and the module when
> built is i2c-mux-pinctrl.
> 
> Signed-off-by: Chris Gorman <chrisjohgorman@gmail.com>

Yes, thanks!

I took the liberty of changing the Subject to

"i2c: mux: pinctrl: mention the correct module name in Kconfig help text"

and applied it to my for-current branch.

Cheers,
Peter
