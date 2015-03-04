From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Date: Wed, 4 Mar 2015 13:06:39 +0900
Message-ID: <20150304040635.GA12776@verge.net.au>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
 <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2775fbb6b2e2b333ef2457133f419d4d-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Feb 23, 2015 at 02:08:42PM +0100, Wolfram Sang wrote:
> Hi,
> 
> On 2015-02-15 15:44, Yoshihiro Kaneko wrote:
> >From: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> >
> >Even if R-Car I2C received NACK, after that it might receive ACK
> >by HW auto restart. In case of that, driver would continue process.
> >If R-Car I2C didn't receive ACK, the driver would detect timeout
> >and would report NACK as -ENXIO.
> >
> >Signed-off-by: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> >Signed-off-by: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Excuse me, but what exactly is HW auto restart in this case? Is it a feature
> of the I2C slave?

I asked Kataoka-san about this and his response was as follows:

    It is a feature of the i2c-rcar(H/W) master.

    If system(CPU) is busy, NACK procedure may have interrupt latency.
    Since the clear of ICMCR.ESG bit is delayed, i2c-rcar(H/W) may auto-restart
    after NACK. Please refer to ESG bit of H/W UM section 55.3.5.

    For example, this is I2C write transmitting.
    1.Start / 2.SlaveAddr,ACK / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop

    If No.2 has NACK and interruption has delay, this transmitting is as follows.
    1.Start / 2.SlaveAddr,NACK/ 1x.auto-restart / 2x.SlaveAddr,ACK
                                    / 3.RegAddr,ACK / 4.RegData,ACK / 5.Stop

    NACK of No.2 is invalidated by ACK of No.2x. It means recover.
