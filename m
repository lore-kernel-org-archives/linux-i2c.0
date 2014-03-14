From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Fri, 14 Mar 2014 07:43:25 +0100
Message-ID: <5322A50D.4040702@topic.nl>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl> <20140309202107.GA2835@katana> <531D92F7.7080509@topic.nl> <20140310105952.GA7227@katana> <20140310152406.GD11592@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140310152406.GD11592@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFOn 03/10/2014 04:24 PM, Wolfram Sang wrote:
>
>>>> Even more, you should complete the whole transfer. There are devic=
es
>>>> where things can really go wrong if you send a half-complete comma=
nd and
>>>> then start with the next one. So, not checking signals at all is t=
he way
>>>> to go for I2C drivers. There is some cruft left, so I am happy abo=
ut
>>>> patches fixing that, with testing on real HW. Like yours here.
>>>
>>> I agree.
>>>
>>> I know the Zynq (using a cadence controller) also lets signals
>>> interrupt I2C transfers, so I'll propose a patch to Xilinx and CC t=
o
>>> you and linux-i2c to completely remove signal handling from that
>>> driver as well.
>>
>> Cool, thanks!
>
> Are you going to update the davinci patch as well?

An amended patch is on its way now. I forgot to set the subject to "PAT=
CHv2"=20
though.

Mike.



Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans-Oq418RWZeHk@public.gmane.org
Website: www.topic.nl

Please consider the environment before printing this e-mail
