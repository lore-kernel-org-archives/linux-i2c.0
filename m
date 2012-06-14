From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Date: Thu, 14 Jun 2012 08:53:49 +0100
Message-ID: <CAOh2x=n3uzc3K1oMtOKicuiQoZLYu4QVTY0gEPmSFsw3_R=u9Q@mail.gmail.com>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Jochen Friedrich <jochen@scram.de>, Grant Likely <grant.likely@secretlab.ca>, Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Deepak Sikri <deepak.sikri@st.com>, Li Yang <leoli@freescale.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, spear-devel <spear-devel@list.st.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>, Jean Delvare 
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2012 at 10:12 PM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---


> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 0506fef..cf3b23c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -147,7 +147,6 @@ static int __devinit dw_i2c_probe(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failure adding adapte=
r\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 of_i2c_register_devices(adap);
>
> =A0 =A0 =A0 =A0return 0;

For SPEAr,

Reviewed-by: Viresh Kumar <viresh.linux@gmail.com>
