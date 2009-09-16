From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Wed, 16 Sep 2009 22:52:47 +0200
Message-ID: <20090916225247.2094619b@hyperion.delvare>
References: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C62896630644CE43BF64B0FF0AC27F0E18153F-RKsfjrak5bi0VCHWTNMfawC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chuck Kamas <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 16 Sep 2009 09:56:37 -0700, Chuck Kamas wrote:
> I am trying to backport Michael's patch to add PROBE and REMOVE ioctls
> to 2.6.21
> http://article.gmane.org/gmane.linux.drivers.i2c/3339/match=ioctls+probe
> 
> I have been able to add the IOCTLS and re-compile the kernel module, but
> am confused as to what function to call in the old device model.  I
> believe that I should use i2c_attach_client() from i2c-core.c.  Is this
> correct?

You are backporting a patch which was rejected upstream, to a model
which is deprecated. It's probably time to reconsider your technical
choices.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
