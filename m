From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 07/13] i2c: pnx: Use devm_*() functions
Date: Fri, 10 Jan 2014 09:34:06 +0900
Message-ID: <001f01cf0d9b$aba03910$02e0ab30$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
 <008b01cf0a88$85df55f0$919e01d0$%han@samsung.com>
 <20140109212422.GB3866@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140109212422.GB3866@katana>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, January 10, 2014 6:24 AM, Wolfram Sang wrote:
> On Mon, Jan 06, 2014 at 11:39:29AM +0900, Jingoo Han wrote:
> > Use devm_*() functions to make cleanup paths simpler.
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> > Changes since V1:
> > - Use devm_ioremap_resource() to make the code simpler, per Wolfram Sang.
> 
> Yes, you used this function but you did not remove all the stuff which
> can go now since you use this function.

Hi Wolfram,

Which thing do I have to remove additionally?
You mean the following?

res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
if (!res) {
	dev_err(&pdev->dev, "Unable to get mem resource.\n");

I think that this error message is not necessary. So, I will
remove it. Please let me know additional things to be remove.
Thank you.

Best regards,
Jingoo Han
