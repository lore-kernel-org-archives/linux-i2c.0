From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Mon, 10 Nov 2014 15:49:11 +0100
Message-ID: <5460D067.3020502@topic.nl>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl> <1394779348-4084-1-git-send-email-mike.looijmans@topic.nl> <20140324161432.GA7524@katana> <20140521081727.GE2708@katana> <53808851.7060308@topic.nl> <20140601201134.GA3853@katana> <20141108215155.GA1266@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141108215155.GA1266@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFOn 11/08/2014 10:51 PM, Wolfram Sang wrote:
> On Sun, Jun 01, 2014 at 10:11:34PM +0200, Wolfram Sang wrote:
>>
>>> Feel free to adap my patch or comments and commit. Or wait a few we=
eks for
>>> when I have a sponsor to split and update the patch.
>>
>> OK, I'll hope you can make it for 3.17. Thanks!
>
> I now picked the part removing the interruptible-call. The part with
> the new exit-path would need to be resend and retested in case anyone
> is still caring.
>

I think that's the right thing to do. There seems to be little interest=
 in the=20
rest of the I2C controller, and it's a tough one to test (you'd have to=
=20
trigger an I2C error at exactly the moment that a clock frequency chang=
e is=20
about to occur...).




Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Topic zoekt gedreven (embedded) software specialisten!
http://topic.nl/vacatures/topic-zoekt-software-engineers/
