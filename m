From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MFD: Add U300 AB3100 core support v1
Date: Mon, 18 May 2009 16:44:40 +0200
Message-ID: <20090518164440.2124a4fa@hyperion.delvare>
References: <63386a3d0905140129s5fd0f32cxde1114489678f012@mail.gmail.com>
	<4A0BF776.9030301@compulab.co.il>
	<63386a3d0905180722u282f0dd3ua62b119a1a6a97e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <63386a3d0905180722u282f0dd3ua62b119a1a6a97e8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Mon, 18 May 2009 16:22:36 +0200, Linus Walleij wrote:
> Here we have a problem. See above:
> msgs[0].addr = ab3100_i2c_client->addr + 1;
> 
> So this chip actually has two addresses. A "special" address
> to deal with test registers, one address up. The I2C framework
> assume all devices have one and one address only (which is
> of course mostly true).

No, the I2C framework doesn't assume this. All the I2C framework
assumes is that only one device can use a given address on any one I2C
segment (which seems reasonable.)

> Here is a special case. When the first device has registered,
> you know that the other address is available as well.
> 
> You could think of several ugly solutions:
> 
> * Keep using i2c_transfer() directly as we do now.
> 
> * Make a raw copy of the i2c_device with something like
>   memcpy(mock_client, i2c_client, sizeof(i2c_client);
>   mock_client->addr++;
>   then use i2c_master_send()
> 
> * Register a new i2c_device in board_info for the other
>   address while strictly speaking it is the same device, and
>   this will yield a lot of probing and synchronization code,
>   because writing the test registers is used when probing the
>   first device, so we have to wait for that device to be probed
>   before we can probe the other one etc.
> 
> Right now I lean toward the first alternative.

Neither is correct. Simply use i2c_new_dummy() on the second I2C
address, and keep a pointer to the instantiated i2c_client for future
use. Don't forget to call i2c_unregister_device() in your .remove()
method.

-- 
Jean Delvare
