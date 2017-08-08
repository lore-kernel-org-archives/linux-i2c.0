From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] i2c: imx: Remove a useless test in
 'i2c_imx_init_recovery_info()'
Date: Tue, 8 Aug 2017 09:04:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708080904410.2012@hadrien>
References: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr> <20170807063617.5wr4i7b7k72uyrit@pengutronix.de> <alpine.DEB.2.20.1708070916300.2061@hadrien> <1dcf5dc4-4b38-bbd1-f0e0-94a37182d46d@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-24956964-1502175894=:2012"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1dcf5dc4-4b38-bbd1-f0e0-94a37182d46d@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--8323329-24956964-1502175894=:2012
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT



On Tue, 8 Aug 2017, Christophe JAILLET wrote:

> Le 07/08/2017 à 09:16, Julia Lawall a écrit :
> >
> > On Mon, 7 Aug 2017, Uwe Kleine-König wrote:
> >
> > > On Mon, Aug 07, 2017 at 01:49:53AM +0200, Christophe JAILLET wrote:
> > > > 'devm_pinctrl_get()' never returns NULL, so this test can be simplified.
> > > That's wrong. If CONFIG_PINCTRL is disabled devm_pinctrl_get returns
> > > NULL. But I think this shouldn't be considered an error, so your change
> > > is right, just the commit log is not.
> > >
> > > > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > > > index 54a47b40546f..7e84662fe1c0 100644
> > > > --- a/drivers/i2c/busses/i2c-imx.c
> > > > +++ b/drivers/i2c/busses/i2c-imx.c
> > > > @@ -997,7 +997,7 @@ static int i2c_imx_init_recovery_info(struct
> > > > imx_i2c_struct *i2c_imx,
> > > >   	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
> > > >
> > > >   	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> > > > -	if (!i2c_imx->pinctrl || IS_ERR(i2c_imx->pinctrl)) {
> > > > +	if (IS_ERR(i2c_imx->pinctrl)) {
> > > >   		dev_info(&pdev->dev, "can't get pinctrl, bus recovery
> > > > not supported\n");
> > > >   		return PTR_ERR(i2c_imx->pinctrl);
> > > >   	}
> > > Side note: I'm not sure, this construct is valid. IIRC PTR_ERR should
> > > only be called for values x where IS_ERR(x) is true. Here it is at least
> > > surprising that an message hints to a problem but the return code is 0.
> > >
> > > @Julia: I'm sure coccinelle can find more of those?!
> > I only found a few.  Christophe, if you want to fix tem up, please go
> > ahead.
>
> Hi Julia,
>
> I've looked quickly at your output, and can't see what could/should be done in
> the spotted cases.
>    e100.c: a comment says that 'If it's NULL, then no ucode is required', so,
> the behavior looks ok to me
>    chcr_algo.c: function 'create_wr_fn' is passed as a parameter. I've no way
> to make sure of its behavior, so the code could be valid. I won't touch it.
>    acl.c:  by code inspection, the way the code is written looks valid to me.
> We have NULL if the a call in 'ocfs2_get_acl_nolock' returns -ENODATA. Not
> that strange to return success in this case
>
> So, personally, I won't propose anything on these files. Up to anyone to dig
> further than me.

OK, thanks for looking at them.  I do find it odd to exploit PTR_ERR to
return a success value.  Maybe I will check with the maintainers in the
uncommented cases.

julia


>
> CJ
> > julia
> >
> > diff -u -p /var/linuxes/linux-next/drivers/net/ethernet/intel/e100.c
> > /tmp/nothing/drivers/net/ethernet/intel/e100.c
> > --- /var/linuxes/linux-next/drivers/net/ethernet/intel/e100.c
> > +++ /tmp/nothing/drivers/net/ethernet/intel/e100.c
> > @@ -1370,8 +1370,6 @@ static inline int e100_load_ucode_wait(s
> >
> >          fw = e100_request_firmware(nic);
> >          /* If it's NULL, then no ucode is required */
> > -       if (!fw || IS_ERR(fw))
> > -               return PTR_ERR(fw);
> >
> >          if ((err = e100_exec_cb(nic, (void *)fw, e100_setup_ucode)))
> >                  netif_err(nic, probe, nic->netdev,
> > diff -u -p /var/linuxes/linux-next/drivers/i2c/busses/i2c-imx.c
> > /tmp/nothing/drivers/i2c/busses/i2c-imx.c
> > --- /var/linuxes/linux-next/drivers/i2c/busses/i2c-imx.c
> > +++ /tmp/nothing/drivers/i2c/busses/i2c-imx.c
> > @@ -997,9 +997,7 @@ static int i2c_imx_init_recovery_info(st
> >          struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
> >
> >          i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
> > -       if (!i2c_imx->pinctrl || IS_ERR(i2c_imx->pinctrl)) {
> >                  dev_info(&pdev->dev, "can't get pinctrl, bus recovery not
> > supported\n");
> > -               return PTR_ERR(i2c_imx->pinctrl);
> >          }
> >
> >          i2c_imx->pinctrl_pins_default =
> > pinctrl_lookup_state(i2c_imx->pinctrl,
> > diff -u -p /var/linuxes/linux-next/drivers/crypto/chelsio/chcr_algo.c
> > /tmp/nothing/drivers/crypto/chelsio/chcr_algo.c
> > --- /var/linuxes/linux-next/drivers/crypto/chelsio/chcr_algo.c
> > +++ /tmp/nothing/drivers/crypto/chelsio/chcr_algo.c
> > @@ -3159,8 +3159,6 @@ static int chcr_aead_op(struct aead_requ
> >          skb = create_wr_fn(req, u_ctx->lldi.rxq_ids[ctx->rx_qidx], size,
> >                             op_type);
> >
> > -       if (IS_ERR(skb) || !skb)
> > -               return PTR_ERR(skb);
> >
> >          skb->dev = u_ctx->lldi.ports[0];
> >          set_wr_txq(skb, CPL_PRIORITY_DATA, ctx->tx_qidx);
> > diff -u -p /var/linuxes/linux-next/fs/ocfs2/acl.c
> > /tmp/nothing/fs/ocfs2/acl.c
> > --- /var/linuxes/linux-next/fs/ocfs2/acl.c
> > +++ /tmp/nothing/fs/ocfs2/acl.c
> > @@ -331,8 +331,6 @@ int ocfs2_acl_chmod(struct inode *inode,
> >                  return 0;
> >
> >          acl = ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
> > -       if (IS_ERR(acl) || !acl)
> > -               return PTR_ERR(acl);
> >          ret = __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
> >          if (ret)
> >                  return ret;
> >
> >
> >
> >
> >
> > > Best regards
> > > Uwe
> > >
> > > --
> > > Pengutronix e.K.                           | Uwe Kleine-König            |
> > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe kernel-janitors"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
>
>
>
--8323329-24956964-1502175894=:2012--
