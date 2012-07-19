From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Thu, 19 Jul 2012 15:05:21 +0200
Message-ID: <CAGm1_ktVXmEBZz90_SMB+WmZGax5DwoXD5pr66Dja=8QW1QcGA@mail.gmail.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com>
 <20120703103221.62fcb7ae@endymion.delvare> <CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com>
 <CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com>
 <CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA@mail.gmail.com>
 <4FFDAF5A.8070205@ti.com> <CANQgH-YxYY7M6o4Hxw0kq9=GSwF8TSgiobXLJoPnGhj=c3w4KQ@mail.gmail.com>
 <CAGm1_ktYqq5HKt13RuQVL8axX0FUnZ_5a6va7BRuUschQRKERQ@mail.gmail.com> <CAM=Q2ct_mfGiuKrX9KAuk7B+PA==FRL7DPOfge9fRAuFg6bA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2ct_mfGiuKrX9KAuk7B+PA==FRL7DPOfge9fRAuFg6bA3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 17, 2012 at 4:01 PM, Shubhrajyoti Datta
<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jul 17, 2012 at 3:01 PM, Yegor Yefremov
> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> On Thu, Jul 12, 2012 at 7:24 AM, Datta, Shubhrajyoti
>> <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> [...]
>>> On Wed, Jul 11, 2012 at 10:22 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>
>
>>
>> Thank you for the patch and sorry for delay. I tried the patch,
>
> Thanks for the test.
>
>> but it doesn't help. I still get timeouts only. I fear it is really a
>> hardware feature,
>
> I feel that could be unlikely.
>
>> that OMAPs i2c stops if address is not acknowledged.
>> At least this is my understanding of the reference manual.
>>
>> Here is the output from dmesg:
>
>
> Another request. Can you disable the NACK interrupt on the ignore and
> enable back?
>
> Also let me know if you know of any of the panda or sdp peripherals
> which could keep going on
> NACK.

I don't know any :-( This is also a not very common hardware where you
have to make such tricks.

> patch below.

As I understand it is a stand alone patch not based on the previous
one? I have the same result - timeout.

Yegor
