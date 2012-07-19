From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Thu, 19 Jul 2012 18:56:10 +0530
Message-ID: <50080AF2.6000404@ti.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com> <20120703103221.62fcb7ae@endymion.delvare> <CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com> <CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com> <CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA@mail.gmail.com> <4FFDAF5A.8070205@ti.com> <CANQgH-YxYY7M6o4Hxw0kq9=GSwF8TSgiobXLJoPnGhj=c3w4KQ@mail.gmail.com> <CAGm1_ktYqq5HKt13RuQVL8axX0FUnZ_5a6va7BRuUschQRKERQ@mail.gmail.com> <CAM=Q2ct_mfGiuKrX9KAuk7B+PA==FRL7DPOfge9fRAuFg6bA3Q@mail.gmail.com> <CAGm1_ktVXmEBZz90_SMB+WmZGax5DwoXD5pr66Dja=8QW1QcGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_ktVXmEBZz90_SMB+WmZGax5DwoXD5pr66Dja=8QW1QcGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 19 July 2012 06:35 PM, Yegor Yefremov wrote:
>> Another request. Can you disable the NACK interrupt on the ignore and
>> > enable back?
>> >
>> > Also let me know if you know of any of the panda or sdp peripherals
>> > which could keep going on
>> > NACK.
> I don't know any :-( This is also a not very common hardware where you
> have to make such tricks.
OK.
>
>> > patch below.
> As I understand it is a stand alone patch not based on the previous
> one? I have the same result - timeout.
Strange. Actually I disabled the NACK interrupt.

Can you share your i2c-omap.c file or link.

>
> Yegor
