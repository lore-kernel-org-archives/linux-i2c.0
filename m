From: Muralidharan Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: i2c bus multiplexing (Version 2).
Date: Fri, 11 Dec 2009 22:41:33 +0000 (UTC)
Message-ID: <loom.20091211T234046-786@post.gmane.org>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> This patch set adds to the I2C core the ability to handle multiplexed
> I2C bus topologies by presenting each multiplexed segment as a I2C
> adapter.

Hi Rodolfo,

Thanks for this patch. I learned about this patch through linux-media
mailing list. 

1)I have a sensor board header that uses pca9543a i2c switch
which is addressed by this patch. In my board, I have another
i2c chip that share the same i2c address with the sensor.
Currently I cannot have both these drivers co-exists due to
this. Please let me know if this can work once I use this patch.

2)Which kernel version you use for this patch?

3) Where can I download your patch so that I can give it a
shot. Is there any platform data I need to setup in my arch/
folder to use this patch?

4) When do you think this will be merged to mainline kernel?

Thanks

Murali
