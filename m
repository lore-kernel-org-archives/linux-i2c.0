From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: [PATCH] i2c-eg20t : Fix the issue of Combined R/W transfer mode
Date: Thu, 23 Jun 2011 09:52:08 +0200
Message-ID: <201106230952.09286.alexander.stein@systec-electronic.com>
References: <1308813430-2697-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308813430-2697-1-git-send-email-tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 23 June 2011 09:17:10 Tomoya MORINAGA wrote:
> @@ -672,7 +672,7 @@ static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	/* transfer not completed */
>  	adap->pch_i2c_xfer_in_progress = true;
> 
> -	for (i = 0; i < num; i++) {
> +	for (i = 0; i < num && ret >= 0; i++) {
>  		pmsg = &msgs[i];
>  		pmsg->flags |= adap->pch_buff_mode_en;
>  		status = pmsg->flags;

Do you have any other local pending patches which are not in git yet? I can't 
find this for loop in current master.

Regards,
Alexander
