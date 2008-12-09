From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 12/33] i2c: Make static
Date: Tue, 9 Dec 2008 20:04:09 +0100
Message-ID: <20081209200409.17fac29f@hyperion.delvare>
References: <493EA286.7080500@gmail.com>
	<493EBBD0.6070201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755166AbYLITEa@vger.kernel.org>
In-Reply-To: <493EBBD0.6070201@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 09 Dec 2008 19:41:20 +0100, Roel Kluin wrote:
> Sparse asked whether these could be static.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  drivers/i2c/i2c-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c6a63f4..1049615 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1699,7 +1699,8 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
>   * This executes the SMBus "process call" protocol, returning negative errno
>   * else a 16-bit unsigned "word" received from the device.
>   */
> -s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
> +static s32 i2c_smbus_process_call(struct i2c_client *client, u8 command,
> +		u16 value)
>  {
>  	union i2c_smbus_data data;
>  	int status;

Nack:

drivers/i2c/i2c-core.c:EXPORT_SYMBOL(i2c_smbus_process_call);

-- 
Jean Delvare
