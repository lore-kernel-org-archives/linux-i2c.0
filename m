From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: Remove a useless test in
 'i2c_imx_init_recovery_info()'
Date: Tue, 8 Aug 2017 10:15:01 +0200
Message-ID: <20170808081501.jxhid5rgfeqpshfw@pengutronix.de>
References: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr>
 <20170807063617.5wr4i7b7k72uyrit@pengutronix.de>
 <9279b880-558a-17fb-404c-98012bb0f9f1@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9279b880-558a-17fb-404c-98012bb0f9f1@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 08, 2017 at 09:40:59AM +0200, Christophe JAILLET wrote:
> Le 07/08/2017 à 08:36, Uwe Kleine-König a écrit :
> > On Mon, Aug 07, 2017 at 01:49:53AM +0200, Christophe JAILLET wrote:
> > > 'devm_pinctrl_get()' never returns NULL, so this test can be simplified.
> > That's wrong. If CONFIG_PINCTRL is disabled devm_pinctrl_get returns
> > NULL. But I think this shouldn't be considered an error, so your change
> > is right, just the commit log is not.
> With that said, in fact, I think that the test is correct as is.
> If CONFIG_PINCTRL is disabled, we will display an info about a missing
> functionality, but would still continue normally without it (i.e. return
> PTR_ERR(NULL) = 0 = success), as stated in the comment in front of
> 'i2c_imx_init_recovery_info':
>     "These alternative pinmux settings can be described in the device tree
> by
>      a separate pinctrl state "gpio". If this is missing this is not a big
>      problem, the only implication is that we can't do bus recovery."
> 
> So, I won't propose any v2 patch with an updated commit log.
> Feel free to update it yourself and apply it if you don't share my analysis
> above.

Then the only issue (maybe?) is that the driver makes use of
PTR_ERR(NULL) == 0 which I'm not sure is explicitly allowed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
