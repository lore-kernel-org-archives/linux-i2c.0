From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c-eg20t: delete 10bit access processing
Date: Tue, 4 Oct 2011 21:55:37 +0100
Message-ID: <20111004205536.GA13323@freya.fluff.org>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <1316591509-4433-3-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1316591509-4433-3-git-send-email-tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 21, 2011 at 04:51:45PM +0900, Tomoya MORINAGA wrote:
> Linux I2C core doesn't support 10bit access formally.
> Additionally, we can't test with 10bit mode.
> This patch deletes the 10bit access processing.

do we want to keep this patch in the series? if not, can
you post a new series with this dropped from it?

-- 
Ben
