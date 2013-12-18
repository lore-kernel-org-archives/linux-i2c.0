From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 04/13] i2c: isch: Use devm_request_region()
Date: Wed, 18 Dec 2013 10:42:39 +0900
Message-ID: <007401cefb92$6f521390$4df63ab0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002801cefaf4$69243d70$3b6cb850$%han@samsung.com>
 <20131217085309.1459ea27@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20131217085309.1459ea27-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, December 17, 2013 4:53 PM, Jean Delvare wrote:
> On Tue, 17 Dec 2013 15:51:28 +0900, Jingoo Han wrote:
> > Use devm_request_region() to make cleanup paths simpler.
> 
> You need to include <linux/ioport.h> for this function.

According to the i2c tree, <linux/ioport.h> is already included. :-)

./ drivers/i2c/busses/i2c-isch.c
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/kernel.h>
#include <linux/delay.h>
#include <linux/stddef.h>
#include <linux/ioport.h>      <-- Here!

> 
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-isch.c |    5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)

[.....]

> > @@ -307,7 +307,6 @@ static int smbus_sch_remove(struct platform_device *pdev)
> >  	if (sch_smba) {
> >  		i2c_del_adapter(&sch_adapter);
> >  		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > -		release_region(res->start, resource_size(res));
> >  		sch_smba = 0;
> >  	}
> 
> "res" becomes useless in the remove function as you removed the only
> use of it. So you can simplify this function further.

OK, you're right.
I will remove tge unnecessary "res" variable.
I will send V2 patch, soon.
Thank you for your comment. :-)

Best regards,
Jingoo Han
