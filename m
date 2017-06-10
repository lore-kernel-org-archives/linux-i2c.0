From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/2] Add I2C driver for ZTE ZX2967 family SoCs
Date: Sat, 10 Jun 2017 22:32:08 +0800
Message-ID: <20170610143207.GA9839@dragon>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbdFJOcn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Jun 2017 10:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xin Zhou <zhou.xin8@sanechips.com.cn>

Hi Wolfram,

On Sun, May 28, 2017 at 12:59:34PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Hi Wolfram,
> 
> The ZX2967 I2C driver submission had gone through quite a number of
> review iterations [1], and seems close to be accepted.  But for some
> reason, the ball got dropped from there.  I'm here to pick it up and
> hopefully move it forward.
> 
> This is basically a resend of the latest posting from Baoyou with
> Wolfram's comments on v7 fully addressed.
> 
> Changes since v7:
>  - Rebase and test on v4.12-rc2.
>  - Drop the dev_err() and hardware reset on timeout, which is not really
>    necessary.
>  - Return -ETIMEDOUT instead of -EIO on timeout.
>  - Unify zx2967_i2c_xfer_write_bytes() and zx2967_i2c_xfer_read_bytes()
>    into one function zx2967_i2c_xfer_bytes(), and zx2967_i2c_xfer_write()
>    and zx2967_i2c_xfer_read() into zx2967_i2c_xfer_msg().

Any comments on the series?  We hope it can get into v4.13 merge window.

Shawn
