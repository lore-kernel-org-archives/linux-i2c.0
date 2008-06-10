From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Frame buffers and early i2c
Date: Tue, 10 Jun 2008 12:57:37 +0200
Message-ID: <20080610125737.0622da44@hyperion.delvare>
References: <200806091647.42757.u.luckas@road.de>
	<200806092359.36080.u.luckas@road.de>
	<20080610082527.0e6d643a@hyperion.delvare>
	<200806101131.19763.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754473AbYFJK6B@vger.kernel.org>
In-Reply-To: <200806101131.19763.u.luckas@road.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com, Linux I2C <i2c@lm-sensors.org>, Ryan Mallon <ryan@bluewatersys.com>, David Brownell <david-b@pacbell.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 Jun 2008 11:31:19 +0200, Uli Luckas wrote:
> On Tuesday, 10. June 2008, Jean Delvare wrote:
> > So you prefer to post to one random list than the two lists where your
> > target audience is? Interesting approach. If you really don't want to
> > post to two lists at once, just send two separate posts?
> >
> And have two seperate threads of communication??? lfml is where they all are 
> and avery maintainer has different preferences. Anyway, I got your point and 
> will come to the i2c list in the future if you prefere.

If you believe that every kernel developer reads LKML, you're seriously
mistaken. We have a hundred of dedicated mailing lists for a reason. I
would have missed your post if you hadn't Cc'd directly.

> Just changing the initcall to subsys really did the trick. I thought, this was 
> the first thing I tried and I thought it crashed my device. But obviousely I 
> had some other problem.
> If Russell gives his Ack, could this be pushed upstream through i2c?
> (...)
> Initialize the pxa i2c bus during subsystem initialization to make it
> available during driver initialization (e.g. display powerup for pxafb).
> 
> Signed-off-by: Uli Luckas <u.luckas@road.de>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index eb69fba..78c0fc4 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1134,5 +1134,5 @@ static void __exit i2c_adap_pxa_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:pxa2xx-i2c");
>  
> -module_init(i2c_adap_pxa_init);
> +subsys_initcall(i2c_adap_pxa_init);
>  module_exit(i2c_adap_pxa_exit);

That's fine with me.

-- 
Jean Delvare
