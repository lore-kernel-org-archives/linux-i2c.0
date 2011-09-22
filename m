From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c-eg20t: delete 10bit access processing
Date: Thu, 22 Sep 2011 09:13:46 +0900
Message-ID: <4E7A7DBA.3020406@dsn.okisemi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com> <1316591509-4433-3-git-send-email-tomoya-linux@dsn.okisemi.com> <B6A520E9CD57404AAFC0831E4FB39541A98073AC7E@IRVEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B6A520E9CD57404AAFC0831E4FB39541A98073AC7E-4wnuKdaqIVJdD26/7+am4baTQr+y5IJFqs7JOtOhHmkAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org" <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(2011/09/22 0:42), Jeffrey (Sheng-Hui) Chu wrote:

 > There is i2c device coming out that uses 10-bit address.
Thank you for your information.
We want to test 10-bit mode using the device.
So let me know the device information ?

Anyway, Now, kernel i2c-core is EXPERIMENTAL stage for 10-bit mode like 
below.

   (Documentation/i2c/ten-bit-addresses)
    WARNING! The current 10 bit address support is EXPERIMENTAL. There
   are several places in the code that will cause SEVERE PROBLEMS with
   10 bit addresses, even though there is some basic handling and
   hooks. Also,
   almost no supported adapter handles the 10 bit addresses correctly.

   As soon as a real 10 bit address device is spotted 'in the wild', we
   can and will add proper support. Right now, 10 bit address devices
   are defined by the I2C protocol, but we have never seen a single
   device which supports them.

After kernel supports 10bit-mode formally, we will add the function  to 
i2c-eg20t again.

Thanks,
tomoya
