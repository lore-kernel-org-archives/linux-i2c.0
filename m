From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v5] i2c: mux: mellanox: add driver
Date: Thu, 10 Nov 2016 12:13:09 +0100
Message-ID: <b7cf55af-1354-0e0d-b960-877a6223b357@axentia.se>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
 <c530714e-b61e-8a38-a054-9d335f0e8a71@axentia.se>
 <AM5PR0501MB2097C2A4BA889C44549A0E9FA2A30@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM5PR0501MB2097C2A4BA889C44549A0E9FA2A30@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

[resend to all, got the wrong button, sorry]

On 2016-11-10 11:42, Peter Rosin wrote:
> On 2016-11-03 06:20, Vadim Pasternak wrote:
>> Hi,
>>
>> I see that this patch has not been picked-up yet for i2c-next.
>> Is it possible it was missed from some reason?
>
> Yes, apparently, really sorry about that!
>
> I'll put it in a branch and make a pull request for Wolfram (but
> that is a bit new for me, we'll see how it goes).

But now that I looked again, I noticed that the source is
dual licensed and yet your MODULE_LICENSE tag says only
"GPL v2". I.e. the same issue your i2c master driver had
that Vladimir Zapolskiy noticed.

Please fix this, and it might be a good idea to take a look
in your other drivers as well in case you have further
problems in this department...

Also, while at it, the patch doesn't apply cleanly anymore,
please rebase to something more current.

Cheers,
Peter
