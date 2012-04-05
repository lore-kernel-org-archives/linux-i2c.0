From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mxs: Fix build warning
Date: Thu, 5 Apr 2012 17:36:29 -0300
Message-ID: <CAOMZO5B7R+O-GtoejT29ZPe-_CrKaDFUhE_yXUzj2xB8TigeJA@mail.gmail.com>
References: <1333656595-3600-1-git-send-email-festevam@gmail.com>
	<20120405201651.GA26902@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120405201651.GA26902-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 5, 2012 at 5:16 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Apr 05, 2012 at 05:09:55PM -0300, Fabio Estevam wrote:
>> Fix the following build warning:
>>
>> drivers/i2c/busses/i2c-mxs.c:207:8: warning: 'data' may be used uninitialized in this function [-Wuninitialized]
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Do you agree with the compiler?

After looking at it carefully I conclude that is not possible for
'data' to be used uninitialized.
