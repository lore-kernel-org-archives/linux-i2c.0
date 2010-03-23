From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c probing
Date: Tue, 23 Mar 2010 14:13:35 +0100
Message-ID: <20100323141335.4def23de@hyperion.delvare>
References: <4BA62B88.8080903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BA62B88.8080903-GANU6spQydw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthieu,

On Sun, 21 Mar 2010 15:22:00 +0100, matthieu castet wrote:
> Do you know why there is 2 methods of probing i2c [1] and [2], with different quirks for eeprom.

Historical reasons, mainly. i2c_detect() is an old thing, it is used by
device drivers which want to automatically probe for devices they
support (and provide a reliable detection function to this purpose.)
Mainly hardware monitoring drivers do this. i2c_new_probed_device() is
more recent, it is meant for bus drivers which want to probe for
device presence at a selected address. There is no detection function
involved in this case.

i2c_detect() is using the device presence detection method that has
been used since 1999 or so. For i2c_new_probed_device(), we learned
from our past mistakes and opted for a safer approach. But in practice,
both should work equally fine.

> Why can't they be merged together ?

I don't really remember, and in all honesty, I did not realize the
legacy probing method was still present until I read your post. I guess
that I didn't dare changing the legacy probing code originally. Now
that we have good results with the new one, I agree that it would be
nice to merge both (that is, get rid of the old one and use the new one
everywhere.)

Would you be interested in working on this? You can register yourself
on the wiki [1] if you want, and add an action item. Or just send a
patch right away if you think it is simple enough.

Note that I have been working lately on letting callers of
i2c_new_probed_device() pass a custom probe function. These changes
will certainly collide with the ones you are suggesting. So if you want
to work on this, please let me know so that we can coordinate our
efforts.

[1] https://i2c.wiki.kernel.org/index.php/Main_Page

Thanks,
-- 
Jean Delvare
