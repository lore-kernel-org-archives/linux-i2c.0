From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 11/26] docs: i2c: smbus: fix link syntax
Date: Mon, 20 Jan 2020 15:10:01 +0100
Message-ID: <20200120151001.29a6b53d@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-11-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbgATOKE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Jan 2020 09:10:04 -0500
In-Reply-To: <20200105225012.11701-11-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 23:49:57 +0100, Luca Ceresoli wrote:
> Use the proper ReST syntax to generate a valid hyperlink.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/smbus-protocol.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
> index e30eb1d274c6..1600b09ec0be 100644
> --- a/Documentation/i2c/smbus-protocol.rst
> +++ b/Documentation/i2c/smbus-protocol.rst
> @@ -27,8 +27,8 @@ a different protocol operation entirely.
>  Each transaction type corresponds to a functionality flag. Before calling a
>  transaction function, a device driver should always check (just once) for
>  the corresponding functionality flag to ensure that the underlying I2C
> -adapter supports the transaction in question. See
> -<file:Documentation/i2c/functionality.rst> for the details.
> +adapter supports the transaction in question. See :doc:`functionality` for
> +the details.
>  
>  
>  Key to symbols

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
