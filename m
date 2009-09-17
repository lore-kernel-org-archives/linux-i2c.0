From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Thu, 17 Sep 2009 18:04:07 +0200
Message-ID: <20090917180407.5460bf33@hyperion.delvare>
References: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com>
	<20090916225247.2094619b@hyperion.delvare>
	<C62896630644CE43BF64B0FF0AC27F0E1815B9@mail.ad.skymv.com>
	<20090917092612.53327f80@hyperion.delvare>
	<C62896630644CE43BF64B0FF0AC27F0E1815EC@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C62896630644CE43BF64B0FF0AC27F0E1815EC-RKsfjrak5bi0VCHWTNMfawC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chuck Kamas <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chuck,

On Thu, 17 Sep 2009 08:45:57 -0700, Chuck Kamas wrote:
> Thanks for the reply.  I see now that I was not clear.  In the patch
> that I mentioned, Michael used a call i2c_new_device(client->adapter,
> &bInfo).  This is from the new model.  What would be the equivalent call
> from the old model?  I.e. what function do I call so that a chip driver
> will issue a probe and if a chip is found it will be properly
> registered?

You keep referring to Michael's patch, while this patch was never
merged, for a reason.

Please let's start all over again. Michael's patch does not exist.
Trying to inject pieces of the new binding model into the old one will
never work, both models are simply too different.

What functional problem are you trying to solve? What's your platform,
what's your I2C bus, what's your I2C device, and which drivers are you
using?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
