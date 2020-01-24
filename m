From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 11/28] docs: i2c: smbus: fix link syntax
Date: Fri, 24 Jan 2020 15:57:31 +0100
Message-ID: <20200124155731.5573076a@endymion>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
        <20200123135103.20540-12-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123135103.20540-12-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Jan 2020 14:50:46 +0100, Luca Ceresoli wrote:
> Use the proper ReST syntax to generate a valid hyperlink.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Subject line is incorrect, it should have "smbus-protocol:" instead of
"smbus:" for consistency with the other patches.

Other than that this is still

Reviewed-by: Jean Delvare <jdelvare@suse.de>

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


-- 
Jean Delvare
SUSE L3 Support
