From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v5+1 repost] i2c: mux: mellanox: add driver
Date: Fri, 11 Nov 2016 09:35:50 +0100
Message-ID: <cd343dec-3154-19b2-c5ca-1947e49bc886@axentia.se>
References: <1478813183-134553-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0099.outbound.protection.outlook.com ([104.47.2.99]:32736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750979AbcKKKI7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 05:08:59 -0500
In-Reply-To: <1478813183-134553-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

On 2016-11-10 22:26, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> This driver allows I2C routing controlled through CPLD select registers on
> a wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).

*snip*

Thanks for your patience!

I changed my Acked-by into a Signed-off-by, fixed up a few multi-line
comment formatting issues, and pushed it to the i2c-mux/for-next
branch at https://github.com/peda-r/i2c-mux.git

Cheers,
Peter
