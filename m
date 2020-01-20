From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 17/26] docs: i2c: i2c-protocol: fix typo
Date: Mon, 20 Jan 2020 16:15:08 +0100
Message-ID: <20200120161508.5564f256@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-17-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-17-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The patch's subject line is wrong, it touches smbus-protocol, not
i2c-protocol.

On Sun,  5 Jan 2020 23:50:03 +0100, Luca Ceresoli wrote:
> The subject is plural, fix the verb.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/smbus-protocol.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
> index 3c0fb3a2044d..de7285de5e93 100644
> --- a/Documentation/i2c/smbus-protocol.rst
> +++ b/Documentation/i2c/smbus-protocol.rst
> @@ -145,7 +145,7 @@ SMBus Write Word
>  Implemented by i2c_smbus_write_word_data()
>  
>  This is the opposite of the Read Word operation. 16 bits
> -of data is written to a device, to the designated register that is
> +of data are written to a device, to the designated register that is
>  specified through the Comm byte.::
>  
>    S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] P

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
