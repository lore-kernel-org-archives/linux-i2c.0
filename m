Return-Path: <SRS0=/6/K=CK=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9DAC433E6
	for <linux-i2c@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BB5205CB
	for <linux-i2c@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIAJfI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:35:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:41080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIAJfI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 1 Sep 2020 05:35:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 448D0B7DB;
        Tue,  1 Sep 2020 09:35:07 +0000 (UTC)
Date:   Tue, 1 Sep 2020 11:35:05 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Volker =?UTF-8?B?UsO8bWVsaW4=?= <vr_qemu@t-online.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] i2c: i801: Fix resume bug
Message-ID: <20200901113505.68faaa49@endymion>
In-Reply-To: <20200831145929.GA11480@gmail.com>
References: <20200825191303.4a258073@endymion>
        <20200828085753.GH1343@ninjato>
        <20200831145929.GA11480@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 31 Aug 2020 20:29:29 +0530, Vaibhav Gupta wrote:
> On Fri, Aug 28, 2020 at 10:57:53AM +0200, Wolfram Sang wrote:
> > On Tue, Aug 25, 2020 at 07:13:03PM +0200, Jean Delvare wrote:  
> > > @@ -1961,8 +1965,11 @@ static int i801_suspend(struct device *d
> > >  
> > >  static int i801_resume(struct device *dev)
> > >  {
> > > -	struct i801_priv *priv = dev_get_drvdata(dev);
> > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +	struct i801_priv *priv = pci_get_drvdata(pci_dev);
> > > +	unsigned char hstcfg = i801_setup_hstcfg(priv->original_hstcfg);
> > >  
> > > +	pci_write_config_byte(pci_dev, SMBHSTCFG, hstcfg);  
> > 
> > And on top of that, we could skip the 'hstcfg' variable here.
>
> Add extra parameter of "struct pci_dev*" type in i801_setup_hstcfg().

That was my first approach, yes. But then I tried passing the struct
i801_priv * instead, and it looks even neater to me (but I'm biased
because I did it). I'll post that for review shortly.

> We can
> also skip the introduction of "struct pci_dev*" type variable in .resume()
> then. Just use to_pci_dev(dev) .

I don't really mind keeping the pci_dev variable, for symmetry with
.suspend(), and the compiler will optimize it away anyway. There's a
minor cleanup possible in this area though, to which I'll give a try.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
