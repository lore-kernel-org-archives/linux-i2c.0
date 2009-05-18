From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MFD: Add U300 AB3100 core support v1
Date: Mon, 18 May 2009 22:48:00 +0530
Message-ID: <5d5443650905181018j11b00a0ekf3b1bedd911fd10a@mail.gmail.com>
References: <63386a3d0905140129s5fd0f32cxde1114489678f012@mail.gmail.com>
	 <4A0BF776.9030301@compulab.co.il>
	 <63386a3d0905180722u282f0dd3ua62b119a1a6a97e8@mail.gmail.com>
	 <20090518164440.2124a4fa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090518164440.2124a4fa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

>>
>> Right now I lean toward the first alternative.
>
> Neither is correct. Simply use i2c_new_dummy() on the second I2C
> address, and keep a pointer to the instantiated i2c_client for future
> use. Don't forget to call i2c_unregister_device() in your .remove()
> method.
>

or simply look at drivers/mfd/twl4030-core.c for example :). TWL4030
is a single chip having four slave addresses over I2C.



-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
