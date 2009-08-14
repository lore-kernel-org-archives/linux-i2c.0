From: Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C -bus programming
Date: Fri, 14 Aug 2009 12:23:34 +0100
Message-ID: <4A854936.5060409@gmail.com>
References: <4A8491E3.4070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A8491E3.4070907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kari Laine <klaine8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Copied to i2c mailing list.

> Dear List,
>
> this is my first post here and I am not sure if this is a suitable topic
> here. Anyway I have a Velleman K8000 IO-card and it uses I2C over
> parallel port to communicate.
>
> when I modprobe i2c-parport it does not complain. I tested without card
> connected and it complained so it seems to find the card.
>
> modprobe pcf8591
>
> modprobe i2c-core
>
> modprobe i2c-dev
>
> I am not sure I am doing it right. Should i2c-core probed first ?
>
> anyway now I have
>
> /dev/i2c-0  /dev/i2c-1
>
> Now I don't know whether these i2c-devices refer to this Velleman  board
> or some other i2c-device which happen to be in the computer...
>
> If these devices probably refer to Velleman - then how I can refer
> different i2c-devices on the board.
>
>
> I am totally new to this i2c thing (reading spec at the moment but it
> does not help much with Linux).
>
> I would be very greatfull if some could point me the way - thanks.
>
> Best Regards
> Kari Laine
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   
