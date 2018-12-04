From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Date: Tue, 4 Dec 2018 12:43:04 +0100
Message-ID: <20181204114304.GA26798@osadl.at>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 04, 2018 at 11:16:59AM +0000, Peter Rosin wrote:
> Hi!
> 
> This patch looks like a good idea. However, a nitpick below.
> 
> On 2018-12-01 11:01, Nicholas Mc Guire wrote:
> > devm_kstrdup() may return NULL if internal allocation failed.
> > Thus using  name, value  is unsafe without being checked. As
> > i2c_demux_pinctrl_probe() can return -ENOMEM in other cases
> > a dev_err() message is included to make the failure location
> > clear.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
> > ---
> > 
> > Problem located with experimental coccinelle script
> > 
> > Q: The use of devm_kstrdup() seems a bit odd while technically not wrong,
> >    personally I think devm_kasprintf() would be more suitable here.
> > 
> > Patch was compile tested with: multi_v7_defconfig 
> > (implies I2C_DEMUX_PINCTRL=y)
> > 
> > Patch is against 4.20-rc4 (localversion-next is next-20181130)
> > 
> >  drivers/i2c/muxes/i2c-demux-pinctrl.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > index 035032e..c466999 100644
> > --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> > @@ -244,6 +244,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
> >  
> >  		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
> >  		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
> > +		if (!props[i].name || !props[i].value) {
> > +			dev_err(&pdev->dev,
> > +				"chan %d name, value allocation failed\n", i);
> 
> Please drop this memory allocation failure message. You should get such a
> message from devm_kstrdup.
>
thanks for the review - will drop the dev_err() then an resend 

thx!
hofrat
 
> 
> > +			err = -ENOMEM;
> > +			goto err_rollback;
> > +		}
> >  		props[i].length = 3;
> >  
> >  		of_changeset_init(&priv->chan[i].chgset);
> > 
> 
