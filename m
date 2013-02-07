From: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH V2] i2c: davinci: update to devm_* API
Date: Thu, 7 Feb 2013 03:02:47 +0000
Message-ID: <A4887BF146CD57468F700B415D2F470158327B@DBDE01.ent.ti.com>
References: <1360149736-32523-1-git-send-email-manishv.b@ti.com>
	<511243C8.8060400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <511243C8.8060400-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sergei,

On Wed, Feb 06, 2013 at 17:21:36, Sergei Shtylyov wrote:
> Hello.
> 
> On 06-02-2013 15:22, Vishwanathrao Badarkhe, Manish wrote:
> 
> > Update the code to use devm_* API so that driver core will manage 
> > resources.
> 
> > Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
> > ---
> > Changes since V1:
> >    - Rebase on top of v3.8-rc6 of linus tree.
> >    - Apply devm operation on clk_get.
> 
> > :100644 100644 6a0a553... da4e218... M	drivers/i2c/busses/i2c-davinci.c
> >   drivers/i2c/busses/i2c-davinci.c |   45 +++++++++++---------------------------
> >   1 files changed, 13 insertions(+), 32 deletions(-)
> 
> > diff --git a/drivers/i2c/busses/i2c-davinci.c 
> > b/drivers/i2c/busses/i2c-davinci.c
> > index 6a0a553..da4e218 100644
> > --- a/drivers/i2c/busses/i2c-davinci.c
> > +++ b/drivers/i2c/busses/i2c-davinci.c
> [...]
> > @@ -699,22 +693,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
> >   		dev->pdata = &davinci_i2c_platform_data_default;
> >   	}
> >
> > -	dev->clk = clk_get(&pdev->dev, NULL);
> > +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> >   	if (IS_ERR(dev->clk)) {
> >   		r = -ENODEV;
> >   		goto err_free_mem;
> >   	}
> >   	clk_prepare_enable(dev->clk);
> >
> > -	dev->base = ioremap(mem->start, resource_size(mem));
> > +	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
> >   	if (!dev->base) {
> >   		r = -EBUSY;
> 
>     Comment to devm_request_and_ioremap() suggests returning -EADDRNOTAVAIL on failure. -EBUSY wasn't the right code even before this change, should have been -ENOMEM.

Oh, you are right. I will change this to -EADDRNOTAVAIL. Thanks for 
pointing this out.

Thanks, 
Manish Badarkhe
