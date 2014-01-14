From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 07/13] i2c: pnx: Use devm_*() functions
Date: Tue, 14 Jan 2014 09:09:52 +0900
Message-ID: <002101cf10bc$f2a7c110$d7f74330$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
 <008b01cf0a88$85df55f0$919e01d0$%han@samsung.com>
 <20140109212422.GB3866@katana>
 <001f01cf0d9b$aba03910$02e0ab30$%han@samsung.com>
 <20140113122907.GB2586@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140113122907.GB2586@katana>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, January 13, 2014 9:29 PM, Wolfram Sang wrote:
> 
> > Which thing do I have to remove additionally?
> 
> Just have a close look at your patches and what you removed. You'll
> figure. Hint: It is related to the resource.
> 
> > You mean the following?
> >
> > res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > if (!res) {
> > 	dev_err(&pdev->dev, "Unable to get mem resource.\n");
> 
> That's one thing, there is more.
> 
> >
> > I think that this error message is not necessary. So, I will
> > remove it.
> 
> Yeah, just have a look at the actual implementation of
> devm_ioremap_resource and you will *know* that it is not necessary.

Aha, I see. Sorry, I forgot it.
The return value of platform_get_resource() is checked by
devm_ioremap_resource(); thus, the redundant return value check
of platform_get_resource() should be removed as below:

Also, 'alg_data->base' is not used anymore, so it should be
removed too.

	/* Register I/O resource */
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	alg_data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(alg_data->ioaddr))
		return PTR_ERR(alg_data->ioaddr);

> 
> > Please let me know additional things to be remove.
> 
> I believe in teaching fishing rather than giving fish.

Thank you for your guidance. :-)
I will send the v3 patch, soon.

Best regards,
Jingoo Han
