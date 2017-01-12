From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 10:40:06 +0100
Message-ID: <20170112104006.4dfed9b7@endymion>
References: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
        <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdALJkP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 04:40:15 -0500
In-Reply-To: <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 11 Jan 2017 03:49:21 +0200, Andy Shevchenko wrote:
> On Tue, Jan 10, 2017 at 2:16 PM, Ricardo Ribalda Delgado
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -585,9 +585,28 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
> >                  u8 command, int size, union i2c_smbus_data *data)
> >  {
> >         struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
> > +       unsigned short piix4_smba = adapdata->smba;
> >         u8 smba_en_lo;
> >         u8 port;
> >         int retval;
> > +       int timeout = 0;
> > +       int smbslvcnt;
> 
> Keep them just after your another added variable.

FWIW, I don't think this makes sense as a general rule. I'd rather have
the variables in an order which makes sense (for human readers or for
stack size optimization - unless gcc does it for us?), rather than
always adding at the same place. Is there a rationale for doing that? I
don't think shrinking the patch size is good enough a reason.

-- 
Jean Delvare
SUSE L3 Support
