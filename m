From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 19/26] docs: i2c: smbus-protocol: improve I2C Block
 transactions description
Date: Tue, 21 Jan 2020 10:16:37 +0100
Message-ID: <20200121101637.07513417@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-19-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJQq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Jan 2020 04:16:46 -0500
In-Reply-To: <20200105225012.11701-19-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:50:05 +0100, Luca Ceresoli wrote:
> Clarify from the beginning what these transactions are, and specifically
> how they differ from the SMBus counterparts, i.e. the lack of a Count byte.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/smbus-protocol.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
> index 7350e4b2c2fa..0edaf6069ac1 100644
> --- a/Documentation/i2c/smbus-protocol.rst
> +++ b/Documentation/i2c/smbus-protocol.rst
> @@ -282,9 +282,10 @@ This is implemented the following way in the Linux kernel:
>  I2C Block Transactions
>  ======================
>  
> -The following I2C block transactions are supported by the
> -SMBus layer and are described here for completeness.
> -They are *NOT* defined by the SMBus specification.
> +The following I2C block transactions are similar to the SMBus Block Read
> +and Write operations, except these do not have a Count byte. They are
> +supported by the SMBus layer and are described here for completeness, but
> +they are *NOT* defined by the SMBus specification.
>  
>  I2C block transactions do not limit the number of bytes transferred
>  but the SMBus layer places a limit of 32 bytes.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
