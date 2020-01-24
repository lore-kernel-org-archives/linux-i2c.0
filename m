From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 27/28] docs: i2c: i2c-protocol: use same wording as
 smbus-protocol
Date: Fri, 24 Jan 2020 16:59:33 +0100
Message-ID: <20200124165933.2613b3a0@endymion>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
        <20200123145626.8102-1-luca@lucaceresoli.net>
        <20200123145626.8102-14-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200123145626.8102-14-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Jan 2020 15:56:25 +0100, Luca Ceresoli wrote:
> In smbus-protocol.rst we use the text "Implemented by" for the same meaning
> as "This corresponds to". Change everything to "Implemented by" for
> coherency.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reported-by: Jean Delvare <jdelvare@suse.de>
> 
> ---
> 
> This patch is new in v2.
> ---
>  Documentation/i2c/i2c-protocol.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/i2c-protocol.rst b/Documentation/i2c/i2c-protocol.rst
> index 6aafc3880bce..b2092f8f815d 100644
> --- a/Documentation/i2c/i2c-protocol.rst
> +++ b/Documentation/i2c/i2c-protocol.rst
> @@ -28,7 +28,7 @@ Count (8 bits)  A data byte containing the length of a block operation.
>  Simple send transaction
>  =======================
>  
> -This corresponds to i2c_master_send()::
> +Implemented by i2c_master_send()::
>  
>    S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P
>  
> @@ -36,7 +36,7 @@ This corresponds to i2c_master_send()::
>  Simple receive transaction
>  ==========================
>  
> -This corresponds to i2c_master_recv()::
> +Implemented by i2c_master_recv()::
>  
>    S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
>  
> @@ -44,7 +44,7 @@ This corresponds to i2c_master_recv()::
>  Combined transactions
>  =====================
>  
> -This corresponds to i2c_transfer().
> +Implemented by i2c_transfer().
>  
>  They are just like the above transactions, but instead of a stop
>  condition P a start condition S is sent and the transaction continues.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
