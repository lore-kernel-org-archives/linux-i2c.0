From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Date: Mon, 23 Feb 2015 14:08:42 +0100
Message-ID: <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424011480-3551-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 2015-02-15 15:44, Yoshihiro Kaneko wrote:
> From: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Even if R-Car I2C received NACK, after that it might receive ACK
> by HW auto restart. In case of that, driver would continue process.
> If R-Car I2C didn't receive ACK, the driver would detect timeout
> and would report NACK as -ENXIO.
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Excuse me, but what exactly is HW auto restart in this case? Is it a 
feature of the I2C slave?

Thanks,

    Wolfram
