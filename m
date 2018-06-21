From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] drivers/i2c: Include SPDX-license-identifier
Date: Thu, 21 Jun 2018 11:45:54 +0200
Message-ID: <331d6408-e61f-6227-da44-0aa26078da0c@axentia.se>
References: <20180621094019.GA5348@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621094019.GA5348@sesnaco>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mawanda Henry <mawandahenrynaco@gmail.com>, mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-06-21 11:40, Mawanda Henry wrote:
> including the SPDX license identifier header  makes it easy for
> developers and machines to know the lecense that is governing the file

If you do changes like this, you should also remove the actual
license text (it follows later in the comment in this case). And
more importantly, you should make *sure* that you use the correct
SPDX tag, which you don't in this case.

So, you need to fix those issues.

Cheers,
Peter

> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
> ---
>  drivers/i2c/i2c-core-slave.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
> index 4a78c65..883ca836 100644
> --- a/drivers/i2c/i2c-core-slave.c
> +++ b/drivers/i2c/i2c-core-slave.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Linux I2C core slave support code
>   *
> 
