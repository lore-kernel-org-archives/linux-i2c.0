From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Mon, 10 Mar 2014 11:24:55 +0100
Message-ID: <531D92F7.7080509@topic.nl>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl> <20140309202107.GA2835@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140309202107.GA2835@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFOn 03/09/2014 09:21 PM, Wolfram Sang wrote:
> On Thu, Jan 09, 2014 at 12:11:25PM +0100, Mike Looijmans wrote:
>> When a signal is caught while the i2c-davinci bus driver is transfer=
ring,
>> the drive just "abandons" the transfer and leaves the controller to =
fend
>> for itself. The next I2C transaction will find the controller in an
>> undefined state and often results in a stream of "initiating i2c bus=
 recovery"
>> messages until the controller arrives in a defined state. This behav=
iour
>> also sends out "half" or possibly even mixed messages to I2C client
>> devices which may put them in an undesired state as well.
>>
>> This patch fixes this issue by always attempting to finish the curre=
nt
>> transaction, and then check on a pending signal. It either reports
>> success if all data has been transferred, or it returns failure when
>> the transaction was aborted. This keeps the controller in a defined
>> state, and is also much friendlier towards client devices, because
>> it will only send complete messages.
>
> Even more, you should complete the whole transfer. There are devices
> where things can really go wrong if you send a half-complete command =
and
> then start with the next one. So, not checking signals at all is the =
way
> to go for I2C drivers. There is some cruft left, so I am happy about
> patches fixing that, with testing on real HW. Like yours here.

I agree.

I know the Zynq (using a cadence controller) also lets signals interrup=
t I2C=20
transfers, so I'll propose a patch to Xilinx and CC to you and linux-i2=
c to=20
completely remove signal handling from that driver as well.

Mike


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
