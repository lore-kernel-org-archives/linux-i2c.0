From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bad dev_get_platdata() conversion
Date: Tue, 10 Sep 2013 18:25:13 +0900
Message-ID: <007401ceae07$a70b41e0$f521c5a0$%han@samsung.com>
References: <1378409024-13432-1-git-send-email-olof@lixom.net>
 <20130910092001.GB4625@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20130910092001.GB4625@katana>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, 'Olof Johansson' <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: 'Sekhar Nori' <nsekhar-l0cyMroinI0@public.gmane.org>, 'Kevin Hilman' <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 10, 2013 6:20 PM, Wolfram Sang wrote:
> On Thu, Sep 05, 2013 at 12:23:44PM -0700, Olof Johansson wrote:
> > commit 6d4028c644e (i2c: use dev_get_platdata()) did a bad conversion
> > of this one case:
> >
> > drivers/i2c/busses/i2c-davinci.c: In function 'davinci_i2c_probe':
> > drivers/i2c/busses/i2c-davinci.c:665:2: warning: passing argument 1 of
> > 	'dev_get_platdata' from incompatible pointer type [enabled by default]
> >
> > Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> 
> Gosh, need to find out why my build-tests failed on that. Thanks!
> 
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> Jingoo Han: Did you buildtest?

I always did builtest for the patch.
However, I cannot know why it makes build error.
Anyway, sorry for making this build error.

Best regards,
Jingoo Han

> 
> > ---
> >  drivers/i2c/busses/i2c-davinci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> > index 5747341..132369f 100644
> > --- a/drivers/i2c/busses/i2c-davinci.c
> > +++ b/drivers/i2c/busses/i2c-davinci.c
> > @@ -662,7 +662,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
> >  #endif
> >  	dev->dev = &pdev->dev;
> >  	dev->irq = irq->start;
> > -	dev->pdata = dev_get_platdata(&dev->dev);
> > +	dev->pdata = dev_get_platdata(&pdev->dev);
> >  	platform_set_drvdata(pdev, dev);
> >
> >  	if (!dev->pdata && pdev->dev.of_node) {
> > --
> > 1.7.10.4
> >
