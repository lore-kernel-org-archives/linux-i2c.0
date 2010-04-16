From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c bus multiplexing (Version 2).
Date: Fri, 16 Apr 2010 13:18:00 +0200
Message-ID: <20100416131800.44fc332b@hyperion.delvare>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
	<loom.20091211T234046-786@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20091211T234046-786-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Muralidharan Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Murali,

On Fri, 11 Dec 2009 22:41:33 +0000 (UTC), Muralidharan Karicheri wrote:
> 
> > This patch set adds to the I2C core the ability to handle multiplexed
> > I2C bus topologies by presenting each multiplexed segment as a I2C
> > adapter.
> 
> Hi Rodolfo,
> 
> Thanks for this patch. I learned about this patch through linux-media
> mailing list. 
> 
> 1)I have a sensor board header that uses pca9543a i2c switch
> which is addressed by this patch. In my board, I have another
> i2c chip that share the same i2c address with the sensor.
> Currently I cannot have both these drivers co-exists due to
> this. Please let me know if this can work once I use this patch.

Yes, this is the idea. With bus multiplexing support, we can finally
handle bus topologies with multiple chips using the same I2C address.

> 2)Which kernel version you use for this patch?
> 
> 3) Where can I download your patch so that I can give it a
> shot. Is there any platform data I need to setup in my arch/
> folder to use this patch?
> 
> 4) When do you think this will be merged to mainline kernel?

I am reviewing the patches at the moment, after Michael sends an
updated version addressing my comments, we should be ready to go. So we
currently aim at merging i2c multiplexing support into kernel 2.6.35.
At least a first version... more features can be added later.

-- 
Jean Delvare
