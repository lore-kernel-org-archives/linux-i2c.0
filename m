From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH 1/2] mfd: dln2: fix _dln2_transfer return code
Date: Tue, 11 Nov 2014 18:32:00 +0200
Message-ID: <CAE1zotLOZX8Kfy=ajSLf0wredSWVvGt1LqO0bYUtzmugg_Ph8A@mail.gmail.com>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
	<1415708457-18798-2-git-send-email-octavian.purdila@intel.com>
	<alpine.DEB.2.02.1411111717270.2047@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1411111717270.2047@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Johan Hovold <johan@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 11, 2014 at 6:18 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Tue, 11 Nov 2014, Octavian Purdila wrote:
>
>> If wait_for_completion_interruptible_timeout returns a positive value
>> it may be propagated as the return value of _dln2_transfer. This
>> contradicts the documentation of the function and exposes unnecessary
>> internals to the callers.
>>
>> This patch makes sure to set the return value to 0 in that case.
>
> I didn't keep around the code or the address of the git tree, but I wonder
> if this makes a later assignment of ret to 0 unnecessary?
>

Yes, you are right, we can skip setting it when ibuf is NULL. I will
send v2 that fixes this and the coding style issue.
