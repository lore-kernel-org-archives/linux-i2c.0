From: =?utf-8?Q?=C3=89meric?= Vigier
	<emeric.vigier-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: Re: how to gracefully unload an i2c driver if chip not detected?
Date: Mon, 22 Apr 2013 07:18:35 -0400 (EDT)
Message-ID: <1001950529.54.1366629515916.JavaMail.root@mail>
References: <20130421154832.GA9593@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130421154832.GA9593-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thanks a lot Wolfram!

Emeric

----- Mail original -----
> Hi,
> 
> thanks, that helped, I think:
> 
> >     //test for device presence
> >     if(vcnl4010_read_transfer(data, VCNL4010_PROD_ID_VER, &reg_val,
> >     1) !=0 )
> >     {
> >         pr_err("vcnl4010: Device not found!");
> >         goto nochip;
> >     }
> > 
> >     if(reg_val != 0x21)
> >     {
> >         pr_err("vcnl4010: Found device isn't a vcnl4010, is a
> >         vcnl4000 installed?");
> >         goto badchip;
> >     }
> 
> You should set 'ret = -Esomething' here. Currently, you return 0
> which
> means success, so the driver core thinks it may call the suspend
> function.
> 
> Regards,
> 
>    Wolfram
> 
> 
