From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 5/6] i2c: designware-baytrail: Fix race when
 resetting the semaphore
Date: Mon, 02 Jan 2017 12:06:57 +0200
Message-ID: <1483351617.9552.192.camel@linux.intel.com>
References: <20170101201521.12364-1-hdegoede@redhat.com>
         <20170101201521.12364-5-hdegoede@redhat.com>
         <1483349801.9552.187.camel@linux.intel.com>
         <d8525a7d-2363-3065-bc3d-22c7a0553d75@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14202 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdABKKB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 2 Jan 2017 05:10:01 -0500
In-Reply-To: <d8525a7d-2363-3065-bc3d-22c7a0553d75@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On Mon, 2017-01-02 at 10:55 +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-01-17 10:36, Andy Shevchenko wrote:
> > On Sun, 2017-01-01 at 21:15 +0100, Hans de Goede wrote:
> > > Use iosf_mbi_modify instead of iosf_mbi_read + iosf_mbi_write so
> > > that
> > > we keep the iosf_mbi_lock locked during the read-modify-write done
> > > to
> > > reset the semaphore.
> > > 
> > 
> > While patch itself looks good to me, I think it reduces a
> > probability to
> >  race and doesn't eliminate an issue completely.
> 
> All accesses through this register are done through the
> iosf_mbi_ helpers, and the modify helper holds the
> iosf_mbi_lock during the entire read-modify-wrtie cycle,
> so I don't see how there can still be any issue left.

Ah, seems you are right.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
>  > Can you check i915 code
> > how it's done there?
> 
> AFAIK the i915 code never takes the pmic i2c bus semaphore.
> 
> Regards,
> 
> Hans
> 
> p.s.
> 
> Since you're interested in this set, you may also be interested
> in this RFC patch-set:
> 
> https://www.spinics.net/lists/intel-gfx/msg115833.html
> 
> 
> > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Changes in v5:
> > > -New patch in v5 of this patch-set
> > > ---
> > >  drivers/i2c/busses/i2c-designware-baytrail.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> > > b/drivers/i2c/busses/i2c-designware-baytrail.c
> > > index 650a700..8df529c 100644
> > > --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> > > +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> > > @@ -47,15 +47,8 @@ static int get_sem(struct dw_i2c_dev *dev, u32
> > > *sem)
> > > 
> > >  static void reset_semaphore(struct dw_i2c_dev *dev)
> > >  {
> > > -	u32 data;
> > > -
> > > -	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > > PUNIT_SEMAPHORE, &data)) {
> > > -		dev_err(dev->dev, "iosf failed to reset punit
> > > semaphore during read\n");
> > > -		return;
> > > -	}
> > > -
> > > -	data &= ~PUNIT_SEMAPHORE_BIT;
> > > -	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> > > PUNIT_SEMAPHORE, data))
> > > +	if (iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > > PUNIT_SEMAPHORE,
> > > +			    0, PUNIT_SEMAPHORE_BIT))
> > >  		dev_err(dev->dev, "iosf failed to reset punit
> > > semaphore during write\n");
> > > 
> > >  	pm_qos_update_request(&dev->pm_qos,
> > > PM_QOS_DEFAULT_VALUE);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
