Return-Path: <SRS0=lg4Y=CG=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8414C433E6
	for <linux-i2c@archiver.kernel.org>; Fri, 28 Aug 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901B520872
	for <linux-i2c@archiver.kernel.org>; Fri, 28 Aug 2020 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598632840;
	bh=11glsaKxgnVpqZnR8QQ+//8pFHFrfxDltSBMzzN/AcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=iU+z0hWM0JtTD57nkQ7KMNnSUp4ijhKv+jZucBnqm8I0g4/ay4Rfn1/ADnEksoKfo
	 yXLuwXnJC5tC9rfabW1/eJ9B/WbU6AFpu5tKvqsNU360303JOgf82VERKYF191qHjY
	 1DvS/AGP11xoom1jQ4JMOHhmXLEEFNXTHTTONKQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1Qkk (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgH1Qki (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 28 Aug 2020 12:40:38 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FD520872;
        Fri, 28 Aug 2020 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598632837;
        bh=11glsaKxgnVpqZnR8QQ+//8pFHFrfxDltSBMzzN/AcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IXB/bTyNunpzFzSx9cyTyhkR7klery+5WRD/XHzkUg2mx6zxmYDymHyTNjd8IuiBp
         MXRsmfBJZ0k3f9MJtFoQnxnuM2ReMUoaymtReYqn/+y9qLyeJx5yD7xtDdrScXa5mL
         ngA48UZkgc+kv6OOkHvsJPpWPXTKmWo+6MH44O40=
Date:   Fri, 28 Aug 2020 11:40:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: [PATCH] i2c: i801: Fix resume bug
Message-ID: <20200828164036.GA2158745@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828085753.GH1343@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Aug 28, 2020 at 10:57:53AM +0200, Wolfram Sang wrote:
> On Tue, Aug 25, 2020 at 07:13:03PM +0200, Jean Delvare wrote:
> > From: Volker Rümelin <vr_qemu@t-online.de>
> > 
> > On suspend the original host configuration gets restored. The
> > resume routine has to undo this, otherwise the SMBus master
> > may be left in disabled state or in i2c mode.
> > 
> > [JD: Rebased on v5.8, simplified a condition.]
> > 
> > Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> > I noticed this bug in a QEMU x86_64 q35 VM booted with OVMF. OVMF
> > doesn't initialize the SMBus master. After 1s of SMBus inactivity
> > autosuspend disables the SMBus master. To reproduce please note QEMU's
> > ICH9 SMBus emulation does not handle interrupts and it's necessary
> > to pass the parameter disable_features=0x10 to the i2c_i801 driver.
> > 
> > Note from JD: I can't test this.
> 
> Thanks for keeping up with this one. I have one high level comment but I
> hope Volker, Bjorn, and Vaibhav have comments/tags, too.
> 
> > +static unsigned char i801_setup_hstcfg(unsigned char hstcfg)
> > +{
> > +	hstcfg &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
> > +	hstcfg |= SMBHSTCFG_HST_EN;
> > +	return hstcfg;
> > +}
> 
> What about putting the write to SMBHSTCFG here, too. When I read the
> function name, I assumed it will do that.

From the point of view of suspend/resume, I think it's nice to have a
write in i801_resume() to match the one in i801_suspend().

Putting the write inside i801_setup_hstcfg() would mean i801_probe()
would do *two* writes instead of the one it currently does.

But I don't really care other than that :)

> > @@ -1961,8 +1965,11 @@ static int i801_suspend(struct device *d
> >  
> >  static int i801_resume(struct device *dev)
> >  {
> > -	struct i801_priv *priv = dev_get_drvdata(dev);
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	struct i801_priv *priv = pci_get_drvdata(pci_dev);
> > +	unsigned char hstcfg = i801_setup_hstcfg(priv->original_hstcfg);
> >  
> > +	pci_write_config_byte(pci_dev, SMBHSTCFG, hstcfg);
> 
> And on top of that, we could skip the 'hstcfg' variable here.
> 


