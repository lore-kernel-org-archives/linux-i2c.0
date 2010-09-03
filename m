From: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Fri, 3 Sep 2010 19:01:52 +0900
Message-ID: <000801cb4b4f$0bc76e70$66f8800a@maildom.okisemi.com>
References: <4C80A089.508@dsn.okisemi.com> <1283501437.1797.441.camel@Joe-Laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

----- Original Message ----- 
From: "Joe Perches" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
To: "Masayuki Ohtak" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>; "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>;
"Crane Cai" <crane.cai-5C7GfCeVMHo@public.gmane.org>; "Samuel Ortiz" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>;
"Ralf Baechle" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>; "srinidhi kasagar" <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
<arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Tomoya MORINAGA" <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Arnd Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>
Sent: Friday, September 03, 2010 5:10 PM
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35


> On Fri, 2010-09-03 at 16:15 +0900, Masayuki Ohtak wrote:
> []
> > +#define pch_dbg(adap, fmt, arg...)  \
> > + dev_dbg(adap->pch_adapter.dev.parent, "%s :"fmt, __func__, ##arg)
> > +
> > +#define pch_err(adap, fmt, arg...)  \
> > + dev_err(adap->pch_adapter.dev.parent, "%s :"fmt, __func__, ##arg)
> > +
> > +#define pch_pci_err(pdev, fmt, arg...)  \
> > + dev_err(&pdev->dev, "%s :"fmt, __func__, ##arg)
> > +#define pch_pci_dbg(pdev, fmt, arg...)  \
> > + dev_dbg(&pdev->dev, "%s :"fmt, __func__, ##arg)
>
> OK, but it seems careless because the two types
> are not uniformly indented, there's a blank line
> between pch_dbg and pch_err, and the two pch_pci_<level>
> defines are in the reverse order without a blank line
> between them.
>
> I think it's better to use separate multiple strings
> that are concatentated by the preprocessor like:
> "%s :" fmt
> not
> "%s :"fmt
>
> Almost all code in kernel uses "%s: " to format __func__.
> Some use "%s(): ".  I think "%s :" is unique.
>
> The rest of the logging messages look good.
>
> Some other comments:
>
> > + if ((pch_wait_for_xfer_complete(adap) == 0) &&
> > + (pch_getack(adap) == 0)) {
>
> This would look better as:
>
> if ((pch_wait_for_xfer_complete(adap) == 0) &&
>     (pch_getack(adap) == 0)) {
>
> > + if ((pch_wait_for_xfer_complete(adap) == 0)
> > +     && (pch_getack(adap) == 0)) {
>
> Here too.
>
> > + for (i = 0; i < PCH_MAX_CHN; i++) {
> > + while ((adap_info->pch_data[i].pch_xfer_in_progress)) {
> > + /* Wait until all channel transfers are completed */
> > + msleep(1);
> > + }
> > + /* Disable the i2c interrupts */
> > + pch_disbl_int(&adap_info->pch_data[i]);
> > + }
>
> Would it be better to disable all possible interrupts first
> or do you need to disable them in order?

* Your proposal
If pch_disbl_int is executed firstly,
queued data  is destroyed.

 * Current spec
If checking status firstly,
all data can be sent.

Thus, I think current spec is better than yours.

>
> Something like:
>
> bool *disabled = kzalloc(PCH_MAX_CHN * sizeof(bool), GFP_KERNEL);
> /*
>  * or a static with a memset, or check something
>  * like pch_is_int_enabled(&adap_info->pch_data[i])
>  * then remove the else because the kzalloc couldn't fail.
>  */
> if (disabled) {
> bool alldone;
> do {
> alldone = true;
> for (i = 0; i < PCH_MAX_CHN; i++) {
> if (!adap_info->pch_data[i].pch_xfer_in_progress &&
>     !disabled[i])) {
> pch_disbl_int(&adap_info->pch_data[i]);
> disabled[i] = true;
> } else
> alldone = false;
> }
> if (!alldone) {
> /* Wait until all channel transfers are completed */
> msleep(1);
> }
> } while (!alldone);
> kfree(disabled);
>
> /* remove the else if there's a static etc */
>
> } else {
> for (i = 0; i < PCH_MAX_CHN; i++) {
> while ((adap_info->pch_data[i].pch_xfer_in_progress)) {
> /* Wait until all channel transfers are completed */
> msleep(1);
> }
> /* Disable the i2c interrupts */
> pch_disbl_int(&adap_info->pch_data[i]);
> }
> }
>
> cheers, Joe
>

I will resubmit modified patch soon.


Thanks, Ohtake(OKISemi)
