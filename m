From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: mlxcpld: fix i2c mux selection caching
Date: Sat, 17 Dec 2016 21:34:34 +0100
Message-ID: <3d7efaaa-ff9a-421f-c0ee-02c6a4870266@axentia.se>
References: <1482006551-23108-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:32214
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752410AbcLQUem (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Dec 2016 15:34:42 -0500
In-Reply-To: <1482006551-23108-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2016-12-17 21:29, Peter Rosin wrote:
> smbus functions return -ve on error, 0 on success.  However,
> __i2c_transfer() have a different return signature - -ve on error, or
> number of buffers transferred (which may be zero or greater.)
> 
> The upshot of this is that the sense of the text is reversed when using

s/text/test/

> the mux on a bus supporting the master_xfer method: we cache the value
> and never retry if we fail to transfer any buffers, but if we succeed,
> we clear the cached value

missing terminating period

> 
> Fix this by making mlxcpld_mux_reg_write() return a -ve error code for
> all failure cases, just as was done in commit 7f638c1cb0a1 ("i2c: mux:
> pca954x: fix i2c mux selection caching")
> 
> This also aligns the implementations of these two muxes in this area.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---

Sorry for the poor proof-reading skills.

Cheers,
peda
