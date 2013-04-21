From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: how to gracefully unload an i2c driver if chip not detected?
Date: Sun, 21 Apr 2013 17:48:32 +0200
Message-ID: <20130421154832.GA9593@the-dreams.de>
References: <20130409092625.GD3624@the-dreams.de>
 <228256972.786837.1366515514850.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <228256972.786837.1366515514850.JavaMail.root@mail>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-15?Q?=C9meric?= Vigier <emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

thanks, that helped, I think:

>     //test for device presence
>     if(vcnl4010_read_transfer(data, VCNL4010_PROD_ID_VER, &reg_val, 1) !=0 )
>     {
>         pr_err("vcnl4010: Device not found!");
>         goto nochip;
>     }
> 
>     if(reg_val != 0x21)
>     {
>         pr_err("vcnl4010: Found device isn't a vcnl4010, is a vcnl4000 installed?");
>         goto badchip;
>     }

You should set 'ret = -Esomething' here. Currently, you return 0 which
means success, so the driver core thinks it may call the suspend
function.

Regards,

   Wolfram
