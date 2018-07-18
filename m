From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Wed, 18 Jul 2018 15:52:20 +0300
Message-ID: <b70d78516e765b3a6587323cffb6066e9363cd48.camel@linux.intel.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
         <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
         <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
         <CAMuHMdWJkwJ5+DDqbaWH-cMhRQynWCxb4MbFtpejqi1HhUBHTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWJkwJ5+DDqbaWH-cMhRQynWCxb4MbFtpejqi1HhUBHTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2018-07-18 at 13:06 +0200, Geert Uytterhoeven wrote:
> On Wed, Jul 18, 2018 at 11:14 AM Simon Horman <horms@verge.net.au>
> wrote:

> >         if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) != -ENOENT)
> >                 return PTR_ERR(dev->busclk);
> > 
> >         ...
> 
> As this is a commonly-used construct, perhaps it would be good to
> introduce
> clk_get_optional() (cfr. gpiod_get_optional()) and
> devm_clk_get_optional(),
> which would return NULL instead of -ENOENT?
> Then it becomes a simple check for IS_ERR() in the driver.

I'm puzzled why CCF still lack of such API.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
