From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Tue, 10 Jul 2012 20:38:27 +0530
Message-ID: <CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com>
	<20120703103221.62fcb7ae@endymion.delvare>
	<CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, shubhrajyoti-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 10, 2012 at 8:29 PM, Yegor Yefremov
<yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> On Tue, Jul 3, 2012 at 10:32 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>> On Tue, 3 Jul 2012 10:12:09 +0200, Yegor Yefremov wrote:
>>> I'm using the second i2c channel to connect to HDMI transmitter
>>> sii9022a. In order to get EDID information from the attached monitor
>>> the sii9022a chip passes i2c request direct to the monitors i2c bus.
>>> To return to sii9022a mode one has to write data to HDMI transmitter,
>>> but this data won't be acknowledged. Because of this i2c produces
>>> timeout permanently (omap_i2c omap_i2c.2: controller timed out), so no
>>> communication is possible. The last bits I see on the scope are the
>>> i2c address of sii9022a. The CPU automatically end the transfer.
>>>
>>> The HDMI chip has i2c address 0x72 (8-bit notation) and EDID channel
>>> 0xa0 (8-bit notation). AFAIK there is only one device at a time on the
>>> bus, i.e. as soon as I switch sii9022a to access monitor only 0xa0
>>> responds to the queries. And I need to send a message to 0x72 ignoring
>>> normal i2c conditions in order to turn it back in normal mode.
>>>
>>> The driver for this HDMI transmitter can be found here:
>>> http://gitorious.org/efikamx/linux-kernel.git
>>> (drivers/video/mxc/siihdmi.c)
>>>
>>> How can I send this write request without awaiting for ACK?
>>
>> Use I2C_M_IGNORE_NAK, see Documentation/i2c/i2c-protocol.
>
> Jean, thanks for the tip. I got it working by disabling the omap-i2c
> driver and enabling i2c-gpio on the same pins. Only in this
> combination and I2C_M_IGNORE_NAK I could get back to the HDMI chip.
> OMAP i2c driver/I2C_M_IGNORE_NAK combo is not working. But I still got
> no chance to try the latest kernel.

OK may be you are missing patches like
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=464fca36d98b97ccd05e4f200ab7483d3acc8345

Personally will recommend the latest kernel.


>
> Yegor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
