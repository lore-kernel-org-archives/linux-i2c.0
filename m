From: Andreas Werner <wernerandy-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] I2C: busses: Do not print error message in syslog if no
 ACK received
Date: Thu, 14 Nov 2013 19:26:09 +0100
Message-ID: <20131114182609.GB2133@thinkpad.fritz.box>
References: <1384278336-3694-1-git-send-email-wernerandy@gmx.de>
 <201311121933.41038.marex@denx.de>
 <20131113182415.GA1458@thinkpad.fritz.box>
 <201311132024.06853.marex@denx.de>
 <1384436392.15774.2.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384436392.15774.2.camel@joe-AO722>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, baohua.song-kQvG35nSl+M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 14, 2013 at 05:39:52AM -0800, Joe Perches wrote:
> On Wed, 2013-11-13 at 20:24 +0100, Marek Vasut wrote:
> > > On Tue, Nov 12, 2013 at 07:33:40PM +0100, Marek Vasut wrote:
> > > > > > That is because if you look at the only caller of this function,
> > > > > > which is pch_i2c_wait_for_check_xfer(), you will see that at the
> > > > > > only place where pch_i2c_getack() is called there is already
> > > > > > pch_dbg():
> > > > > > 
> > > > > > 369         if (pch_i2c_getack(adap)) {
> > > > > > 370                 pch_dbg(adap, "Receive NACK for slave address"
> > > > > > 371                         "setting\n");
> > > > > > 372                 return -EIO;
> > > > > > 373         }
> > > 
> > > Sorry i misunderstood that. You are absolutly right, thats the best
> > > solution for that. Remove the pch_err at getack so that only the pch_dbg
> > > get printed where getack is called. This should be enough information.
> > 
> > No problem ;-)
> 
> If this is the approach taken, please coalesce the format.
> As is there's a missing space between address and setting.
> This should be:
> 
> 		pch_dbg(adap, "Received NACK for slave address setting\n");
> 
> 
Hi,
yes you are right, i will also add it and resand the patch in a few days.

regards 
Andy
