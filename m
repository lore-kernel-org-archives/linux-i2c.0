From: James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: pxa: enable high speed mode for i2c bus
Date: Tue, 6 Aug 2013 11:05:29 +0800
Message-ID: <CAOng1WTFY3o9X=fRjhCgjp2m1FQ9RJgL1gVu1ZPrRScq7YHTXw@mail.gmail.com>
References: <1370587097-21006-1-git-send-email-shangll@marvell.com>
	<20130615144812.GD2923@katana>
	<CAOng1WTa0c2Jb9yPeynKXQ0K4-bPhrcGPsKd-AP-MuxQPH80Jg@mail.gmail.com>
	<CAOng1WSNDQMrce6CSN9Zh-FHJgoC6+SbOioYTyuoiAFTBdPYbA@mail.gmail.com>
	<CAOng1WRu8yjVQ2jhm7fnPcG6ts+fBSxpn-D1ZCcLQvSVBfmF3A@mail.gmail.com>
	<CAOng1WR+QVTZs9Zi=aKKsy_f=3R7=bB1PPWvuH2KtLaK+6rVBw@mail.gmail.com>
	<CAOng1WTQP9XuPNDtiECZVOsCkowU1iyoq7C-h=Na7zspjFrjKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOng1WTQP9XuPNDtiECZVOsCkowU1iyoq7C-h=Na7zspjFrjKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

Would you please take a tiny time to look at this?

2013/7/30 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi All
>
> Would you please help to look at this patch?
>
> Thanks!
>
> 2013/7/22 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi Guys
>>
>>       Any comments?
>>
>> 2013/7/11 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> Hi all
>>>
>>>       I am still waiting for your response.....
>>>
>>> 2013/7/5 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>> Hi guys,
>>>>
>>>>         Any comments?
>>>>
>>>> 2013/7/2 James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>> Hi Wolfram
>>>>>
>>>>>     Have you finished reading datasheet?
>>>>>
>>>>> 2013/6/15 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Jun 07, 2013 at 02:38:17PM +0800, Leilei Shang wrote:
>>>>>>> To enter high speed mode, following steps should be done:
>>>>>>> 1. When running in high speed mode, i2c clock rate is different
>>>>>>> from standard mode. Clock rate must be set according to
>>>>>>> specification first.
>>>>>>> 2. When i2c controller sends a master code and wins arbitration,
>>>>>>> high speed mode is entered.
>>>>>>>
>>>>>>> If you want to enable high speed mode, the following members of
>>>>>>> platform data should be set to proper value:
>>>>>>
>>>>>> I couldn't find any support for hs-mode in pxa2xx and pxa3xx. So it
>>>>>> shouldn't be set in platform data, but depending on checks if this is
>>>>>> supported on this device at all. And why don't simply switch to it if
>>>>>> rate is bigger than what is supported without hs-mode?
>>>>>>
>>>>>
>>>>> 1. High speed mode is hardware feature, you can't read it from
>>>>> software. It's similar to fast mode, and fast mode is set in platform
>>>>> data.
>>>>>
>>>>>     The only method I can think of is to add a platform, like pxa910.
>>>>> And if you enable hs mode and platform is not pxa910, we'll set it to
>>>>> normal mode. Is this OK?
>>>>>
>>>>> 2. About hs mode clock setting. We don't know whether currently hs
>>>>> mode clock will be changed in future. Do you think below code is OK?
>>>>>
>>>>> if (i2c->rate)
>>>>>             clk_set_rate(i2c->clk, i2c->rate);
>>>>> else
>>>>>             clk_set_rate(i2c->clk, 62400000);
>>>>>
>>>>>             pr_info("i2c: <%s> set rate to %ld\n",
>>>>>                 i2c->adap.name, clk_get_rate(i2c->clk));
>>>>>
>>>>>>> 1. "high_mode" should be set to "1".
>>>>>>> 2. "master_code" should be set to "8'b 0000_1xxx"(x is 0 or 1).
>>>>>>>    If no master_code is set, set to default value 0xe.
>>>>>>> 3. "rate" should be set according to specification.
>>>>>>
>>>>>> Note that you should fall back to full-speed mode after sending the stop
>>>>>> bit in high-speed mode. I can't find this in the code?
>>>>>>
>>>>>
>>>>> 3. Will fall back to normal mode when stop bit is sent.
>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>>>>>
>>>>>> Which SoC supports this? I'd like to have a look at the datasheet.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>    Wolfram
>>>>>>
>>>>>
>>>>> Hope you can reply soon!
>>>>>
>>>>> Best regards
>>>>> Leilei
