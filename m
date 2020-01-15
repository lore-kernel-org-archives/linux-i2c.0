From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] i2c: parport-light: remove driver
Date: Wed, 15 Jan 2020 12:04:47 +0100
Message-ID: <20200115120447.1596a6ce@endymion>
References: <20200113210643.5033-1-wsa+renesas@sang-engineering.com>
        <20200113210643.5033-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgAOLEu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 15 Jan 2020 06:04:50 -0500
In-Reply-To: <20200113210643.5033-2-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org

On Mon, 13 Jan 2020 22:06:41 +0100, Wolfram Sang wrote:
> The justification of a light version of the parport driver was less
> overhead for embedded systems. Well, today, even if an embedded system
> still has a parport, it surely can handle the fully-fledged parport
> driver. Remove it to reduce the maintenance burden.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../i2c/busses/i2c-parport-light.rst          |  24 --
>  Documentation/i2c/busses/index.rst            |   1 -
>  MAINTAINERS                                   |   2 -
>  drivers/i2c/busses/Kconfig                    |  28 --
>  drivers/i2c/busses/Makefile                   |   1 -
>  drivers/i2c/busses/i2c-parport-light.c        | 267 ------------------
>  6 files changed, 323 deletions(-)
>  delete mode 100644 Documentation/i2c/busses/i2c-parport-light.rst
>  delete mode 100644 drivers/i2c/busses/i2c-parport-light.c
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>


-- 
Jean Delvare
SUSE L3 Support
