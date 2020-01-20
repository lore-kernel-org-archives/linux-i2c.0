From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 10/26] docs: i2c: i2c-protocol: use proper names for ACK
 and NACK
Date: Mon, 20 Jan 2020 14:50:49 +0100
Message-ID: <20200120145049.32239ee2@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-10-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATNuw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Jan 2020 08:50:52 -0500
In-Reply-To: <20200105225012.11701-10-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:49:56 +0100, Luca Ceresoli wrote:
> Use the proper ACK and NACK naming from the I2C specification instead of
> "accept" and "reverse accept".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/i2c-protocol.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/i2c-protocol.rst b/Documentation/i2c/i2c-protocol.rst
> index 66adac3a5afd..9a4ac944cf9d 100644
> --- a/Documentation/i2c/i2c-protocol.rst
> +++ b/Documentation/i2c/i2c-protocol.rst
> @@ -11,7 +11,7 @@ Key to symbols
>  S               Start condition
>  P               Stop condition
>  Rd/Wr (1 bit)   Read/Write bit. Rd equals 1, Wr equals 0.
> -A, NA (1 bit)   Accept and reverse accept bit.
> +A, NA (1 bit)   Acknowledge (ACK) and Not Acknowledge (NACK) bit
>  Addr  (7 bits)  I2C 7 bit address. Note that this can be expanded as usual to
>                  get a 10 bit I2C address.
>  Comm  (8 bits)  Command byte, a data byte which often selects a register on

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
