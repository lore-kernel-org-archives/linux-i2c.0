From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c: stub: move module_init/exit annotations to the
 proper place
Date: Thu, 18 May 2017 09:58:42 +0200
Message-ID: <20170518095842.7f3b612a@endymion>
References: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 16 May 2017 13:21:04 +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-stub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> index 06af583d510150..0aa4d646f8fb26 100644
> --- a/drivers/i2c/i2c-stub.c
> +++ b/drivers/i2c/i2c-stub.c
> @@ -406,16 +406,15 @@ static int __init i2c_stub_init(void)
>  	i2c_stub_free();
>  	return ret;
>  }
> +module_init(i2c_stub_init);
>  
>  static void __exit i2c_stub_exit(void)
>  {
>  	i2c_del_adapter(&stub_adapter);
>  	i2c_stub_free();
>  }
> +module_exit(i2c_stub_exit);
>  
>  MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
>  MODULE_DESCRIPTION("I2C stub driver");
>  MODULE_LICENSE("GPL");
> -
> -module_init(i2c_stub_init);
> -module_exit(i2c_stub_exit);

I'm not sure on what you base your claim that this is the "proper
place". checkpatch doesn't complain about either, and if anything, the
original style (module_init/exit) at end of file seems a lot more
popular through the kernel tree.

-- 
Jean Delvare
SUSE L3 Support
