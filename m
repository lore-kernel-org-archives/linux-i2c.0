From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/2] i2c: mux: move include files out of
 include/linux/i2c
Date: Sun, 13 Aug 2017 23:23:13 +0200
Message-ID: <4ff46816-6585-2197-5804-c0065af6d9f5@axentia.se>
References: <20170813135856.3454-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10116.outbound.protection.outlook.com ([40.107.1.116]:56348
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbdHMVXV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Aug 2017 17:23:21 -0400
In-Reply-To: <20170813135856.3454-1-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-08-13 15:58, Wolfram Sang wrote:
> include/linux/i2c is to be deprecated, so move these header files only
> including platform_data to the better suited platform_data directory.
> 
> Peter, I know I said I'll include these two patches in my for-current branch.
> But other of these cleanup patches missed this merge window as well. Since I
> need to wait for the next merge window anyhow (until all patches are applied),
> I'd think these patches can also go the proper way via your tree, too.
> 
> These patches are rebased to v4.13-rc4 (let me know if you prefer a
> different base). The PCA patch has an empty line removed now.

Right, no problem, I'm happy to take them. However, I know I probably acked
them and all, but now that I look at them I see that the #includes are no
longer sorted. Care to fix that?

Cheers,
peda

> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (2):
>   i2c: mux: pca954x: move header file out of I2C realm
>   i2c: mux: mlxcpld: move header file out of I2C realm
> 
>  drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
>  drivers/i2c/muxes/i2c-mux-pca9541.c                | 3 +--
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 2 +-
>  include/linux/{i2c => platform_data}/pca954x.h     | 0
>  include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
>  5 files changed, 3 insertions(+), 4 deletions(-)
>  rename include/linux/{i2c => platform_data}/pca954x.h (100%)
>  rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)
> 
