From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 28/28] docs: i2c: writing-clients: properly name the
 stop condition
Date: Fri, 24 Jan 2020 17:01:10 +0100
Message-ID: <20200124170110.0a6110b2@endymion>
References: <20200123135103.20540-1-luca@lucaceresoli.net>
        <20200123145626.8102-1-luca@lucaceresoli.net>
        <20200123145626.8102-15-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200123145626.8102-15-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Jan 2020 15:56:26 +0100, Luca Ceresoli wrote:
> In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
> condition".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reported-by: Jean Delvare <jdelvare@suse.de>
> 
> ---
> 
> This patch is new in v2.
> ---
>  Documentation/i2c/writing-clients.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
> index 82aa33c964d3..978cc8210bf3 100644
> --- a/Documentation/i2c/writing-clients.rst
> +++ b/Documentation/i2c/writing-clients.rst
> @@ -357,9 +357,9 @@ read/written.
>  
>  This sends a series of messages. Each message can be a read or write,
>  and they can be mixed in any way. The transactions are combined: no
> -stop bit is sent between transaction. The i2c_msg structure contains
> -for each message the client address, the number of bytes of the message
> -and the message data itself.
> +stop condition is issued between transaction. The i2c_msg structure
> +contains for each message the client address, the number of bytes of the
> +message and the message data itself.
>  
>  You can read the file ``i2c-protocol`` for more information about the
>  actual I2C protocol.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

I have reviewed the whole v2 series, so any patch to which I did not
reply to retains my Reviewed-by tag.

Thanks Luca!

-- 
Jean Delvare
SUSE L3 Support
