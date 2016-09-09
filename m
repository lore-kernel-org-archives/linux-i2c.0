From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
Date: Fri, 9 Sep 2016 22:59:26 +0200
Message-ID: <20160909205926.dbxmvhqvfsqzk6dx@pengutronix.de>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <8f8f7ffc4aef513ef5064ba0491fbc63@agner.ch>
 <CADRPPNR4oiRVgFqaM=1=Zn_JzrVJDVmozWsouLByXRtaHCh=qQ@mail.gmail.com>
 <306f579a2f2362595a55c53e48657563@agner.ch>
 <CADRPPNS3PecYRaAMR+0RuzU+gE3y5ZN-x7HzqggrdDsN-CkArg@mail.gmail.com>
 <649e7e70becb94adf3b8c4ae2409ea00@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <649e7e70becb94adf3b8c4ae2409ea00@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Leo Li <pku.leo@gmail.com>, Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Sep 09, 2016 at 01:34:31PM -0700, Stefan Agner wrote:
> Yeah it is a bit a wording thing: In my understanding, pinctrl is
> required on SoC's witch have a pin controller... It is just that the
> driver does not need to get the pinctrl by itself because the stack is
> taking care of it implicitly. And yes, that makes the particular example
> not a real world example.

At first I thought, too, that it's a fatal problem if getting the
pinctrl stuff fails. IMHO that shows that the comments (or the code) are
still not good enough.

Maybe we should do something like that:

/*
 * As the IP doesn't support bus recovery, we have to switch SCL and SDA
 * to their GPIO function and do some bitbanging. These alternative
 * pinmux settings can be described in the device tree by a separate
 * pinctrl state "gpio". If this is missing this is not a big problem,
 * the only implication is that we can't do bus recovery.
 */
static void i2c_imx_init_recovery_info(...)
{
	...

and then put

        i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
        if (IS_ERR(i2c_imx->pinctrl))
		return;

into this function (and remove it from i2c_imx_probe). This makes it
more obvious that .pinctrl is only ever used for recovery and as
i2c_imx_init_recovery_info is void there is no error to propagate.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
